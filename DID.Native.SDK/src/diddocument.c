/*
 * Copyright (c) 2019 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <assert.h>

#include "did.h"
#include "diddocument.h"
#include "didstore.h"
#include "credential.h"
#include "common.h"
#include "JsonGenerator.h"
#include "crypto.h"
#include "HDkey.h"
#include "didmeta.h"

#define MAX_EXPIRES              5

static const char *ProofType = "ECDSAsecp256r1";

typedef enum KeyType {
    KeyType_Authentication,
    KeyType_Authorization,
    KeyType_PublicKey
} KeyType;

static void PublicKey_Destroy(PublicKey *publickey)
{
    if(!publickey)
        return;

    free(publickey);
}

static void Service_Destroy(Service *service)
{
    if (!service)
        return;

    free(service);
}

static
int PublicKey_ToJson(JsonGenerator *gen, PublicKey *pk, int compact)
{
    char id[MAX_DIDURL];

    assert(gen);
    assert(gen->buffer);
    assert(pk);

    CHECK(JsonGenerator_WriteStartObject(gen));
    CHECK(JsonGenerator_WriteStringField(gen, "id",
        DIDURL_ToString(&pk->id, id, sizeof(id), compact)));
    if (!compact) {
        CHECK(JsonGenerator_WriteStringField(gen, "type", pk->type));
        CHECK(JsonGenerator_WriteStringField(gen, "controller",
                DID_ToString(&pk->controller, id, sizeof(id))));
    } else {
        if (!DID_Equals(&pk->id.did, &pk->controller))
            CHECK(JsonGenerator_WriteStringField(gen, "controller",
                   DID_ToString(&pk->controller, id, sizeof(id))));
    }
    CHECK(JsonGenerator_WriteStringField(gen, "publicKeyBase58", pk->publicKeyBase58));
    CHECK(JsonGenerator_WriteEndObject(gen));

    return 0;
}

static int didurl_func(const void *a, const void *b)
{
    char _stringa[MAX_DID], _stringb[MAX_DID];
    char *stringa, *stringb;

    PublicKey *keya = (PublicKey*)a;
    PublicKey *keyb = (PublicKey*)b;

    stringa = DIDURL_ToString(&keya->id, _stringa, MAX_DID, true);
    stringb = DIDURL_ToString(&keyb->id, _stringb, MAX_DID, true);

    return strcmp(stringa, stringb);
}

static
int PublicKeyArray_ToJson(JsonGenerator *gen, PublicKey **pks, size_t size,
                          int compact, int quoted)
{
    size_t i;

    assert(gen);
    assert(gen->buffer);
    assert(pks);

    qsort(pks, size, sizeof(PublicKey*), didurl_func);

    CHECK(JsonGenerator_WriteStartArray(gen));
    for (i = 0; i < size; i++ ) {
        char id[MAX_DIDURL];

        if (!quoted)
            CHECK(PublicKey_ToJson(gen, pks[i], compact));
        if (quoted)
            CHECK(JsonGenerator_WriteString(gen,
                DIDURL_ToString(&pks[i]->id, id, sizeof(id), compact)));
    }
    CHECK(JsonGenerator_WriteEndArray(gen));

    return 0;
}

static
int Service_ToJson(JsonGenerator *gen, Service *service, int compact)
{
    char id[MAX_DIDURL];

    assert(gen);
    assert(gen->buffer);
    assert(service);

    CHECK(JsonGenerator_WriteStartObject(gen));
    CHECK(JsonGenerator_WriteStringField(gen, "id",
        DIDURL_ToString(&service->id, id, sizeof(id), compact)));
    if (!compact)
       CHECK(JsonGenerator_WriteStringField(gen, "type", service->type));
    CHECK(JsonGenerator_WriteStringField(gen, "serviceEndpoint", service->endpoint));
    CHECK(JsonGenerator_WriteEndObject(gen));

    return 0;
}

static
int ServiceArray_ToJson(JsonGenerator *gen, Service **services, size_t size,
                        int compact)
{
    size_t i;

    assert(gen);
    assert(gen->buffer);
    assert(services);

    // TODO: qsort ?

    CHECK(JsonGenerator_WriteStartArray(gen));
    for ( i = 0; i < size; i++ ) {
        CHECK(Service_ToJson(gen, services[i], compact));
    }
    CHECK(JsonGenerator_WriteEndArray(gen));

    return 0;
}

static int proof_toJson(JsonGenerator *gen, DIDDocument *doc, int compact)
{
    char id[MAX_DIDURL];
    char _timestring[DOC_BUFFER_LEN];

    assert(gen);
    assert(gen->buffer);
    assert(doc);

    CHECK(JsonGenerator_WriteStartObject(gen));
    if (!compact)
        CHECK(JsonGenerator_WriteStringField(gen, "type", doc->proof.type));
    CHECK(JsonGenerator_WriteStringField(gen, "created",
            get_time_string(_timestring, sizeof(_timestring), &doc->proof.created)));
    CHECK(JsonGenerator_WriteStringField(gen, "creator",
            DIDURL_ToString(&doc->proof.creater, id, sizeof(id), compact)));
    CHECK(JsonGenerator_WriteStringField(gen, "signatureValue", doc->proof.signatureValue));
    CHECK(JsonGenerator_WriteEndObject(gen));
    return 0;
}

//api don't check if pk is existed in array.
static int add_to_publickeys(DIDDocument *document, PublicKey *pk, KeyType keytype)
{
    PublicKey **pks, **pk_array = NULL;
    size_t size;

    assert(document);
    assert(pk);

    switch (keytype) {
        case KeyType_Authentication:
            pk_array = document->authentication.pks;
            size = document->authentication.size;
            break;
        case KeyType_Authorization:
            pk_array = document->authorization.pks;
            size = document->authorization.size;
            break;
        case KeyType_PublicKey:
            pk_array = document->publickeys.pks;
            size = document->publickeys.size;
            break;
        default:
            return -1;
    }

    if (!pk_array)
        pks = (PublicKey**)calloc(1, sizeof(PublicKey*));
    else
        pks = realloc(pk_array,
                     (size + 1) * sizeof(PublicKey*));

    if (!pks)
        return -1;
    pks[size] = pk;

    switch(keytype) {
        case KeyType_Authentication:
            document->authentication.pks = pks;
            document->authentication.size++;
            break;
        case KeyType_Authorization:
            document->authorization.pks = pks;
            document->authorization.size++;
            break;
        case KeyType_PublicKey:
            document->publickeys.pks = pks;
            document->publickeys.size++;
            break;
    }

    return 0;
}

static int Parser_PublicKey(DID *did, cJSON *json, PublicKey **publickey)
{
    PublicKey *pk;
    cJSON *field;

    assert(did);
    assert(json);
    assert(publickey);

    pk = (PublicKey*)calloc(1, sizeof(PublicKey));
    if (!pk)
        return -1;

    field = cJSON_GetObjectItem(json, "id");
    if (!field || !cJSON_IsString(field)) {
        PublicKey_Destroy(pk);
        return -1;
    }

    if (parse_didurl(&pk->id, field->valuestring, did) < 0) {
        PublicKey_Destroy(pk);
        return -1;
    }

    assert(strcmp(did->idstring, pk->id.did.idstring) == 0);

    // set default value for 'type'
    strcpy(pk->type, "ECDSAsecp256r1");

    field = cJSON_GetObjectItem(json, "publicKeybase58");
    if (!field || !cJSON_IsString(field)) {
        PublicKey_Destroy(pk);
        return -1;
    }

    //public key must be have 'publicKeybase58'
    strcpy(pk->publicKeyBase58, field->valuestring);

    //'controller' may be default
    field = cJSON_GetObjectItem(json, "controller");
    if (field && (!cJSON_IsString(field) ||
            parse_did(&pk->controller, field->valuestring) < 0)) {
        PublicKey_Destroy(pk);
        return -1;
    }

    if (!field) { // the controller is self did.
        strcpy(pk->controller.idstring, did->idstring);
        *publickey = pk;
        return 0;
    }

    *publickey = pk;
    return 0;
}

static int Parser_PublicKeys(DIDDocument *document, DID *did, cJSON *json)
{
    int pk_size, i, size = 0;

    assert(document);
    assert(did);
    assert(json);

    pk_size = cJSON_GetArraySize(json);
    if (!pk_size)
        return -1;

    //parse public key(required)
    PublicKey **pks = (PublicKey**)calloc(pk_size, sizeof(PublicKey*));
    if (!pks)
        return -1;

    for (i = 0; i < pk_size; i++) {
        cJSON *pk_item, *id_field, *base_field;
        PublicKey *pk;

        pk_item = cJSON_GetArrayItem(json, i);
        if (!pk_item)
            continue;

        //check public key's format
        id_field = cJSON_GetObjectItem(pk_item, "id");
        base_field = cJSON_GetObjectItem(pk_item, "publicKeybase58");
        if (!id_field || !base_field)              //(required and can't default)
            continue;

        if (Parser_PublicKey(did, pk_item, &pk) == -1)
            continue;

        pks[size++] = pk;
    }

    if (!size) {
        free(pks);
        return -1;
    }

    document->publickeys.pks = pks;
    document->publickeys.size = size;

    return 0;
}

static
int Parser_Auth_PublicKeys(DIDDocument *document, cJSON *json, KeyType keytype)
{
    int pk_size, i, j, size = 0, total_size = 0;

    assert(document);
    assert(json);

    pk_size = cJSON_GetArraySize(json);
    if (!pk_size)
        return -1;

    //parse authentication(required)
    PublicKey **pks = (PublicKey**)calloc(pk_size, sizeof(PublicKey*));
    if (!pks)
        return -1;

    for (i = 0; i < pk_size; i++) {
        DIDURL id;
        cJSON *pk_item, *id_field;

        pk_item = cJSON_GetArrayItem(json, i);
        if (!pk_item)
            continue;

        id_field = cJSON_GetObjectItem(pk_item, "id");
        if (!id_field) {
            if (parse_didurl(&id, pk_item->valuestring, &document->did) < 0)
                    continue;

            for (j = 0; j < document->publickeys.size; j++) {
                int flag = 0;

                PublicKey *pk = document->publickeys.pks[j];
                if (DIDURL_Equals(&id, &pk->id)) {
                    flag = 1;
                    pks[size++] = pk;
                    break;
                }
            }
            continue;
        }

        PublicKey *pk;
        if (Parser_PublicKey(&(document->did), pk_item, &pk) == -1)
            continue;

        if (add_to_publickeys(document, pk, KeyType_PublicKey) == -1) {
            free(pk);
            continue;
        }

        pks[size++] = pk;
        continue;
    }

    if (!size) {
        free(pks);
        return -1;
    }

    if (keytype == KeyType_Authentication) {
        document->authentication.pks = pks;
        document->authentication.size = size;
        return size;
    }

    document->authorization.pks = pks;
    document->authorization.size = size;
    return size;
}

static int Parser_Authentication(DIDDocument *document, cJSON *json)
{
    if (!document || !json)
        return -1;

    return Parser_Auth_PublicKeys(document, json, KeyType_Authentication);
}

static int Parser_Authorization(DIDDocument *document, cJSON *json)
{
    if (!document || !json)
        return -1;

    return Parser_Auth_PublicKeys(document, json, KeyType_Authorization);
}

static int Parser_Services(DIDDocument *document, cJSON *json)
{
    size_t service_size;
    size_t autal_size = 0;
    size_t i;

    if (!document || !json)
        return -1;

    service_size = cJSON_GetArraySize(json);
    if (!service_size)
        return -1;

    Service **services = (Service**)calloc(service_size, sizeof(Service*));
    if (!services)
        return -1;

    for (i = 0; i < service_size; i++) {
        Service *service;
        cJSON *item;
        cJSON *field;

        item = cJSON_GetArrayItem(json, i);
        if (!item)
            continue;

        service = (Service *)calloc(1, sizeof(Service));
        if (!service)
            continue;

        field = cJSON_GetObjectItem(item, "id");
        if (!field || !cJSON_IsString(field)) {
            Service_Destroy(service);
            continue;
        }

        if (parse_didurl(&service->id, field->valuestring, &document->did) < 0) {
            Service_Destroy(service);
            continue;
        }

        if (!*service->id.did.idstring)
            strcpy(service->id.did.idstring, document->did.idstring);

        field = cJSON_GetObjectItem(item, "type");
        if (!field || !cJSON_IsString(field)) {
            Service_Destroy(service);
            continue;
        }
        strcpy(service->type, field->valuestring);

        field = cJSON_GetObjectItem(item, "serviceEndPoint");
        if (!field || !cJSON_IsString(field)) {
            Service_Destroy(service);
            continue;
        }
        strcpy(service->endpoint, field->valuestring);

        services[autal_size++] = service;
    }

    if (!autal_size) {
        free(services);
        return -1;
    }

    document->services.services = services;
    document->services.size = autal_size;

    return 0;
}

static int Parser_Proof(DIDDocument *document, cJSON *json)
{
    cJSON *item;

    assert(document);
    assert(json);

    item = cJSON_GetObjectItem(json, "type");
    if (item) {
        if ((cJSON_IsString(item) && strlen(item->valuestring) + 1 > MAX_TYPE) ||
                !cJSON_IsString(item))
            return -1;
        else
            strcpy(document->proof.type, item->valuestring);
    }
    else
        strcpy(document->proof.type, ProofType);

    item = cJSON_GetObjectItem(json, "created");
    if (!item || !cJSON_IsString(item) ||
            parse_time(&document->proof.created, item->valuestring) == -1)
        return -1;

    item = cJSON_GetObjectItem(json, "creator");
    if (item && (!cJSON_IsString(item) ||
            parse_didurl(&document->proof.creater, item->valuestring, &document->did) == -1))
        return -1;

    if (!item && DIDURL_Copy(&document->proof.creater,
            DIDDocument_GetDefaultPublicKey(document)) == -1)
        return -1;

    item = cJSON_GetObjectItem(json, "signatureValue");
    if (!item || !cJSON_IsString(item) ||
            (strlen(item->valuestring) + 1 > MAX_SIGN))
        return -1;
    strcpy(document->proof.signatureValue, item->valuestring);

    return 0;
}

static bool check_auth_publickey(DIDDocument *document, DIDURL *keyid, KeyType keytype)
{
    PublicKey **pks;
    PublicKey *pk = NULL;
    size_t size;
    size_t i;

    assert(document);
    assert(keyid);
    assert(keytype == KeyType_Authentication || keytype == KeyType_Authorization);

    if (keytype == KeyType_Authentication) {
        size = DIDDocument_GetAuthenticationCount(document);
        pks = document->authentication.pks;
    }
    else {
        size = DIDDocument_GetAuthorizationCount(document);
        pks = document->authorization.pks;
    }

    for ( i = 0; i < size; i++ ) {
        pk = pks[i];
        if (DIDURL_Equals(&pk->id, keyid))
            return true;
    }

    return false;
}

//publickey: type = 0; authentication: type = 1; authorization: type = 2
static void remove_publickey(DIDDocument *document, DIDURL *keyid, KeyType keytype)
{
    PublicKey **pks;
    PublicKey *pk = NULL;
    size_t *pk_size;
    size_t size;
    size_t i;

    assert(document);
    assert(keyid);
    assert(keytype == KeyType_Authentication || keytype == KeyType_Authorization ||
            keytype == KeyType_PublicKey);

    if (keytype == KeyType_Authentication) {
        size = DIDDocument_GetAuthenticationCount(document);
        pks = document->authentication.pks;
        pk_size = &document->authentication.size;
    }
    else if(keytype == KeyType_Authorization) {
        size = DIDDocument_GetAuthorizationCount(document);
        pks = document->authorization.pks;
        pk_size = &document->authorization.size;
    }
    else {
        size = DIDDocument_GetPublicKeyCount(document);
        pks = document->publickeys.pks;
        pk_size = &document->publickeys.size;
    }

    for ( i = 0; i < size; i++ ) {
        pk = pks[i];
        if (!DIDURL_Equals(&pk->id, keyid))
            continue;

        if (i != size - 1)
            memcpy(pks + sizeof(PublicKey*) * i, pks + sizeof(PublicKey*) * (i + 1),
                    size - i - 1);

        pks[size - 1] = NULL;
        (*pk_size)--;

        if (keytype == KeyType_PublicKey)
            PublicKey_Destroy(pk);

        return;
    }
}

static int Parser_Credentials_InDoc(DIDDocument *document, cJSON *json)
{
    size_t size = 0;

    assert(document);
    assert(json);

    size = cJSON_GetArraySize(json);
    if (size <= 0)
        return -1;

    Credential **credentials = (Credential**)calloc(size, sizeof(Credential*));
    if (!credentials)
        return -1;

    size = Parser_Credentials(DIDDocument_GetSubject(document), credentials, size, json);
    if (size <= 0) {
        free(credentials);
        return -1;
    }

    document->credentials.credentials = credentials;
    document->credentials.size = size;

    return 0;
}

DIDMeta *document_getmeta(DIDDocument *document)
{
    if (!document)
        return NULL;

    return &document->meta;
}

////////////////////////////////Document///////////////////////////////////////////////////////////
DIDDocument *DIDDocument_FromJson(const char *json)
{
    DIDDocument *doc;
    cJSON *root;
    cJSON *item;

    if (!json)
        return NULL;

    root = cJSON_Parse(json);
    if (!root)
        return NULL;

    doc = (DIDDocument*)calloc(1, sizeof(DIDDocument));
    if (!doc) {
        cJSON_Delete(root);
        return NULL;
    }

    item = cJSON_GetObjectItem(root, "id");
    if (!item || !cJSON_IsString(item) ||
        parse_did(&doc->did, item->valuestring) == -1)
        goto errorExit;

    //parse publickey
    item = cJSON_GetObjectItem(root, "publicKey");
    if (!item || !cJSON_IsArray(item) ||
        Parser_PublicKeys(doc, &doc->did, item) == -1)
        goto errorExit;

    //parse authentication(optional)
    item = cJSON_GetObjectItem(root, "authentication");
    if (item && (!cJSON_IsArray(item) ||
            Parser_Authentication(doc, item) == -1))
        goto errorExit;

    item = cJSON_GetObjectItem(root, "authorization");
    if (item  && (!cJSON_IsArray(item) ||
            Parser_Authorization(doc, item) == -1))
        goto errorExit;

    //parse expires
    item = cJSON_GetObjectItem(root, "expires");
    if (!item || !cJSON_IsString(item) ||
        parse_time(&doc->expires, item->valuestring) == -1)
        goto errorExit;

    //todo: parse credential
    item = cJSON_GetObjectItem(root, "verifiableCredential");
    if (item && (!cJSON_IsArray(item) ||
            Parser_Credentials_InDoc(doc, item) == -1))
        goto errorExit;

    //parse services
    item = cJSON_GetObjectItem(root, "service");
    if (item && (!cJSON_IsArray(item) ||
            Parser_Services(doc, item) == -1))
        goto errorExit;

    item = cJSON_GetObjectItem(root, "proof");
    if (!item || !cJSON_IsObject(item) ||
            Parser_Proof(doc, item) == -1)
        goto errorExit;

    cJSON_Delete(root);
    return doc;

errorExit:
    DIDDocument_Destroy(doc);
    cJSON_Delete(root);

    return NULL;
}

static
int DIDDocument_ToJson_Internal(JsonGenerator *gen, DIDDocument *doc,
        int compact, int forsign)
{
    char id[MAX_DIDURL];
    char _timestring[DOC_BUFFER_LEN];
    size_t i;

    assert(gen);
    assert(gen->buffer);
    assert(doc);

    CHECK(JsonGenerator_WriteStartObject(gen));
    CHECK(JsonGenerator_WriteStringField(gen, "id",
        DID_ToString(&doc->did, id, sizeof(id))));
    CHECK(JsonGenerator_WriteFieldName(gen, "publicKey"));
    CHECK(PublicKeyArray_ToJson(gen, doc->publickeys.pks, doc->publickeys.size,
                                 compact, 0));

    if (doc->authentication.size > 0) {
        CHECK(JsonGenerator_WriteFieldName(gen, "authentication"));
        CHECK(PublicKeyArray_ToJson(gen, doc->authentication.pks,
                                doc->authentication.size, compact, 1));
    }

    if (doc->authorization.size > 0) {
        CHECK(JsonGenerator_WriteFieldName(gen, "authorization"));
        CHECK(PublicKeyArray_ToJson(gen, doc->authorization.pks,
                                doc->authorization.size, compact, 1));
    }

    if (doc->credentials.size > 0) {
        CHECK(JsonGenerator_WriteFieldName(gen, "verifiableCredential"));
        CHECK(CredentialArray_ToJson(gen, doc->credentials.credentials,
                                 doc->credentials.size, compact));
    }

    if (doc->services.size > 0) {
        CHECK(JsonGenerator_WriteFieldName(gen, "service"));
        CHECK(ServiceArray_ToJson(gen, doc->services.services,
                                doc->services.size, compact));
    }

    CHECK(JsonGenerator_WriteStringField(gen, "expires",
            get_time_string(_timestring, sizeof(_timestring), &doc->expires)));
    if (!forsign) {
        CHECK(JsonGenerator_WriteFieldName(gen, "proof"));
        CHECK(proof_toJson(gen, doc, compact));
    }
    CHECK(JsonGenerator_WriteEndObject(gen));

    return 0;
}

const char *DIDDocument_ToJson(DIDDocument *doc, int compact, int forsign)
{
    JsonGenerator g, *gen;

    if (!doc)
        return NULL;

    gen = JsonGenerator_Initialize(&g);
    if (!gen)
        return NULL;

    if (DIDDocument_ToJson_Internal(gen, doc, compact, forsign) < 0)
        return NULL;

    return JsonGenerator_Finish(gen);
}

void DIDDocument_Destroy(DIDDocument *document)
{
    size_t i;

    if (!document)
        return;

    for (i = 0; i < document->publickeys.size; i++)
        PublicKey_Destroy(document->publickeys.pks[i]);

    for (i = 0; i < document->services.size; i++)
        Service_Destroy(document->services.services[i]);

    for (i = 0; i < document->credentials.size; i++)
        Credential_Destroy(document->credentials.credentials[i]);

    if (document->publickeys.pks)
        free(document->publickeys.pks);

    if (document->authentication.pks)
        free(document->authentication.pks);

    if (document->authorization.pks)
        free(document->authorization.pks);

    if (document->services.services)
        free(document->services.services);

    if (document->credentials.credentials)
        free(document->credentials.credentials);

    free(document);
    document = NULL;
}

int DIDDocument_SetAlias(DIDDocument *document, const char *alias)
{
    DIDStore *store;

    if (!document)
        return -1;

    if (DIDMeta_SetAlias(&document->meta, alias) == -1)
        return -1;

    store = DIDStore_GetInstance();
    return didstore_storedidmeta(store, &document->meta, &document->did);
}

int DIDDocument_GetAlias(DIDDocument *document, char *alias, size_t size)
{
    if (!document || !alias || size <= 0)
        return -1;

    return DIDMeta_GetAlias(&document->meta, alias, size);
}

int DIDDocument_GetTxid(DIDDocument *document, char *txid, size_t size)
{
    if (!document || !txid || size <= 0)
        return -1;

    return DIDMeta_GetTxid(&document->meta, txid, size);
}

time_t DIDDocument_GetTimestamp(DIDDocument *document)
{
    if (!document)
        return 0;

    return DIDMeta_GetTimestamp(&document->meta);
}

bool DIDDocument_IsDeactivated(DIDDocument *document)
{
    if (!document)
        return true;

    return DIDMeta_GetDeactived(&document->meta);
}

bool DIDDocument_IsGenuine(DIDDocument *document)
{
    const char *data;
    int rc;

    if (!document)
        return false;

    if (!DIDURL_Equals(DIDDocument_GetDefaultPublicKey(document),
            &document->proof.creater))
        return false;

    if (strcmp(document->proof.type, ProofType))
        return false;

    data = DIDDocument_ToJson(document, 0, 1);
    if (!data)
        return false;

    rc = DIDDocument_Verify(document, NULL, document->proof.signatureValue, 1,
            (unsigned char*)data, strlen(data));
    return rc == 0 ? true : false;
}

bool DIDDocument_IsExpires(DIDDocument *document)
{
    time_t curtime;

    if (!document)
        return true;

    curtime = time(NULL);
    return curtime > document->expires;
}

bool DIDDocument_IsValid(DIDDocument *document)
{
    if (!document)
        return false;

    return !DIDDocument_IsExpires(document) &&
           !DIDDocument_IsDeactivated(document) && DIDDocument_IsGenuine(document);
}

static int publickeys_copy(DIDDocument *doc, PublicKey **pks, size_t size, KeyType keytype)
{
    PublicKey **pk_array;
    size_t *psize;
    int i;

    assert(doc);
    assert(pks);
    assert(size >= 0);

    if (size == 0)
        return 0;

    pk_array = (PublicKey**)calloc(size, sizeof(PublicKey*));
    if (!pk_array)
        return -1;

    switch (keytype) {
        case KeyType_Authentication:
            doc->authentication.pks = pk_array;
            psize = &doc->authentication.size;
            break;
        case KeyType_Authorization:
            doc->authorization.pks = pk_array;
            psize = &doc->authorization.size;
            break;
        case KeyType_PublicKey:
            doc->publickeys.pks = pk_array;
            psize = &doc->publickeys.size;
            break;
        default:
            return -1;
    }

    for (i = 0; i < size; i++) {
        PublicKey *pk = (PublicKey*)calloc(1, sizeof(PublicKey));
        if (!pk)
            return -1;

        memcpy(pk_array[(*psize)++], pks[i], sizeof(PublicKey));
    }
    return 0;
}

static int credentials_copy(DIDDocument *doc, Credential **creds, size_t size)
{
    Credential **cred_array;
    int i, j;

    assert(doc);
    assert(creds);
    assert(size >= 0);

    if (size == 0)
        return 0;

    doc->credentials.credentials = (Credential**)calloc(size, sizeof(Credential*));
    if (!doc->credentials.credentials)
        return -1;

    for (i = 0; i < size; i++) {
        Credential *ccred;
        size_t typesize;
        Credential *cred = (Credential*)calloc(1, sizeof(Credential));
        if (!cred)
            return -1;

        ccred = creds[i];
        memcpy(cred, ccred, sizeof(Credential));
        typesize = ccred->type.size;
        if (typesize == 0)
            continue;

        cred->type.types = calloc(typesize, sizeof(char*));
        if (!cred->type.types)
            return -1;

        for (j = 0; j < typesize; j++) {
            char *type = ccred->type.types[j];
            size_t len = strlen(type) + 1;
            cred->type.types[j] = calloc(len, 1);
            if (!cred->type.types[j])
                return -1;

            strcpy(cred->type.types[j], type);
            cred->type.size = j + 1;
        }
        doc->credentials.size = i + 1;
    }

    return 0;
}

static int services_copy(DIDDocument *doc, Service **services, size_t size)
{
    int i;

    assert(doc);
    assert(services);
    assert(size >= 0);

    if (size == 0)
        return 0;

    doc->services.services = (Service**)calloc(size, sizeof(Service*));
    if (!doc->services.services)
        return -1;

    for (i = 0; i < size; i++) {
        Service *service = (Service*)calloc(1, sizeof(Service));
        if (!service)
            return -1;
        memcpy(service, services[i], sizeof(Service));
        doc->services.services[i] = service;
        doc->services.size = i + 1;
    }
    return 0;
}

static int DIDDocument_Copy(DIDDocument *doc, DIDDocument *document)
{
    size_t size;
    int i;

    assert(doc);
    assert(document);

    DID_Copy(&doc->did, &document->did);

    if (publickeys_copy(doc, document->publickeys.pks, document->publickeys.size,
            KeyType_PublicKey) == -1 || publickeys_copy(doc,
            document->authentication.pks, document->authentication.size,
            KeyType_Authentication) == -1 || publickeys_copy(doc,
            document->authorization.pks, document->authorization.size,
            KeyType_Authorization) == -1)
        return -1;

    if (credentials_copy(doc, document->credentials.credentials,
            document->credentials.size) == -1)
        return -1;

    if (services_copy(doc, document->services.services, document->services.size) == -1)
        return -1;

    doc->expires = document->expires;
    memcpy(&doc->proof, &document->proof, sizeof(DocumentProof));
    return 0;
}

DIDDocumentBuilder* DIDDocument_Modify(DIDDocument *document)
{
    DIDDocumentBuilder *builder;

    builder = (DIDDocumentBuilder*)calloc(1, sizeof(DIDDocumentBuilder));
    if (!builder)
        return NULL;

    builder->document = (DIDDocument*)calloc(1, sizeof(DIDDocument));
    if (!builder->document) {
        free(builder);
        return NULL;
    }

    if (document && DIDDocument_Copy(builder->document, document) == -1) {
        DIDDocumentBuilder_Destroy(builder);
        return NULL;
    }

    return builder;
}

void DIDDocumentBuilder_Destroy(DIDDocumentBuilder *builder)
{
    if (!builder)
        return;

    if (!builder->document) {
        free(builder);
        return;
    }

    DIDDocument_Destroy(builder->document);
    free(builder);
}

DIDDocument *DIDDocumentBuilder_Seal(DIDDocumentBuilder *builder, const char *storepass)
{
    DIDDocument *doc;
    DIDURL *key;
    const char *data;
    char signature[SIGNATURE_BYTES * 2 + 16];
    int rc;

    if (!builder || !storepass || !*storepass)
        return NULL;

    doc = builder->document;
    key = DIDDocument_GetDefaultPublicKey(doc);
    if (!key) {
       //DIDDocumentBuilder_Destroy(builder);
        return NULL;
    }

    data = DIDDocument_ToJson(doc, 0, 1);
    if (!data) {
        //DIDDocumentBuilder_Destroy(builder);
        return NULL;
    }

    rc = DIDDocument_Sign(doc, key, storepass, signature, 1,
            (unsigned char*)data, strlen(data));
    free((char*)data);
    if (rc) {
        //sDIDDocumentBuilder_Destroy(builder);
        return NULL;
    }

    strcpy(doc->proof.type, ProofType);
    time(&doc->proof.created);
    DIDURL_Copy(&doc->proof.creater, key);
    strcpy(doc->proof.signatureValue, signature);

    builder->document = NULL;
    return doc;
}

static
PublicKey *create_publickey(DIDURL *id, DID *controller, const char *publickey)
{
    PublicKey *pk = NULL;

    assert(id);
    assert(controller);
    assert(publickey);

    pk = (PublicKey*)calloc(1, sizeof(PublicKey));
    if (!pk)
        return NULL;

    DIDURL_Copy(&pk->id, id);
    DID_Copy(&pk->controller, controller);

    strcpy(pk->type, "ECDSAsecp256r1");
    strcpy(pk->publicKeyBase58, publickey);

    return pk;
}

int DIDDocumentBuilder_AddPublicKey(DIDDocumentBuilder *builder, DIDURL *keyid,
        DID *controller, const char *key)
{
    DIDDocument *document;
    PublicKey *pk;
    uint8_t binkey[PUBLICKEY_BYTES];
    size_t size;
    int i;

    if (!builder || !builder->document || !keyid || !key || !*key ||
        strlen(key) >= MAX_PUBLICKEY_BASE58)
        return -1;

    //check base58 is valid and keyid is existed in pk array
    if (base58_decode(binkey, key) != PUBLICKEY_BYTES)
        return -1;

    document = builder->document;
    size = DIDDocument_GetPublicKeyCount(document);
    for (i = 0; i < size; i++) {
        pk = document->publickeys.pks[i];
        if (DIDURL_Equals(&pk->id, keyid) ||
            !strcmp(pk->publicKeyBase58, key))
            return -1;
    }

    if (!controller)
        controller = DIDDocument_GetSubject(document);

    pk = create_publickey(keyid, controller, key);
    if (!pk)
        return -1;

    if (add_to_publickeys(document, pk, KeyType_PublicKey) == -1) {
        PublicKey_Destroy(pk);
        return -1;
    }

    return 0;
}

int DIDDocumentBuilder_RemovePublicKey(DIDDocumentBuilder *builder, DIDURL *keyid, bool force)
{
    DIDDocument* document;
    PublicKey *pk = NULL;
    DIDURL *key;
    size_t size;
    size_t i;

    if (!builder || !builder->document || !keyid)
        return -1;

    document = builder->document;
    key = DIDDocument_GetDefaultPublicKey(document);
    if (DIDURL_Equals(key, keyid))
        return -1;

    if (!force && (check_auth_publickey(document, keyid, KeyType_Authentication) ||
                check_auth_publickey(document, keyid, KeyType_Authorization)))
        return -1;

    if (force) {
        remove_publickey(document, keyid, KeyType_Authentication);
        remove_publickey(document, keyid, KeyType_Authorization);
    }

    remove_publickey(document, keyid, KeyType_PublicKey);

    return 0;
}

//authentication keys are all did's own key.
int DIDDocumentBuilder_AddAuthenticationKey(DIDDocumentBuilder *builder,
        DIDURL *keyid, const char *key)
{
    DIDDocument *document;
    PublicKey **pks;
    PublicKey *pk;
    uint8_t binkey[PUBLICKEY_BYTES];
    DID *controller;

    if (!builder || !builder->document || !keyid || !key || !*key ||
        strlen (key) >= MAX_PUBLICKEY_BASE58)
        return -1;

    if (base58_decode(binkey, key) != PUBLICKEY_BYTES)
        return -1;

    document = builder->document;
    //check new authentication key is exist in publickeys
    pk = DIDDocument_GetPublicKey(document, keyid);
    if (pk) {
        if ((!strcmp(pk->publicKeyBase58, key) &&
                DIDDocument_IsAuthenticationKey(document, keyid)) ||
                strcmp(pk->publicKeyBase58, key) )
            return -1;
        else
            return add_to_publickeys(document, pk, KeyType_Authentication);
    }

    controller = DIDDocument_GetSubject(document);
    pk = create_publickey(keyid, controller, key);
    if (!pk)
        return -1;

    if (add_to_publickeys(document, pk, KeyType_PublicKey) == -1) {
        PublicKey_Destroy(pk);
        return -1;
    }

    if (add_to_publickeys(document, pk, KeyType_Authentication) == -1) {
        remove_publickey(document, &pk->id, KeyType_PublicKey);
        PublicKey_Destroy(pk);
        return -1;
    }

    return 0;
}

int DIDDocumentBuilder_RemoveAuthenticationKey(DIDDocumentBuilder *builder, DIDURL *keyid)
{
    DIDDocument *document;
    DIDURL *key;

    if (!builder || !builder->document || !keyid)
        return -1;

    document = builder->document;
    key = DIDDocument_GetDefaultPublicKey(document);
    if (DIDURL_Equals(key, keyid))
        return -1;

    remove_publickey(document, keyid, KeyType_Authentication);
    return 0;
}

bool DIDDocument_IsAuthenticationKey(DIDDocument *document, DIDURL *keyid)
{
    return check_auth_publickey(document, keyid, KeyType_Authentication);
}

bool DIDDocument_IsAuthorizationKey(DIDDocument *document, DIDURL *keyid)
{
    return check_auth_publickey(document, keyid, KeyType_Authorization);
}

int DIDDocumentBuilder_AddAuthorizationKey(DIDDocumentBuilder *builder, DIDURL *keyid,
        DID *controller, const char *key)
{
    DIDDocument *document;
    PublicKey **pks;
    PublicKey *pk = NULL;
    uint8_t binkey[PUBLICKEY_BYTES];

    if (!builder || !builder->document || !keyid || !controller || !key || !*key ||
        strlen (key) >= MAX_PUBLICKEY_BASE58)
        return -1;

    document = builder->document;
    if (DID_Equals(controller, DIDDocument_GetSubject(document)))
        return -1;

    if (base58_decode(binkey, key) != PUBLICKEY_BYTES)
        return -1;

    //check new authentication key is exist in publickeys
    pk = DIDDocument_GetPublicKey(document, keyid);
    if (pk) {
        if ((!strcmp(pk->publicKeyBase58, key) &&
                DIDDocument_IsAuthorizationKey(document, keyid)) ||
                strcmp(pk->publicKeyBase58, key))
            return -1;
        else
            return add_to_publickeys(document, pk, KeyType_Authorization);
    }

    pk = create_publickey(keyid, controller, key);
    if (!pk)
        return -1;

    if (add_to_publickeys(document, pk, KeyType_PublicKey) == -1) {
        PublicKey_Destroy(pk);
        return -1;
    }

    if (add_to_publickeys(document, pk, KeyType_Authorization) == -1) {
        remove_publickey(document, &pk->id, KeyType_PublicKey);
        PublicKey_Destroy(pk);
        return -1;
    }

    return 0;
}

int DIDDocumentBuilder_AuthorizationDid(DIDDocumentBuilder *builder, DIDURL *keyid,
        DID *controller, DIDURL *authorkeyid)
{
    DIDDocument *doc;
    PublicKey *pk;
    int rc;

    if (!builder || !builder->document || !keyid || !controller || !authorkeyid)
        return -1;

    doc = DID_Resolve(controller);
    if (!doc)
        return -1;

    pk = DIDDocument_GetAuthenticationKey(doc, authorkeyid);
    if (!pk) {
        DIDDocument_Destroy(doc);
        return -1;
    }

    rc = DIDDocumentBuilder_AddAuthorizationKey(builder, keyid, controller,
            pk->publicKeyBase58);
    DIDDocument_Destroy(doc);
    return rc;
}

int DIDDocumentBuilder_RemoveAuthorizationKey(DIDDocumentBuilder *builder, DIDURL *keyid)
{
    DIDDocument *document;
    DIDURL *key;

    if (!builder || !builder->document || !keyid)
        return -1;

    document = builder->document;
    key = DIDDocument_GetDefaultPublicKey(document);
    if (DIDURL_Equals(key, keyid))
        return -1;

    remove_publickey(document, keyid, KeyType_Authorization);

    return 0;
}

int DIDDocumentBuilder_AddCredential(DIDDocumentBuilder *builder, Credential *credential)
{
    DIDDocument *document;
    Credential **creds = NULL;
    Credential *temp_cred = NULL;
    DIDURL *credid;
    ssize_t i;

    if (!builder || !builder->document || !credential)
        return -1;

    document = builder->document;
    credid = Credential_GetId(credential);
    if (!DID_Equals(DIDDocument_GetSubject(document), DIDURL_GetDid(credid)))
        return -1;

    for (i = 0; i < document->credentials.size; i++) {
        temp_cred = document->credentials.credentials[i];
        if (DIDURL_Equals(&temp_cred->id, &credential->id))
            return -1;
    }

    if (document->credentials.size == 0)
        creds = (Credential**)calloc(1, sizeof(Credential*));
    else
        creds = (Credential**)realloc(document->credentials.credentials,
                       (document->credentials.size + 1) * sizeof(Credential*));

    if (!creds)
        return -1;

    creds[document->credentials.size] = credential;
    document->credentials.credentials = creds;
    document->credentials.size++;

    return 0;
}

int DIDDocumentBuilder_RemoveCredential(DIDDocumentBuilder *builder, DIDURL *credid)
{
    DIDDocument *document;
    Credential *cred = NULL;
    size_t size;
    size_t i;

    if (!builder || !builder->document || !credid)
        return -1;

    document = builder->document;
    size = DIDDocument_GetCredentialCount(document);
    for ( i = 0; i < size; i++ ) {
        cred = document->credentials.credentials[i];
        if (!DIDURL_Equals(&cred->id, credid))
            continue;

        Credential_Destroy(cred);

        if (i != size - 1)
            memcpy(document->credentials.credentials + sizeof(Credential*) * i,
                    document->credentials.credentials + sizeof(Credential*) * (i + 1),
                    size - i - 1);

        document->credentials.credentials[size - 1] = NULL;
        document->credentials.size--;
        return 0;
    }

    return 0;
}

int DIDDocumentBuilder_AddService(DIDDocumentBuilder *builder, DIDURL *serviceid,
        const char *type, const char *endpoint)
{
    DIDDocument *document;
    Service **services = NULL;
    Service *service = NULL;
    size_t i;

    if (!builder || !builder->document || !serviceid || !type || !*type
        || strlen(type) >= MAX_TYPE || !endpoint || !*endpoint ||
        strlen(endpoint) >= MAX_ENDPOINT)
        return -1;

    document = builder->document;
    if (!DID_Equals(DIDDocument_GetSubject(document), DIDURL_GetDid(serviceid)))
        return -1;

    for (i = 0; i < document->services.size; i++) {
        service = document->services.services[i];
        if (DIDURL_Equals(&service->id, serviceid))
            return -1;
    }

    service = (Service*)calloc(1, sizeof(Service));
    if (!service)
        return -1;

    DIDURL_Copy(&service->id, serviceid);
    strcpy(service->type, type);
    strcpy(service->endpoint, endpoint);

    if (document->services.size == 0)
        services = (Service**)calloc(1, sizeof(Service*));
    else
        services = (Service**)realloc(document->services.services,
                            (document->services.size + 1) * sizeof(Service*));

    if (!services) {
        Service_Destroy(service);
        return -1;
    }

    services[document->services.size++] = service;
    document->services.services = services;

    return 0;
}

int DIDDocumentBuilder_RemoveService(DIDDocumentBuilder *builder, DIDURL *serviceid)
{
    DIDDocument *document;
    Service *service = NULL;
    size_t size;
    size_t i;

    if (!builder || !builder->document || !serviceid)
        return -1;

    document = builder->document;
    size = DIDDocument_GetServiceCount(document);
    for ( i = 0; i < size; i++ ) {
        service = document->services.services[i];
        if (!DIDURL_Equals(&service->id, serviceid))
            continue;

        Service_Destroy(service);

        if (i != size - 1)
            memcpy(document->services.services + sizeof(Service*) * i,
                    document->services.services + sizeof(Service*) * (i + 1),
                    size - i - 1);

        document->services.services[size - 1] = NULL;
        document->services.size--;
        return 0;
    }

    return 0;
}

//////////////////////////PublicKey//////////////////////////////////////////
DID* DIDDocument_GetSubject(DIDDocument *document)
{
    if (!document)
        return NULL;

    return &document->did;
}

ssize_t DIDDocument_GetPublicKeyCount(DIDDocument *document)
{
    if (!document)
        return -1;

    return (ssize_t)document->publickeys.size;
}

PublicKey *DIDDocument_GetPublicKey(DIDDocument *document, DIDURL *keyid)
{
    PublicKey *pk;
    size_t size;
    size_t i;

    if (!document || !keyid || !*keyid->fragment || !*keyid->did.idstring)
        return NULL;

    size = document->publickeys.size;
    if (!size)
        return NULL;

    for (i = 0; i < size; i++ ) {
        pk = document->publickeys.pks[i];
        if (DIDURL_Equals(keyid, &pk->id))
            return pk;
    }

    return NULL;
}

ssize_t DIDDocument_GetPublicKeys(DIDDocument *document, PublicKey **pks,
                                  size_t size)
{
    size_t actual_size;

    if (!document || !pks)
        return -1;

    actual_size = document->publickeys.size;
    if (actual_size > size)
        return -1;

    memcpy(pks, document->publickeys.pks, sizeof(PublicKey*) * actual_size);
    return (ssize_t)actual_size;
}

ssize_t DIDDocument_SelectPublicKeys(DIDDocument *document,
                                    const char *type, DIDURL *keyid,
                                    PublicKey **pks, size_t size)
{
    size_t actual_size = 0;
    size_t total_size;
    size_t i;

    if (!document || (!keyid && !type) || (keyid && !*keyid->fragment))
        return -1;

    if (keyid && !*keyid->did.idstring)
        strcpy(keyid->did.idstring, document->did.idstring);

    total_size = document->publickeys.size;
    for (i = 0; i < total_size; i++) {
        PublicKey *pk = document->publickeys.pks[i];

        if (keyid && !DIDURL_Equals(keyid, &pk->id))
            continue;
        if (type && strcmp(type, pk->type))
            continue;

        if (actual_size >= size)
            return -1;

        pks[actual_size++] = pk;
    }

    return (ssize_t)actual_size;
}

DIDURL *DIDDocument_GetDefaultPublicKey(DIDDocument *document)
{
    char idstring[MAX_ID_SPECIFIC_STRING];
    uint8_t binkey[PUBLICKEY_BYTES];
    PublicKey *pk;
    size_t i;

    if (!document)
        return NULL;

    for (i = 0; i < document->publickeys.size; i++) {
        pk = document->publickeys.pks[i];
        if (DID_Equals(&pk->controller, &document->did) == 0)
            continue;

        base58_decode(binkey, pk->publicKeyBase58);
        HDkey_GetIdString(binkey, idstring, sizeof(idstring));

        if (!strcmp(idstring, pk->id.did.idstring))
            return &pk->id;
    }

    return NULL;
}

///////////////////////Authentications/////////////////////////////
ssize_t DIDDocument_GetAuthenticationCount(DIDDocument *document)
{
    if (!document)
        return -1;

    return (ssize_t)document->authentication.size;
}

ssize_t DIDDocument_GetAuthenticationKeys(DIDDocument *document, PublicKey **pks,
                                       size_t size)
{
    size_t actual_size;

    if (!document || !pks)
        return -1;

    actual_size = document->authentication.size;
    if (actual_size > size)
        return -1;

    memcpy(pks, document->authentication.pks, sizeof(PublicKey*) * actual_size);
    return (ssize_t)actual_size;
}

PublicKey *DIDDocument_GetAuthenticationKey(DIDDocument *document, DIDURL *keyid)
{
    PublicKey *pk;
    size_t size;
    size_t i;

    if (!document || !keyid || !*keyid->fragment)
        return NULL;

    size = document->authentication.size;
    if (!size)
        return NULL;

    if (!*keyid->did.idstring)
        strcpy(keyid->did.idstring, document->did.idstring);

    for (i = 0; i < size; i++) {
        pk = document->authentication.pks[i];
        if (DIDURL_Equals(keyid, &pk->id))
            return pk;
    }

    return NULL;
}

ssize_t DIDDocument_SelectAuthenticationKeys(DIDDocument *document,
                                         const char *type, DIDURL *keyid,
                                         PublicKey **pks, size_t size)
{
    size_t actual_size = 0;
    size_t total_size;
    size_t i;

    if (!document || (!keyid && !type) || (keyid && !*keyid->fragment))
        return -1;

    if (keyid && !*keyid->did.idstring)
        strcpy(keyid->did.idstring, document->did.idstring);

    total_size = document->authentication.size;
    for (i = 0; i < total_size; i++) {
        PublicKey *pk = document->authentication.pks[i];

        if (keyid && !DIDURL_Equals(keyid, &pk->id))
            continue;
        if (type && strcmp(type, pk->type))
            continue;

        if (actual_size >= size)
            return -1;

        pks[actual_size++] = pk;
    }

    return (ssize_t)actual_size;
}

////////////////////////////Authorization//////////////////////////
ssize_t DIDDocument_GetAuthorizationCount(DIDDocument *document)
{
    if (!document)
        return -1;

    return (ssize_t)document->authorization.size;
}

ssize_t DIDDocument_GetAuthorizationKeys(DIDDocument *document, PublicKey **pks,
                                      size_t size)
{
    size_t actual_size;

    if (!document || !pks)
        return -1;

    actual_size = document->authorization.size;
    if (actual_size > size)
        return -1;

    memcpy(pks, document->authorization.pks, sizeof(PublicKey*) * actual_size);
    return (ssize_t)actual_size;
}

PublicKey *DIDDocument_GetAuthorizationKey(DIDDocument *document, DIDURL *keyid)
{
    PublicKey *pk = NULL;
    size_t size;
    size_t i;

    if (!document || !keyid)
        return NULL;

    size = document->authorization.size;
    if (!size)
        return NULL;

    if (strlen(keyid->did.idstring) == 0)
        strcpy(keyid->did.idstring, document->did.idstring);

    for (i = 0; i < size; i++) {
        pk = document->authorization.pks[i];
        if (DIDURL_Equals(keyid, &pk->id))
            return pk;
    }

    return NULL;
}

ssize_t DIDDocument_SelectAuthorizationKeys(DIDDocument *document,
                                        const char *type, DIDURL *keyid,
                                        PublicKey **pks, size_t size)
{
    size_t actual_size = 0;
    size_t total_size;
    size_t i;

    if (!document || (!keyid && !type) || (keyid && !*keyid->fragment))
        return -1;

    total_size = document->authorization.size;
    if (!total_size)
        return -1;

    if (keyid && !*keyid->did.idstring)
        strcpy(keyid->did.idstring, document->did.idstring);

    for (i = 0; i < total_size; i++) {
        PublicKey *pk = document->authorization.pks[i];

        if (keyid && !DIDURL_Equals(keyid, &pk->id))
            continue;
        if (type && strcmp(type, pk->type))
            continue;

        if (actual_size >= size)
            return -1;

        pks[actual_size++] = pk;
    }

    return (ssize_t)actual_size;
}

//////////////////////////Credential///////////////////////////
ssize_t DIDDocument_GetCredentialCount(DIDDocument *document)
{
    if (!document)
        return -1;

    return (ssize_t)document->credentials.size;
}

ssize_t DIDDocument_GetCredentials(DIDDocument *document, Credential **creds,
                                   size_t size)
{
    size_t actual_size;

    if (!document || !creds)
        return -1;

    actual_size = document->credentials.size;
    if (actual_size > size)
        return -1;

    memcpy(creds, document->credentials.credentials, sizeof(Credential*) * actual_size);
    return (ssize_t)actual_size;
}

Credential *DIDDocument_GetCredential(DIDDocument *document, DIDURL *credid)
{
    Credential *credential = NULL;
    size_t size;
    size_t i;

    if (!document || !credid || !*credid->fragment)
        return NULL;

    size = document->credentials.size;
    if (!size)
        return NULL;

    for (i = 0; i < size; i++) {
        credential = document->credentials.credentials[i];
        if (DIDURL_Equals(credid, &credential->id))
            return credential;
    }

    return NULL;
}

ssize_t DIDDocument_SelectCredentials(DIDDocument *document,
                                     const char *type, DIDURL *credid,
                                     Credential **creds, size_t size)
{
    size_t actual_size = 0;
    size_t total_size;
    size_t i, j;

    if (!document || (!credid && !type) || (credid && !*credid->fragment))
        return -1;

    total_size = document->credentials.size;
    if (!total_size)
        return -1;

    if (credid && (!*credid->did.idstring))
        strcpy(credid->did.idstring, document->did.idstring);

    for (i = 0; i < total_size; i++) {
        Credential *cred = document->credentials.credentials[i];

        if (credid && !DIDURL_Equals(credid, &cred->id))
            continue;

        if (type) { // TODO: check.
            for (j = 0; j < cred->type.size; j++) {
                const char *new_type = cred->type.types[j];
                if (!new_type || strcmp(new_type, type))
                    continue;
            }
        }

        if (actual_size >= size)
            return -1;

        creds[actual_size++] = cred;
    }

    return (ssize_t)actual_size;
}

////////////////////////////////service//////////////////////
ssize_t DIDDocument_GetServiceCount(DIDDocument *document)
{
    if (!document)
        return -1;

    return (ssize_t)document->services.size;
}

ssize_t DIDDocument_GetServices(DIDDocument *document, Service **services,
                                size_t size)
{
    size_t actual_size;

    if (!document || !services)
        return -1;

    actual_size = document->services.size;
    if (actual_size > size)
        return -1;

    memcpy(services, document->services.services, sizeof(Service*) * actual_size);
    return (ssize_t)actual_size;
}

Service *DIDDocument_GetService(DIDDocument *document, DIDURL *serviceid)
{
    Service *service = NULL;
    size_t size;
    size_t i;

    if (!document || !serviceid || !*serviceid->fragment)
        return NULL;

    size = document->services.size;
    if (!size)
        return NULL;

    for (i = 0; i < size; i++) {
        service = document->services.services[i];
        if (DIDURL_Equals(serviceid, &service->id))
            return service;
    }

    return NULL;
}

ssize_t DIDDocument_SelectServices(DIDDocument *document,
                                  const char *type, DIDURL *serviceid,
                                  Service **services, size_t size)
{
    size_t actual_size = 0;
    size_t total_size;
    size_t i;

    if (!document || (!serviceid && !type) || !*serviceid->fragment)
        return -1;

    total_size = document->services.size;
    if (!total_size)
        return -1;

    if (serviceid && !*serviceid->did.idstring)
        strcpy(serviceid->did.idstring, document->did.idstring);

    for (i = 0; i < total_size; i++) {
        Service *service = document->services.services[i];

        if (serviceid && !DIDURL_Equals(serviceid, &service->id))
            continue;
        if (type && strcmp(type, service->type))
            continue;

        if (actual_size >= size)
            return -1;

        services[actual_size++] = service;
    }

    return (ssize_t)actual_size;
}

///////////////////////////////expires////////////////////////
time_t DIDDocument_GetExpires(DIDDocument *document)
{
    if (!document)
        return 0;

    return document->expires;
}

int DIDDocument_SetExpires(DIDDocument *document, time_t expires)
{
    time_t max_expires;
    struct tm *tm = NULL;

    if (!document)
        return -1;

    max_expires = time(NULL);
    tm = gmtime(&max_expires);
    tm->tm_year += MAX_EXPIRES;
    max_expires = mktime(tm);

    if (expires == 0) {
        document->expires = max_expires;
        return 0;
    }

    tm = gmtime(&expires);
    expires = mktime(tm);

    if (expires > max_expires)
        return -1;

    document->expires = expires;
    return 0;
}

int DIDDocument_Sign(DIDDocument *document, DIDURL *keyid, const char *storepass,
         char *sig, int count, ...)
{
    int rc;
    va_list inputs;
    DIDStore *store;

    if (!document || !storepass || !*storepass || !sig || count <= 0)
        return -1;

    if (!keyid)
        keyid = DIDDocument_GetDefaultPublicKey(document);

    store = DIDStore_GetInstance();
    if (!store)
        return -1;

    va_start(inputs, count);
    rc = DIDStore_Signv(store, DIDDocument_GetSubject(document), keyid, storepass,
            sig, count, inputs);
    va_end(inputs);

    return rc;
}

int DIDDocument_Verify(DIDDocument *document, DIDURL *keyid, char *sig,
         int count, ...)
{
    int rc;
    va_list inputs;
    PublicKey *publickey;
    uint8_t binkey[PUBLICKEY_BYTES];

    if (!document || !sig || count <= 0)
        return -1;

    if (!keyid)
        keyid = DIDDocument_GetDefaultPublicKey(document);

    publickey = DIDDocument_GetPublicKey(document, keyid);
    if (!publickey)
        return -1;

    base58_decode(binkey, PublicKey_GetPublicKeyBase58(publickey));

    va_start(inputs, count);
    rc = ecdsa_verify_base64v(sig, binkey, count, inputs);
    va_end(inputs);

    return rc;
}

DIDURL *PublicKey_GetId(PublicKey *publickey)
{
    if (!publickey)
        return NULL;

    return &publickey->id;
}

DID *PublicKey_GetController(PublicKey *publickey)
{
    if (!publickey)
        return NULL;

    return &publickey->controller;
}

const char *PublicKey_GetPublicKeyBase58(PublicKey *publickey)
{
    if (!publickey)
        return NULL;

    return publickey->publicKeyBase58;
}

const char *PublicKey_GetType(PublicKey *publickey)
{
    if (!publickey)
        return NULL;

    return publickey->type;
}

DIDURL *Service_GetId(Service *service)
{
    if (!service)
        return NULL;

    return &service->id;
}

const char *Service_GetEndpoint(Service *service)
{
    if (!service)
        return NULL;

    return service->endpoint;
}

const char *Service_GetType(Service *service)
{
    if (!service)
        return NULL;

    return service->type;
}