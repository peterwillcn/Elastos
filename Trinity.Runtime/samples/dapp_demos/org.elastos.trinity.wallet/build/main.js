webpackJsonp([14],{

/***/ 11:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return Config; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};

/***
 * 封装配置信息
 */
var Config = /** @class */ (function () {
    function Config() {
    }
    Config.getKycObj = function () {
        return this.kycObj;
    };
    Config.setKycObj = function (obj) {
        this.kycObj = obj;
    };
    Config.setDeviceID = function (deviceID) {
        this.deviceID = deviceID;
    };
    Config.getdeviceID = function () {
        return this.deviceID;
    };
    Config.getSerIds = function () {
        return this.serIds;
    };
    Config.setSerIds = function (serIds) {
        console.info("Elastjs setSerIds serIds " + JSON.stringify(serIds));
        this.serIds = serIds;
    };
    Config.add = function (idObj, newIds, id, path) {
        for (var index in idObj[id][path]) {
            var data = idObj[id][path][index];
            newIds[index] = { "id": id, "path": path, "serialNum": data["serialNum"], "txHash": data["txHash"] };
        }
    };
    Config.getSertoId = function (ids) {
        var newIds = {};
        for (var key in ids) {
            var id = key;
            var idObj = ids[id];
            var path = "enterprise";
            if (idObj[path]) {
                this.add(ids, newIds, id, path);
            }
            path = "identityCard";
            if (idObj[path]) {
                this.add(ids, newIds, id, path);
            }
            path = "phone";
            if (idObj[path]) {
                this.add(ids, newIds, id, path);
            }
            path = "bankCard";
            if (idObj[path]) {
                this.add(ids, newIds, id, path);
            }
        }
        return newIds;
    };
    Config.getCurMasterWalletId = function () {
        return this.masterWalletId;
    };
    Config.setCurMasterWalletId = function (masterWalletId) {
        this.masterWalletId = masterWalletId;
    };
    Config.getMasterWalletIdList = function () {
        return this.masterWalletList;
    };
    Config.setMasterWalletIdList = function (masterWalletList) {
        this.masterWalletList = masterWalletList;
    };
    Config.uuid = function (len, radix) {
        var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
        var uuid = [], i;
        radix = radix || chars.length;
        if (len) {
            // Compact form
            for (i = 0; i < len; i++)
                uuid[i] = chars[0 | Math.random() * radix];
        }
        else {
            // rfc4122, version 4 form
            var r;
            // rfc4122 requires these characters
            uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
            uuid[14] = '4';
            // Fill in random data. At i==19 set the high bits of clock sequence as
            // per rfc4122, sec. 4.1.5
            for (i = 0; i < 36; i++) {
                if (!uuid[i]) {
                    r = 0 | Math.random() * 16;
                    uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
                }
            }
        }
        return uuid.join('');
    };
    Config.setMasterPer = function (masterId, coin, per) {
        if (this.perObj[masterId]) {
            this.perObj[masterId][coin] = per;
        }
        else {
            this.perObj[masterId] = {};
            this.perObj[masterId][coin] = per;
        }
    };
    Config.getMasterPer = function (masterId, coin) {
        if (this.perObj[masterId]) {
            return this.perObj[masterId][coin] || 0;
        }
        else {
            return 0;
        }
    };
    Config.setMappingList = function (list) {
        this.mappingList = list;
    };
    Config.getMappingList = function () {
        return this.mappingList;
    };
    Config.objtoarr = function (obj) {
        var arr = [];
        for (var key in obj) {
            arr.push(obj[key]);
        }
        return arr;
    };
    Config.getWalletName = function (id) {
        return this.mappingList[id]["wallname"] || "";
    };
    Config.setWalletName = function (id, walletname) {
        this.mappingList[id]["wallname"] = walletname;
    };
    Config.getSubWallet = function (id) {
        return this.mappingList[id]["coinListCache"] || null;
    };
    Config.isResregister = function (id, coin) {
        if (this.walletResregister[id]) {
            if (this.walletResregister[id][coin]) {
                return this.walletResregister[id][coin];
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
    };
    Config.setResregister = function (id, coin, isOpen) {
        if (this.walletResregister[id]) {
            this.walletResregister[id][coin] = isOpen;
        }
        else {
            this.walletResregister[id] = {};
            this.walletResregister[id][coin] = isOpen;
        }
    };
    Config.getAccountType = function (masterWalletId) {
        return this.mappingList[masterWalletId]["Account"] || {};
    };
    Config.getEstimatedHeight = function (masterId, coin) {
        if (this.perObj[masterId]) {
            if (this.perObj[masterId][coin]) {
                if (this.perObj[masterId][coin]["maxHeight"]) {
                    return this.perObj[masterId][coin]["maxHeight"];
                }
                else {
                    return 0;
                }
            }
            else {
                return 0;
            }
        }
        else {
            return 0;
        }
    };
    Config.setEstimatedHeight = function (masterId, coin, estimatedHeight) {
        if (this.perObj[masterId]) {
            if (this.perObj[masterId][coin]) {
                this.perObj[masterId][coin]["maxHeight"] = estimatedHeight;
            }
            else {
                this.perObj[masterId][coin] = {};
                this.perObj[masterId][coin]["maxHeight"] = estimatedHeight;
            }
        }
        else {
            this.perObj[masterId] = {};
            if (this.perObj[masterId][coin]) {
                this.perObj[masterId][coin]["maxHeight"] = estimatedHeight;
            }
            else {
                this.perObj[masterId][coin] = {};
                this.perObj[masterId][coin]["maxHeight"] = estimatedHeight;
            }
        }
    };
    Config.getCurrentHeight = function (masterId, coin) {
        if (this.perObj[masterId]) {
            if (this.perObj[masterId][coin]) {
                if (this.perObj[masterId][coin]["curHeight"]) {
                    return this.perObj[masterId][coin]["curHeight"];
                }
                else {
                    return 0;
                }
            }
            else {
                return 0;
            }
        }
        else {
            return 0;
        }
    };
    Config.setCureentHeight = function (masterId, coin, currentHeight) {
        if (this.perObj[masterId]) {
            if (this.perObj[masterId][coin]) {
                this.perObj[masterId][coin]["curHeight"] = currentHeight;
            }
            else {
                this.perObj[masterId][coin] = {};
                this.perObj[masterId][coin]["curHeight"] = currentHeight;
            }
        }
        else {
            this.perObj[masterId] = {};
            if (this.perObj[masterId][coin]) {
                this.perObj[masterId][coin]["curHeight"] = currentHeight;
            }
            else {
                this.perObj[masterId][coin] = {};
                this.perObj[masterId][coin]["curHeight"] = currentHeight;
            }
        }
    };
    Config.getAllCountry = function () {
        return this.countrys;
    };
    Config.getCountryByCode = function (code) {
        for (var index in this.countrys) {
            var item = this.countrys[index];
            if (code === parseInt(item["code"])) {
                return item["key"];
            }
        }
        return "Unknown";
    };
    Config.accMul = function (arg1, arg2) {
        var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
        try {
            m += s1.split(".")[1].length;
        }
        catch (e) { }
        try {
            m += s2.split(".")[1].length;
        }
        catch (e) { }
        return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
    };
    Config.getNickname = function (ownerpublickey, voteList) {
        for (var index = 0; index < voteList.length; index++) {
            var item = voteList[index];
            if (ownerpublickey === item["ownerpublickey"]) {
                return item["nickname"];
            }
        }
        return "";
    };
    Config.total = 2;
    Config.voted = 1;
    Config.deposit = 5000;
    Config.isDebug = true;
    Config.masterWallObj = { id: "", wallname: "" };
    Config.perObj = {};
    Config.masterWalletId = "1";
    Config.masterWalletList = [];
    Config.mappingList = {};
    Config.SELA = 100000000;
    //public static BLOCKCHAIN_URL: String = 'https://blockchain.elastos.org/';
    Config.BLOCKCHAIN_URL = 'https://blockchain-beta.elastos.org/';
    //public static BLOCKCHAIN_URL: String = 'https://blockchain-regtest.elastos.org/';
    Config.kycObj = {};
    Config.deviceID = "";
    Config.serIds = {};
    Config.walletResregister = {};
    Config.countrys = [{
            "key": "Afghanistan",
            "code": "93"
        }, {
            "key": "Albania",
            "code": "355"
        }, {
            "key": "Algeria",
            "code": "213"
        }, {
            "key": "American Samoa",
            "code": "684"
        }, {
            "key": "Andorra",
            "code": "376"
        }, {
            "key": "Angola",
            "code": "244"
        }, {
            "key": "Anguilla",
            "code": "1264"
        }, {
            "key": "Antarctica",
            "code": "672"
        }, {
            "key": "Antigua and Barbuda",
            "code": "1268"
        }, {
            "key": "Argentina",
            "code": "54"
        }, {
            "key": "Armenia",
            "code": "374"
        }, {
            "key": "Aruba",
            "code": "297"
        }, {
            "key": "Australia",
            "code": "61"
        }, {
            "key": "Austria",
            "code": "43"
        }, {
            "key": "Azerbaijan",
            "code": "994"
        }, {
            "key": "Bahamas",
            "code": "1242"
        }, {
            "key": "Bahrain",
            "code": "973"
        }, {
            "key": "Bangladesh",
            "code": "880"
        }, {
            "key": "Barbados",
            "code": "1246"
        }, {
            "key": "Belarus",
            "code": "375"
        }, {
            "key": "Belgium",
            "code": "32"
        }, {
            "key": "Belize",
            "code": "501"
        }, {
            "key": "Benin",
            "code": "229"
        }, {
            "key": "Bermuda",
            "code": "1441"
        }, {
            "key": "Bhutan",
            "code": "975"
        }, {
            "key": "Bolivia",
            "code": "591"
        }, {
            "key": "Bosnia and Herzegovina",
            "code": "387"
        }, {
            "key": "Botswana",
            "code": "267"
        }, {
            "key": "Brazil",
            "code": "55"
        }, {
            "key": "British Indian Ocean Territory",
            "code": "246"
        }, {
            "key": "Brunei Darussalam",
            "code": "673"
        }, {
            "key": "Bulgaria",
            "code": "359"
        }, {
            "key": "Burkina Faso",
            "code": "226"
        }, {
            "key": "Burundi",
            "code": "257"
        }, {
            "key": "Cambodia",
            "code": "855"
        }, {
            "key": "Cameroon",
            "code": "237"
        }, {
            "key": "Canada",
            "code": "1"
        }, {
            "key": "Cape Verde",
            "code": "238"
        }, {
            "key": "Cayman Islands",
            "code": "1345"
        }, {
            "key": "Central African Republic",
            "code": "236"
        }, {
            "key": "Chad",
            "code": "235"
        }, {
            "key": "Chile",
            "code": "56"
        }, {
            "key": "China",
            "code": "86"
        }, {
            "key": "Christmas Island",
            "code": "61"
        }, {
            "key": "Cocos (Keeling) Islands",
            "code": "61"
        }, {
            "key": "Colombia",
            "code": "57"
        }, {
            "key": "Comoros",
            "code": "269"
        }, {
            "key": "Congo",
            "code": "242"
        }, {
            "key": "Congo, The Democratic Republic Of The",
            "code": "243"
        }, {
            "key": "Cook Islands",
            "code": "682"
        }, {
            "key": "Costa Rica",
            "code": "506"
        }, {
            "key": "Cote D'Ivoire",
            "code": "225"
        }, {
            "key": "Croatia (local name: Hrvatska)",
            "code": "385"
        }, {
            "key": "Cuba",
            "code": "53"
        }, {
            "key": "Cyprus",
            "code": "357"
        }, {
            "key": "Czech Republic",
            "code": "420"
        }, {
            "key": "Denmark",
            "code": "45"
        }, {
            "key": "Djibouti",
            "code": "253"
        }, {
            "key": "Dominica",
            "code": "1767"
        }, {
            "key": "Dominican Republic",
            "code": "1849"
        }, {
            "key": "East Timor",
            "code": "670"
        }, {
            "key": "Ecuador",
            "code": "593"
        }, {
            "key": "Egypt",
            "code": "20"
        }, {
            "key": "El Salvador",
            "code": "503"
        }, {
            "key": "Equatorial Guinea",
            "code": "240"
        }, {
            "key": "Eritrea",
            "code": "291"
        }, {
            "key": "Estonia",
            "code": "372"
        }, {
            "key": "Ethiopia",
            "code": "251"
        }, {
            "key": "Falkland Islands (Malvinas)",
            "code": "500"
        }, {
            "key": "Faroe Islands",
            "code": "298"
        }, {
            "key": "Fiji",
            "code": "679"
        }, {
            "key": "Finland",
            "code": "358"
        }, {
            "key": "France",
            "code": "33"
        }, {
            "key": "France Metropolitan",
            "code": "33"
        }, {
            "key": "French Guiana",
            "code": "594"
        }, {
            "key": "French Polynesia",
            "code": "689"
        }, {
            "key": "Gabon",
            "code": "241"
        }, {
            "key": "Gambia",
            "code": "220"
        }, {
            "key": "Georgia",
            "code": "995"
        }, {
            "key": "Germany",
            "code": "49"
        }, {
            "key": "Ghana",
            "code": "233"
        }, {
            "key": "Gibraltar",
            "code": "350"
        }, {
            "key": "Greece",
            "code": "30"
        }, {
            "key": "Greenland",
            "code": "45"
        }, {
            "key": "Grenada",
            "code": "1473"
        }, {
            "key": "Guadeloupe",
            "code": "590"
        }, {
            "key": "Guam",
            "code": "1671"
        }, {
            "key": "Guatemala",
            "code": "502"
        }, {
            "key": "Guinea",
            "code": "224"
        }, {
            "key": "Guinea-Bissau",
            "code": "245"
        }, {
            "key": "Guyana",
            "code": "592"
        }, {
            "key": "Haiti",
            "code": "509"
        }, {
            "key": "Honduras",
            "code": "504"
        }, {
            "key": "Hong Kong",
            "code": "852"
        }, {
            "key": "Hungary",
            "code": "36"
        }, {
            "key": "Iceland",
            "code": "354"
        }, {
            "key": "India",
            "code": "91"
        }, {
            "key": "Indonesia",
            "code": "62"
        }, {
            "key": "Iran (Islamic Republic of)",
            "code": "98"
        }, {
            "key": "Iraq",
            "code": "964"
        }, {
            "key": "Ireland",
            "code": "353"
        }, {
            "key": "Israel",
            "code": "972"
        }, {
            "key": "Italy",
            "code": "39"
        }, {
            "key": "Jamaica",
            "code": "1876"
        }, {
            "key": "Japan",
            "code": "81"
        }, {
            "key": "Jordan",
            "code": "962"
        }, {
            "key": "Kazakhstan",
            "code": "7"
        }, {
            "key": "Kenya",
            "code": "254"
        }, {
            "key": "Kuwait",
            "code": "965"
        }, {
            "key": "Kyrgyzstan",
            "code": "996"
        }, {
            "key": "Latvia",
            "code": "371"
        }, {
            "key": "Lebanon",
            "code": "961"
        }, {
            "key": "Lesotho",
            "code": "266"
        }, {
            "key": "Liberia",
            "code": "231"
        }, {
            "key": "Libyan Arab Jamahiriya",
            "code": "218"
        }, {
            "key": "Liechtenstein",
            "code": "423"
        }, {
            "key": "Lithuania",
            "code": "370"
        }, {
            "key": "Luxembourg",
            "code": "352"
        }, {
            "key": "Macau",
            "code": "853"
        }, {
            "key": "Madagascar",
            "code": "261"
        }, {
            "key": "Malawi",
            "code": "265"
        }, {
            "key": "Malaysia",
            "code": "60"
        }, {
            "key": "Maldives",
            "code": "960"
        }, {
            "key": "Mali",
            "code": "223"
        }, {
            "key": "Malta",
            "code": "356"
        }, {
            "key": "Marshall Islands",
            "code": "692"
        }, {
            "key": "Martinique",
            "code": "596"
        }, {
            "key": "Mauritania",
            "code": "222"
        }, {
            "key": "Mauritius",
            "code": "230"
        }, {
            "key": "Mayotte",
            "code": "262"
        }, {
            "key": "Mexico",
            "code": "52"
        }, {
            "key": "Micronesia",
            "code": "691"
        }, {
            "key": "Moldova",
            "code": "373"
        }, {
            "key": "Monaco",
            "code": "377"
        }, {
            "key": "Mongolia",
            "code": "976"
        }, {
            "key": "Montenegro",
            "code": "382"
        }, {
            "key": "Montserrat",
            "code": "1664"
        }, {
            "key": "Morocco",
            "code": "212"
        }, {
            "key": "Mozambique",
            "code": "258"
        }, {
            "key": "Myanmar",
            "code": "95"
        }, {
            "key": "Namibia",
            "code": "264"
        }, {
            "key": "Nauru",
            "code": "674"
        }, {
            "key": "Nepal",
            "code": "977"
        }, {
            "key": "Netherlands",
            "code": "31"
        }, {
            "key": "Netherlands Antilles",
            "code": "599"
        }, {
            "key": "New Caledonia",
            "code": "687"
        }, {
            "key": "New Zealand",
            "code": "64"
        }, {
            "key": "Nicaragua",
            "code": "505"
        }, {
            "key": "Niger",
            "code": "227"
        }, {
            "key": "Nigeria",
            "code": "234"
        }, {
            "key": "Norfolk Island",
            "code": "6723"
        }, {
            "key": "North Korea",
            "code": "850"
        }, {
            "key": "Northern Mariana Islands",
            "code": "1670"
        }, {
            "key": "Norway",
            "code": "47"
        }, {
            "key": "Oman",
            "code": "968"
        }, {
            "key": "Pakistan",
            "code": "92"
        }, {
            "key": "Palau",
            "code": "680"
        }, {
            "key": "Palestine",
            "code": "970"
        }, {
            "key": "Panama",
            "code": "507"
        }, {
            "key": "Papua New Guinea",
            "code": "675"
        }, {
            "key": "Paraguay",
            "code": "595"
        }, {
            "key": "Peru",
            "code": "51"
        }, {
            "key": "Philippines",
            "code": "63"
        }, {
            "key": "Pitcairn",
            "code": "64"
        }, {
            "key": "Poland",
            "code": "48"
        }, {
            "key": "Portugal",
            "code": "351"
        }, {
            "key": "Puerto Rico",
            "code": "1787"
        }, {
            "key": "Qatar",
            "code": "974"
        }, {
            "key": "Reunion",
            "code": "262"
        }, {
            "key": "Romania",
            "code": "40"
        }, {
            "key": "Russian Federation",
            "code": "7"
        }, {
            "key": "Rwanda",
            "code": "250"
        }, {
            "key": "Samoa",
            "code": "685"
        }, {
            "key": "San Marino",
            "code": "378"
        }, {
            "key": "Saudi Arabia",
            "code": "966"
        }, {
            "key": "Senegal",
            "code": "221"
        }, {
            "key": "Serbia",
            "code": "381"
        }, {
            "key": "Seychelles",
            "code": "248"
        }, {
            "key": "Sierra Leone",
            "code": "232"
        }, {
            "key": "Singapore",
            "code": "65"
        }, {
            "key": "Slovakia (Slovak Republic)",
            "code": "421"
        }, {
            "key": "Slovenia",
            "code": "386"
        }, {
            "key": "Solomon Islands",
            "code": "677"
        }, {
            "key": "Somalia",
            "code": "252"
        }, {
            "key": "South Africa",
            "code": "27"
        }, {
            "key": "South Korea",
            "code": "82"
        }, {
            "key": "Spain",
            "code": "34"
        }, {
            "key": "Sri Lanka",
            "code": "94"
        }, {
            "key": "Sudan",
            "code": "249"
        }, {
            "key": "Suriname",
            "code": "597"
        }, {
            "key": "Swaziland",
            "code": "268"
        }, {
            "key": "Sweden",
            "code": "46"
        }, {
            "key": "Switzerland",
            "code": "41"
        }, {
            "key": "Syrian Arab Republic",
            "code": "963"
        }, {
            "key": "Taiwan",
            "code": "886"
        }, {
            "key": "Tajikistan",
            "code": "992"
        }, {
            "key": "Tanzania",
            "code": "255"
        }, {
            "key": "Thailand",
            "code": "66"
        }, {
            "key": "Togo",
            "code": "228"
        }, {
            "key": "Tokelau",
            "code": "690"
        }, {
            "key": "Tonga",
            "code": "676"
        }, {
            "key": "Trinidad and Tobago",
            "code": "1868"
        }, {
            "key": "Tunisia",
            "code": "216"
        }, {
            "key": "Turkey",
            "code": "90"
        }, {
            "key": "Turkmenistan",
            "code": "993"
        }, {
            "key": "Turks and Caicos Islands",
            "code": "1809"
        }, {
            "key": "Tuvalu",
            "code": "688"
        }, {
            "key": "Uganda",
            "code": "256"
        }, {
            "key": "Ukraine",
            "code": "380"
        }, {
            "key": "United Arab Emirates",
            "code": "971"
        }, {
            "key": "United Kingdom",
            "code": "44"
        }, {
            "key": "United States",
            "code": "1"
        }, {
            "key": "Uruguay",
            "code": "598"
        }, {
            "key": "Uzbekistan",
            "code": "998"
        }, {
            "key": "Vanuatu",
            "code": "678"
        }, {
            "key": "Vatican City State (Holy See)",
            "code": "39"
        }, {
            "key": "Venezuela",
            "code": "58"
        }, {
            "key": "Vietnam",
            "code": "84"
        }, {
            "key": "Virgin Islands (British)",
            "code": "1284"
        }, {
            "key": "Virgin Islands (U.S.)",
            "code": "1340"
        }, {
            "key": "Wallis And Futuna Islands",
            "code": "681"
        }, {
            "key": "Western Sahara",
            "code": "685"
        }, {
            "key": "Yemen",
            "code": "967"
        }, {
            "key": "Yugoslavia",
            "code": "381"
        }, {
            "key": "Zambia",
            "code": "260"
        }, {
            "key": "Zimbabwe",
            "code": "263"
        }, {
            "key": "the Republic of Abkhazia",
            "code": "7"
        }, {
            "key": "the Republic of South Ossetia",
            "code": "7"
        }, {
            "key": "Bailiwick of Jersey",
            "code": "44"
        }, {
            "key": "Lao People's Democratic Republic",
            "code": "856"
        }, {
            "key": "The Republic of Macedonia",
            "code": "389"
        }, {
            "key": "The Federation of Saint Kitts and Nevis",
            "code": "1869"
        }, {
            "key": "Santa Luzia Island",
            "code": "1758"
        }, {
            "key": "Saint Vincent and the Grenadines",
            "code": "1784"
        }, {
            "key": "Sao Tome and Principe",
            "code": "239"
        }, {
            "key": "Saint-Martin",
            "code": "590"
        }, {
            "key": "The Republic of South Sudan",
            "code": "211"
        }];
    Config = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])()
    ], Config);
    return Config;
}());

//# sourceMappingURL=Config.js.map

/***/ }),

/***/ 121:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return LauncherComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__wallet_wallet_create_wallet_create_component__ = __webpack_require__(197);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__wallet_import_import_component__ = __webpack_require__(484);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_createmultiwallte_createmultiwallte__ = __webpack_require__(485);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var LauncherComponent = /** @class */ (function () {
    function LauncherComponent(navCtrl, navParams) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
    }
    LauncherComponent.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad WalltelistPage');
    };
    LauncherComponent.prototype.onNext = function (type) {
        switch (type) {
            case 1:
                this.navCtrl.push(__WEBPACK_IMPORTED_MODULE_1__wallet_wallet_create_wallet_create_component__["a" /* WalletCreateComponent */]);
                break;
            case 2:
                this.navCtrl.push(__WEBPACK_IMPORTED_MODULE_2__wallet_import_import_component__["a" /* ImportComponent */]);
                break;
            case 3:
                this.navCtrl.push(__WEBPACK_IMPORTED_MODULE_4__pages_createmultiwallte_createmultiwallte__["a" /* CreatemultiwalltePage */]);
                break;
        }
    };
    LauncherComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-launcher',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/launcher/launcher.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{"text-add-wallet"|translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content>\n    <div id="wrapper">\n        <div id="cell">\n            <div>\n                <button ion-button full (click)="onNext(1)">{{\'launcher-create-wallet\' | translate }}</button>\n            </div>\n            <div>\n                <button ion-button full (click)="onNext(2)">{{\'launcher-backup-import\' | translate }}</button>\n            </div>\n            <button ion-button full (click)="onNext(3)">{{\'signature-wallet\' | translate }}</button>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/launcher/launcher.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_3_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_3_ionic_angular__["l" /* NavParams */]])
    ], LauncherComponent);
    return LauncherComponent;
}());

//# sourceMappingURL=launcher.component.js.map

/***/ }),

/***/ 127:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PersonWriteChainPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__ = __webpack_require__(65);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__providers_popup__ = __webpack_require__(38);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};











//{notary:"COOIX"}
var PersonWriteChainPage = /** @class */ (function () {
    function PersonWriteChainPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager, popupProvider, ngzone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.popupProvider = popupProvider;
        this.ngzone = ngzone;
        this.masterWalletId = "1";
        this.pageObj = {};
        this.personObj = {
            fullName: 'sss',
            identityNumber: '410426198811151012',
            mobile: '18210230496',
            cardNumber: '6225260167820399',
            cardMobile: '18210230496'
        };
        this.phoneObj = {
            fullName: 'sss',
            identityNumber: '410426198811151012',
            mobile: '18210230496'
        };
        this.debitObj = {
            fullName: 'sss',
            identityNumber: '410426198811151012',
            cardNumber: '6225260167820399',
            cardMobile: '18210230496'
        };
        this.message = { Id: "", Path: "", Proof: "", DataHash: "", Sign: "" };
        this.passworld = "";
        this.idObj = {};
        this.orderStatus = 0;
        this.serialNum = "";
        this.init();
    }
    PersonWriteChainPage.prototype.init = function () {
        var _this = this;
        this.events.subscribe("order:update", function (orderStatus, appr) {
            _this.native.info(orderStatus);
            _this.native.info(appr);
            if (appr != "enterprise") {
                _this.ngzone.run(function () {
                    _this.orderStatus = orderStatus;
                });
            }
        });
        this.idObj = this.navParams.data;
        this.native.info(this.idObj);
        this.did = this.idObj["payObj"]["did"];
        this.native.info(this.idObj["pathStatus"]);
        this.orderStatus = this.idObj["pathStatus"];
        this.serialNum = this.idObj["serialNum"];
        this.getPerson();
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(status)) {
            this.type = '0';
        }
        else {
            this.type = status;
        }
    };
    PersonWriteChainPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.navBar.backButtonClick = function (e) {
            _this.navCtrl.pop();
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__["a" /* IdHomeComponent */]);
        };
    };
    PersonWriteChainPage.prototype.getPerson = function () {
        this.pageObj = this.getPageObj(this.idObj["adata"]);
        var index = this.idObj["adata"].length - 1;
        var adata = this.idObj["adata"][index];
        //let pesronObj = adata["retdata"];
        this.message["Path"] = adata["type"];
        // this.approdType =  adata["type"];
        // if(this.message["Path"] === "identityCard"){
        //      this.personObj["fullName"] = pesronObj["fullName"];
        //      this.personObj["identityNumber"] = pesronObj["identityNumber"];
        //      this.signature = pesronObj["signature"];
        // }else if(this.message["Path"] === "phone"){
        //      this.phoneObj["fullName"] =  pesronObj["fullName"];
        //      this.phoneObj["identityNumber"] =  pesronObj["identityNumber"];
        //      this.phoneObj["mobile"] = pesronObj["mobile"];
        //      this.signature = pesronObj["signature"];
        // }else if(this.message["Path"] === "bankCard"){
        //     this.debitObj["fullName"] =  pesronObj["fullName"];
        //     this.debitObj["identityNumber"] =  pesronObj["identityNumber"];
        //     this.debitObj["cardNumber"] = pesronObj["cardNumber"];
        //     this.debitObj["cardMobile"] = pesronObj["mobile"];
        //     this.signature = pesronObj["signature"];
        // }
    };
    PersonWriteChainPage.prototype.onCommit = function () {
        var _this = this;
        this.popupProvider.presentPrompt().then(function (val) {
            if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(val)) {
                _this.native.toast_trans("text-id-kyc-prompt-password");
                return;
            }
            _this.passworld = val.toString();
            _this.caulmessageNew();
        }).catch(function () {
        });
    };
    PersonWriteChainPage.prototype.didGenerateProgram = function () {
        var _this = this;
        this.native.info(this.message);
        this.native.info(this.passworld);
        this.walletManager.didGenerateProgram(this.did, JSON.stringify(this.message), this.passworld, function (result) {
            _this.programJson = result.value;
            _this.native.info(_this.didGenerateProgram);
            _this.createfromAddress();
        });
    };
    PersonWriteChainPage.prototype.createfromAddress = function () {
        var _this = this;
        this.walletManager.createAddress(this.masterWalletId, "IdChain", function (result) {
            _this.fromAddress = result.address;
            _this.cauFee();
        });
    };
    PersonWriteChainPage.prototype.cauFee = function () {
        var _this = this;
        //alert("createIdTransaction before" + this.fromAddress);
        this.walletManager.createIdTransaction(this.masterWalletId, "IdChain", "", this.message, this.programJson, "", "", function (result) {
            _this.native.info(_this.fromAddress);
            _this.native.info(_this.message);
            _this.native.info(_this.programJson);
            var rawTransaction = result['json'].toString();
            _this.native.info(rawTransaction);
            _this.calculateTransactionFee(rawTransaction);
        });
    };
    PersonWriteChainPage.prototype.calculateTransactionFee = function (rawTransaction) {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, "IdChain", rawTransaction, 10000, function (data) {
            _this.fee = data['fee'];
            _this.native.info(rawTransaction);
            _this.native.info(_this.fee);
            _this.popupProvider.presentConfirm(_this.fee / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA).then(function () {
                _this.sendRawTransaction(rawTransaction);
            });
        });
    };
    //////////////////////
    PersonWriteChainPage.prototype.getKycContent = function (authData) {
        var retContent = {};
        switch (authData.type) {
            case "identityCard":
                retContent["fullName"] = authData["retdata"]["fullName"];
                retContent["identityNumber"] = authData["retdata"]["identityNumber"];
                break;
            case "phone":
                retContent["fullName"] = authData["retdata"]["fullName"];
                retContent["identityNumber"] = authData["retdata"]["identityNumber"];
                retContent["mobile"] = authData["retdata"]["mobile"];
                break;
            case "bankCard":
                retContent["fullName"] = authData["retdata"]["fullName"];
                retContent["identityNumber"] = authData["retdata"]["identityNumber"];
                retContent["cardNumber"] = authData["retdata"]["cardNumber"];
                retContent["cardMobile"] = authData["retdata"]["mobile"];
                break;
            case "enterprise":
                retContent["word"] = authData["retdata"]["word"];
                retContent["legalPerson"] = authData["retdata"]["legalPerson"];
                retContent["registrationNum"] = authData["retdata"]["RegistrationNum"];
                break;
        }
        return retContent;
    };
    PersonWriteChainPage.prototype.getcontent = function (authType, authData) {
        var retContent = {};
        retContent["Path"] = 'kyc' + '/' + authData["type"];
        retContent["Values"] = [];
        var proofObj = {
            signature: authData["resultSign"],
            notary: "COOIX"
        };
        /////////////////
        var valueObj = {};
        valueObj["Proof"] = JSON.stringify(proofObj);
        var kycContent = this.getKycContent(authData);
        console.info("ElastJs company getcontent kycContent " + JSON.stringify(kycContent));
        console.info("ElastJs company getcontent Proof " + valueObj["Proof"]);
        var authDataHash = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].hash(JSON.stringify(kycContent) + valueObj["Proof"]);
        valueObj["DataHash"] = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].hash(authDataHash + valueObj["Proof"]);
        var idJsonPart = {};
        idJsonPart["hash"] = valueObj["DataHash"];
        idJsonPart["KycContent"] = kycContent;
        idJsonPart["Proof"] = valueObj["Proof"];
        this.dataManager.addIdPathJson(this.did, retContent["Path"], idJsonPart);
        console.info("ElastJs company getcontent retContent before push ");
        retContent["Values"].push(valueObj);
        console.info("ElastJs company getcontent retContent " + JSON.stringify(retContent));
        return retContent;
        ////////////////
        // retContent["Proof"] = JSON.stringify(proofObj);
        //
        // console.info("getcontent Proof "+ retContent["Proof"]);
        //
        // let kycContent = this.getKycContent(authData);
        //
        // console.info("getcontent kycContent "+ JSON.stringify(kycContent));
        //
        // let authDataHash = IDManager.hash(JSON.stringify(kycContent)+retContent["Proof"]);
        // retContent["DataHash"] = IDManager.hash(authDataHash+retContent["Proof"]);
        //
        // console.info("getcontent retContent "+ JSON.stringify(retContent));
        //return retContent;
    };
    PersonWriteChainPage.prototype.caulmessageNew = function () {
        var _this = this;
        //
        ///////////////////////
        var signMessage = {};
        signMessage["Id"] = this.did; //
        //signMessage["Sign"] = "" ;//
        signMessage["Contents"] = [];
        var content;
        var params = this.idObj; //
        for (var _i = 0, _a = params.adata; _i < _a.length; _i++) {
            var ele = _a[_i];
            content = this.getcontent(params.type, ele);
            signMessage["Contents"].push(content);
        }
        this.native.info(signMessage);
        this.walletManager.didSign(this.did, JSON.stringify(signMessage), this.passworld, function (result) {
            _this.message = {
                Id: _this.did,
                Sign: result.value,
                Contents: signMessage["Contents"],
            };
            _this.didGenerateProgram();
        });
    };
    ////////////////////////
    PersonWriteChainPage.prototype.sendRawTransaction = function (rawTransaction) {
        //alert("sendRawTransaction begin==");
        // this.walletManager.sendRawTransaction(this.masterWalletId,"IdChain",rawTransaction,this.fee,this.passworld,(result)=>{
        //   let rawTransactionObj = JSON.parse(rawTransaction);
        //   console.log("ElastosJs person-write-chain.ts ---sendRawTransaction---"+"rawTransaction="+JSON.stringify(rawTransactionObj)+"fee="+this.fee);
        //   //console.log("ElastosJs ---sendRawTransaction--- PayLoad"+ JSON.stringify(rawTransactionObj.PayLoad));
        //   if (!rawTransactionObj.PayLoad) {
        //     console.log("ElastosJs ---sendRawTransaction--- PayLoad NULL");
        //     return;
        //   }
        //   if (!rawTransactionObj["PayLoad"]["Contents"]){
        //     console.log("ElastosJs ---sendRawTransaction--- Contents NULL");
        //     return ;
        //   }
        //   for (let ele of rawTransactionObj["PayLoad"]["Contents"] ) {
        //     console.log("ElastosJs person-write-chain.ts ---sendRawTransaction--- ele " + JSON.stringify(ele));
        //     let arr = ele["Path"].split("/");
        //     if (arr[1]) {
        //       let self = this;
        //       //iterat values
        //       for (let valueObj of ele["Values"]){
        //         let proofObj = JSON.parse(valueObj["Proof"]);
        //         this.localStorage.getSeqNumObj(proofObj["signature"], rawTransactionObj.PayLoad.Id, arr[1], function (reult : any) {
        //           console.info("ElastosJs reult " + JSON.stringify(reult) );
        //           self.dataManager.addSeqNumObj(proofObj["signature"] , reult );
        //         });
        //       }
        //       // let proofObj = JSON.parse(ele["Proof"]);
        //       // let self = this;
        //       //
        //       // this.localStorage.getSeqNumObj(proofObj["signature"], rawTransactionObj.PayLoad.Id, arr[1], function (reult : any) {
        //       //   console.info("ElastosJs reult" + JSON.stringify(reult) );
        //       //   self.dataManager.addSeqNumObj(proofObj["signature"] , reult );
        //       //
        //       // });
        //     }
        //   }
        //   console.info("sendRawTransaction person-write-chain.ts setOrderStatus(4)")
        //   this.setOrderStatus(4);
        //   //this.messageBox("text-id-kyc-china");
        // })
    };
    PersonWriteChainPage.prototype.getPageObj = function (obj) {
        var aprObj = {};
        for (var index in obj) {
            var data = obj[index];
            var retdata = data["retdata"];
            if (data["type"] === "identityCard") {
                aprObj["identityCard"] = { "identityNumber": retdata["identityNumber"], "fullName": retdata["fullName"] };
            }
            else if (data["type"] === "phone") {
                aprObj["phone"] = { "mobile": retdata["mobile"] };
            }
            else if (data["type"] === "bankCard") {
                aprObj["bankCard"] = { "cardMobile": retdata["mobile"], "cardNumber": retdata["cardNumber"] };
            }
        }
        return aprObj;
    };
    // setOrderStatus(){
    //   let serids = Config.getSerIds();
    //   let serid = serids[this.serialNum];
    //   let did = serid["id"];
    //   let appName = serid["appName"];
    //   let appr = serid["appr"];
    //   let idsObj = {};
    //   this.localStorage.getKycList("kycId").then((val)=>{
    //       if(val == null || val === undefined || val === {} || val === ''){
    //            return;
    //       }
    //    idsObj = JSON.parse(val);
    //    idsObj[did][appName][appr]["order"][this.serialNum]["status"] = 2;
    //    this.localStorage.set("kycId",idsObj).then(()=>{
    //             this.orderStatus = 2;
    //    });
    //   });
    // }
    // }
    PersonWriteChainPage.prototype.setOrderStatus = function (status) {
        var _this = this;
        console.info("ElastJs setOrderStatus status begin" + status);
        var serids = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getSerIds();
        console.info("ElastJs setOrderStatus status serids" + JSON.stringify(serids));
        var serid = serids[this.serialNum];
        var did = serid["id"];
        var path = serid["path"];
        var idsObj = {};
        this.localStorage.getKycList("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                console.info("ElastJs setOrderStatus val == null return ");
                return;
            }
            idsObj = JSON.parse(val);
            idsObj[did][path][_this.serialNum]["pathStatus"] = status;
            _this.localStorage.set("kycId", idsObj).then(function () {
                console.info("ElastJs setOrderStatus  end  status " + status);
                _this.orderStatus = status;
            });
        });
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["m" /* Navbar */])
    ], PersonWriteChainPage.prototype, "navBar", void 0);
    PersonWriteChainPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-person-write-chain',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/kyc/person-write-chain/person-write-chain.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-kyc-result\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n    <div class="company-result" style="height:100%;overflow: auto;">\n        <div class="result-title" *ngIf="type===\'0\'">\n            <p>{{\'text-kyc-success\' | translate }} <img src=\'./assets/images/icon/icon-success.svg\' class="result-img" /></p>\n        </div>\n\n        <div class="result-title" *ngIf="type===\'1\'">\n            <p>{{\'text-kyc-failure\' | translate }} <img src=\'./assets/images/icon/icon-failure.svg\' class="result-img" /></p>\n        </div>\n\n        <ion-grid>\n            <ion-col col-2 class="font-size-1">\n                {{\'text-name\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1">\n                {{pageObj["identityCard"]["fullName"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-identity\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1">\n                {{pageObj["identityCard"]["identityNumber"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1" *ngIf="pageObj[\'phone\']">\n                {{\'text-certified-phone\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="pageObj[\'phone\']">\n                {{pageObj["phone"]["mobile"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1" *ngIf="pageObj[\'bankCard\']">\n                {{\'text-card-debit\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="pageObj[\'bankCard\']">\n                {{pageObj["bankCard"]["cardMobile"]}}\n            </ion-col>\n\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-card\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1">\n                {{pageObj["bankCard"]["cardNumber"]}}\n            </ion-col>\n        </ion-grid>\n    </div>\n</ion-content>\n\n<ion-footer>\n    <div class="title">\n        <p class="text-person-agreement-wenzi">{{ \'text-id-chain-prompt1\' | translate }}</p>\n    </div>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%" *ngIf="orderStatus===2"> {{\'text-data-chain\' | translate}}</button>\n    <button ion-button full class="button-footer" style="width: 100%" *ngIf="orderStatus===4">{{\'text-data-chain1\' | translate}}</button>\n    <button ion-button full class="button-footer" style="width: 100%" *ngIf="orderStatus===5">{{\'text-data-chain2\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/kyc/person-write-chain/person-write-chain.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */], __WEBPACK_IMPORTED_MODULE_10__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], PersonWriteChainPage);
    return PersonWriteChainPage;
}());

//# sourceMappingURL=person-write-chain.js.map

/***/ }),

/***/ 128:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return MpublickeyPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_addpublickey_addpublickey__ = __webpack_require__(217);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_addprivatekey_addprivatekey__ = __webpack_require__(483);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var MpublickeyPage = /** @class */ (function () {
    function MpublickeyPage(navCtrl, navParams, native, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.masterWalletId = "1";
        this.qrcode = null;
        this.exatParm = this.navParams.data;
        this.native.info(this.exatParm);
        if (this.exatParm["mnemonicStr"]) {
            this.getPublicKey();
        }
        else if (this.exatParm["importText"]) {
            this.getMultiSignPubKeyWithPrivKey();
        }
    }
    MpublickeyPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad MpublickeyPage');
    };
    MpublickeyPage.prototype.copy = function () {
        this.native.copyClipboard(this.qrcode);
        this.native.toast_trans('copy-ok');
    };
    MpublickeyPage.prototype.getPublicKey = function () {
        var _this = this;
        this.walletManager.getMultiSignPubKeyWithMnemonic(this.exatParm["mnemonicStr"], this.exatParm["mnemonicPassword"], function (data) {
            if (data["success"]) {
                _this.qrcode = data["success"];
            }
            else {
            }
        });
    };
    MpublickeyPage.prototype.getMultiSignPubKeyWithPrivKey = function () {
        var _this = this;
        this.walletManager.getMultiSignPubKeyWithPrivKey(this.exatParm["importText"], function (data) {
            if (data["success"]) {
                _this.qrcode = data["success"];
            }
            else {
            }
        });
    };
    MpublickeyPage.prototype.nextPage = function () {
        if (this.exatParm["mnemonicStr"]) {
            this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__pages_addpublickey_addpublickey__["a" /* AddpublickeyPage */], this.exatParm);
        }
        else if (this.exatParm["importText"]) {
            this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__pages_addprivatekey_addprivatekey__["a" /* AddprivatekeyPage */], this.exatParm);
        }
    };
    MpublickeyPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-mpublickey',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/mpublickey/mpublickey.html"*/'<!--\n  Generated template for the MpublickeyPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-check-publickey\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n    <div style="text-align: center;width:100%;" (click)="copy()">\n        <qrcode class="receive-qrocde" [qrdata]="qrcode" [size]="200" [level]="\'M\'" style="display:inline-block;"></qrcode>\n        <p style="text-align:left;margin-top: 10px;font-size:1.6em">{{qrcode}}</p>\n    </div>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="nextPage()">{{\'text-next-step\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/mpublickey/mpublickey.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */]])
    ], MpublickeyPage);
    return MpublickeyPage;
}());

//# sourceMappingURL=mpublickey.js.map

/***/ }),

/***/ 197:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return WalletCreateComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__mnemonic_mnemonic_component__ = __webpack_require__(413);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var WalletCreateComponent = /** @class */ (function () {
    function WalletCreateComponent(navCtrl, navParams, native, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.zone = zone;
        this.isShow = false;
        this.wallet = {
            name: '',
            singleAddress: false,
            payPassword: '',
            rePayPassword: '' //houpeitest
        };
        this.MultObj = this.navParams.data;
        this.native.info(this.MultObj);
        if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isEmptyObject(this.MultObj)) {
            this.wallet.singleAddress = true;
            this.isShow = true;
        }
    }
    WalletCreateComponent.prototype.updateSingleAddress = function (isShow) {
        var _this = this;
        this.zone.run(function () {
            _this.wallet.singleAddress = isShow;
        });
    };
    WalletCreateComponent.prototype.onCreate = function () {
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.wallet.name)) {
            this.native.toast_trans("text-wallet-name-validator");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWalletName(this.wallet.name)) {
            this.native.toast_trans("text-wallet-name-validator1");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWallNameExit(this.wallet.name)) {
            this.native.toast_trans("text-wallet-name-validator2");
            return;
        }
        if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].password(this.wallet.payPassword)) {
            this.native.toast_trans("text-pwd-validator");
            return;
        }
        if (this.wallet.payPassword != this.wallet.rePayPassword) {
            this.native.toast_trans("text-repwd-validator");
            return;
        }
        this.createWallet();
    };
    WalletCreateComponent.prototype.createWallet = function () {
        // Master Wallet
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__mnemonic_mnemonic_component__["a" /* MnemonicComponent */], { payPassword: this.wallet.payPassword, name: this.wallet.name, singleAddress: this.wallet.singleAddress, mult: this.MultObj });
    };
    WalletCreateComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-wallet-create',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/wallet-create/wallet-create.component.html"*/'<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'launcher-create-wallet\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n<ion-content>\n    <ion-list>\n        <ion-item>\n            <ion-label stacked>{{ \'addwallet-walletname-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="{{ \'addwallet-walletname-placeholder\' | translate }}" [(ngModel)]="wallet.name"></ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-label stacked>{{ \'addwallet-paypassword1-title\' | translate }}</ion-label>\n            <ion-input type="password" placeholder="{{ \'addwallet-paypassword1-placeholder\' | translate }}" [(ngModel)]="wallet.payPassword"></ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-input type="password" placeholder="{{ \'addwallet-paypassword2-placeholder\' | translate }}" [(ngModel)]="wallet.rePayPassword"></ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-label>{{\'text-signaddress\' | translate }}</ion-label>\n            <ion-checkbox [(ngModel)]="wallet.singleAddress" [(disabled)]="isShow" (ionChange)="updateSingleAddress(wallet.singleAddress)"></ion-checkbox>\n        </ion-item>\n    </ion-list>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="onCreate()">{{ \'confirm\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/wallet-create/wallet-create.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], WalletCreateComponent);
    return WalletCreateComponent;
}());

//# sourceMappingURL=wallet-create.component.js.map

/***/ }),

/***/ 198:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ContactListComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__contact_create_contact_create_component__ = __webpack_require__(417);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__contacts_component__ = __webpack_require__(418);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};








var ContactListComponent = /** @class */ (function () {
    function ContactListComponent(navCtrl, navParams, walletManager, native, localStorage, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.isnodata = false;
        this.contactUsers = [];
        this.params = {};
        this.init();
    }
    ContactListComponent.prototype.init = function () {
        var _this = this;
        this.params = this.navParams.data || {};
        this.events.subscribe("contanctList:update", function () {
            _this.localStorage.get('contactUsers').then(function (val) {
                if (val) {
                    if (__WEBPACK_IMPORTED_MODULE_7__providers_Util__["a" /* Util */].isEmptyObject(JSON.parse(val))) {
                        _this.isnodata = true;
                        return;
                    }
                    _this.isnodata = false;
                    _this.contactUsers = __WEBPACK_IMPORTED_MODULE_7__providers_Util__["a" /* Util */].objtoarr(JSON.parse(val));
                }
                else {
                    _this.isnodata = true;
                }
            });
        });
        this.localStorage.get('contactUsers').then(function (val) {
            if (val) {
                if (__WEBPACK_IMPORTED_MODULE_7__providers_Util__["a" /* Util */].isEmptyObject(JSON.parse(val))) {
                    _this.isnodata = true;
                    return;
                }
                _this.isnodata = false;
                _this.contactUsers = __WEBPACK_IMPORTED_MODULE_7__providers_Util__["a" /* Util */].objtoarr(JSON.parse(val));
            }
            else {
                _this.isnodata = true;
            }
        });
    };
    ContactListComponent.prototype.rightHeader = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__contact_create_contact_create_component__["a" /* ContactCreateComponent */]);
    };
    ContactListComponent.prototype.onclick = function (id) {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__contacts_component__["a" /* ContactsComponent */], { id: id, "exatOption": this.params });
    };
    ContactListComponent.prototype.ionViewDidLeave = function () {
        //this.events.unsubscribe("contanctList:update");
    };
    ContactListComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-contact-list',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/contacts/contact-list/contact-list.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-contacts\' | translate}}</ion-title>\n        <ion-buttons end>\n            <button ion-button icon-only (click)="rightHeader()">\n              <ion-icon name="add"></ion-icon>\n            </button>\n        </ion-buttons>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <nodata keyText=\'no-add-contact\' *ngIf="isnodata"></nodata>\n    <ion-list *ngIf="!isnodata">\n        <button ion-item *ngFor="let item of contactUsers" (click)="onclick(item.id)">\n          {{ item.name }}\n        </button>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/contacts/contact-list/contact-list.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_3_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_3_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_5__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_3_ionic_angular__["c" /* Events */]])
    ], ContactListComponent);
    return ContactListComponent;
}());

//# sourceMappingURL=contact-list.component.js.map

/***/ }),

/***/ 212:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdImportComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__ = __webpack_require__(65);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};







var IdImportComponent = /** @class */ (function () {
    function IdImportComponent(navCtrl, navParams, native, localStorage, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.localStorage = localStorage;
        this.dataManager = dataManager;
        this.kycObj = {};
        this.keyStoreContent = "";
        this.init();
    }
    IdImportComponent.prototype.init = function () {
        var _this = this;
        this.localStorage.get("kycId").then(function (val) {
            if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(val)) {
                _this.kycObj = {};
            }
            else {
                _this.kycObj = JSON.parse(val);
            }
        });
    };
    IdImportComponent.prototype.onImport = function () {
        var _this = this;
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.keyStoreContent)) {
            this.native.toast_trans("text-id-kyc-import-no-message");
            return;
        }
        var addObjs = JSON.parse(this.keyStoreContent);
        for (var key in addObjs) {
            this.kycObj[key] = addObjs[key];
        }
        this.localStorage.set('kycId', this.kycObj).then(function () {
            _this.native.toast_trans('text-exprot-sucess-message');
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__["a" /* IdHomeComponent */]);
        });
    };
    IdImportComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'id-import',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/import/import.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-id-import\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <div class="id-box import-box">\n        <img class="id-logo" src="assets/images/1.0logo.png">\n\n        <div class="content-id">\n            <div class="importid-box">\n                <p>{{ \'text-id-import-file\' | translate }}</p>\n                <div class="kuangTextArea">\n                    <textarea rows="4" class="backupWalletTextArea" placeholder="{{ \'text-id-kyc-import-text-message\' | translate}}" [(ngModel)]="keyStoreContent"></textarea>\n                </div>\n                <button (click)="onImport()" class="btn-commit btn1" id="btn-t" style="color: #fff;cursor: pointer;display: block">{{ \'confirm\' | translate }}</button>\n            </div>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/import/import.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_2_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_5__providers_DataManager__["a" /* DataManager */]])
    ], IdImportComponent);
    return IdImportComponent;
}());

//# sourceMappingURL=import.js.map

/***/ }),

/***/ 213:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PathlistPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_companypathinfo_companypathinfo__ = __webpack_require__(457);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_id_bankcardpathinfo_bankcardpathinfo__ = __webpack_require__(460);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_id_phonepathinfo_phonepathinfo__ = __webpack_require__(462);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_id_identitypathinfo_identitypathinfo__ = __webpack_require__(464);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};











var PathlistPage = /** @class */ (function () {
    function PathlistPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.parmar = {};
        this.pathList = [
            { "name": "text-identity", "path": "identityCard" },
            { "name": "text-certified-phone", "path": "phone" },
            { "name": "text-certified-card", "path": "bankCard" },
            { "name": "text-certified-company", "path": "enterprise" }
        ];
        this.init();
    }
    PathlistPage.prototype.init = function () {
        this.parmar = this.navParams.data;
    };
    PathlistPage.prototype.onNext = function (item) {
        this.parmar["path"] = item["path"];
        this.native.info(this.parmar);
        this.nextPage();
    };
    PathlistPage.prototype.nextPage = function () {
        var _this = this;
        this.localStorage.get("kycId").then(function (val) {
            var idsObj = JSON.parse(val);
            var id = _this.parmar["id"];
            var path = _this.parmar["path"];
            var idObj = idsObj[id];
            if (__WEBPACK_IMPORTED_MODULE_10__providers_Util__["a" /* Util */].isNull(idObj[path])) {
                idObj[path] = {};
                _this.localStorage.set("kycId", idsObj).then(function () {
                    _this.jumpPage(path);
                });
            }
            else {
                _this.jumpPage(path);
            }
        });
    };
    PathlistPage.prototype.jumpPage = function (path) {
        switch (path) {
            case "enterprise":
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_companypathinfo_companypathinfo__["a" /* CompanypathinfoPage */], this.parmar);
                break;
            case "identityCard":
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__pages_id_identitypathinfo_identitypathinfo__["a" /* IdentitypathinfoPage */], this.parmar);
                break;
            case "phone":
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_id_phonepathinfo_phonepathinfo__["a" /* PhonepathinfoPage */], this.parmar);
                break;
            case "bankCard":
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_bankcardpathinfo_bankcardpathinfo__["a" /* BankcardpathinfoPage */], this.parmar);
                break;
        }
    };
    PathlistPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-pathlist',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/pathlist/pathlist.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-path-list\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content no-bounce>\n    <ion-list>\n        <button ion-item *ngFor="let item of pathList; let i = index" (click)="onNext(item)">\n            {{ item.name | translate }}\n          </button>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/pathlist/pathlist.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_5_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_7__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_9__providers_DataManager__["a" /* DataManager */]])
    ], PathlistPage);
    return PathlistPage;
}());

//# sourceMappingURL=pathlist.js.map

/***/ }),

/***/ 214:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PaymentConfirmComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__pages_paymentbox_paymentbox__ = __webpack_require__(97);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};









var PaymentConfirmComponent = /** @class */ (function () {
    function PaymentConfirmComponent(navCtrl, navParams, walletManager, native, localStorage, modalCtrl, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.modalCtrl = modalCtrl;
        this.events = events;
        this.masterWalletId = "1";
        this.transfer = {
            toAddress: '',
            amount: '',
            memo: '',
            fee: 0,
            payPassword: '',
            remark: '',
        };
        this.chianId = 'ELA';
        this.feePerKb = 10000;
        this.SELA = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].SELA;
        this.init();
    }
    PaymentConfirmComponent.prototype.init = function () {
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.getAllSubWallets();
        var account = this.GetQueryString("account") || this.navParams.get("account");
        var toAddress = this.GetQueryString("address") || this.navParams.get("address");
        var memo = this.GetQueryString("memo") || this.navParams.get("memo");
        var information = this.GetQueryString("information");
        this.transfer.amount = account;
        this.transfer.toAddress = toAddress;
        this.transfer.memo = memo;
        this.information = information;
    };
    PaymentConfirmComponent.prototype.getAllSubWallets = function () {
        var _this = this;
        this.walletManager.getAllSubWallets(this.masterWalletId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    PaymentConfirmComponent.prototype.GetQueryString = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            return decodeURI(r[2]);
        return null;
    };
    PaymentConfirmComponent.prototype.onClick = function (type) {
        switch (type) {
            case 1:
                break;
            case 2:// 转账
                this.checkValue();
                break;
        }
    };
    PaymentConfirmComponent.prototype.checkValue = function () {
        var _this = this;
        if (__WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].isNull(this.transfer.toAddress)) {
            this.native.toast_trans('correct-address');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].isNull(this.transfer.amount)) {
            this.native.toast_trans('amount-null');
            return;
        }
        if (!__WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].number(this.transfer.amount)) {
            this.native.toast_trans('correct-amount');
            return;
        }
        if (this.transfer.amount > this.balance) {
            this.native.toast_trans('error-amount');
            return;
        }
        this.walletManager.isAddressValid(this.masterWalletId, this.transfer.toAddress, function (data) {
            if (!data['success']) {
                _this.native.toast_trans("contact-address-digits");
                return;
            }
            _this.native.showLoading().then(function () {
                _this.createTransaction();
            });
        });
    };
    PaymentConfirmComponent.prototype.createTransaction = function () {
        var _this = this;
        this.walletManager.createTransaction(this.masterWalletId, this.chianId, "", this.transfer.toAddress, this.transfer.amount, this.transfer.memo, this.transfer.remark, false, function (data) {
            if (data['success']) {
                _this.native.info(data);
                _this.rawTransaction = data['success'];
                _this.getFee();
            }
            else {
                _this.native.info(data);
            }
        });
    };
    PaymentConfirmComponent.prototype.getFee = function () {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.feePerKb, function (data) {
            if (data['success']) {
                _this.native.info(data);
                _this.native.hideLoading();
                _this.transfer.fee = data['success'];
                _this.openPayModal(_this.transfer);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    PaymentConfirmComponent.prototype.sendRawTransaction = function () {
        this.updateTxFee();
    };
    PaymentConfirmComponent.prototype.updateTxFee = function () {
        var _this = this;
        this.walletManager.updateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.transfer.fee, "", function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.singTx(data["success"]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    PaymentConfirmComponent.prototype.singTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.signTransaction(this.masterWalletId, this.chianId, rawTransaction, this.transfer.payPassword, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.sendTx(data["success"]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    PaymentConfirmComponent.prototype.sendTx = function (rawTransaction) {
        var _this = this;
        this.native.info(rawTransaction);
        this.walletManager.publishTransaction(this.masterWalletId, this.chianId, rawTransaction, function (data) {
            if (data["success"]) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.txId = JSON.parse(data['success'])["TxHash"];
                var result = {
                    txId: _this.txId
                };
                return result;
            }
            else {
                _this.native.info(data);
            }
            _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__["a" /* TabsComponent */]);
        });
    };
    PaymentConfirmComponent.prototype.openPayModal = function (data) {
        var _this = this;
        var transfer = this.native.clone(data);
        var modal = this.modalCtrl.create(__WEBPACK_IMPORTED_MODULE_8__pages_paymentbox_paymentbox__["a" /* PaymentboxPage */], transfer);
        modal.onDidDismiss(function (data) {
            if (data) {
                _this.native.showLoading().then(function () {
                    _this.transfer = _this.native.clone(data);
                    _this.sendRawTransaction();
                });
            }
        });
        modal.present();
    };
    PaymentConfirmComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-payment-confirm',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/payment-confirm/payment-confirm.component.html"*/'<ion-header>\n    <ion-navbar hideBackButton="true">\n        <ion-title style="text-align:center">{{\'text-payment-confirm\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <ion-grid>\n        <ion-row>\n\n            <ion-col col-3 class="font-size-1">\n                {{\'transaction-price\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                - {{transfer.amount/SELA}} {{chianId}}\n            </ion-col>\n\n            <ion-col col-3 class="font-size-1">\n                {{\'text-to-address\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                - {{transfer.amount/SELA}} {{chianId}}\n            </ion-col>\n\n            <ion-col col-3 class="font-size-1">\n                {{\'text-to-address\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                {{transfer.toAddress}}\n            </ion-col>\n\n            <ion-col col-3 class="font-size-1">\n                {{\'text-memo\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                {{transfer.memo}}\n            </ion-col>\n\n            <ion-col col-3 class="font-size-1">\n                {{\'text-memo\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                {{transfer.memo}}\n            </ion-col>\n\n            <ion-col col-3 class="font-size-1">\n                {{\'text-information\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                {{information}}\n            </ion-col>\n\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button style="width: 100%" (click)="onClick(2)">{{ \'text-transfer\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/payment-confirm/payment-confirm.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */],
            __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["j" /* ModalController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */]])
    ], PaymentConfirmComponent);
    return PaymentConfirmComponent;
}());

//# sourceMappingURL=payment-confirm.component.js.map

/***/ }),

/***/ 215:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PublickeyPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var PublickeyPage = /** @class */ (function () {
    function PublickeyPage(navCtrl, navParams, native, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.masterWalletId = "1";
        this.qrcode = null;
        this.getPublicKey();
    }
    PublickeyPage.prototype.ionViewDidLoad = function () {
    };
    PublickeyPage.prototype.copy = function () {
        this.native.copyClipboard(this.qrcode);
        this.native.toast_trans('copy-ok');
    };
    PublickeyPage.prototype.getPublicKey = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walletManager.getMasterWalletPublicKey(this.masterWalletId, function (data) {
            if (data["success"]) {
                _this.qrcode = data["success"];
                _this.native.info(data);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    PublickeyPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-publickey',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/publickey/publickey.html"*/'<!--\n  Generated template for the PublickeyPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-check-publickey\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n    <div style="text-align: center;width:100%;" (click)="copy()">\n        <qrcode class="receive-qrocde" [qrdata]="qrcode" [size]="200" [level]="\'M\'" style="display:inline-block;"></qrcode>\n        <p style="text-align:left;margin-top: 10px;font-size:1.6em">{{qrcode}}</p>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/publickey/publickey.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */]])
    ], PublickeyPage);
    return PublickeyPage;
}());

//# sourceMappingURL=publickey.js.map

/***/ }),

/***/ 216:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdLauncherComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_import_import__ = __webpack_require__(212);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_id_home_home__ = __webpack_require__(65);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};









var IdLauncherComponent = /** @class */ (function () {
    function IdLauncherComponent(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
    }
    IdLauncherComponent.prototype.onNext = function (type) {
        switch (type) {
            case 0:
                this.createId();
                break;
            case 1:
                this.native.Go(this.navCtrl, this, __WEBPACK_IMPORTED_MODULE_1__pages_id_import_import__["a" /* IdImportComponent */]);
                break;
        }
    };
    IdLauncherComponent.prototype.createId = function () {
        var _this = this;
        var self = this;
        this.walletManager.createDID("s12345678", function (result) {
            var idObj = { id: result.didname };
            console.info("ElastosJs luncher.ts createDID result add registerIdListener" + JSON.stringify(result));
            self.walletManager.registerIdListener(result.didname, function (data) {
                console.info("lacucher.ts ElastosJs createDID registerIdListener " + JSON.stringify(data));
                //alert("home.ts createDID registerIdListener  data  callback"+ JSON.stringify(data));
                //first commit
                if (data["path"] == "Added") {
                    var valueObj = JSON.parse(data["value"]);
                    if ((valueObj["Contents"].length > 0) && (valueObj["Contents"][0]["Values"].length > 0) && valueObj["Contents"][0]["Values"][0]["Proof"]) {
                        var proofObj = JSON.parse(valueObj["Contents"][0]["Values"][0]["Proof"]);
                        console.info("lacucher.ts ElastosJs createDID proofObj[\"signature\"]  " + proofObj["signature"]);
                        var seqNumObj = self.dataManager.getSeqNumObj(proofObj["signature"]);
                        var serialNum = seqNumObj["serialNum"];
                        console.info("lacucher.ts ElastosJs createDID serialNum " + serialNum);
                        self.setOrderStatus(5, serialNum);
                        self.dataManager.OutPutIDJson(data.id, valueObj["Contents"][0]["Path"], proofObj["signature"]);
                        //self.dataManager.addIdPathJson(data.id, valueObj["Contents"][0]["Path"], valueObj);
                        // alert("lacucher.ts createDID registerIdListener  data  callback"+ JSON.stringify(data));
                    }
                }
                //console.info("home.ts ElastosJs createDID registerIdListener " + JSON.stringify(data));
                console.info("lacucher.ts ElastosJs createDID registerIdListener  data  callback !!!!!" + JSON.stringify(data));
            });
            _this.localStorage.add("kycId", idObj).then(function () {
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_home_home__["a" /* IdHomeComponent */]);
            });
        });
    };
    IdLauncherComponent.prototype.setOrderStatus = function (status, serialNum) {
        var _this = this;
        console.info("setOrderStatus begin status " + status + " serialNum " + serialNum);
        var serids = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getSerIds();
        var serid = serids[serialNum];
        console.info("setOrderStatus serid" + JSON.stringify(serid));
        console.info("setOrderStatus serids" + JSON.stringify(serids));
        var did = serid["id"];
        var path = serid["path"];
        console.info("setOrderStatus appr" + path);
        var idsObj = {};
        this.localStorage.getKycList("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                return;
            }
            idsObj = JSON.parse(val);
            idsObj[did][path][serialNum]["pathStatus"] = status;
            _this.localStorage.set("kycId", idsObj).then(function () {
                _this.events.publish("order:update", status, path);
            });
        });
    };
    IdLauncherComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'id-launcher',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/launcher/launcher.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-id-my\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <div class="id-box id-launcher-box">\n        <img class="id-logo" src="./assets/images/1.0logo.png">\n\n        <div class="content-id">\n            <div class="id-con">\n                <p>{{ \'text-id-not\' | translate }}</p>\n                <div class="id-btn creat-id">\n                    <a (click)="onNext(0)">\n                        <i class="icon"></i>\n                        <span>{{ \'text-id-create\' | translate }}</span>\n                    </a>\n                </div>\n                <div class="id-btn import-id">\n                    <a (click)="onNext(1)">\n                        <i class="icon"></i>\n                        <span>{{ \'text-id-import\' | translate }}</span>\n                    </a>\n                </div>\n            </div>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/launcher/launcher.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */]])
    ], IdLauncherComponent);
    return IdLauncherComponent;
}());

//# sourceMappingURL=launcher.js.map

/***/ }),

/***/ 217:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AddpublickeyPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__pages_scan_scan__ = __webpack_require__(66);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};








var AddpublickeyPage = /** @class */ (function () {
    function AddpublickeyPage(navCtrl, navParams, walletManager, native, localStorage, events) {
        var _this = this;
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.masterWalletId = "1";
        this.publicKeyArr = [];
        this.name = "";
        this.curIndex = 0;
        this.qrcode = null;
        this.native.info(this.navParams.data);
        this.msobj = this.navParams.data;
        this.name = this.msobj["name"];
        var totalCopayers = 0;
        if (this.msobj["payPassword"]) {
            this.isOnly = false;
            this.innerType = "Standard";
            totalCopayers = this.msobj["totalCopayers"] - 1;
            this.getPublicKey();
        }
        else {
            this.isOnly = true;
            this.innerType = "Readonly";
            totalCopayers = this.msobj["totalCopayers"];
        }
        for (var index = 0; index < totalCopayers; index++) {
            var item = { index: index, publicKey: "" };
            this.publicKeyArr.push(item);
        }
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].uuid(6, 16);
        this.events.subscribe("publickey:update", function (val) {
            _this.publicKeyArr[_this.curIndex]['publicKey'] = val;
        });
    }
    AddpublickeyPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad AddpublickeyPage');
    };
    AddpublickeyPage.prototype.copy = function () {
        this.native.copyClipboard(this.qrcode);
        this.native.toast_trans('copy-ok');
    };
    AddpublickeyPage.prototype.saomiao = function (index) {
        this.curIndex = index;
        console.log("saomiao=" + index);
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scan_scan__["a" /* ScanPage */], { "pageType": "5" });
    };
    AddpublickeyPage.prototype.isRepeat = function (arr) {
        var hash = {};
        for (var i in arr) {
            if (hash[arr[i]]) {
                return true;
            }
            // 不存在该元素，则赋值为true，可以赋任意值，相应的修改if判断条件即可
            hash[arr[i]] = true;
        }
        return false;
    };
    AddpublickeyPage.prototype.nextPage = function () {
        var _this = this;
        var copayers = this.getTotalCopayers();
        //this.native.info(copayers);
        //this.native.info(this.isRepeat(copayers));
        if (this.isRepeat(JSON.parse(copayers))) {
            this.native.toast_trans("publickey-repeat");
            return;
        }
        this.native.showLoading().then(function () {
            if (_this.msobj["payPassword"]) {
                _this.createWalletWithMnemonic();
            }
            else {
                _this.createWallet();
            }
        });
    };
    AddpublickeyPage.prototype.createWallet = function () {
        var _this = this;
        var copayers = this.getTotalCopayers();
        this.walletManager.createMultiSignMasterWallet(this.masterWalletId, copayers, this.msobj["requiredCopayers"], function (data) {
            if (data['success']) {
                _this.createSubWallet("ELA");
            }
            else {
                _this.native.hideLoading();
                alert("=====createMultiSignMasterWallet===error==" + JSON.stringify(data));
            }
        });
    };
    AddpublickeyPage.prototype.getTotalCopayers = function () {
        var arr = [];
        for (var index = 0; index < this.publicKeyArr.length; index++) {
            var item = this.publicKeyArr[index];
            var publicKey = item["publicKey"].replace(/^\s+|\s+$/g, "");
            arr.push(publicKey);
        }
        return JSON.stringify(arr);
    };
    AddpublickeyPage.prototype.createSubWallet = function (chainId) {
        var _this = this;
        // Sub Wallet
        this.walletManager.createSubWallet(this.masterWalletId, chainId, 0, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.registerWalletListener(_this.masterWalletId, chainId);
                _this.saveWalletList();
            }
            else {
                _this.native.hideLoading();
            }
        });
    };
    AddpublickeyPage.prototype.saveWalletList = function () {
        var _this = this;
        __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getMasterWalletIdList().push(this.masterWalletId);
        this.localStorage.saveCurMasterId({ masterId: this.masterWalletId }).then(function (data) {
            var walletObj = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].masterWallObj);
            walletObj["id"] = _this.masterWalletId;
            walletObj["wallname"] = _this.name;
            walletObj["Account"] = { "SingleAddress": true, "Type": "Multi-Sign", "InnerType": _this.innerType };
            _this.localStorage.saveMappingTable(walletObj).then(function (data) {
                var mappingList = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getMappingList());
                mappingList[_this.masterWalletId] = walletObj;
                _this.native.info(mappingList);
                __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setMappingList(mappingList);
                _this.native.hideLoading();
                __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setCurMasterWalletId(_this.masterWalletId);
                _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__["a" /* TabsComponent */]);
            });
        });
    };
    AddpublickeyPage.prototype.createWalletWithMnemonic = function () {
        var _this = this;
        var copayers = this.getTotalCopayers();
        this.walletManager.createMultiSignMasterWalletWithMnemonic(this.masterWalletId, this.msobj["mnemonicStr"], this.msobj["mnemonicPassword"], this.msobj["payPassword"], copayers, this.msobj["requiredCopayers"], function (data) {
            if (data['success']) {
                _this.native.info(data);
                _this.createMnemonicSubWallet("ELA", _this.msobj["payPassword"]);
            }
            else {
                _this.native.hideLoading();
            }
        });
    };
    AddpublickeyPage.prototype.createMnemonicSubWallet = function (chainId, password) {
        var _this = this;
        // Sub Wallet
        this.walletManager.createSubWallet(this.masterWalletId, chainId, 0, function (data) {
            if (data["success"]) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.registerWalletListener(_this.masterWalletId, chainId);
                _this.saveWalletList();
            }
            else {
                _this.native.hideLoading();
                alert("createSubWallet=error:" + JSON.stringify(data));
            }
        });
    };
    AddpublickeyPage.prototype.registerWalletListener = function (masterId, coin) {
        var _this = this;
        this.walletManager.registerWalletListener(masterId, coin, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].isResregister(masterId, coin)) {
                __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setResregister(masterId, coin, true);
            }
            _this.events.publish("register:update", masterId, coin, data);
        });
    };
    AddpublickeyPage.prototype.getPublicKey = function () {
        var _this = this;
        this.walletManager.getMultiSignPubKeyWithMnemonic(this.msobj["mnemonicStr"], this.msobj["mnemonicPassword"], function (data) {
            if (data["success"]) {
                _this.qrcode = data["success"];
            }
            else {
            }
        });
    };
    AddpublickeyPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-addpublickey',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/addpublickey/addpublickey.html"*/'<!--\n  Generated template for the AddpublickeyPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-add-publickey-title\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content>\n    <!-- <ion-list>\n        <ion-item *ngFor="let copayer of publicKeyArr">\n            <ion-input type="text" placeholder="{{\'text-publickey-placeholder\'|translate}}" [(ngModel)]="copayer[\'publicKey\']"></ion-input>\n        </ion-item>\n    </ion-list> -->\n    <ion-row *ngFor="let copayer of publicKeyArr">\n        <ion-col align-self-center col-10>\n            <ion-item>\n                <ion-input type="text" placeholder="{{\'text-publickey-placeholder\'|translate}}" [(ngModel)]="copayer[\'publicKey\']"></ion-input>\n            </ion-item>\n        </ion-col>\n        <ion-col align-self-center col-2 (click)="saomiao(copayer[\'index\'])">\n            <img src="assets/images/icon/ico-scan.svg" style="width: 40px;height:30px">\n        </ion-col>\n    </ion-row>\n\n    <div style="text-align: center;width:100%;margin-top:20px" (click)="copy()" *ngIf="!isOnly">\n        <qrcode class="receive-qrocde" [qrdata]="qrcode" [size]="200" [level]="\'M\'" style="display:inline-block;"></qrcode>\n        <p style="text-align:left;margin-top: 10px;font-size:14px;padding:0px 10px">{{\'my-publickey\'|translate}}：{{qrcode}}</p>\n    </div>\n\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="nextPage()">{{\'text-next-step\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/addpublickey/addpublickey.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */]])
    ], AddpublickeyPage);
    return AddpublickeyPage;
}());

//# sourceMappingURL=addpublickey.js.map

/***/ }),

/***/ 227:
/***/ (function(module, exports) {

function webpackEmptyAsyncContext(req) {
	// Here Promise.resolve().then() is used instead of new Promise() to prevent
	// uncatched exception popping up in devtools
	return Promise.resolve().then(function() {
		throw new Error("Cannot find module '" + req + "'.");
	});
}
webpackEmptyAsyncContext.keys = function() { return []; };
webpackEmptyAsyncContext.resolve = webpackEmptyAsyncContext;
module.exports = webpackEmptyAsyncContext;
webpackEmptyAsyncContext.id = 227;

/***/ }),

/***/ 27:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return DataManager; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};

/***
 * 封装配置信息
 */
var DataManager = /** @class */ (function () {
    function DataManager() {
        //map key is signature value is jsonObj (with seqnum and so on)
        this.SignSeqNumObjetMap = {};
        // ID all three Path Json
        this.idPathJson = {};
        //key is proof signature, value is  kyc auth content
        this.kycSignCont = {};
    }
    DataManager.prototype.addIdPathJson = function (Id, Path, objJson) {
        if (!this.idPathJson[Id]) {
            this.idPathJson[Id] = {};
        }
        console.info("ElastosJs DataManager addIdPathJson Id " + Id + " Path" + Path + "objJson " + JSON.stringify(objJson));
        if (!this.idPathJson[Id][Path]) {
            this.idPathJson[Id][Path] = [];
        }
        this.idPathJson[Id][Path].push(objJson);
        console.info("ElastosJs DataManager addIdPathJson end Id " + Id + " Path" + Path + "objJson " + JSON.stringify(objJson));
    };
    DataManager.prototype.getIdPathJson = function (Id, Path) {
        var jsonObj = {};
        console.info("ElastosJs DataManager getIdPathJson begin Id " + Id + " Path" + Path);
        if (this.idPathJson[Id]) {
            jsonObj = this.idPathJson[Id][Path];
        }
        console.info("ElastosJs DataManager getIdPathJson end jsonObj " + JSON.stringify(jsonObj));
        return jsonObj;
    };
    DataManager.prototype.OutPutIDJson = function (Id, Path, signature) {
        var idJson = {};
        var jsonObj = this.getIdPathJson(Id, Path);
        //if( (jsonObj["Contents"].length > 0) && (jsonObj["Contents"][0]["Values"].length > 0)){
        //let proofObj = JSON.parse(jsonObj["Contents"][0]["Values"][0]["Proof"] );
        var signCont = this.getSignCont(signature);
        idJson["Id"] = Id;
        idJson["Path"] = Path;
        idJson["SignContent"] = signCont;
        //idJson["DataHash"] = [];
        idJson["DataHash"] = (jsonObj);
        console.info("Elastjs OutPutIDJson " + JSON.stringify(idJson));
        return idJson;
        //}
    };
    DataManager.prototype.addSignCont = function (sign, cont) {
        console.info("ElastosJs DataManager addSignCont sign " + sign + "cont " + JSON.stringify(cont));
        this.kycSignCont[sign] = cont;
    };
    DataManager.prototype.getSignCont = function (sign) {
        console.info("ElastosJs DataManager getSignCont sign " + sign + "obj " + JSON.stringify(this.kycSignCont[sign]));
        return this.kycSignCont[sign];
    };
    //add obj
    DataManager.prototype.addSeqNumObj = function (sign, obj) {
        console.info("ElastosJs DataManager addSeqNumObj sign " + sign + "obj " + JSON.stringify(obj));
        this.SignSeqNumObjetMap[sign] = obj;
    };
    //get object
    DataManager.prototype.getSeqNumObj = function (sign) {
        console.info("ElastosJs DataManager getSeqNumObj sign " + sign + "obj " + JSON.stringify(this.SignSeqNumObjetMap[sign]));
        return this.SignSeqNumObjetMap[sign];
    };
    DataManager = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])()
    ], DataManager);
    return DataManager;
}());

//# sourceMappingURL=DataManager.js.map

/***/ }),

/***/ 272:
/***/ (function(module, exports, __webpack_require__) {

var map = {
	"../pages/about/about.module": [
		930,
		13
	],
	"../pages/supernodeelection/superpoint/iconpromptbox/iconpromptbox.module": [
		931,
		12
	],
	"../pages/supernodeelection/superpoint/inputpassword/inputpassword.module": [
		932,
		11
	],
	"../pages/supernodeelection/superpoint/inputtickets/inputtickets.module": [
		933,
		10
	],
	"../pages/supernodeelection/superpoint/joinvotelist/joinvotelist.module": [
		934,
		9
	],
	"../pages/supernodeelection/superpoint/lockdetails/lockdetails.module": [
		935,
		8
	],
	"../pages/supernodeelection/superpoint/myvote/myvote.module": [
		936,
		7
	],
	"../pages/supernodeelection/superpoint/nodeinformation/nodeinformation.module": [
		937,
		6
	],
	"../pages/supernodeelection/superpoint/pointvote/pointvote.module": [
		943,
		5
	],
	"../pages/supernodeelection/superpoint/signup/signup.module": [
		938,
		4
	],
	"../pages/supernodeelection/superpoint/superpoint.module": [
		939,
		3
	],
	"../pages/supernodeelection/superpoint/updateproducer/updateproducer.module": [
		940,
		2
	],
	"../pages/supernodeelection/superpoint/votemanage/votemanage.module": [
		941,
		1
	],
	"../pages/supernodeelection/superpoint/votingrules/votingrules.module": [
		942,
		0
	]
};
function webpackAsyncContext(req) {
	var ids = map[req];
	if(!ids)
		return Promise.reject(new Error("Cannot find module '" + req + "'."));
	return __webpack_require__.e(ids[1]).then(function() {
		return __webpack_require__(ids[0]);
	});
};
webpackAsyncContext.keys = function webpackAsyncContextKeys() {
	return Object.keys(map);
};
webpackAsyncContext.id = 272;
module.exports = webpackAsyncContext;

/***/ }),

/***/ 277:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return HttpService; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_rxjs_add_operator_toPromise__ = __webpack_require__(165);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_rxjs_add_operator_toPromise___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_rxjs_add_operator_toPromise__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_rxjs__ = __webpack_require__(523);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_rxjs___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_rxjs__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__angular_http__ = __webpack_require__(364);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






//import {Native} from "./Native"
//import {ApiUrl} from "./ApiUrl";
/***
 * 请求处理
 *
 * demo：
 *  this.httpService.getByAuth(url, {
      "newpid":"sss",
      "orid": "sss"
    }).toPromise().then(data => {

    }).catch(error => {

    });
 */
var HttpService = /** @class */ (function () {
    function HttpService(http) {
        this.http = http;
    }
    HttpService_1 = HttpService;
    HttpService.prototype.getByAuth = function (url, paramMap) {
        //this.native.info(paramMap);
        var headers = new __WEBPACK_IMPORTED_MODULE_3__angular_http__["a" /* Headers */]({
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        });
        return __WEBPACK_IMPORTED_MODULE_2_rxjs__["Observable"].fromPromise(this.http.get(url, new __WEBPACK_IMPORTED_MODULE_3__angular_http__["d" /* RequestOptions */]({ search: HttpService_1.buildURLSearchParams(paramMap),
            headers: headers }))
            .toPromise().then(function (result) { return result; }, function (error) { return error; }));
    };
    HttpService.prototype.postByAuth = function (url, paramMap) {
        //this.native.info(paramMap);
        var headers = new __WEBPACK_IMPORTED_MODULE_3__angular_http__["a" /* Headers */]({
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Accept': 'application/json;charset=utf-8',
        });
        return this.http.post(url, HttpService_1.buildURLSearchParams(paramMap).toString(), new __WEBPACK_IMPORTED_MODULE_3__angular_http__["d" /* RequestOptions */]({ headers: headers }));
    };
    HttpService.buildURLSearchParams = function (paramMap) {
        var params = new __WEBPACK_IMPORTED_MODULE_3__angular_http__["e" /* URLSearchParams */]();
        for (var key in paramMap) {
            var val = paramMap[key];
            if (val instanceof Date) {
                val = __WEBPACK_IMPORTED_MODULE_4__Util__["a" /* Util */].dateFormat(val, 'yyyy-MM-dd HH:mm:ss');
            }
            params.set(key, val);
        }
        //params.set('ajax', 'true');
        return params;
    };
    HttpService = HttpService_1 = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_3__angular_http__["b" /* Http */]])
    ], HttpService);
    return HttpService;
    var HttpService_1;
}());

//# sourceMappingURL=HttpService.js.map

/***/ }),

/***/ 35:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return TabsComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__tabs_home_home_component__ = __webpack_require__(415);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__tabs_my_my_component__ = __webpack_require__(475);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};



var TabsComponent = /** @class */ (function () {
    function TabsComponent(zone, changeDetectorRef) {
        this.zone = zone;
        this.changeDetectorRef = changeDetectorRef;
        this.homeRoot = __WEBPACK_IMPORTED_MODULE_1__tabs_home_home_component__["a" /* HomeComponent */];
        this.settingsRoot = __WEBPACK_IMPORTED_MODULE_2__tabs_my_my_component__["a" /* MyComponent */];
    }
    TabsComponent.prototype.changeTabs = function () {
        var _this = this;
        this.zone.run(function () {
            _this.changeDetectorRef.markForCheck();
            _this.changeDetectorRef.detectChanges();
        });
    };
    TabsComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/tabs/tabs.component.html"*/'<ion-tabs #myTabs (ionChange)="changeTabs()">\n    <ion-tab [root]="homeRoot" tabTitle="{{ \'tab-home\' | translate }}" tabIcon="tab-home"></ion-tab>\n    <ion-tab [root]="settingsRoot" tabTitle="{{ \'tab-setting\' | translate }}" tabIcon="tab-settings"></ion-tab>\n</ion-tabs>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/tabs/tabs.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["j" /* ChangeDetectorRef */]])
    ], TabsComponent);
    return TabsComponent;
}());

//# sourceMappingURL=tabs.component.js.map

/***/ }),

/***/ 36:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IDManager; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_crypto_browserify__ = __webpack_require__(837);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_crypto_browserify___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_crypto_browserify__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_secp256k1__ = __webpack_require__(921);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_secp256k1___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_secp256k1__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_elliptic__ = __webpack_require__(30);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_elliptic___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_4_elliptic__);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





/***
 * id链相关
 */
var IDManager = /** @class */ (function () {
    function IDManager() {
    }
    IDManager_1 = IDManager;
    IDManager.test = function () {
        var msg = Object(__WEBPACK_IMPORTED_MODULE_1_crypto_browserify__["randomBytes"])(32);
        // const msg = this.hash("我是哈哈哈");
        var privKey;
        do {
            privKey = Object(__WEBPACK_IMPORTED_MODULE_1_crypto_browserify__["randomBytes"])(32);
        } while (!__WEBPACK_IMPORTED_MODULE_2_secp256k1___default.a.privateKeyVerify(privKey));
        var pubKey = __WEBPACK_IMPORTED_MODULE_2_secp256k1___default.a.publicKeyCreate(privKey);
        var sigObj = this.sign(msg, privKey);
    };
    IDManager.sign = function (msg, privKey) {
        var EC = __WEBPACK_IMPORTED_MODULE_4_elliptic___default.a.ec;
        var ec = new EC('p256'); // 获取secp256r1曲线
        var message = this.hash(msg);
        var key = ec.keyFromPrivate(privKey, 'hex'); // 导入私钥
        var sign = key.sign(message).toDER('hex'); // 生成签名
        return sign;
    };
    IDManager.sign1 = function (msg, privKey) {
        var EC = __WEBPACK_IMPORTED_MODULE_4_elliptic___default.a.ec;
        var ec = new EC('p256'); // 获取secp256r1曲线
        var message = this.hash(msg);
        //let key = ec.keyFromPrivate(privKey, 'hex'); // 导入私钥
        var sign = ec.sign(message, privKey, 16).toDER('hex'); // 生成签名
        return sign;
    };
    IDManager.verify = function (msg, signature, pubKey) {
        return __WEBPACK_IMPORTED_MODULE_2_secp256k1___default.a.verify(msg, signature, pubKey);
    };
    IDManager.hash = function (msg) {
        return Object(__WEBPACK_IMPORTED_MODULE_1_crypto_browserify__["createHash"])('sha256').update(msg).digest('hex');
    };
    //接口数字签名
    IDManager.getInfoSign = function (obj) {
        var keys = IDManager_1.getObjKeys(obj, "asc");
        var msg = "";
        for (var index in keys) {
            msg = msg + obj[keys[index]];
        }
        return this.sign1(msg, "");
    };
    //checksum计算规则
    IDManager.getCheckSum = function (obj, sort) {
        var keys = IDManager_1.getObjKeys(obj, sort);
        var msg = "";
        for (var index in keys) {
            msg = msg + obj[keys[index]];
        }
        return this.hash(msg);
    };
    IDManager.getObjKeys = function (obj, sort) {
        if (sort === void 0) { sort = ""; }
        var arr = [];
        for (var key in obj) {
            if (!__WEBPACK_IMPORTED_MODULE_3__Util__["a" /* Util */].isNull(obj[key])) {
                arr.push(key);
            }
        }
        if (sort === "asc") {
            IDManager_1.asc(arr);
        }
        else if (sort === "des") {
            IDManager_1.des(arr);
        }
        return arr;
    };
    /**
     * 从小到大
     */
    IDManager.asc = function (keys) {
        keys.sort(function (s1, s2) {
            var x1 = s1.toUpperCase();
            var x2 = s2.toUpperCase();
            if (x1 < x2) {
                return -1;
            }
            if (x1 > x2) {
                return 1;
            }
            return 0;
        });
    };
    /**
  * 从大到小
  */
    IDManager.des = function (keys) {
        keys.sort(function (s1, s2) {
            var x1 = s1.toUpperCase();
            var x2 = s2.toUpperCase();
            if (x1 > x2) {
                return -1;
            }
            if (x1 < x2) {
                return 1;
            }
            return 0;
        });
    };
    /**
     * 获得公钥
     * @param privKey
     */
    IDManager.getPublicKey = function (privKey) {
        return "111111";
    };
    IDManager.getPriKey = function () {
        return "sssss";
    };
    IDManager = IDManager_1 = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [])
    ], IDManager);
    return IDManager;
    var IDManager_1;
}());

//# sourceMappingURL=IDManager.js.map

/***/ }),

/***/ 365:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return Logger; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(803);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Config__ = __webpack_require__(11);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};



/**
 * 日志控制
 */
var Logger = /** @class */ (function () {
    function Logger() {
    }
    Logger.info = function (message) {
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].isDebug) {
            var msg = "elastos==" + (__WEBPACK_IMPORTED_MODULE_1_lodash__["isString"](message) ? message : JSON.stringify(message));
            console.log(msg, 'color:#e8c406');
        }
    };
    Logger = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [])
    ], Logger);
    return Logger;
}());

//# sourceMappingURL=Logger.js.map

/***/ }),

/***/ 38:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PopupProvider; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_ionic_angular__ = __webpack_require__(2);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};



var PopupProvider = /** @class */ (function () {
    function PopupProvider(alertCtrl, translate) {
        this.alertCtrl = alertCtrl;
        this.translate = translate;
    }
    PopupProvider.prototype.ionicAlert = function (title, subTitle, okText) {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant(title),
                subTitle: _this.translate.instant(subTitle),
                enableBackdropDismiss: false,
                buttons: [
                    {
                        text: okText ? okText : _this.translate.instant('confirm'),
                        handler: function () {
                            console.log('Ok clicked');
                            resolve();
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    ;
    PopupProvider.prototype.ionicAlert_data = function (title, subTitle, amount, okText) {
        var _this = this;
        var suggestAmount = this.translate.instant('suggest-amount');
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant(title),
                subTitle: _this.translate.instant(subTitle) + "(" + suggestAmount + amount + ")",
                enableBackdropDismiss: false,
                buttons: [
                    {
                        text: okText ? okText : _this.translate.instant('confirm'),
                        handler: function () {
                            console.log('Ok clicked');
                            resolve();
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    ;
    PopupProvider.prototype.ionicAlert_delTx = function (title, subTitle, hash, okText) {
        var _this = this;
        var transactionDeleted = this.translate.instant('transaction-deleted');
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant(title),
                subTitle: "txHash:" + "(" + hash + ")" + ":" + transactionDeleted,
                enableBackdropDismiss: false,
                buttons: [
                    {
                        text: okText ? okText : _this.translate.instant('confirm'),
                        handler: function () {
                            console.log('Ok clicked');
                            resolve();
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    ;
    PopupProvider.prototype.ionicAlert_PublishedTx_fail = function (title, subTitle, hash, okText) {
        var _this = this;
        var sub = this.translate.instant(subTitle);
        var reason = this.translate.instant('reasons-failure');
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant(title),
                subTitle: reason + ":" + sub + "<br/>" + "(" + "txHash:" + hash + ")",
                enableBackdropDismiss: false,
                buttons: [
                    {
                        text: okText ? okText : _this.translate.instant('confirm'),
                        handler: function () {
                            console.log('Ok clicked');
                            resolve();
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    ;
    PopupProvider.prototype.ionicAlert_PublishedTx_sucess = function (title, subTitle, hash, okText) {
        var _this = this;
        var sub = this.translate.instant(subTitle);
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant(title),
                subTitle: sub + "<br/>" + "(" + "txHash:" + hash + ")",
                enableBackdropDismiss: false,
                buttons: [
                    {
                        text: okText ? okText : _this.translate.instant('confirm'),
                        handler: function () {
                            console.log('Ok clicked');
                            resolve();
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    ;
    PopupProvider.prototype.ionicConfirm = function (title, message, okText, cancelText) {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var confirm = _this.alertCtrl.create({
                title: _this.translate.instant(title),
                message: _this.translate.instant(message),
                buttons: [
                    {
                        text: cancelText ? cancelText : _this.translate.instant('cancel'),
                        handler: function () {
                            console.log('Disagree clicked');
                            resolve(false);
                        }
                    },
                    {
                        text: okText ? okText : _this.translate.instant('confirm'),
                        handler: function () {
                            console.log('Agree clicked');
                            resolve(true);
                        }
                    }
                ]
            });
            confirm.present();
        });
    };
    ;
    PopupProvider.prototype.ionicPrompt = function (title, message, opts, okText, cancelText) {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var defaultText = opts && opts.defaultText ? opts.defaultText : null;
            var placeholder = opts && opts.placeholder ? opts.placeholder : null;
            var inputType = opts && opts.type ? opts.type : 'text';
            var cssClass = opts.useDanger ? "alertDanger" : null;
            var enableBackdropDismiss = !!opts.enableBackdropDismiss;
            var prompt = _this.alertCtrl.create({
                title: title,
                message: message,
                cssClass: cssClass,
                enableBackdropDismiss: enableBackdropDismiss,
                inputs: [
                    {
                        value: defaultText,
                        placeholder: placeholder,
                        type: inputType
                    },
                ],
                buttons: [
                    {
                        text: cancelText ? cancelText : _this.translate.instant('Cancel'),
                        handler: function (data) {
                            console.log('Cancel clicked');
                            resolve(null);
                        }
                    },
                    {
                        text: okText ? okText : _this.translate.instant('Ok'),
                        handler: function (data) {
                            console.log('Saved clicked');
                            resolve(data[0]);
                        }
                    }
                ]
            });
            prompt.present();
        });
    };
    PopupProvider.prototype.presentPrompt = function () {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant("text-id-kyc-prompt-title"),
                inputs: [
                    {
                        name: 'password',
                        placeholder: _this.translate.instant("text-id-kyc-prompt-password"),
                        type: 'password'
                    }
                ],
                buttons: [
                    {
                        text: _this.translate.instant('cancel'),
                        role: 'cancel',
                        handler: function (data) {
                            console.log('Cancel clicked');
                            reject(null);
                        }
                    },
                    {
                        text: _this.translate.instant('Ok'),
                        handler: function (data) {
                            resolve(data.password);
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    PopupProvider.prototype.presentConfirm = function (price) {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant("text-id-kyc-prompt-title"),
                message: _this.translate.instant('text-id-kyc-cochain') + price + "ELA",
                buttons: [
                    {
                        text: _this.translate.instant('cancel'),
                        role: 'cancel',
                        handler: function () {
                            reject();
                        }
                    },
                    {
                        text: _this.translate.instant('Ok'),
                        handler: function () {
                            resolve();
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    PopupProvider.prototype.webKeyPrompt = function () {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant("text-id-kyc-prompt-title"),
                inputs: [
                    {
                        name: 'password',
                        placeholder: _this.translate.instant("importmnes-optionalpassword-placeholder"),
                        type: 'password'
                    }
                ],
                buttons: [
                    {
                        text: _this.translate.instant('cancel'),
                        role: 'cancel',
                        handler: function (data) {
                            console.log('Cancel clicked');
                            reject(null);
                        }
                    },
                    {
                        text: _this.translate.instant('Ok'),
                        handler: function (data) {
                            resolve(data.password);
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    PopupProvider.prototype.presentConfirm1 = function (price) {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var alert = _this.alertCtrl.create({
                title: _this.translate.instant("text-id-kyc-prompt-title"),
                message: _this.translate.instant('text-id-kyc-cochain1') + price + "ELA",
                buttons: [
                    {
                        text: _this.translate.instant('cancel'),
                        role: 'cancel',
                        handler: function () {
                            reject();
                        }
                    },
                    {
                        text: _this.translate.instant('Ok'),
                        handler: function () {
                            resolve();
                        }
                    }
                ]
            });
            alert.present();
        });
    };
    PopupProvider = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_2_ionic_angular__["a" /* AlertController */],
            __WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__["c" /* TranslateService */]])
    ], PopupProvider);
    return PopupProvider;
}());

//# sourceMappingURL=popup.js.map

/***/ }),

/***/ 412:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return InitializepagePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_launcher_launcher_component__ = __webpack_require__(121);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__pages_tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__pages_coin_payment_confirm_payment_confirm_component__ = __webpack_require__(214);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__pages_third_party_did_login_did_login_component__ = __webpack_require__(490);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__ngx_translate_core__ = __webpack_require__(51);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};












var InitializepagePage = /** @class */ (function () {
    function InitializepagePage(appCtrl, platform, navCtrl, navParams, walletManager, native, localStorage, events, translate, keyboard, ionicApp) {
        this.appCtrl = appCtrl;
        this.platform = platform;
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.translate = translate;
        this.keyboard = keyboard;
        this.ionicApp = ionicApp;
        this.backButtonPressed = false; //用于判断返回键是否触发
    }
    InitializepagePage.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.registerBackButtonAction(this.tabs);
        this.native.showLoading().then(function () {
            _this.initializeApp();
        });
    };
    InitializepagePage.prototype.registerBackButtonAction = function (tabRef) {
        var _this = this;
        this.platform.registerBackButtonAction(function () {
            //按下返回键时，先关闭键盘
            if (_this.keyboard.isOpen()) {
                _this.keyboard.close();
                return;
            }
            ;
            var activePortal = _this.ionicApp._modalPortal.getActive() || _this.ionicApp._overlayPortal.getActive();
            if (activePortal) {
                activePortal.dismiss().catch(function () { });
                activePortal.onDidDismiss(function () { });
                return;
            }
            var loadingPortal = _this.ionicApp._loadingPortal.getActive();
            if (loadingPortal) {
                //loading的话，返回键无效
                return;
            }
            var activeNav = _this.appCtrl.getActiveNav();
            if (activeNav.canGoBack()) {
                activeNav.pop();
            }
            else {
                if (tabRef == null || tabRef._selectHistory[tabRef._selectHistory.length - 1] === tabRef.getByIndex(0).id) {
                    _this.showExit();
                }
                else {
                    //选择首页第一个的标签
                    tabRef.select(0);
                }
            }
        }, 1);
    };
    //双击退出提示框
    InitializepagePage.prototype.showExit = function () {
        var _this = this;
        if (this.backButtonPressed) {
            this.platform.exitApp();
        }
        else {
            var exitmesage = this.translate.instant("text-exit-message");
            this.native.toast(exitmesage);
            this.backButtonPressed = true;
            setTimeout(function () { return _this.backButtonPressed = false; }, 2000); //2秒内没有再次点击返回则将触发标志标记为false
        }
    };
    InitializepagePage.prototype.initializeApp = function () {
        var _this = this;
        this.load().then(function (data) {
            _this.successHandle(data["success"]);
        }).catch(function (data) {
            _this.errorHandle(data);
        });
    };
    InitializepagePage.prototype.load = function () {
        var _this = this;
        return new Promise(function (resolve, reject) {
            _this.walletManager.getAllMasterWallets(function (data) {
                if (data["success"]) {
                    resolve(data);
                }
                else {
                    reject(data);
                }
            });
        });
    };
    InitializepagePage.prototype.successHandle = function (data) {
        var _this = this;
        var idList = JSON.parse(data);
        var type = __WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].GetQueryString("type");
        if (idList.length === 0) {
            __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setMappingList({});
            this.handleNull(type);
        }
        else {
            this.native.info(idList);
            this.localStorage.getCurMasterId().then(function (data) {
                var item = JSON.parse(data);
                _this.native.info(item["masterId"]);
                if (_this.isInArray(idList, item["masterId"])) {
                    __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setCurMasterWalletId(item["masterId"]);
                    __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setMasterWalletIdList(idList);
                    _this.handleMappingdata(idList);
                    _this.getAllsubWallet(item["masterId"], type);
                }
                else {
                    var id = idList[0];
                    __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setCurMasterWalletId(id);
                    __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setMasterWalletIdList(idList);
                    _this.handleMappingdata(idList);
                    _this.getAllsubWallet(id, type);
                }
            });
        }
    };
    InitializepagePage.prototype.errorHandle = function (data) {
        var error = data["error"];
        this.native.info(error["code"]);
        if (error["code"] === 10002) {
            this.native.info(error["code"]);
            var type = __WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].GetQueryString("type");
            this.handleNull(type);
        }
        else {
            this.native.hideLoading();
        }
    };
    InitializepagePage.prototype.handleNull = function (type) {
        var _this = this;
        if (type == 'payment') {
            var account = __WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].GetQueryString("account");
            var toAddress = __WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].GetQueryString("address");
            var memo = __WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].GetQueryString("memo");
            var payment_params = {
                account: account,
                toAddress: toAddress,
                memo: memo
            };
            this.localStorage.set('payment', payment_params).then(function () {
                _this.native.hideLoading();
                __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setMasterWalletIdList([]);
                _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_2__pages_launcher_launcher_component__["a" /* LauncherComponent */]);
            });
        }
        else {
            this.native.hideLoading();
            __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setMasterWalletIdList([]);
            this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_2__pages_launcher_launcher_component__["a" /* LauncherComponent */]);
        }
    };
    InitializepagePage.prototype.handleMappingdata = function (idList) {
        var mappList = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getMappingList();
        var list = {};
        for (var index in idList) {
            var id = idList[index];
            list[id] = mappList[id];
        }
        __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setMappingList(list);
        this.native.info(__WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getMappingList());
    };
    InitializepagePage.prototype.getAllsubWallet = function (masterId, type) {
        var _this = this;
        this.walletManager.getAllSubWallets(masterId, function (data) {
            if (data["success"]) {
                var chinas = JSON.parse(data["success"]);
                for (var index in chinas) {
                    var chain = chinas[index];
                    _this.registerWalletListener(masterId, chain);
                }
                _this.native.hideLoading();
                switch (type) {
                    case "payment":
                        _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_9__pages_coin_payment_confirm_payment_confirm_component__["a" /* PaymentConfirmComponent */]);
                        break;
                    case "did_login":
                        _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_10__pages_third_party_did_login_did_login_component__["a" /* DidLoginComponent */]);
                        break;
                    default:
                        _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_7__pages_tabs_tabs_component__["a" /* TabsComponent */]);
                        break;
                }
            }
        });
    };
    InitializepagePage.prototype.registerWalletListener = function (masterId, coin) {
        var _this = this;
        this.walletManager.registerWalletListener(masterId, coin, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].isResregister(masterId, coin)) {
                __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].setResregister(masterId, coin, true);
            }
            _this.events.publish("register:update", masterId, coin, data);
        });
    };
    InitializepagePage.prototype.isInArray = function (arr, value) {
        for (var i = 0; i < arr.length; i++) {
            if (value === arr[i]) {
                return true;
            }
        }
        return false;
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])('myTabs'),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["o" /* Tabs */])
    ], InitializepagePage.prototype, "tabs", void 0);
    InitializepagePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-initializepage',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/initializepage/initializepage.html"*/'<ion-content>\n\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/initializepage/initializepage.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["b" /* App */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["n" /* Platform */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_11__ngx_translate_core__["c" /* TranslateService */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["h" /* Keyboard */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicApp */]])
    ], InitializepagePage);
    return InitializepagePage;
}());

//# sourceMappingURL=initializepage.js.map

/***/ }),

/***/ 413:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return MnemonicComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__write_write_component__ = __webpack_require__(414);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};








var MnemonicComponent = /** @class */ (function () {
    function MnemonicComponent(navCtrl, navParams, walletManager, native, localStorage, events) {
        var _this = this;
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.masterWalletId = "1";
        this.mnemonicList = [];
        this.mnemonicPassword = "";
        this.singleAddress = false;
        this.defaultCointype = "Ela";
        this.isSelect = false;
        native.showLoading().then(function () {
            _this.init();
        });
    }
    MnemonicComponent.prototype.init = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].uuid(6, 16);
        this.walletManager.generateMnemonic(this.native.getMnemonicLang(), function (data) {
            if (data["success"]) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.mnemonicStr = data["success"].toString();
                var mnemonicArr = _this.mnemonicStr.split(/[\u3000\s]+/);
                for (var i = 0; i < mnemonicArr.length; i++) {
                    _this.mnemonicList.push({ text: mnemonicArr[i], selected: false });
                }
            }
            else {
                _this.native.info(data);
            }
        });
        this.payPassword = this.navParams.get("payPassword");
        this.name = this.navParams.get("name");
        this.singleAddress = this.navParams.get("singleAddress");
        this.multType = this.navParams.get("mult");
    };
    MnemonicComponent.prototype.onNext = function () {
        var _this = this;
        if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].password(this.mnemonicPassword) && this.isSelect) {
            this.native.toast_trans("text-pwd-validator");
            return;
        }
        if (this.mnemonicPassword != this.mnemonicRepassword && this.isSelect) {
            this.native.toast_trans("text-repwd-validator");
            return;
        }
        if (!this.isSelect) {
            this.mnemonicPassword = "";
            this.mnemonicRepassword = "";
        }
        if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isEmptyObject(this.multType)) {
            this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__write_write_component__["a" /* WriteComponent */], { "mult": this.multType, mnemonicStr: this.mnemonicStr, mnemonicList: this.mnemonicList, "totalCopayers": this.multType["totalCopayers"], "requiredCopayers": this.multType["requiredCopayers"], "mnemonicPassword": this.mnemonicPassword, "payPassword": this.payPassword, name: this.name });
            return;
        }
        this.native.showLoading().then(function () {
            _this.walletManager.createMasterWallet(_this.masterWalletId, _this.mnemonicStr, _this.mnemonicPassword, _this.payPassword, _this.singleAddress, function (data) {
                if (data["success"]) {
                    _this.native.info(data);
                    _this.createSubWallet('ELA');
                }
                else {
                    _this.native.info(data);
                }
            });
        });
    };
    MnemonicComponent.prototype.createSubWallet = function (chainId) {
        var _this = this;
        // Sub Wallet
        this.walletManager.createSubWallet(this.masterWalletId, chainId, 0, function (data) {
            if (data["success"]) {
                var walletObj_1 = _this.native.clone(__WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].masterWallObj);
                walletObj_1["id"] = _this.masterWalletId;
                walletObj_1["wallname"] = _this.name;
                walletObj_1["Account"] = { "SingleAddress": _this.singleAddress, "Type": "Standard" };
                _this.localStorage.saveMappingTable(walletObj_1).then(function (data) {
                    var mappingList = _this.native.clone(__WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getMappingList());
                    mappingList[_this.masterWalletId] = walletObj_1;
                    _this.native.info(mappingList);
                    __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].setMappingList(mappingList);
                    _this.saveWalletList();
                    _this.registerWalletListener(_this.masterWalletId, chainId);
                });
            }
            else {
                alert("createSubWallet=error:" + JSON.stringify(data));
            }
        });
    };
    MnemonicComponent.prototype.saveWalletList = function () {
        var _this = this;
        __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getMasterWalletIdList().push(this.masterWalletId);
        this.localStorage.saveCurMasterId({ masterId: this.masterWalletId }).then(function (data) {
            _this.native.hideLoading();
            __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].setCurMasterWalletId(_this.masterWalletId);
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__write_write_component__["a" /* WriteComponent */], { mnemonicStr: _this.mnemonicStr, mnemonicList: _this.mnemonicList });
        });
    };
    MnemonicComponent.prototype.registerWalletListener = function (masterId, coin) {
        var _this = this;
        this.walletManager.registerWalletListener(masterId, coin, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].isResregister(masterId, coin)) {
                __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].setResregister(masterId, coin, true);
            }
            _this.events.publish("register:update", masterId, coin, data);
            //this.saveWalletList();
        });
    };
    MnemonicComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-mnemonic',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/mnemonic/mnemonic.component.html"*/'<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-mnemonic\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n<ion-content>\n    <div class="mnemonic">\n        <div class="slide-container">\n            <div class="slide-title">{{ \'text-mnemonic-prompt\' | translate}}</div>\n            <div class="slide-body">\n                <div class="phrase-container">\n                    <div class="phrase">\n                        <span *ngFor="let item of mnemonicList;let i=index">\n                      <span>{{item.text}}</span>\n                        </span>\n                    </div>\n                </div>\n            </div>\n            <div class="mnemonic-password">\n                <ion-list>\n                    <ion-item>\n                        <ion-label style="font-size:15px">{{\'showmnes-optionalpassword1-title\' | translate }}</ion-label>\n                        <ion-toggle [(ngModel)]="isSelect"></ion-toggle>\n                    </ion-item>\n\n                    <ion-item *ngIf="isSelect">\n                        <ion-input type="password" placeholder="{{ \'showmnes-optionalpassword1-placeholder\' | translate }}" [(ngModel)]="mnemonicPassword"></ion-input>\n                    </ion-item>\n\n                    <ion-item *ngIf="isSelect">\n                        <ion-input type="password" placeholder="{{ \'showmnes-optionalpassword2-placeholder\' | translate }}" [(ngModel)]="mnemonicRepassword"></ion-input>\n                    </ion-item>\n\n                </ion-list>\n            </div>\n        </div>\n    </div>\n</ion-content>\n<ion-footer>\n    <button ion-button (click)="onNext()" full>{{ \'text-memory\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/mnemonic/mnemonic.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */]])
    ], MnemonicComponent);
    return MnemonicComponent;
}());

//# sourceMappingURL=mnemonic.component.js.map

/***/ }),

/***/ 414:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return WriteComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_mpublickey_mpublickey__ = __webpack_require__(128);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var WriteComponent = /** @class */ (function () {
    function WriteComponent(navCtrl, navParams, native, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.zone = zone;
        this.mnemonicList = [];
        this.selectList = [];
        this.selectComplete = false;
        this.init();
    }
    WriteComponent.prototype.init = function () {
        this.exatParm = this.native.clone(this.navParams.data);
        this.multType = this.navParams.get("mult");
        this.mnemonicStr = this.native.clone(this.navParams.get("mnemonicStr"));
        this.mnemonicList = this.native.clone(this.navParams.get("mnemonicList")).sort(function () { return 0.5 - Math.random(); });
    };
    WriteComponent.prototype.onNext = function () {
        var mn = "";
        for (var i = 0; i < this.selectList.length; i++) {
            mn += this.selectList[i].text;
        }
        if (!__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isNull(mn) && mn == this.mnemonicStr.replace(/\s+/g, "")) {
            if (this.multType) {
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__pages_mpublickey_mpublickey__["a" /* MpublickeyPage */], this.exatParm);
            }
            else {
                this.native.toast_trans('text-mnemonic-ok');
                this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__["a" /* TabsComponent */]);
            }
        }
        else {
            this.native.toast_trans('text-mnemonic-prompt3');
        }
    };
    WriteComponent.prototype.addButton = function (index, item) {
        var _this = this;
        var newWord = {
            text: item.text,
            prevIndex: index
        };
        this.zone.run(function () {
            _this.selectList.push(newWord);
            _this.mnemonicList[index].selected = true;
            _this.shouldContinue();
        });
    };
    WriteComponent.prototype.removeButton = function (index, item) {
        var _this = this;
        this.zone.run(function () {
            _this.selectList.splice(index, 1);
            _this.mnemonicList[item.prevIndex].selected = false;
            _this.shouldContinue();
        });
    };
    WriteComponent.prototype.shouldContinue = function () {
        this.selectComplete = this.selectList.length === this.mnemonicList.length ? true : false;
    };
    WriteComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-write',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/mnemonic/write/write.component.html"*/'<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-mnemonic-check\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n<ion-content>\n    <div class="mnemonic-write">\n\n        <div class="slide-container">\n            <div class="slide-body">\n                <div class="slide-title">{{\'text-mnemonic-prompt2\' | translate}}</div>\n                <div class="phrase-container">\n                    <div class="phrase">\n                        <button ion-button outline *ngFor="let item of selectList; let i = index" (click)="removeButton(i,item)" style="text-transform: none">{{item.text}}</button>\n                    </div>\n                </div>\n            </div>\n\n            <div class="bottom-phrase">\n                <div *ngIf="!selectComplete">\n                    <div class="words">\n                        <button ion-button outline *ngFor="let item of mnemonicList; let i = index" (click)="addButton(i, item)" [disabled]="item.selected" style="text-transform: none">{{item.text}}\n                    </button>\n                    </div>\n                </div>\n            </div>\n        </div>\n\n\n        <div *ngIf="selectComplete" class="bottom-absolute">\n            <button ion-button full class="button-standard" (click)="onNext()">\n            {{ \'confirm\' | translate }}\n          </button>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/mnemonic/write/write.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], WriteComponent);
    return WriteComponent;
}());

//# sourceMappingURL=write.component.js.map

/***/ }),

/***/ 415:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return HomeComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__coin_coin_component__ = __webpack_require__(416);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__coin_coin_list_coin_list_component__ = __webpack_require__(473);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__coin_payment_confirm_payment_confirm_component__ = __webpack_require__(214);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_walltelist_walltelist__ = __webpack_require__(474);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__providers_popup__ = __webpack_require__(38);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};












var HomeComponent = /** @class */ (function () {
    function HomeComponent(navCtrl, navParams, walletManager, native, localStorage, zone, events, popupProvider) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.zone = zone;
        this.events = events;
        this.popupProvider = popupProvider;
        this.masterWalletId = "1";
        this.wallet = {
            name: 'myWallet',
            showBalance: true
        };
        this.ElaObj = { "name": "ELA", "balance": 0 };
        this.coinList = [];
        this.account = {};
        //this.init();
    }
    HomeComponent.prototype.ionViewWillEnter = function () {
        this.init();
    };
    HomeComponent.prototype.ionViewDidLeave = function () {
        this.events.unsubscribe("register:update");
    };
    HomeComponent.prototype.init = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.account = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getAccountType(this.masterWalletId);
        this.wallet["name"] = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
        this.events.subscribe("register:update", function (walletId, coin, result) {
            if (result["MasterWalletID"] === _this.masterWalletId && result["ChaiID"] === "ELA") {
                _this.handleEla(result);
            }
            if (result["MasterWalletID"] === _this.masterWalletId && result["ChaiID"] === "IdChain") {
                _this.handleIdchain(coin, result);
            }
        });
        this.goPayment();
        this.zone.run(function () {
            //this.elaPer = Config.getMasterPer(this.masterWalletId,"ELA");;
            _this.elaMaxHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getEstimatedHeight(_this.masterWalletId, "ELA");
            _this.elaCurHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurrentHeight(_this.masterWalletId, "ELA");
            _this.idChainMaxHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getEstimatedHeight(_this.masterWalletId, "IdChain");
            _this.idChainCurHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurrentHeight(_this.masterWalletId, "IdChain");
            //this.idChainPer = Config.getMasterPer(this.masterWalletId,"IdChain");
        });
        this.getAllSubWallets();
    };
    HomeComponent.prototype.onOpen = function () {
        this.wallet.showBalance = !this.wallet.showBalance;
    };
    HomeComponent.prototype.goPayment = function () {
        var _this = this;
        this.localStorage.get('payment').then(function (val) {
            if (val) {
                _this.localStorage.remove('payment');
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__coin_payment_confirm_payment_confirm_component__["a" /* PaymentConfirmComponent */], JSON.parse(val));
            }
        });
    };
    HomeComponent.prototype.onClick = function (type) {
        switch (type) {
            case 0:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__pages_walltelist_walltelist__["a" /* WalltelistPage */]);
                break;
            case 1:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__coin_coin_list_coin_list_component__["a" /* CoinListComponent */]);
                break;
        }
    };
    HomeComponent.prototype.onItem = function (item) {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__coin_coin_component__["a" /* CoinComponent */], { name: item.name, "elaPer": this.elaPer, "idChainPer": this.idChainPer });
    };
    HomeComponent.prototype.getElaBalance = function (item) {
        var _this = this;
        this.walletManager.getBalance(this.masterWalletId, item.name, __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].total, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.zone.run(function () {
                    _this.ElaObj.balance = __WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].scientificToNumber(data["success"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA);
                });
            }
            else {
                alert("getElaBalance=error:" + JSON.stringify(data));
            }
        });
    };
    HomeComponent.prototype.getAllSubWallets = function () {
        this.getElaBalance(this.ElaObj);
        this.handleSubwallet();
    };
    HomeComponent.prototype.getSubBalance = function (coin) {
        var _this = this;
        this.walletManager.getBalance(this.masterWalletId, coin, __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].total, function (data) {
            _this.native.info(data);
            if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(data["success"])) {
                if (_this.coinList.length === 0) {
                    _this.coinList.push({ name: coin, balance: data["success"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA });
                }
                else {
                    var index = _this.getCoinIndex(coin);
                    if (index != -1) {
                        var item = _this.coinList[index];
                        item["balance"] = data["success"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA;
                        _this.coinList.splice(index, 1, item);
                    }
                    else {
                        _this.coinList.push({ name: coin, balance: data["success"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA });
                    }
                }
            }
            else {
                alert("getSubBalance=error" + JSON.stringify(data));
            }
        });
    };
    HomeComponent.prototype.getCoinIndex = function (coin) {
        for (var index = 0; index < this.coinList.length; index++) {
            var item = this.coinList[index];
            if (coin === item["name"]) {
                return index;
            }
        }
        return -1;
    };
    HomeComponent.prototype.handleSubwallet = function () {
        var subwall = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getSubWallet(this.masterWalletId);
        if (subwall) {
            if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isEmptyObject(subwall)) {
                this.coinList = [];
                return;
            }
            for (var coin in subwall) {
                //this.sycIdChain(coin);
                this.getSubBalance(coin);
            }
        }
        else {
            this.coinList = [];
        }
    };
    HomeComponent.prototype.OnTxPublished = function (data) {
        var hash = data["hash"];
        var result = JSON.parse(data["result"]);
        var code = result["Code"];
        var tx = "txPublished-";
        switch (code) {
            case 0:
            case 18:
                this.popupProvider.ionicAlert_PublishedTx_sucess('confirmTitle', tx + code, hash);
                break;
            case 1:
            case 16:
            case 17:
            case 22:
            case 64:
            case 65:
            case 66:
            case 67:
                this.popupProvider.ionicAlert_PublishedTx_fail('confirmTitle', tx + code, hash);
                break;
        }
    };
    HomeComponent.prototype.handleEla = function (result) {
        var _this = this;
        if (result["Action"] === "OnTxDeleted") {
            var txHash = result["hash"];
            this.popupProvider.ionicAlert_delTx('confirmTitle', 'transaction-deleted', txHash);
        }
        if (result["Action"] === "OnTxPublished") {
            this.OnTxPublished(result);
        }
        if (result["Action"] === "OnTransactionStatusChanged") {
            this.native.info(result['confirms']);
            if (result['confirms'] == 1) {
                this.getElaBalance(this.ElaObj);
                this.popupProvider.ionicAlert('confirmTitle', 'confirmTransaction').then(function (data) {
                });
            }
        }
        if (result["Action"] === "OnBalanceChanged") {
            if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(result["Balance"])) {
                this.zone.run(function () {
                    _this.ElaObj.balance = __WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].scientificToNumber(result["Balance"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA);
                });
            }
        }
        if (result["Action"] === "OnBlockSyncStopped") {
            this.zone.run(function () {
                //this.elaPer = Config.getMasterPer(this.masterWalletId,"ELA");
                _this.elaMaxHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getEstimatedHeight(_this.masterWalletId, "ELA");
                _this.elaCurHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurrentHeight(_this.masterWalletId, "ELA");
            });
        }
        else if (result["Action"] === "OnBlockSyncStarted") {
            this.zone.run(function () {
                //this.elaPer = Config.getMasterPer(this.masterWalletId,"ELA");
                _this.elaMaxHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getEstimatedHeight(_this.masterWalletId, "ELA");
                _this.elaCurHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurrentHeight(_this.masterWalletId, "ELA");
            });
        }
        else if (result["Action"] === "OnBlockHeightIncreased") {
            //this.elaPer= result["progress"];
            this.zone.run(function () {
                _this.elaMaxHeight = result["estimatedHeight"];
                _this.elaCurHeight = result["currentBlockHeight"];
                //Config.setMasterPer(this.masterWalletId,"ELA",this.elaPer);
                __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].setCureentHeight(_this.masterWalletId, "ELA", _this.elaCurHeight);
                __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].setEstimatedHeight(_this.masterWalletId, "ELA", _this.elaMaxHeight);
                _this.localStorage.setProgress(__WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].perObj);
            });
        }
        //  if(this.elaPer === 1){
        //     this.zone.run(() => {
        //     this.elaPer = Config.getMasterPer(this.masterWalletId,"ELA");
        //   });
        //  }
    };
    HomeComponent.prototype.handleIdchain = function (coin, result) {
        var _this = this;
        if (result["Action"] === "OnTxDeleted") {
            var txHash = result["hash"];
            this.popupProvider.ionicAlert_delTx('confirmTitle', 'transaction-deleted', txHash);
        }
        if (result["Action"] === "OnTxPublished") {
            this.OnTxPublished(result);
        }
        if (result["Action"] === "OnBalanceChanged") {
            if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(result["Balance"])) {
                if (this.coinList.length === 0) {
                    this.coinList.push({ name: coin, balance: __WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].scientificToNumber(result["Balance"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA) });
                }
                else {
                    var index = this.getCoinIndex(coin);
                    if (index != -1) {
                        var item = this.coinList[index];
                        item["balance"] = __WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].scientificToNumber(result["Balance"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA);
                        this.coinList.splice(index, 1, item);
                    }
                    else {
                        this.coinList.push({ name: coin, balance: __WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].scientificToNumber(result["Balance"] / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA) });
                    }
                }
            }
        }
        if (result["Action"] === "OnTransactionStatusChanged") {
            if (result['confirms'] == 1) {
                this.handleSubwallet();
                this.popupProvider.ionicAlert('confirmTitle', 'confirmTransaction').then(function (data) {
                });
            }
        }
        if (result["Action"] === "OnBlockSyncStopped") {
            this.zone.run(function () {
                //this.idChainPer = Config.getMasterPer(this.masterWalletId,coin);
                _this.idChainMaxHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getEstimatedHeight(_this.masterWalletId, "IdChain");
                _this.idChainCurHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurrentHeight(_this.masterWalletId, "IdChain");
            });
        }
        else if (result["Action"] === "OnBlockSyncStarted") {
            this.zone.run(function () {
                //this.idChainPer = Config.getMasterPer(this.masterWalletId,coin);
                _this.idChainMaxHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getEstimatedHeight(_this.masterWalletId, "IdChain");
                _this.idChainCurHeight = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurrentHeight(_this.masterWalletId, "IdChain");
            });
        }
        else if (result["Action"] === "OnBlockHeightIncreased") {
            this.zone.run(function () {
                //this.idChainPer  = result["progress"];
                _this.idChainMaxHeight = result["estimatedHeight"];
                _this.idChainCurHeight = result["currentBlockHeight"];
                //Config.setMasterPer(this.masterWalletId,coin,this.idChainPer);
                __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].setCureentHeight(_this.masterWalletId, coin, _this.idChainCurHeight);
                __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].setEstimatedHeight(_this.masterWalletId, coin, _this.idChainMaxHeight);
                _this.localStorage.setProgress(__WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].perObj);
            });
        }
        // if(this.idChainPer === 1){
        //         this.zone.run(() => {
        //           this.idChainPer = Config.getMasterPer(this.masterWalletId,coin);
        //         });
        // }
    };
    HomeComponent.prototype.doRefresh = function (refresher) {
        //this.init();
        this.getElaBalance(this.ElaObj);
        this.handleSubwallet();
        setTimeout(function () {
            refresher.complete();
        }, 1000);
    };
    HomeComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-home',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/tabs/home/home.component.html"*/'<ion-content>\n    <ion-refresher (ionRefresh)="doRefresh($event)">\n        <ion-refresher-content pullingIcon="arrow-dropdown" pullingText="" refreshingSpinner="circles" refreshingText="">\n        </ion-refresher-content>\n        <ion-refresher-content>\n        </ion-refresher-content>\n    </ion-refresher>\n    <div class="home-top">\n        <!-- <img src="./assets/images/icon/ion-list.svg" class="home-top-button-left" (click)="onClick(0)">\n        <img src="" class="home-top-button-left" style="color: #fff;"> -->\n        <img src="./assets/images/icon/icon-manager.svg" class="home-top-button-right" (click)="onClick(1)">\n    </div>\n\n    <div>\n        <div class="home-top-box" (click)="onClick(0)">\n            <img src="./assets/images/icon/icon-wallet.svg">\n            <div style="font-size: 1.6em;">{{wallet.name}}\n                <span *ngIf="account[\'Type\']===\'Standard\'" style="font-size: 0.6em;">{{\'text-standard-wallte\' | translate}}</span>\n                <span *ngIf="account[\'Type\']===\'Multi-Sign\'" style="font-size: 0.6em;">{{\'text-multi-wallte\' | translate}}</span>\n            </div>\n        </div>\n        <ion-grid>\n            <ion-row>\n                <ion-col col-5 class="row-title">\n                    {{\'text-coin-list\' | translate}}\n                </ion-col>\n                <ion-col col-7 class="text-right">\n                    <div class="home-eye" (click)="onOpen()" [ngClass]="{\'home-eye-on\':wallet.showBalance,\'home-eye-off\':!wallet.showBalance }"></div>\n                </ion-col>\n            </ion-row>\n\n            <ion-row class="hang" (click)="onItem(ElaObj)">\n                <ion-col col-2 align-self-center class="text-center">\n                    <img src="./assets/images/logo-maincolor.svg" alt="" style="display: inline;">\n                </ion-col>\n                <ion-col col-3 align-self-center class="text-left font-size-1">\n                    {{ElaObj.name}}\n                </ion-col>\n                <ion-col col-7 class="text-right font-size-1" align-self-center>\n                    <div><span [hidden]="!wallet.showBalance">{{ElaObj.balance}}</span></div>\n                </ion-col>\n            </ion-row>\n            <ion-row>\n                <ion-col col-12 class="text-right">\n                    <!-- <progress-bar proportion="{{elaPer}}"></progress-bar> -->\n                    <span [ngClass]="{\'red\':elaCurHeight!=elaMaxHeight,\'green\':elaCurHeight==elaMaxHeight}">{{elaCurHeight}}</span>/<span [ngClass]="{\'red\':elaCurHeight!=elaMaxHeight,\'green\':elaCurHeight==elaMaxHeight}">{{elaMaxHeight}}</span>\n                </ion-col>\n            </ion-row>\n\n            <div *ngFor="let item of coinList" (click)="onItem(item)">\n                <ion-row class="hang">\n                    <ion-col col-2 align-self-center class="text-center">\n                        <img src="./assets/images/logo-maincolor.svg" alt="" style="display: inline;">\n                    </ion-col>\n                    <ion-col col-3 align-self-center class="text-left font-size-1">\n                        {{item.name}}\n                    </ion-col>\n                    <ion-col col-7 class="text-right font-size-1" align-self-center>\n                        <div><span [hidden]="!wallet.showBalance">{{item.balance}}</span></div>\n                    </ion-col>\n                </ion-row>\n                <ion-row>\n                    <ion-col col-12 class="text-right">\n                        <!-- <progress-bar proportion="{{idChainPer}}"></progress-bar> -->\n                        <span [ngClass]="{\'red\':idChainCurHeight!=idChainMaxHeight,\'green\':idChainCurHeight==idChainMaxHeight}">{{idChainCurHeight}}</span>/<span [ngClass]="{\'red\':idChainCurHeight!=idChainMaxHeight,\'green\':idChainCurHeight==idChainMaxHeight}">{{idChainMaxHeight}}</span>\n                    </ion-col>\n                </ion-row>\n            </div>\n            <div class="bottom-broder">\n\n            </div>\n        </ion-grid>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/tabs/home/home.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_7_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_8__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_9__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_10__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */], __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_11__providers_popup__["a" /* PopupProvider */]])
    ], HomeComponent);
    return HomeComponent;
}());

//# sourceMappingURL=home.component.js.map

/***/ }),

/***/ 416:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CoinComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__transfer_transfer_component__ = __webpack_require__(70);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__coin_select_coin_select_component__ = __webpack_require__(467);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__withdraw_withdraw_component__ = __webpack_require__(469);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__receive_receive_component__ = __webpack_require__(470);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__recordinfo_recordinfo_component__ = __webpack_require__(472);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};











var CoinComponent = /** @class */ (function () {
    function CoinComponent(navCtrl, navParams, walletManager, native, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.events = events;
        this.masterWalletInfo = {};
        this.masterWalletId = "1";
        this.transferList = [];
        this.coinCount = 0;
        this.coinId = 0;
        this.coinName = "";
        this.pageNo = 0;
        this.start = 0;
        this.textShow = '';
        this.isShowMore = false;
        this.MaxCount = 0;
        this.isNodata = false;
        this.jiajian = "";
        this.votedCount = 0;
        //this.init();
    }
    CoinComponent.prototype.ionViewWillEnter = function () {
        this.pageNo = 0;
        this.start = 0;
        this.MaxCount = 0;
        this.transferList = [];
        this.init();
    };
    CoinComponent.prototype.ionViewDidLeave = function () {
        //clearInterval(this.myInterval);
    };
    CoinComponent.prototype.init = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var item = JSON.parse(data["success"])["Account"];
                _this.masterWalletInfo = item;
            }
            else {
                alert("=======getMasterWalletBasicInfo====error=====" + JSON.stringify(data));
            }
        });
        this.coinName = this.navParams.get("name");
        this.elaPer = this.navParams.get("elaPer") || 0;
        this.idChainPer = this.navParams.get("idChainPer") || 0;
        if (this.coinName == 'ELA') {
            this.textShow = 'text-recharge';
        }
        else {
            this.textShow = 'text-withdraw';
        }
        this.initData();
    };
    CoinComponent.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.navBar.backButtonClick = function (e) {
            _this.navCtrl.pop();
        };
    };
    CoinComponent.prototype.initData = function () {
        var _this = this;
        this.walletManager.getBalance(this.masterWalletId, this.coinName, __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].total, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.native.info(data);
                _this.coinCount = data["success"] / __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].SELA;
            }
            else {
                _this.native.info(data);
            }
        });
        if (this.coinName === "ELA") {
            this.walletManager.getBalance(this.masterWalletId, this.coinName, __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].voted, function (data) {
                if (!__WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].isNull(data["success"])) {
                    _this.native.info(data);
                    _this.votedCount = data["success"] / __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].SELA;
                }
                else {
                    _this.native.info(data);
                }
            });
        }
        this.getAllTx();
        // this.myInterval = setInterval(()=>{
        //   this.walletManager.getBalance(this.masterWalletId,this.coinName,0, (data)=>{
        //     if(!Util.isNull(data["success"])){
        //       this.native.info(data);
        //       this.coinCount = data["success"]/Config.SELA;
        //     }else{
        //       this.native.info(data);
        //     }
        //    });
        //       this.pageNo = 0;
        //       this.transferList =[];
        //       this.getAllTx();
        // },1000);
    };
    CoinComponent.prototype.getAllTx = function () {
        var _this = this;
        this.walletManager.getAllTransaction(this.masterWalletId, this.coinName, this.start, '', function (data) {
            if (data["success"]) {
                var allTransaction = JSON.parse(data['success']);
                var transactions = allTransaction['Transactions'];
                _this.MaxCount = allTransaction['MaxCount'];
                if (_this.MaxCount > 0) {
                    _this.isNodata = false;
                }
                else {
                    _this.isNodata = true;
                }
                if (_this.start >= _this.MaxCount) {
                    _this.isShowMore = false;
                    return;
                }
                else {
                    _this.isShowMore = true;
                }
                if (!transactions) {
                    _this.isShowMore = false;
                    return;
                }
                if (_this.MaxCount <= 20) {
                    _this.isShowMore = false;
                }
                for (var key in transactions) {
                    var transaction = transactions[key];
                    var timestamp = transaction['Timestamp'] * 1000;
                    var datetime = __WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].dateFormat(new Date(timestamp));
                    var txId = transaction['TxHash'];
                    var payStatusIcon = transaction["Direction"];
                    var jiajian = "";
                    if (payStatusIcon === "Received") {
                        payStatusIcon = './assets/images/tx-state/icon-tx-received-outline.svg';
                        jiajian = "+";
                    }
                    else if (payStatusIcon === "Sent") {
                        payStatusIcon = './assets/images/tx-state/icon-tx-sent.svg';
                        jiajian = "-";
                    }
                    else if (payStatusIcon === "Moved") {
                        payStatusIcon = './assets/images/tx-state/icon-tx-moved.svg';
                        jiajian = "";
                    }
                    else if (payStatusIcon === "Deposit") {
                        payStatusIcon = './assets/images/tx-state/icon-tx-moved.svg';
                        if (transaction["Amount"] > 0) {
                            jiajian = "-";
                        }
                        else {
                            jiajian = "";
                        }
                    }
                    var status_1 = '';
                    switch (transaction["Status"]) {
                        case 'Confirmed':
                            status_1 = 'Confirmed';
                            break;
                        case 'Pending':
                            status_1 = 'Pending';
                            break;
                        case 'Unconfirmed':
                            status_1 = 'Unconfirmed';
                            break;
                    }
                    var transfer = {
                        "status": status_1,
                        "resultAmount": transaction["Amount"] / __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].SELA,
                        "datetime": datetime,
                        "timestamp": timestamp,
                        "txId": txId,
                        "payStatusIcon": payStatusIcon,
                        "fuhao": jiajian
                    };
                    _this.transferList.push(transfer);
                }
            }
            else {
                alert("====getAllTransaction====error");
            }
        });
    };
    CoinComponent.prototype.onItem = function (item) {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__recordinfo_recordinfo_component__["a" /* RecordinfoComponent */], { chainId: this.coinName, txId: item.txId });
    };
    CoinComponent.prototype.onNext = function (type) {
        switch (type) {
            case 1:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_9__receive_receive_component__["a" /* ReceiveComponent */], { id: this.coinId, chianId: this.coinName });
                break;
            case 2:
                if (this.coinName == 'ELA') {
                    // if(this.elaPer != 1){
                    //   this.messageBox("text-ela-per-message");
                    //   return;
                    // }
                    this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_6__transfer_transfer_component__["a" /* TransferComponent */], { id: this.coinId, chianId: this.coinName, "walletInfo": this.masterWalletInfo });
                }
                else {
                    // if(this.idChainPer != 1){
                    //   this.messageBox("text-ela-per-message");
                    //   return;
                    // }
                    this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_6__transfer_transfer_component__["a" /* TransferComponent */], { id: this.coinId, chianId: this.coinName, "walletInfo": this.masterWalletInfo });
                }
                break;
            case 3:
                if (this.coinName == 'ELA') {
                    // if(this.elaPer != 1){
                    //   this.messageBox("text-ela-per-message");
                    //   return;
                    // }
                    this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__coin_select_coin_select_component__["a" /* CoinSelectComponent */], { chianId: this.coinName, "walletInfo": this.masterWalletInfo });
                }
                else {
                    // if(this.idChainPer != 1){
                    //   this.messageBox("text-ela-per-message");
                    //   return;
                    // }
                    this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_8__withdraw_withdraw_component__["a" /* WithdrawComponent */], { chianId: this.coinName, "walletInfo": this.masterWalletInfo });
                }
                break;
        }
    };
    CoinComponent.prototype.clickMore = function () {
        this.pageNo++;
        this.start = this.pageNo * 20;
        if (this.start >= this.MaxCount) {
            this.isShowMore = false;
            return;
        }
        this.isShowMore = true;
        this.getAllTx();
    };
    CoinComponent.prototype.doRefresh = function (refresher) {
        var _this = this;
        this.walletManager.getBalance(this.masterWalletId, this.coinName, __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].total, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.native.info(data);
                _this.coinCount = data["success"] / __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].SELA;
            }
            else {
                _this.native.info(data);
            }
        });
        this.pageNo = 0;
        this.start = 0;
        this.transferList = [];
        this.MaxCount = 0;
        this.getAllTx();
        setTimeout(function () {
            refresher.complete();
        }, 1000);
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["m" /* Navbar */])
    ], CoinComponent.prototype, "navBar", void 0);
    CoinComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'coin',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/coin.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{coinName}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <nodata keyText=\'no-tx-record\' *ngIf="isNodata"></nodata>\n    <ion-refresher (ionRefresh)="doRefresh($event)" *ngIf="!isNodata">\n        <ion-refresher-content pullingIcon="arrow-dropdown" pullingText="" refreshingSpinner="circles" refreshingText="">\n        </ion-refresher-content>\n        <ion-refresher-content>\n        </ion-refresher-content>\n    </ion-refresher>\n    <div class=\'address-whole\' *ngIf="!isNodata">\n        <div class="coin-info-top-box">\n            <img src="./assets/images/logo-maincolor.svg">\n            <div style="font-size: 1.6em;">{{\'total-balance\' | translate}}: {{coinCount}} {{coinName}}</div>\n            <div style="font-size: 1.6em;" *ngIf="coinName===\'ELA\'">{{"vote-balance" | translate}}: {{votedCount}} {{coinName}}</div>\n        </div>\n\n        <ion-grid style="margin-bottom: 60px">\n            <ion-row>\n                <ion-col col-12 class="row-title">\n                    {{ \'coin-recent-transfer\' | translate }}\n                </ion-col>\n            </ion-row>\n            <ion-row *ngFor="let item of transferList; let i = index" (click)="onItem(item)" class="hang" [ngClass]="{\'bottom-border\': i==transferList.length-1}">\n                <ion-col col-2 align-self-center>\n                    <img src={{item.payStatusIcon}} alt="" class="transfer-list-img">\n                </ion-col>\n                <ion-col col-5 align-self-center class="text-left">\n                    <span class="font-size-2">{{item.status | translate}}</span> <span class="transfer-list-date" *ngIf="item.timestamp!=\'0\'" class="font-size-2"> {{item.datetime}} </span>\n                </ion-col>\n                <ion-col col-5 align-self-center class="text-right font-size-1">\n                    {{item.fuhao}} {{item.resultAmount}}\n                </ion-col>\n            </ion-row>\n\n            <ion-row>\n                <ion-col col-12>\n                    <p class="more" (click)="clickMore()" *ngIf="isShowMore">{{ \'click-to-load-more\' | translate }}</p>\n                </ion-col>\n            </ion-row>\n\n        </ion-grid>\n\n    </div>\n</ion-content>\n<ion-footer>\n    <div class="coin-bottom">\n        <div (click)="onNext(1)" style="font-size: 1.6em;">\n            {{ \'text-receive\' | translate }}\n        </div>\n        <div (click)="onNext(3)" style="font-size: 1.6em;">\n            {{ this.textShow | translate }}\n        </div>\n        <div (click)="onNext(2)" style="font-size: 1.6em;">\n            {{ \'text-transfer\' | translate }}\n        </div>\n    </div>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/coin.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */]])
    ], CoinComponent);
    return CoinComponent;
}());

//# sourceMappingURL=coin.component.js.map

/***/ }),

/***/ 417:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ContactCreateComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Localstorage__ = __webpack_require__(9);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var ContactCreateComponent = /** @class */ (function () {
    function ContactCreateComponent(navCtrl, navParams, walletManager, native, localStorage, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
    }
    ContactCreateComponent.prototype.add = function () {
        var _this = this;
        var contactUsers = {
            id: this.name,
            name: this.name,
            address: this.address,
            phone: this.phone,
            email: this.email,
            remark: this.remark
        };
        if (__WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].isNull(this.name)) {
            this.native.toast_trans("contact-name-notnull");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].isNull(this.address)) {
            this.native.toast_trans("contact-address-notnull");
            return;
        }
        if (!__WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].isAddressValid(this.address)) {
            this.native.toast_trans("contact-address-digits");
            return;
        }
        if (this.phone && __WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].checkCellphone(this.phone.toString())) {
            this.native.toast_trans("contact-phone-check");
            return;
        }
        this.localStorage.add('contactUsers', contactUsers).then(function (val) {
            _this.events.publish("contanctList:update");
            _this.navCtrl.pop();
        });
    };
    ContactCreateComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-contact-create',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/contacts/contact-create/contact-create.component.html"*/'<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-contacts-add\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n<ion-content>\n    <ion-list>\n        <ion-item>\n            <ion-label stacked>{{ \'contacts-name-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="" [(ngModel)]="name">\n            </ion-input>\n        </ion-item>\n        <ion-item>\n            <ion-label stacked>{{ \'contacts-address-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="" [(ngModel)]="address">\n            </ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-label stacked>{{ \'contacts-phone-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="" [(ngModel)]="phone">\n            </ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-label stacked>{{ \'contacts-email-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="" [(ngModel)]="email">\n            </ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-label stacked>{{ \'contacts-remark-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="" [(ngModel)]="remark">\n            </ion-input>\n        </ion-item>\n    </ion-list>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="add()">{{\'text-add\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/contacts/contact-create/contact-create.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_2_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["c" /* Events */]])
    ], ContactCreateComponent);
    return ContactCreateComponent;
}());

//# sourceMappingURL=contact-create.component.js.map

/***/ }),

/***/ 418:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ContactsComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__ = __webpack_require__(9);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var ContactsComponent = /** @class */ (function () {
    function ContactsComponent(navCtrl, navParams, native, localStorage, events, popupProvider) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.popupProvider = popupProvider;
        this.contactUser = {};
        this.qrcode = null;
        this.masterId = "1";
        this.isShow = false;
        this.isShow = this.navParams.get("exatOption")["hideButton"] || false;
        this.init();
    }
    ContactsComponent.prototype.init = function () {
        var _this = this;
        this.localStorage.get('contactUsers').then(function (val) {
            if (val) {
                var id = _this.navParams.get("id");
                _this.contactUser = JSON.parse(val)[id];
                _this.qrcode = _this.contactUser["address"].toString();
            }
        });
    };
    ContactsComponent.prototype.rightHeader = function () {
        var _this = this;
        this.popupProvider.ionicConfirm("confirmTitle", "text-delete-contact-confirm").then(function (data) {
            if (data) {
                _this.localStorage.get('contactUsers').then(function (val) {
                    var contactUsers = JSON.parse(val);
                    delete (contactUsers[_this.contactUser["id"]]);
                    _this.localStorage.set('contactUsers', contactUsers);
                    _this.events.publish("contanctList:update");
                    _this.navCtrl.pop();
                });
            }
        });
    };
    ContactsComponent.prototype.pay = function (address) {
        //this.native.Go(this.navCtrl,TransferComponent,{addr:this.contactUser['address']});
        this.events.publish("address:update", address);
        this.navCtrl.popTo(this.navCtrl.getByIndex(this.navCtrl.length() - 3));
    };
    ContactsComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-contacts',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/contacts/contacts.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-contacts\' | translate}}</ion-title>\n        <ion-buttons end>\n            <button ion-button icon-only (click)="rightHeader()">\n              <ion-icon name="close"></ion-icon>\n            </button>\n        </ion-buttons>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <ion-list>\n        <ion-item>\n            <ion-label>\n                <span>{{\'contacts-name-title\' | translate }}</span>\n            </ion-label>\n            <ion-note *ngIf="contactUser[\'name\']" item-end>\n                {{contactUser["name"]}}\n            </ion-note>\n        </ion-item>\n\n        <ion-item>\n            <ion-label>\n                <span>{{\'contacts-address-title\' | translate }}</span>\n            </ion-label>\n            <ion-note *ngIf="contactUser[\'address\']" item-end style="font-size: 12px">\n                {{contactUser["address"]}}\n            </ion-note>\n        </ion-item>\n\n        <ion-item>\n            <ion-label>\n                <span>{{\'contacts-phone-title\' | translate}}</span>\n            </ion-label>\n            <ion-note *ngIf="contactUser[\'phone\']" item-end style="font-size: 12px">\n                {{contactUser["phone"]}}\n            </ion-note>\n        </ion-item>\n\n        <ion-item>\n            <ion-label>\n                <span>{{\'contacts-email-title\' | translate}}</span>\n            </ion-label>\n            <ion-note *ngIf="contactUser[\'email\']" item-end style="font-size: 12px">\n                {{contactUser["email"]}}\n            </ion-note>\n        </ion-item>\n\n\n        <ion-item>\n            <ion-label>\n                <span>{{\'text-remark\' | translate}}</span>\n            </ion-label>\n            <ion-note *ngIf="contactUser[\'remark\']" item-end style="font-size: 12px">\n                {{contactUser["remark"]}}\n            </ion-note>\n        </ion-item>\n        <div style="text-align: center;width:100%;margin: 10px 0px">\n            <qrcode [qrdata]="qrcode" [size]="200" [level]="\'M\'" style="display:inline-block;"></qrcode>\n        </div>\n    </ion-list>\n</ion-content>\n<ion-footer *ngIf="isShow">\n    <button ion-button full (click)="pay(contactUser[\'address\'])">{{ \'text-transfer\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/contacts/contacts.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_3__providers_popup__["a" /* PopupProvider */]])
    ], ContactsComponent);
    return ContactsComponent;
}());

//# sourceMappingURL=contacts.component.js.map

/***/ }),

/***/ 43:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ApiUrl; });
/***
 * URL
 */
var ApiUrl = /** @class */ (function () {
    function ApiUrl() {
    }
    /**后台服务*/
    ApiUrl.SERVER = 'https://39.106.96.168:8446/api';
    /**后台服务*/
    ApiUrl.SERVER1 = 'https://123.206.52.29/api';
    ApiUrl.SERVER2 = 'https://52.81.8.194:442/api';
    /**获取认证费用定价 */
    ApiUrl.GET_PRICE = ApiUrl.SERVER + '/getPrice';
    ApiUrl.SEND_CODE = ApiUrl.SERVER + '/sendCode';
    /**用户信息认证接口*/
    ApiUrl.AUTH = ApiUrl.SERVER + '/authreqstatus/auth';
    /**APP认证结果请求接口 */
    ApiUrl.APP_AUTH = ApiUrl.SERVER + '/app/auth';
    /**获取投票列表 */
    ApiUrl.listproducer = ApiUrl.SERVER2 + '/dposnoderpc/check/listproducer';
    ApiUrl.getdepositcoin = ApiUrl.SERVER2 + '/dposnoderpc/check/getdepositcoin';
    return ApiUrl;
}());

//# sourceMappingURL=ApiUrl.js.map

/***/ }),

/***/ 455:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdResultComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__ = __webpack_require__(65);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_id_pathlist_pathlist__ = __webpack_require__(213);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};









var IdResultComponent = /** @class */ (function () {
    function IdResultComponent(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.init();
    }
    IdResultComponent.prototype.init = function () {
        this.parms = this.navParams.data;
        var status = this.parms["status"];
        if (__WEBPACK_IMPORTED_MODULE_8__providers_Util__["a" /* Util */].isNull(status)) {
            this.type = '0';
        }
        else {
            this.type = status;
        }
    };
    IdResultComponent.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.navBar.backButtonClick = function (e) {
            _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__["a" /* IdHomeComponent */]);
        };
    };
    IdResultComponent.prototype.check = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_pathlist_pathlist__["a" /* PathlistPage */], this.parms);
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_3_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_3_ionic_angular__["m" /* Navbar */])
    ], IdResultComponent.prototype, "navBar", void 0);
    IdResultComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'id-kyc-result',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/result/result.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-commit-result\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <div class="result">\n        <div *ngIf="type===\'0\'">\n            <img src=\'./assets/images/icon/icon-success.svg\' class="result-img" />\n            <p class="result-wenzi color-main ">{{\'text-commit-success\' | translate }}</p>\n            <p class="result-wenzi1 color-main ">{{\'text-commit-wait\' | translate }}</p>\n        </div>\n\n        <div *ngIf="type===\'1\'">\n            <img src=\'./assets/images/icon/icon-failure.svg\' class="result-img" />\n            <p class="result-wenzi-color color-main ">{{\'text-browsing-failure\' | translate }}</p>\n        </div>\n\n        <button tappable class="button-default" (click)="check()" style="margin-top: 40px;">{{\'text-id-kyc-check\' | translate }}</button>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/result/result.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_3_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_3_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_5__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_3_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_7__providers_DataManager__["a" /* DataManager */]])
    ], IdResultComponent);
    return IdResultComponent;
}());

//# sourceMappingURL=result.js.map

/***/ }),

/***/ 456:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdManagerComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};







/**
 * Generated class for the LauncherPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var IdManagerComponent = /** @class */ (function () {
    function IdManagerComponent(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.kycIdArr = [];
        this.isSelectObj = {};
        this.selectAll = false;
        this.init();
    }
    IdManagerComponent.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.navBar.backButtonClick = function (e) {
            _this.events.publish("idhome:update");
            _this.navCtrl.pop();
        };
    };
    IdManagerComponent.prototype.init = function () {
        var _this = this;
        this.localStorage.get('kycId').then(function (val) {
            if (val === null) {
                _this.kycIdArr = [];
            }
            else {
                _this.kycIdArr = __WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].objtoarr(JSON.parse(val));
                _this.idsObj = JSON.parse(val);
            }
        });
    };
    IdManagerComponent.prototype.onItem = function (id) {
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.isSelectObj[id])) {
            this.isSelectObj[id] = true;
            this.selectAll = this.setAllButton();
            return;
        }
        this.isSelectObj[id] = !this.isSelectObj[id];
        this.selectAll = this.setAllButton();
    };
    IdManagerComponent.prototype.onNext = function (type) {
        switch (type) {
            case 1://导出
                var improtids = this.getSelsetId();
                this.downButton(improtids);
                break;
            case 2://删除
                var delids = this.getSelsetId();
                console.log(JSON.stringify(delids));
                this.delIds(delids);
                break;
            case 3:
                this.selectAll = !this.selectAll;
                this.setSelectAll(this.selectAll);
                break;
        }
    };
    IdManagerComponent.prototype.setSelectAll = function (stauts) {
        for (var key in this.idsObj) {
            this.isSelectObj[key] = stauts;
        }
    };
    IdManagerComponent.prototype.getSelsetId = function () {
        var arr = [];
        for (var key in this.isSelectObj) {
            if (this.isSelectObj[key]) {
                arr.push(key);
            }
        }
        return arr;
    };
    IdManagerComponent.prototype.setAllButton = function () {
        var isCheck = true;
        if (Object.keys(this.isSelectObj).length < this.kycIdArr.length) {
            isCheck = false;
            return isCheck;
        }
        for (var key in this.isSelectObj) {
            if (!this.isSelectObj[key]) {
                isCheck = false;
                return isCheck;
            }
        }
        return isCheck;
    };
    IdManagerComponent.prototype.downButton = function (ids) {
        if (ids.length === 0) {
            this.native.toast_trans("text-down-please-message");
            return;
        }
        var idsObj = {};
        var kycObj = this.idsObj;
        for (var id in ids) {
            var key = ids[id];
            idsObj[key] = kycObj[key];
        }
        this.backupWalletPlainText = JSON.stringify(idsObj);
    };
    IdManagerComponent.prototype.onCopay = function () {
        var _this = this;
        this.native.copyClipboard(this.backupWalletPlainText).then(function () {
            _this.native.toast_trans('text-copied-to-clipboard');
        }).catch(function () {
        });
    };
    IdManagerComponent.prototype.delIds = function (ids) {
        var _this = this;
        if (ids.length === 0) {
            this.native.toast_trans("text-id-kyc-import-text-del-please-message");
            return;
        }
        for (var id in ids) {
            var key = ids[id];
            delete this.idsObj[key];
        }
        this.localStorage.set("kycId", this.idsObj).then(function () {
            _this.kycIdArr = __WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].objtoarr(_this.idsObj);
            _this.native.toast_trans('text-id-kyc-import-text-del-message');
        });
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["m" /* Navbar */])
    ], IdManagerComponent.prototype, "navBar", void 0);
    IdManagerComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-manager',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/manager/manager.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-id-manager\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <div class="per-certified">\n        <div *ngIf="backupWalletPlainText" class="kuangTextArea">\n            <p>{{ \'text-keystroe-message\' | translate }} </p>\n            <textarea rows="10" class="backupWalletTextArea">{{backupWalletPlainText}}</textarea>\n        </div>\n\n        <button *ngIf="backupWalletPlainText" ion-button full class="button-footer" (click)="onCopay()" style="width: 100%">{{ \'text-copy-to-clipboard\' | translate }}</button>\n\n        <ul class="idList" *ngIf="!backupWalletPlainText">\n            <li class="item" *ngFor="let item of kycIdArr" (click)="onItem(item.id)">\n                <a class="tiaozhuan">\n                    <div [ngClass]="{\'radio\':true,\'per-select\':isSelectObj[item.id]}"></div>\n                    <div class="item-text">\n                        <span class="item-text-title huan-hang">{{item.id}}</span>\n                    </div>\n                </a>\n            </li>\n        </ul>\n\n        <div class="chooseAll" style="background: white;" *ngIf="!backupWalletPlainText">\n\n            <div [ngClass]="{\'radio\':true,\'per-select\':selectAll}" style="margin: 0px 16px;" (click)="onNext(3)"></div>\n            <span (click)="onNext(3)">{{ \'text-select-all\' | translate }}</span>\n\n            <div class="btns">\n                <a class="importBtn" (click)="onNext(1)">{{ \'text-export\' | translate }}</a>\n                <a class="delBtn" (click)="onNext(2)">{{ \'text-delete\' | translate }}</a>\n            </div>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/manager/manager.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_5__providers_DataManager__["a" /* DataManager */]])
    ], IdManagerComponent);
    return IdManagerComponent;
}());

//# sourceMappingURL=manager.js.map

/***/ }),

/***/ 457:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CompanypathinfoPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_kyc_company_company__ = __webpack_require__(458);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_id_kyc_company_write_chain_company_write_chain__ = __webpack_require__(459);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_DataManager__ = __webpack_require__(27);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};










var CompanypathinfoPage = /** @class */ (function () {
    function CompanypathinfoPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        //public companyPathList = [{'pathStatus':4,payObj:{parms:{"word":"sss","legalPerson":"zzxxxxx","registrationNum":"ccccccccccc"}}}];
        this.companyPathList = [];
        this.parmar = {};
        this.idsObj = {};
        this.init();
    }
    CompanypathinfoPage.prototype.init = function () {
        var _this = this;
        this.parmar = this.navParams.data;
        this.native.info(this.parmar);
        this.localStorage.get("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                return;
            }
            _this.idsObj = JSON.parse(val);
            var pathList = _this.idsObj[_this.parmar["id"]][_this.parmar["path"]];
            for (var key in pathList) {
                _this.companyPathList.push(pathList[key]);
            }
        });
    };
    CompanypathinfoPage.prototype.onNext = function (item) {
        this.jumpPage(item);
    };
    CompanypathinfoPage.prototype.onCommit = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_kyc_company_company__["a" /* IdKycCompanyComponent */], this.parmar);
    };
    CompanypathinfoPage.prototype.jumpPage = function (item) {
        switch (item["pathStatus"]) {
            case 0:
                break;
            case 1:
                this.getAppAuth(item);
                break;
            case 2:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__pages_id_kyc_company_write_chain_company_write_chain__["a" /* CompanyWriteChainPage */], item);
                break;
        }
    };
    /*  authResult[data] 格式
      [{
        "type": "enterprise",
        "result": "success",
        "retdata": {
          "app": "b1c0b7028c8c4be3beafc4c4812ae92e",
          "signature": "04c7a7e1b062d4692172f8bf9cad0b54d99a780d88c674dece9956bead38c228b53ebdaeb7f2d10b2804f7dd18aa764dcf9a12f7e27ccc3b949965db93ffd46a",
          "RegistrationNum": "911101080804655794",
          "legalPerson": "詹克团",
          "word": "北京比特大陆科技有限公司",
          "authid": "12345678",
          "ts": "1535090480"
        },
        "message": "认证成功",
        "timestamp": "1535090608902",
        "resultSign": "304402204187f00b8217b9eaeaad4c7c25ab01479872467443c7a516c68b368d290767ea02205f4130cd5bb904a070978baf2141ecaafb72163b45c21dc64fc48d63ad3ab0c4"
      }]
      */
    CompanypathinfoPage.prototype.getAppAuth = function (item) {
        var _this = this;
        var serialNum = item["serialNum"];
        var txHash = item["txHash"];
        this.native.info(typeof (txHash));
        this.native.info(serialNum);
        this.native.info(txHash);
        var timestamp = this.native.getTimestamp();
        var parms = { "serialNum": serialNum,
            "txHash": txHash,
            "timestamp": timestamp,
        };
        var checksum = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_3__providers_ApiUrl__["a" /* ApiUrl */].APP_AUTH, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.native.info(data);
                var authResult = JSON.parse(data["_body"]);
                _this.native.info(authResult);
                if (authResult["errorCode"] === "1") {
                    _this.native.toast_trans("text-id-kyc-auth-fee-fail");
                    return;
                }
                if (authResult["errorCode"] === "2") {
                    _this.native.toast_trans("text-id-kyc-auth-query-timeout");
                    return;
                }
                if (authResult["errorCode"] === "4") {
                    _this.native.toast_trans("text-id-kyc-auth-uncompleted");
                    return;
                }
                if (authResult["errorCode"] === "0") {
                    //this.params["adata"] = authResult["data"];
                    item["adata"] = authResult["data"];
                    _this.saveSerialNumParm(serialNum, item);
                    _this.native.info(authResult["data"].length);
                    if (authResult["data"].length > 0) {
                        var signCont = JSON.parse(JSON.stringify(authResult["data"][0]));
                        var resultSign = signCont["resultSign"];
                        delete signCont["resultSign"];
                        _this.dataManager.addSignCont(resultSign, signCont);
                    }
                }
            }
        }).catch(function (error) {
        });
    };
    CompanypathinfoPage.prototype.saveSerialNumParm = function (serialNum, item) {
        var _this = this;
        item["pathStatus"] = 2;
        this.idsObj[this.parmar["id"]][this.parmar["path"]][serialNum] = item;
        this.localStorage.set("kycId", this.idsObj).then(function () {
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__pages_id_kyc_company_write_chain_company_write_chain__["a" /* CompanyWriteChainPage */], item);
        });
    };
    CompanypathinfoPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-companypathinfo',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/companypathinfo/companypathinfo.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-company-path-deatils\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content no-bounce>\n    <ion-grid>\n        <ion-row *ngFor="let item of companyPathList; let i = index" (click)="onNext(item)" class="hang" [ngClass]="{\'bottom-border\': i==companyPathList.length-1}">\n            <ion-col col-4 class="font-size-1">\n                {{\'text-company-name\' | translate }}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                {{item["payObj"]["parms"]["word"]}}\n            </ion-col>\n\n            <ion-col col-4 class="font-size-1">\n                {{\'text-company-legal\' | translate }}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                {{item["payObj"]["parms"]["legalPerson"]}}\n            </ion-col>\n\n            <ion-col col-4 class="font-size-1">\n                {{\'text-company-code\' | translate }}\n            </ion-col>\n            <ion-col col-8 class="font-size-1">\n                {{item["payObj"]["parms"]["registrationNum"]}}\n            </ion-col>\n\n            <ion-col col-4 class="font-size-1">\n                {{\'path-status\' | translate }}\n            </ion-col>\n            <ion-col col-8 class="font-size-1" *ngIf="item[\'pathStatus\']===0">\n                {{\'path-status-no-pay\' | translate }}\n            </ion-col>\n\n            <ion-col col-8 class="font-size-1" *ngIf="item[\'pathStatus\']===1">\n                {{\'path-status-authing\' | translate }}\n            </ion-col>\n\n            <ion-col col-8 class="font-size-1" *ngIf="item[\'pathStatus\']===2">\n                {{\'path-status-authed\' | translate }}\n            </ion-col>\n\n            <ion-col col-8 class="font-size-1" *ngIf="item[\'pathStatus\']===4">\n                {{\'text-data-chain1\' | translate }}\n            </ion-col>\n\n            <ion-col col-8 class="font-size-1" *ngIf="item[\'pathStatus\']===5">\n                {{\'text-data-chain2\' | translate }}\n            </ion-col>\n\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%"> {{\'add-path\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/companypathinfo/companypathinfo.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_5_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_7__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_9__providers_DataManager__["a" /* DataManager */]])
    ], CompanypathinfoPage);
    return CompanypathinfoPage;
}());

//# sourceMappingURL=companypathinfo.js.map

/***/ }),

/***/ 458:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdKycCompanyComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__ = __webpack_require__(70);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};










var IdKycCompanyComponent = /** @class */ (function () {
    function IdKycCompanyComponent(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.businessObj = {
            "type": "enterprise",
            "word": "北京比特大陆科技有限公司",
            "legalPerson": "詹克团",
            "registrationNum": "911101080804655794"
        };
        this.priceObj = {};
        this.payMoney = 0;
        this.unit = "ELA";
        this.path = "";
        this.init();
    }
    IdKycCompanyComponent.prototype.init = function () {
        this.parms = this.navParams.data;
        this.did = this.parms["id"];
        this.path = this.parms["path"] || "";
        this.getPrice();
    };
    IdKycCompanyComponent.prototype.onCommit = function () {
        if (this.checkParms()) {
            this.businessObj["serialNum"] = this.serialNum;
            this.saveKycSerialNum(this.serialNum);
        }
    };
    IdKycCompanyComponent.prototype.saveKycSerialNum = function (serialNum) {
        var _this = this;
        this.localStorage.get("kycId").then(function (val) {
            var idsObj = JSON.parse(val);
            var order = idsObj[_this.did][_this.path];
            order[serialNum] = { serialNum: serialNum, pathStatus: 0, payObj: { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.businessObj } };
            _this.localStorage.set("kycId", idsObj).then(function (newVal) {
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__["a" /* TransferComponent */], { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.businessObj });
            });
        });
    };
    IdKycCompanyComponent.prototype.checkParms = function () {
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.businessObj.word)) {
            this.native.toast_trans('text-word-message');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.businessObj.legalPerson)) {
            this.native.toast_trans('text-legalPerson-message');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.businessObj.registrationNum)) {
            this.native.toast_trans('text-registrationN-message');
            return false;
        }
        return true;
    };
    IdKycCompanyComponent.prototype.getPrice = function () {
        var _this = this;
        var timestamp = this.native.getTimestamp();
        var parms = { "appid": "elastid", "timestamp": timestamp };
        var checksum = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_1__providers_ApiUrl__["a" /* ApiUrl */].GET_PRICE, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.priceObj = JSON.parse(data["_body"]);
                _this.payMoney = _this.priceObj["price"] || 0.1;
                _this.unit = _this.priceObj["unit"] || "ELA";
                _this.serialNum = _this.priceObj["serialNum"];
            }
        }).catch(function (error) {
        });
    };
    IdKycCompanyComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'id-company',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/kyc/company/company.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-certified-company\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n    <ion-grid>\n        <ion-row>\n            <ion-col col-4 align-self-center class="font-size-1 text-left">{{\'text-company-name\' | translate }}</ion-col>\n            <ion-col col-8 align-self-center>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="businessObj.word"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-4 align-self-center class="font-size-1 text-left">{{\'text-company-legal\' | translate }}</ion-col>\n            <ion-col col-8 align-self-center>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="businessObj.legalPerson"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-4 align-self-center class="font-size-1 text-left">{{\'text-company-code\' | translate }}</ion-col>\n            <ion-col col-8 align-self-center>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="this.businessObj.registrationNum"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%">{{\'text-pay\' | translate}}{{payMoney}}{{unit}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/kyc/company/company.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */]])
    ], IdKycCompanyComponent);
    return IdKycCompanyComponent;
}());

//# sourceMappingURL=company.js.map

/***/ }),

/***/ 459:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CompanyWriteChainPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__ = __webpack_require__(65);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__providers_popup__ = __webpack_require__(38);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};











//{notary:"COOIX"}
var CompanyWriteChainPage = /** @class */ (function () {
    function CompanyWriteChainPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager, popupProvider, ngzone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.popupProvider = popupProvider;
        this.ngzone = ngzone;
        this.masterWalletId = "1";
        this.approdType = "enterprise";
        this.businessObj = {
            "word": "xxxxx",
            "legalPerson": "xxxxx",
            "registrationNum": "xxxxxxxx",
        };
        this.message = { Id: "", Path: "", Proof: "", DataHash: "", Sign: "" };
        this.passworld = "";
        this.idObj = {};
        this.orderStatus = 0;
        this.serialNum = "";
        this.init();
    }
    CompanyWriteChainPage.prototype.init = function () {
        var _this = this;
        this.events.subscribe("order:update", function (orderStatus, appr) {
            if (appr === "enterprise") {
                _this.ngzone.run(function () {
                    _this.orderStatus = orderStatus;
                });
            }
        });
        this.idObj = this.navParams.data;
        this.orderStatus = this.idObj["pathStatus"];
        this.serialNum = this.idObj["serialNum"];
        this.native.info(this.idObj);
        this.did = this.idObj["payObj"]["did"];
        this.getCompany();
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(status)) {
            this.type = '0';
        }
        else {
            this.type = status;
        }
    };
    CompanyWriteChainPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.navBar.backButtonClick = function (e) {
            _this.navCtrl.pop();
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_home_home__["a" /* IdHomeComponent */]);
        };
    };
    CompanyWriteChainPage.prototype.getCompany = function () {
        var adata = this.idObj["adata"][0];
        var companyObj = adata["retdata"];
        this.message["Path"] = adata["type"];
        this.approdType = adata["type"];
        this.businessObj["word"] = companyObj["word"];
        this.businessObj["legalPerson"] = companyObj["legalPerson"];
        this.businessObj["registrationNum"] = companyObj["RegistrationNum"];
        this.signature = companyObj["signature"];
    };
    CompanyWriteChainPage.prototype.onCommit = function () {
        var _this = this;
        this.popupProvider.presentPrompt().then(function (val) {
            if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(val)) {
                _this.native.toast_trans("text-id-kyc-prompt-password");
                return;
            }
            _this.passworld = val.toString();
            _this.caulmessageNew();
        }).catch(function () {
        });
        //this.didGenerateProgram();
    };
    CompanyWriteChainPage.prototype.didGenerateProgram = function () {
        var _this = this;
        this.native.info(this.message);
        this.native.info(this.passworld);
        this.walletManager.didGenerateProgram(this.did, JSON.stringify(this.message), this.passworld, function (result) {
            _this.programJson = result.value;
            _this.native.info(_this.programJson);
            _this.createfromAddress();
        });
    };
    CompanyWriteChainPage.prototype.createfromAddress = function () {
        var _this = this;
        this.walletManager.createAddress(this.masterWalletId, "IdChain", function (result) {
            _this.fromAddress = result.address;
            _this.cauFee();
        });
    };
    CompanyWriteChainPage.prototype.cauFee = function () {
        var _this = this;
        this.walletManager.createIdTransaction(this.masterWalletId, "IdChain", "", this.message, this.programJson, "", "", function (result) {
            _this.native.info(_this.fromAddress);
            _this.native.info(_this.message);
            _this.native.info(_this.programJson);
            var rawTransaction = result['json'].toString();
            _this.native.info(rawTransaction);
            _this.calculateTransactionFee(rawTransaction);
        });
    };
    CompanyWriteChainPage.prototype.calculateTransactionFee = function (rawTransaction) {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, "IdChain", rawTransaction, 10000, function (data) {
            _this.fee = data['fee'];
            _this.native.info(rawTransaction);
            _this.native.info(_this.fee);
            _this.popupProvider.presentConfirm(_this.fee / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA).then(function () {
                _this.sendRawTransaction(rawTransaction);
            });
        });
    };
    //////////////////////
    CompanyWriteChainPage.prototype.getKycContent = function (authData) {
        var retContent = {};
        switch (authData.type) {
            case "identityCard":
                retContent["fullName"] = authData["retdata"]["fullName"];
                retContent["identityNumber"] = authData["retdata"]["identityNumber"];
                break;
            case "phone":
                retContent["fullName"] = authData["retdata"]["fullName"];
                retContent["identityNumber"] = authData["retdata"]["identityNumber"];
                retContent["mobile"] = authData["retdata"]["mobile"];
                break;
            case "bankCard":
                retContent["fullName"] = authData["retdata"]["fullName"];
                retContent["identityNumber"] = authData["retdata"]["identityNumber"];
                retContent["cardNumber"] = authData["retdata"]["cardNumber"];
                retContent["cardMobile"] = authData["retdata"]["mobile"];
                break;
            case "enterprise":
                retContent["word"] = authData["retdata"]["word"];
                retContent["legalPerson"] = authData["retdata"]["legalPerson"];
                retContent["registrationNum"] = authData["retdata"]["RegistrationNum"];
                break;
        }
        return retContent;
    };
    // authtype is one of  person company
    /*
    *
    * {
        "serialNum": "VIN1533555041238630",
        "pathStatus": 2,
        "payObj": {
            "did": "ihWrYTvJ4FYHBuQ5mwmTNTVXenSfvWHDy9",
            "addr": "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
            "money": "0.1",
            "appType": "kyc",
            "chianId": "ELA",
            "selectType": "enterprise",
            "parms": {
                "type": "enterprise",
                "word": "北京比特大陆科技有限公司",
                "legalPerson": "詹克团",
                "registrationNum": "911101080804655794",
                "serialNum": "VIN1533555041238630"
            }
        },
        "txHash": "fc812077fba108ab407166eb284b3780ad03da893d73f118ffb241c9533128af",
        "adata": [{
            "type": "enterprise",
            "result": "success",
            "retdata": {
                "app": "b1c0b7028c8c4be3beafc4c4812ae92e",
                "signature": "04c7a7e1b062d4692172f8bf9cad0b54d99a780d88c674dece9956bead38c228b53ebdaeb7f2d10b2804f7dd18aa764dcf9a12f7e27ccc3b949965db93ffd46a",
                "RegistrationNum": "911101080804655794",
                "legalPerson": "詹克团",
                "word": "北京比特大陆科技有限公司",
                "authid": "12345678",
                "ts": "1535090480"
            },
            "message": "认证成功",
            "timestamp": "1535090608902"
        }]
    }
    * */
    // authData is one of  adata
    CompanyWriteChainPage.prototype.getcontent = function (authData) {
        var retContent = {};
        retContent["Path"] = 'kyc' + '/' + authData["type"];
        retContent["Values"] = [];
        var proofObj = {
            signature: authData["resultSign"],
            notary: "COOIX"
        };
        var valueObj = {};
        valueObj["Proof"] = JSON.stringify(proofObj);
        var kycContent = this.getKycContent(authData);
        console.info("ElastJs company getcontent kycContent " + JSON.stringify(kycContent));
        console.info("ElastJs company getcontent Proof " + valueObj["Proof"]);
        var authDataHash = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].hash(JSON.stringify(kycContent) + valueObj["Proof"]);
        valueObj["DataHash"] = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].hash(authDataHash + valueObj["Proof"]);
        var idJsonPart = {};
        idJsonPart["hash"] = valueObj["DataHash"];
        idJsonPart["KycContent"] = kycContent;
        idJsonPart["Proof"] = valueObj["Proof"];
        this.dataManager.addIdPathJson(this.did, retContent["Path"], idJsonPart);
        retContent["Values"].push(valueObj);
        console.info("ElastJs company getcontent retContent " + JSON.stringify(retContent));
        return retContent;
    };
    CompanyWriteChainPage.prototype.caulmessageNew = function () {
        var _this = this;
        //
        ///////////////////////
        var signMessage = {};
        signMessage["Id"] = this.did; //
        //signMessage["Sign"] = "" ;//
        signMessage["Contents"] = [];
        var content;
        var params = this.idObj; //
        for (var _i = 0, _a = params.adata; _i < _a.length; _i++) {
            var ele = _a[_i];
            content = this.getcontent(ele);
            signMessage["Contents"].push(content);
        }
        this.native.info(signMessage);
        this.walletManager.didSign(this.did, JSON.stringify(signMessage), this.passworld, function (result) {
            _this.message = {
                Id: _this.did,
                Sign: result.value,
                Contents: signMessage["Contents"],
            };
            _this.didGenerateProgram();
        });
    };
    ////////////////////////
    CompanyWriteChainPage.prototype.caulmessage = function () {
        var _this = this;
        //kyc 内容
        var kycContent = {};
        kycContent = this.businessObj;
        this.message["Path"] = 'kyc' + "|" + "company" + "|" + "enterprise";
        //kyc 结果
        var authSign = {
            signature: this.signature,
            notary: "COOIX"
        };
        this.native.info(this.signature);
        var authDataHash = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].hash(JSON.stringify(kycContent) + JSON.stringify(authSign));
        var kycChainDataHash = __WEBPACK_IMPORTED_MODULE_2__providers_IDManager__["a" /* IDManager */].hash(authDataHash + JSON.stringify(authSign));
        this.native.info(kycChainDataHash.length);
        var singObj = { Id: this.did, Path: this.message["Path"], Proof: authSign, DataHash: kycChainDataHash };
        this.walletManager.didSign(this.did, JSON.stringify(singObj), this.passworld, function (result) {
            _this.native.info(result);
            var proofString = JSON.stringify(authSign);
            _this.message = { Id: _this.did, Path: _this.message["Path"], Proof: proofString, DataHash: kycChainDataHash, Sign: result.value };
            _this.didGenerateProgram();
        });
    };
    CompanyWriteChainPage.prototype.sendRawTransaction = function (rawTransaction) {
        //alert("sendRawTransaction begin==");
        //   this.walletManager.sendRawTransaction(this.masterWalletId,"IdChain",rawTransaction,this.fee,this.passworld,(result)=>{
        //     let rawTransactionObj = JSON.parse(rawTransaction);
        //     console.log("ElastosJs ---sendRawTransaction---"+"rawTransaction="+JSON.stringify(rawTransactionObj)+"fee="+this.fee);
        //     //console.log("ElastosJs ---sendRawTransaction--- PayLoad"+ JSON.stringify(rawTransactionObj.PayLoad));
        //     if (!rawTransactionObj.PayLoad) {
        //       console.log("ElastosJs ---sendRawTransaction--- PayLoad NULL");
        //       return;
        //     }
        //     if (!rawTransactionObj["PayLoad"]["Contents"]){
        //       console.log("ElastosJs ---sendRawTransaction--- Contents NULL");
        //       return ;
        //     }
        //     /*
        //     *
        //     *
        //     "PayLoad": {
        // 	"Contents": [{
        // 		"Path": "kyc/company/enterprise",
        // 		"Values": [{
        // 			"DataHash": "7f6d1d62480d06e939999f33cc9f3802602236dccfb8243a2e74176b9fb905ab",
        // 			"Proof": "{\"signature\":\"c82657ce310aa4313fd95272f3e52a28b6c4ec9fd2461d1047db5e86edf289995576d9bd3304d938a7bb66cab196258751b6a3c7e7d76b4867588fa827d4de58\",\"notary\":\"COOIX\"}"
        // 		}]
        // 	}],
        // 	"Id": "ifrQqG7kiqqSxGfHN62QPyRZD88ggK6MdD",
        // 	"Sign": "4029d9695dfd5919de9f05b4bd48beb93b33fcb960276cfbbc29ae47365cbb601ea68eceb98ed3c888474b01e66231fccfcef9d633c76e6d513af995e7fd60bd66"
        // } */
        //     for (let ele of rawTransactionObj["PayLoad"]["Contents"] ) {
        //       console.log("ElastosJs company-write-chain ---sendRawTransaction--- ele " + JSON.stringify(ele));
        //       let arr = ele["Path"].split("/");
        //       if (arr[1]) {
        //         let self = this;
        //         //iterat values
        //         for (let valueObj of ele["Values"]){
        //           let proofObj = JSON.parse(valueObj["Proof"]);
        //           this.localStorage.getSeqNumObj(proofObj["signature"], rawTransactionObj.PayLoad.Id, arr[1], function (reult : any) {
        //             console.info("ElastosJs reult " + JSON.stringify(reult) );
        //             self.dataManager.addSeqNumObj(proofObj["signature"] , reult );
        //           });
        //         }
        //       }
        //     }
        //     console.log("ElastosJs company-write-chain setOrderStatus(4) ");
        //     this.setOrderStatus(4);
        //     //this.messageBox("text-id-kyc-china");
        //   })
    };
    CompanyWriteChainPage.prototype.getDepositTransaction = function () {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, "ELA", this.depositTransaction, 10000, function (data) {
            _this.depositTransactionFee = data['fee'];
        });
    };
    CompanyWriteChainPage.prototype.setOrderStatus = function (status) {
        var _this = this;
        console.info("ElastJs setOrderStatus status begin" + status);
        var serids = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getSerIds();
        var serid = serids[this.serialNum];
        var did = serid["id"];
        var path = serid["path"];
        var idsObj = {};
        this.localStorage.getKycList("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                console.info("setOrderStatus val == null return ");
                return;
            }
            idsObj = JSON.parse(val);
            idsObj[did][path][_this.serialNum]["pathStatus"] = status;
            _this.localStorage.set("kycId", idsObj).then(function () {
                console.info("ElastJs setOrderStatus  end  status " + status);
                _this.orderStatus = status;
            });
        });
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["m" /* Navbar */])
    ], CompanyWriteChainPage.prototype, "navBar", void 0);
    CompanyWriteChainPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-company-write-chain',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/kyc/company-write-chain/company-write-chain.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-kyc-result\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n    <div class="company-result">\n        <div class="result-title" *ngIf="type===\'0\'">\n            <p>{{\'text-kyc-success\' | translate }} <img src=\'./assets/images/icon/icon-success.svg\' class="result-img" /></p>\n        </div>\n\n        <div class="result-title" *ngIf="type===\'1\'">\n            <p>{{\'text-kyc-failure\' | translate }} <img src=\'./assets/images/icon/icon-failure.svg\' class="result-img" /></p>\n        </div>\n\n        <ion-grid>\n            <ion-row>\n                <ion-col col-4 class="font-size-1">\n                    {{\'text-company-name\' | translate }}\n                </ion-col>\n\n                <ion-col col-8 class="font-size-1">\n                    {{businessObj.word}}\n                </ion-col>\n\n                <ion-col col-4 class="font-size-1">\n                    {{\'text-company-legal\' | translate }}\n                </ion-col>\n\n                <ion-col col-8 class="font-size-1">\n                    {{businessObj.legalPerson}}\n                </ion-col>\n\n                <ion-col col-4 class="font-size-1">\n                    {{\'text-company-code\' | translate }}\n                </ion-col>\n\n                <ion-col col-8 class="font-size-1">\n                    {{businessObj.registrationNum}}\n                </ion-col>\n            </ion-row>\n\n        </ion-grid>\n    </div>\n</ion-content>\n<ion-footer>\n    <div class="title">\n        <p class="text-person-agreement-wenzi">{{ \'text-id-chain-prompt1\' | translate }}</p>\n    </div>\n    <button ion-button full (click)="onCommit()" style="width: 100%" *ngIf="orderStatus===2"> {{\'text-data-chain\' | translate}}</button>\n    <button ion-button full style="width: 100%" *ngIf="orderStatus===4">{{\'text-data-chain1\' | translate}}</button>\n    <button ion-button full style="width: 100%" *ngIf="orderStatus===5">{{\'text-data-chain2\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/kyc/company-write-chain/company-write-chain.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */], __WEBPACK_IMPORTED_MODULE_10__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], CompanyWriteChainPage);
    return CompanyWriteChainPage;
}());

//# sourceMappingURL=company-write-chain.js.map

/***/ }),

/***/ 460:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return BankcardpathinfoPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_bankcardauth_bankcardauth__ = __webpack_require__(461);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__ = __webpack_require__(127);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_DataManager__ = __webpack_require__(27);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};










var BankcardpathinfoPage = /** @class */ (function () {
    function BankcardpathinfoPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        //public backcardList =[{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':5,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}}];
        this.backcardList = [];
        this.parmar = {};
        this.idsObj = {};
        this.init();
    }
    BankcardpathinfoPage.prototype.init = function () {
        var _this = this;
        this.parmar = this.navParams.data;
        this.native.info(this.parmar);
        this.localStorage.get("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                return;
            }
            _this.idsObj = JSON.parse(val);
            var pathList = _this.idsObj[_this.parmar["id"]][_this.parmar["path"]];
            for (var key in pathList) {
                _this.backcardList.push(pathList[key]);
            }
        });
    };
    BankcardpathinfoPage.prototype.onNext = function (item) {
        this.jumpPage(item);
    };
    BankcardpathinfoPage.prototype.onCommit = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_bankcardauth_bankcardauth__["a" /* BankcardauthPage */], this.parmar);
    };
    BankcardpathinfoPage.prototype.jumpPage = function (item) {
        switch (item["pathStatus"]) {
            case 0:
                break;
            case 1:
                this.getAppAuth(item);
                break;
            case 2:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */], item);
                break;
        }
    };
    BankcardpathinfoPage.prototype.getAppAuth = function (item) {
        var _this = this;
        var serialNum = item["serialNum"];
        var txHash = item["txHash"];
        this.native.info(typeof (txHash));
        this.native.info(serialNum);
        this.native.info(txHash);
        var timestamp = this.native.getTimestamp();
        var parms = { "serialNum": serialNum,
            "txHash": txHash,
            "timestamp": timestamp,
        };
        var checksum = __WEBPACK_IMPORTED_MODULE_3__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_4__providers_ApiUrl__["a" /* ApiUrl */].APP_AUTH, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.native.info(data);
                var authResult = JSON.parse(data["_body"]);
                if (authResult["errorCode"] === "1") {
                    _this.native.toast_trans("text-id-kyc-auth-fee-fail");
                    return;
                }
                if (authResult["errorCode"] === "2") {
                    _this.native.toast_trans("text-id-kyc-auth-query-timeout");
                    return;
                }
                if (authResult["errorCode"] === "4") {
                    _this.native.toast_trans("text-id-kyc-auth-uncompleted");
                    return;
                }
                if (authResult["errorCode"] === "0") {
                    //this.params["adata"] = authResult["data"];
                    item["adata"] = authResult["data"];
                    _this.saveSerialNumParm(serialNum, item);
                    if (authResult["data"].length > 0) {
                        var signCont = JSON.parse(JSON.stringify(authResult["data"][0]));
                        var resultSign = signCont["resultSign"];
                        delete signCont["resultSign"];
                        _this.dataManager.addSignCont(resultSign, signCont);
                    }
                }
            }
        }).catch(function (error) {
        });
    };
    BankcardpathinfoPage.prototype.saveSerialNumParm = function (serialNum, item) {
        var _this = this;
        item["pathStatus"] = 2;
        this.idsObj[this.parmar["id"]][this.parmar["path"]][serialNum] = item;
        this.localStorage.set("kycId", this.idsObj).then(function () {
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */], item);
        });
    };
    BankcardpathinfoPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-bankcardpathinfo',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/bankcardpathinfo/bankcardpathinfo.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-bankcard-path-deatils\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content no-bounce>\n    <ion-grid>\n\n        <ion-row *ngFor="let item of backcardList; let i = index" (click)="onNext(item)" class="hang" [ngClass]="{\'bottom-border\': i==backcardList.length-1}">\n            <ion-col col-2 class="font-size-1">\n                {{\'text-name\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["fullName"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-identity\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["identityNumber"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-phone\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["cardMobile"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-card\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["cardNumber"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'path-status\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===0">\n                {{\'path-status-no-pay\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===1">\n                {{\'path-status-authing\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===2">\n                {{\'path-status-authed\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===4">\n                {{\'text-data-chain1\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===5">\n                {{\'text-data-chain2\' | translate }}\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%"> {{\'add-path\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/bankcardpathinfo/bankcardpathinfo.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_5_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_7__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_9__providers_DataManager__["a" /* DataManager */]])
    ], BankcardpathinfoPage);
    return BankcardpathinfoPage;
}());

//# sourceMappingURL=bankcardpathinfo.js.map

/***/ }),

/***/ 461:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return BankcardauthPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__ = __webpack_require__(70);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};










var BankcardauthPage = /** @class */ (function () {
    function BankcardauthPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.debitCard = { fullName: '宋家准', identityNumber: '410426198811151012', cardNumber: '6225880167820399', cardMobile: '18210230496', cardCode: '', type: "bankCard" };
        this.payMoney = 0;
        this.unit = "ELA";
        this.priceObj = {};
        this.verifyCode = {
            verifyCodeTips: "获取验证码",
            countdown: 60,
            disable: true
        };
        this.init();
    }
    BankcardauthPage.prototype.init = function () {
        this.parms = this.navParams.data;
        this.did = this.parms["id"];
        this.path = this.parms["path"] || "";
        this.getPrice();
    };
    BankcardauthPage.prototype.getPrice = function () {
        var _this = this;
        var timestamp = this.native.getTimestamp();
        var parms = { "appid": "elastid", "timestamp": timestamp };
        var checksum = __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__["a" /* ApiUrl */].GET_PRICE, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.priceObj = JSON.parse(data["_body"]);
                _this.payMoney = _this.priceObj["price"] || 0.1;
                _this.unit = _this.priceObj["unit"] || "ELA";
                _this.serialNum = _this.priceObj["serialNum"];
            }
        }).catch(function (error) {
        });
    };
    BankcardauthPage.prototype.sendCodeHttp = function (mobile) {
        var code = (Math.random() * 1000000000000000).toString().substring(0, 6);
        var timestamp = this.native.getTimestamp();
        var parms = { "mobile": mobile, "code": code, "serialNum": this.serialNum, "timestamp": timestamp };
        var checksum = __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__["a" /* ApiUrl */].SEND_CODE, parms).toPromise().then(function (data) {
        }).catch(function (error) {
        });
    };
    BankcardauthPage.prototype.onCommit = function () {
        if (this.checkParms()) {
            this.saveKycSerialNum(this.serialNum);
        }
    };
    BankcardauthPage.prototype.saveKycSerialNum = function (serialNum) {
        var _this = this;
        this.localStorage.get("kycId").then(function (val) {
            var idsObj = JSON.parse(val);
            var order = idsObj[_this.did][_this.path];
            order[serialNum] = { serialNum: serialNum, pathStatus: 0, payObj: { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.debitCard } };
            _this.localStorage.set("kycId", idsObj).then(function (newVal) {
                _this.debitCard["serialNum"] = serialNum;
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__["a" /* TransferComponent */], { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.debitCard });
            });
        });
    };
    BankcardauthPage.prototype.checkParms = function () {
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.debitCard.fullName)) {
            this.native.toast_trans('text-realname-message');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.debitCard.identityNumber)) {
            this.native.toast_trans('text-cardNo-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isCardNo(this.debitCard.identityNumber)) {
            this.native.toast_trans('text-cardNo-message-2');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.debitCard.cardNumber)) {
            this.native.toast_trans('text-debitCard-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isBankCard(this.debitCard.cardNumber)) {
            this.native.toast_trans('text-debitCard-message-2');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.debitCard.cardMobile)) {
            this.native.toast_trans('text-phone-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].checkCellphone(this.debitCard.cardMobile)) {
            this.native.toast_trans('text-phone-message-2');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.debitCard.cardCode)) {
            this.native.toast_trans('text-sendcode-message-1');
            return;
        }
        return true;
    };
    BankcardauthPage.prototype.getCode = function (phone) {
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(phone)) {
            this.native.toast_trans('text-phone-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].checkCellphone(phone)) {
            this.native.toast_trans('text-phone-message-2');
            return;
        }
        if (this.verifyCode.disable) {
            this.verifyCode.disable = false;
            this.settime();
            this.sendCodeHttp(phone);
        }
    };
    //倒计时
    BankcardauthPage.prototype.settime = function () {
        var _this = this;
        if (this.verifyCode.countdown == 0) {
            this.verifyCode.verifyCodeTips = "获取验证码";
            this.verifyCode.disable = true;
            this.verifyCode.countdown = 60;
            return;
        }
        else {
            this.verifyCode.countdown--;
        }
        setTimeout(function () {
            _this.verifyCode.verifyCodeTips = "重新获取" + _this.verifyCode.countdown + "秒";
            _this.settime();
        }, 1000);
    };
    BankcardauthPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-bankcardauth',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/bankcardauth/bankcardauth.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-card-debit\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n    <ion-grid>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{ \'text-name\' | translate }} </ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="text" [(ngModel)]="debitCard.fullName" placeholder="{{\'text-input-please\' | translate }}"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-identity\' | translate }}</ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="tel" [(ngModel)]="debitCard.identityNumber" placeholder="{{\'text-input-please\' | translate }}"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-card-debit\' | translate }}</ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="tel" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="debitCard.cardNumber"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-phone\' | translate }}</ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="tel" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="debitCard.cardMobile"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-check-code\' | translate }}</ion-col>\n            <ion-col col-4 align-self-center>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="debitCard.cardCode"></ion-input>\n                </ion-item>\n            </ion-col>\n\n            <ion-col col-6 align-self-center class="text-center">\n                <button ion-button full [(disabled)]="verifyCode.disabled" (click)="getCode(debitCard.cardMobile)">{{verifyCode.verifyCodeTips}}</button>\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n    <!-- <div class="person">\n        <div class="certified-phone">\n            <div class="weui-cells__title">{{\'text-card-debit\' | translate }}</div>\n            <div class="weui-cells">\n\n                <div class="weui-cell">\n                    <div class="weui-cell__hd"><label for="" class="weui-label">{{\'text-name\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="text" [(ngModel)]="debitCard.fullName" placeholder="{{\'text-input-please\' | translate }}">\n                    </div>\n                </div>\n\n                <div class="weui-cell">\n                    <div class="weui-cell__hd"><label for="" class="weui-label">{{\'text-identity\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="tel" [(ngModel)]="debitCard.identityNumber" placeholder="{{\'text-input-please\' | translate }}">\n                    </div>\n                </div>\n\n                <div class="weui-cell">\n                    <div class="weui-cell__hd"><label for="" class="weui-label">{{\'text-card-debit\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="tel" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="debitCard.cardNumber">\n                    </div>\n                </div>\n\n\n                <div class="weui-cell">\n                    <div class="weui-cell__hd"><label for="" class="weui-label">{{\'text-phone\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="tel" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="debitCard.cardMobile">\n                    </div>\n                </div>\n\n                <div class="weui-cell weui-cell_vcode">\n                    <div class="weui-cell__hd"><label class="weui-label">{{\'text-check-code\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="text" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="debitCard.cardCode">\n                    </div>\n                    <div class="weui-cell__ft" (click)="sendCode(debitCard.cardMobile)">\n                        <button class="weui-vcode-btn" [weui-vcode]="onSendCode" weui-seconds="60" weui-tpl="${num}s" weui-error="重新发送">获取验证码</button>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div> -->\n</ion-content>\n\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%">{{\'text-pay\' | translate}}{{payMoney}}{{unit}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/bankcardauth/bankcardauth.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */]])
    ], BankcardauthPage);
    return BankcardauthPage;
}());

//# sourceMappingURL=bankcardauth.js.map

/***/ }),

/***/ 462:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PhonepathinfoPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_phoneauth_phoneauth__ = __webpack_require__(463);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__ = __webpack_require__(127);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};









var PhonepathinfoPage = /** @class */ (function () {
    function PhonepathinfoPage(navCtrl, navParams, native, localStorage, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.localStorage = localStorage;
        this.dataManager = dataManager;
        //public phonepathlist = [{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':5,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}}];
        this.phonepathlist = [];
        this.parmar = {};
        this.idsObj = {};
        this.init();
    }
    PhonepathinfoPage.prototype.init = function () {
        var _this = this;
        this.parmar = this.navParams.data;
        this.native.info(this.parmar);
        this.localStorage.get("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                return;
            }
            _this.idsObj = JSON.parse(val);
            var pathList = _this.idsObj[_this.parmar["id"]][_this.parmar["path"]];
            for (var key in pathList) {
                _this.phonepathlist.push(pathList[key]);
            }
        });
    };
    PhonepathinfoPage.prototype.onNext = function (item) {
        this.jumpPage(item);
    };
    PhonepathinfoPage.prototype.onCommit = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_phoneauth_phoneauth__["a" /* PhoneauthPage */], this.parmar);
    };
    PhonepathinfoPage.prototype.jumpPage = function (item) {
        switch (item["pathStatus"]) {
            case 0:
                break;
            case 1:
                this.getAppAuth(item);
                break;
            case 2:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */], item);
                break;
        }
    };
    PhonepathinfoPage.prototype.getAppAuth = function (item) {
        var _this = this;
        var serialNum = item["serialNum"];
        var txHash = item["txHash"];
        this.native.info(typeof (txHash));
        this.native.info(serialNum);
        this.native.info(txHash);
        var timestamp = this.native.getTimestamp();
        var parms = { "serialNum": serialNum,
            "txHash": txHash,
            "timestamp": timestamp,
        };
        var checksum = __WEBPACK_IMPORTED_MODULE_3__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_4__providers_ApiUrl__["a" /* ApiUrl */].APP_AUTH, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.native.info(data);
                var authResult = JSON.parse(data["_body"]);
                if (authResult["errorCode"] === "1") {
                    _this.native.toast_trans("text-id-kyc-auth-fee-fail");
                    return;
                }
                if (authResult["errorCode"] === "2") {
                    _this.native.toast_trans("text-id-kyc-auth-query-timeout");
                    return;
                }
                if (authResult["errorCode"] === "4") {
                    _this.native.toast_trans("text-id-kyc-auth-uncompleted");
                    return;
                }
                if (authResult["errorCode"] === "0") {
                    //this.params["adata"] = authResult["data"];
                    item["adata"] = authResult["data"];
                    _this.saveSerialNumParm(serialNum, item);
                    if (authResult["data"].length > 0) {
                        var signCont = JSON.parse(JSON.stringify(authResult["data"][0]));
                        var resultSign = signCont["resultSign"];
                        delete signCont["resultSign"];
                        _this.dataManager.addSignCont(resultSign, signCont);
                    }
                }
            }
        }).catch(function (error) {
        });
    };
    PhonepathinfoPage.prototype.saveSerialNumParm = function (serialNum, item) {
        var _this = this;
        item["pathStatus"] = 2;
        this.idsObj[this.parmar["id"]][this.parmar["path"]][serialNum] = item;
        this.localStorage.set("kycId", this.idsObj).then(function () {
            _this.native.Go(__WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */], item);
        });
    };
    PhonepathinfoPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-phonepathinfo',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/phonepathinfo/phonepathinfo.html"*/'<!--\n  Generated template for the PhonepathinfoPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'phone-path-deatils\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content no-bounce>\n    <ion-grid>\n\n        <ion-row *ngFor="let item of phonepathlist; let i = index" (click)="onNext(item)" class="hang" [ngClass]="{\'bottom-border\': i==phonepathlist.length-1}">\n            <ion-col col-2 class="font-size-1">\n                {{\'text-name\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["fullName"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-identity\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["identityNumber"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-phone\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["mobile"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'path-status\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===0">\n                {{\'path-status-no-pay\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===1">\n                {{\'path-status-authing\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===2">\n                {{\'path-status-authed\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===4">\n                {{\'text-data-chain1\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===5">\n                {{\'text-data-chain2\' | translate }}\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%"> {{\'add-path\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/phonepathinfo/phonepathinfo.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_5_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */]])
    ], PhonepathinfoPage);
    return PhonepathinfoPage;
}());

//# sourceMappingURL=phonepathinfo.js.map

/***/ }),

/***/ 463:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PhoneauthPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__ = __webpack_require__(70);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};










var PhoneauthPage = /** @class */ (function () {
    function PhoneauthPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.phoneValidate = { fullName: '宋家准', identityNumber: '410426198811151012', mobile: '18210230496', code: '', type: "phone" };
        this.payMoney = 0;
        this.unit = "ELA";
        this.priceObj = {};
        this.verifyCode = {
            verifyCodeTips: "获取验证码",
            countdown: 60,
            disable: true
        };
        this.init();
    }
    PhoneauthPage.prototype.init = function () {
        this.parms = this.navParams.data;
        this.did = this.parms["id"];
        this.path = this.parms["path"] || "";
        this.getPrice();
    };
    PhoneauthPage.prototype.getPrice = function () {
        var _this = this;
        var timestamp = this.native.getTimestamp();
        var parms = { "appid": "elastid", "timestamp": timestamp };
        var checksum = __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__["a" /* ApiUrl */].GET_PRICE, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.priceObj = JSON.parse(data["_body"]);
                _this.payMoney = _this.priceObj["price"] || 0.1;
                _this.unit = _this.priceObj["unit"] || "ELA";
                _this.serialNum = _this.priceObj["serialNum"];
            }
        }).catch(function (error) {
        });
    };
    PhoneauthPage.prototype.onCommit = function () {
        this.saveKycSerialNum(this.serialNum);
    };
    PhoneauthPage.prototype.saveKycSerialNum = function (serialNum) {
        var _this = this;
        this.localStorage.get("kycId").then(function (val) {
            var idsObj = JSON.parse(val);
            var order = idsObj[_this.did][_this.path];
            order[serialNum] = { serialNum: serialNum, pathStatus: 0, payObj: { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.phoneValidate } };
            _this.localStorage.set("kycId", idsObj).then(function (newVal) {
                _this.phoneValidate["serialNum"] = serialNum;
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__["a" /* TransferComponent */], { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.phoneValidate });
            });
        });
    };
    PhoneauthPage.prototype.checkIdentity = function () {
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.phoneValidate.fullName)) {
            this.native.toast_trans('text-realname-message');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.phoneValidate.identityNumber)) {
            this.native.toast_trans('text-cardNo-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isCardNo(this.phoneValidate.identityNumber)) {
            this.native.toast_trans('text-cardNo-message-2');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.phoneValidate.mobile)) {
            this.native.toast_trans('text-phone-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].checkCellphone(this.phoneValidate.mobile)) {
            this.native.toast_trans('text-phone-message-2');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.phoneValidate.code)) {
            this.native.toast_trans('text-sendcode-message-1');
            return;
        }
        return true;
    };
    PhoneauthPage.prototype.sendCodeHttp = function (mobile) {
        var code = (Math.random() * 1000000000000000).toString().substring(0, 6);
        var timestamp = this.native.getTimestamp();
        var parms = { "mobile": mobile, "code": code, "serialNum": this.serialNum, "timestamp": timestamp };
        var checksum = __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__["a" /* ApiUrl */].SEND_CODE, parms).toPromise().then(function (data) {
        }).catch(function (error) {
        });
    };
    PhoneauthPage.prototype.getCode = function (phone) {
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(phone)) {
            this.native.toast_trans('text-phone-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].checkCellphone(phone)) {
            this.native.toast_trans('text-phone-message-2');
            return;
        }
        if (this.verifyCode.disable) {
            this.verifyCode.disable = false;
            this.settime();
            this.sendCodeHttp(phone);
        }
    };
    //倒计时
    PhoneauthPage.prototype.settime = function () {
        var _this = this;
        if (this.verifyCode.countdown == 0) {
            this.verifyCode.verifyCodeTips = "获取验证码";
            this.verifyCode.disable = true;
            this.verifyCode.countdown = 60;
            return;
        }
        else {
            this.verifyCode.countdown--;
        }
        setTimeout(function () {
            _this.verifyCode.verifyCodeTips = "重新获取" + _this.verifyCode.countdown + "秒";
            _this.settime();
        }, 1000);
    };
    PhoneauthPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-phoneauth',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/phoneauth/phoneauth.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-certified-phone\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n    <ion-grid>\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{ \'text-name\' | translate }} </ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="text" [(ngModel)]="phoneValidate.fullName" placeholder="{{\'text-input-please\' | translate }}"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-identity\' | translate }}</ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="tel" [(ngModel)]="phoneValidate.identityNumber" placeholder="{{\'text-input-please\' | translate }}"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-phone\' | translate }}</ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="tel" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="phoneValidate.mobile"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-check-code\' | translate }}</ion-col>\n            <ion-col col-4 align-self-center>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="phoneValidate.code"></ion-input>\n                </ion-item>\n            </ion-col>\n\n            <ion-col col-6 align-self-center class="text-center">\n                <button ion-button full [(disabled)]="verifyCode.disabled" (click)="getCode(phoneValidate.mobile)">{{verifyCode.verifyCodeTips}}</button>\n            </ion-col>\n        </ion-row>\n\n    </ion-grid>\n    <!-- <div class="person">\n        <div class="certified-phone">\n            <div class="weui-cells__title">{{\'text-certified-phone\' | translate }}</div>\n            <div class="weui-cells">\n\n                <div class="weui-cell">\n                    <div class="weui-cell__hd"><label for="" class="weui-label">{{\'text-name\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="text" [(ngModel)]="phoneValidate.fullName" placeholder="{{\'text-input-please\' | translate }}">\n                    </div>\n                </div>\n\n                <div class="weui-cell">\n                    <div class="weui-cell__hd"><label for="" class="weui-label">{{\'text-identity\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="tel" [(ngModel)]="phoneValidate.identityNumber" placeholder="{{\'text-input-please\' | translate }}">\n                    </div>\n                </div>\n\n\n                <div class="weui-cell">\n                    <div class="weui-cell__hd"><label for="" class="weui-label">{{\'text-phone\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="tel" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="phoneValidate.mobile">\n                    </div>\n                </div>\n\n                <div class="weui-cell weui-cell_vcode">\n                    <div class="weui-cell__hd"><label class="weui-label">{{\'text-check-code\' | translate }}</label></div>\n                    <div class="weui-cell__bd">\n                        <input class="weui-input" type="text" placeholder="{{\'text-input-please\' | translate }}" [(ngModel)]="phoneValidate.code">\n                    </div>\n                    <div class="weui-cell__ft" (click)="sendCode(phoneValidate.mobile)">\n                        <button class="weui-vcode-btn" [weui-vcode]="onSendCode" weui-seconds="60" weui-tpl="${num}s" weui-error="重新发送">获取验证码</button>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div> -->\n</ion-content>\n\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%">{{\'text-pay\' | translate}}{{payMoney}}{{unit}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/phoneauth/phoneauth.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */]])
    ], PhoneauthPage);
    return PhoneauthPage;
}());

//# sourceMappingURL=phoneauth.js.map

/***/ }),

/***/ 464:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdentitypathinfoPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_identityauth_identityauth__ = __webpack_require__(465);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__ = __webpack_require__(127);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};









var IdentitypathinfoPage = /** @class */ (function () {
    function IdentitypathinfoPage(navCtrl, navParams, native, localStorage, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.localStorage = localStorage;
        this.dataManager = dataManager;
        //public identitypathlist =[{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':5,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}},{'pathStatus':4,payObj:{parms:{"fullName":"sssssss","identityNumber":410426,"mobile":18210230496}}}];
        this.identitypathlist = [];
        this.parmar = {};
        this.idsObj = {};
        this.init();
    }
    IdentitypathinfoPage.prototype.init = function () {
        var _this = this;
        this.parmar = this.navParams.data;
        this.native.info(this.parmar);
        this.localStorage.get("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                return;
            }
            _this.idsObj = JSON.parse(val);
            var pathList = _this.idsObj[_this.parmar["id"]][_this.parmar["path"]];
            for (var key in pathList) {
                _this.identitypathlist.push(pathList[key]);
            }
        });
    };
    IdentitypathinfoPage.prototype.onNext = function (item) {
        this.jumpPage(item);
    };
    IdentitypathinfoPage.prototype.onCommit = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_identityauth_identityauth__["a" /* IdentityauthPage */], this.parmar);
    };
    IdentitypathinfoPage.prototype.jumpPage = function (item) {
        switch (item["pathStatus"]) {
            case 0:
                break;
            case 1:
                this.getAppAuth(item);
                break;
            case 2:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */], item);
                break;
        }
    };
    IdentitypathinfoPage.prototype.getAppAuth = function (item) {
        var _this = this;
        var serialNum = item["serialNum"];
        var txHash = item["txHash"];
        this.native.info(typeof (txHash));
        this.native.info(serialNum);
        this.native.info(txHash);
        var timestamp = this.native.getTimestamp();
        var parms = { "serialNum": serialNum,
            "txHash": txHash,
            "timestamp": timestamp,
        };
        var checksum = __WEBPACK_IMPORTED_MODULE_3__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_4__providers_ApiUrl__["a" /* ApiUrl */].APP_AUTH, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.native.info(data);
                var authResult = JSON.parse(data["_body"]);
                if (authResult["errorCode"] === "1") {
                    _this.native.toast_trans("text-id-kyc-auth-fee-fail");
                    return;
                }
                if (authResult["errorCode"] === "2") {
                    _this.native.toast_trans("text-id-kyc-auth-query-timeout");
                    return;
                }
                if (authResult["errorCode"] === "4") {
                    _this.native.toast_trans("text-id-kyc-auth-uncompleted");
                    return;
                }
                if (authResult["errorCode"] === "0") {
                    //this.params["adata"] = authResult["data"];
                    item["adata"] = authResult["data"];
                    _this.saveSerialNumParm(serialNum, item);
                    if (authResult["data"].length > 0) {
                        var signCont = JSON.parse(JSON.stringify(authResult["data"][0]));
                        var resultSign = signCont["resultSign"];
                        delete signCont["resultSign"];
                        _this.dataManager.addSignCont(resultSign, signCont);
                    }
                }
            }
        }).catch(function (error) {
        });
    };
    IdentitypathinfoPage.prototype.saveSerialNumParm = function (serialNum, item) {
        var _this = this;
        item["pathStatus"] = 2;
        this.idsObj[this.parmar["id"]][this.parmar["path"]][serialNum] = item;
        this.localStorage.set("kycId", this.idsObj).then(function () {
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */], item);
        });
    };
    IdentitypathinfoPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-identitypathinfo',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/identitypathinfo/identitypathinfo.html"*/'<!--\n  Generated template for the PhonepathinfoPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-identity-path-deatils\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content no-bounce>\n    <ion-grid>\n\n        <ion-row *ngFor="let item of identitypathlist; let i = index" (click)="onNext(item)" class="hang" [ngClass]="{\'bottom-border\': i==identitypathlist.length-1}">\n            <ion-col col-2 class="font-size-1">\n                {{\'text-name\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["fullName"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'text-identity\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1">\n                {{item["payObj"]["parms"]["identityNumber"]}}\n            </ion-col>\n\n            <ion-col col-2 class="font-size-1">\n                {{\'path-status\' | translate }}\n            </ion-col>\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===0">\n                {{\'path-status-no-pay\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===1">\n                {{\'path-status-authing\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===2">\n                {{\'path-status-authed\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===4">\n                {{\'text-data-chain1\' | translate }}\n            </ion-col>\n\n            <ion-col col-10 class="font-size-1" *ngIf="item[\'pathStatus\']===5">\n                {{\'text-data-chain2\' | translate }}\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%"> {{\'add-path\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/identitypathinfo/identitypathinfo.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_5_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_5_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */]])
    ], IdentitypathinfoPage);
    return IdentitypathinfoPage;
}());

//# sourceMappingURL=identitypathinfo.js.map

/***/ }),

/***/ 465:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdentityauthPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__ = __webpack_require__(70);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};










var IdentityauthPage = /** @class */ (function () {
    function IdentityauthPage(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.personValidate = { fullName: '宋家准', identityNumber: '410426198811151012', "type": "identityCard" }; //个人验证对象
        this.payMoney = 0;
        this.unit = "ELA";
        this.priceObj = {};
        this.init();
    }
    IdentityauthPage.prototype.init = function () {
        this.parms = this.navParams.data;
        this.did = this.parms["id"];
        this.path = this.parms["path"] || "";
        this.getPrice();
    };
    IdentityauthPage.prototype.onCommit = function () {
        if (this.checkIdentity()) {
            this.saveKycSerialNum(this.serialNum);
        }
    };
    IdentityauthPage.prototype.saveKycSerialNum = function (serialNum) {
        var _this = this;
        this.localStorage.get("kycId").then(function (val) {
            var idsObj = JSON.parse(val);
            var order = idsObj[_this.did][_this.path];
            order[serialNum] = { serialNum: serialNum, pathStatus: 0, payObj: { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.personValidate } };
            _this.localStorage.set("kycId", idsObj).then(function (newVal) {
                _this.personValidate["serialNum"] = serialNum;
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_coin_transfer_transfer_component__["a" /* TransferComponent */], { did: _this.did, addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD", money: _this.payMoney, appType: "kyc", chianId: "ELA", selectType: _this.path, parms: _this.personValidate });
            });
        });
    };
    IdentityauthPage.prototype.checkIdentity = function () {
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.personValidate.fullName)) {
            this.native.toast_trans('text-realname-message');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isNull(this.personValidate.identityNumber)) {
            this.native.toast_trans('text-cardNo-message-1');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_9__providers_Util__["a" /* Util */].isCardNo(this.personValidate.identityNumber)) {
            this.native.toast_trans('text-cardNo-message-2');
            return;
        }
        return true;
    };
    IdentityauthPage.prototype.getPrice = function () {
        var _this = this;
        var timestamp = this.native.getTimestamp();
        var parms = { "appid": "elastid", "timestamp": timestamp };
        var checksum = __WEBPACK_IMPORTED_MODULE_1__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_2__providers_ApiUrl__["a" /* ApiUrl */].GET_PRICE, parms).toPromise().then().then(function (data) {
            if (data["status"] === 200) {
                _this.priceObj = JSON.parse(data["_body"]);
                _this.payMoney = _this.priceObj["price"] || 0.1;
                _this.unit = _this.priceObj["unit"] || "ELA";
                _this.serialNum = _this.priceObj["serialNum"];
            }
        }).catch(function (error) {
        });
    };
    IdentityauthPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-identityauth',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/identityauth/identityauth.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-certified-identity\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n\n    <ion-grid>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{ \'text-name\' | translate }} </ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="text" [(ngModel)]="personValidate.fullName" placeholder="{{\'text-input-please\' | translate }}"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-2 align-self-center class="font-size-1 text-left">{{\'text-identity\' | translate }}</ion-col>\n            <ion-col col-10 align-self-center>\n                <ion-item>\n                    <ion-input type="tel" [(ngModel)]="personValidate.identityNumber" placeholder="{{\'text-input-please\' | translate }}"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n\n<ion-footer>\n    <button ion-button full class="button-footer" (click)="onCommit()" style="width: 100%">{{\'text-pay\' | translate}}{{payMoney}}{{unit}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/identityauth/identityauth.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_DataManager__["a" /* DataManager */]])
    ], IdentityauthPage);
    return IdentityauthPage;
}());

//# sourceMappingURL=identityauth.js.map

/***/ }),

/***/ 466:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return TxdetailsPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_scancode_scancode__ = __webpack_require__(67);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Config__ = __webpack_require__(11);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};








var TxdetailsPage = /** @class */ (function () {
    function TxdetailsPage(navCtrl, navParams, popupProvider, native, walletManager) {
        var _this = this;
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.popupProvider = popupProvider;
        this.native = native;
        this.walletManager = walletManager;
        this.masterWalletId = "1";
        this.singPublickey = [];
        this.type = this.navParams.data["type"];
        this.txDetails = JSON.parse(this.navParams.data['content'])['tx'];
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.native.info(this.txDetails);
        this.walletManager.decodeTransactionFromString(this.txDetails["raw"], function (raw) {
            if (raw["success"]) {
                _this.native.info(raw);
                _this.raw = raw["success"];
                _this.txHash = JSON.parse(raw["success"])["TxHash"];
                _this.txDetails["address"] = JSON.parse(raw["success"])["Outputs"][0]["Address"];
                _this.txDetails["amount"] = JSON.parse(raw["success"])["Outputs"][0]["Amount"] / __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].SELA;
                _this.getTransactionSignedSigners(_this.masterWalletId, _this.txDetails["chianId"], _this.raw);
            }
        });
    }
    TxdetailsPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad TxdetailsPage');
    };
    TxdetailsPage.prototype.nextPage = function () {
        var _this = this;
        if (this.type === 4) {
            this.getPassWord();
        }
        else if (this.type === 3) {
            this.native.showLoading().then(function () {
                _this.sendTx(_this.masterWalletId, _this.txDetails["chianId"], _this.raw);
            });
        }
    };
    TxdetailsPage.prototype.getPassWord = function () {
        var _this = this;
        this.popupProvider.presentPrompt().then(function (data) {
            if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNull(data)) {
                _this.native.toast_trans("text-id-kyc-prompt-password");
                return;
            }
            _this.singTx(_this.masterWalletId, _this.txDetails["chianId"], _this.raw, data.toString());
        }).catch(function (err) {
            alert(JSON.stringify(err));
        });
    };
    TxdetailsPage.prototype.singTx = function (masterWalletId, chain, rawTransaction, payPassWord) {
        var _this = this;
        this.walletManager.signTransaction(masterWalletId, chain, rawTransaction, payPassWord, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.walletManager.encodeTransactionToString(data["success"], function (raw) {
                    if (raw["success"]) {
                        _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.txDetails["chianId"], "fee": _this.txDetails["fee"], "raw": raw["success"] } });
                    }
                });
            }
        });
    };
    TxdetailsPage.prototype.sendTx = function (masterWalletId, chain, rawTransaction) {
        var _this = this;
        this.walletManager.publishTransaction(masterWalletId, chain, rawTransaction, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.native.hideLoading();
                _this.native.toast_trans('send-raw-transaction');
                _this.navCtrl.pop();
            }
        });
    };
    TxdetailsPage.prototype.getTransactionSignedSigners = function (masterWalletId, chain, rawTransaction) {
        var _this = this;
        this.walletManager.getTransactionSignedSigners(masterWalletId, chain, rawTransaction, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.native.info(data["success"]);
                _this.singPublickey = JSON.parse(data["success"])["Signers"];
                _this.native.info(_this.singPublickey);
            }
        });
    };
    TxdetailsPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-txdetails',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/txdetails/txdetails.html"*/'<!--\n  Generated template for the TxdetailsPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-tx-details\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n    <ul>\n        <li>\n            {{\'transaction-id\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{txHash}}\n        </li>\n\n        <li>\n            {{\'transfer-address\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{txDetails[\'address\']}}\n        </li>\n        <li>\n            {{\'text-price\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{txDetails[\'amount\']}}\n        </li>\n        <li>\n            {{\'text-fees\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{txDetails[\'fee\']}}\n        </li>\n\n        <li *ngIf="singPublickey.length > 0">\n            {{\'already-signed-publickey\' | translate}}\n        </li>\n        <li *ngFor="let item of singPublickey; let i = index" [ngClass]="{\'bottom-border\': i==singPublickey.length-1}">\n            {{i+1}}.{{item}}\n        </li>\n\n    </ul>\n</ion-content>\n<ion-footer>\n    <button ion-button style="width: 100%" (click)="nextPage()">{{\'text-next-step\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/txdetails/txdetails.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */]])
    ], TxdetailsPage);
    return TxdetailsPage;
}());

//# sourceMappingURL=txdetails.js.map

/***/ }),

/***/ 467:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CoinSelectComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__recharge_recharge_component__ = __webpack_require__(468);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var CoinSelectComponent = /** @class */ (function () {
    function CoinSelectComponent(navCtrl, navParams, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.isNoData = false;
        this.coinList = [];
        this.masterWalletInfo = {};
        this.init();
    }
    CoinSelectComponent.prototype.init = function () {
        this.masterWalletInfo = this.navParams.get("walletInfo");
        var mastId = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var subwallet = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getSubWallet(mastId);
        if (subwallet) {
            if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isEmptyObject(subwallet)) {
                this.coinList = [];
                this.isNoData = true;
                return;
            }
            this.isNoData = false;
            for (var coin in subwallet) {
                if (coin != 'ELA') {
                    this.coinList.push({ name: coin });
                }
            }
        }
        else {
            this.isNoData = true;
            this.coinList = [];
        }
    };
    CoinSelectComponent.prototype.onItem = function (item) {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__recharge_recharge_component__["a" /* RechargeComponent */], { chianId: item.name, "walletInfo": this.masterWalletInfo });
    };
    CoinSelectComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-coin-slect',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/coin-select/coin-select.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-coin-list\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <nodata keyText=\'no-open-side-chain\' *ngIf="isNoData"></nodata>\n    <ion-list *ngIf="!isNoData">\n        <ion-item *ngFor="let item of coinList" (click)="onItem(item)">\n            <ion-icon item-start>\n                <img src="./assets/images/logo-maincolor.svg" width="40">\n            </ion-icon>\n            <ion-note item-end>\n                {{item.name}}\n            </ion-note>\n        </ion-item>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/coin-select/coin-select.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_5__providers_Native__["a" /* Native */]])
    ], CoinSelectComponent);
    return CoinSelectComponent;
}());

//# sourceMappingURL=coin-select.component.js.map

/***/ }),

/***/ 468:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return RechargeComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_paymentbox_paymentbox__ = __webpack_require__(97);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__pages_scan_scan__ = __webpack_require__(66);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__pages_scancode_scancode__ = __webpack_require__(67);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};











var RechargeComponent = /** @class */ (function () {
    function RechargeComponent(navCtrl, navParams, walletManager, native, localStorage, modalCtrl, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.modalCtrl = modalCtrl;
        this.events = events;
        this.masterWalletId = "1";
        this.transfer = {
            toAddress: '',
            amount: '',
            memo: '',
            fee: 10000,
            payPassword: '',
            remark: '',
        };
        this.sidechain = {
            accounts: '',
            amounts: 0,
            index: 0,
            rate: 1,
        };
        this.balance = 0;
        this.feePerKb = 10000;
        this.SELA = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA;
        this.walletInfo = {};
        this.init();
    }
    RechargeComponent.prototype.init = function () {
        var _this = this;
        this.events.subscribe("address:update", function (address) {
            _this.sidechain.accounts = address;
        });
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var transferObj = this.navParams.data;
        this.walletInfo = transferObj["walletInfo"] || {};
        this.chianId = transferObj["chianId"];
        this.getGenesisAddress();
        this.initData();
    };
    RechargeComponent.prototype.rightHeader = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_9__pages_scan_scan__["a" /* ScanPage */], { "pageType": "1" });
    };
    RechargeComponent.prototype.initData = function () {
        var _this = this;
        this.walletManager.getBalance(this.masterWalletId, 'ELA', __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].total, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.native.info(data);
                _this.balance = data["success"];
            }
            else {
                _this.native.info(data);
            }
        });
    };
    RechargeComponent.prototype.onClick = function (type) {
        switch (type) {
            // case 1:
            //   this.Go(ContactListComponent);
            //   break;
            case 2:// 转账
                this.checkValue();
                break;
        }
    };
    RechargeComponent.prototype.checkValue = function () {
        var _this = this;
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.sidechain.accounts)) {
            this.native.toast_trans('correct-address');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.transfer.amount)) {
            this.native.toast_trans('amount-null');
            return;
        }
        if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].number(this.transfer.amount)) {
            this.native.toast_trans('correct-amount');
            return;
        }
        if (this.transfer.amount <= 0) {
            this.native.toast_trans('correct-amount');
            return;
        }
        if (this.transfer.amount > this.balance) {
            this.native.toast_trans('error-amount');
            return;
        }
        if (this.transfer.amount.toString().indexOf(".") > -1 && this.transfer.amount.toString().split(".")[1].length > 8) {
            this.native.toast_trans('correct-amount');
            return;
        }
        this.walletManager.isAddressValid(this.masterWalletId, this.sidechain.accounts, function (data) {
            if (!data['success']) {
                _this.native.toast_trans("contact-address-digits");
                return;
            }
            _this.native.showLoading().then(function () {
                _this.createDepositTransaction();
            });
        });
    };
    RechargeComponent.prototype.createDepositTransaction = function () {
        var _this = this;
        var toAmount = 0;
        //toAmount = parseFloat((this.transfer.amount*Config.SELA).toPrecision(16));
        toAmount = this.accMul(this.transfer.amount, __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA);
        var sidechainAddress = this.sidechain.accounts;
        this.walletManager.createDepositTransaction(this.masterWalletId, 'ELA', "", this.transfer.toAddress, // genesisAddress
        toAmount, // user input amount
        sidechainAddress, // user input address
        this.transfer.memo, this.transfer.remark, false, function (data) {
            if (data['success']) {
                _this.native.info(data);
                _this.rawTransaction = data['success'];
                _this.getFee();
            }
            else {
                _this.native.info(data);
            }
        });
    };
    RechargeComponent.prototype.getGenesisAddress = function () {
        var _this = this;
        this.walletManager.getGenesisAddress(this.masterWalletId, this.chianId, function (data) {
            _this.transfer.toAddress = data['success'];
        });
    };
    RechargeComponent.prototype.getFee = function () {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, 'ELA', this.rawTransaction, this.feePerKb, function (data) {
            if (data['success']) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.transfer.fee = data['success'];
                _this.transfer.rate = _this.sidechain.rate;
                _this.openPayModal(_this.transfer);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    RechargeComponent.prototype.sendRawTransaction = function () {
        this.updateTxFee();
    };
    RechargeComponent.prototype.updateTxFee = function () {
        var _this = this;
        this.walletManager.updateTransactionFee(this.masterWalletId, 'ELA', this.rawTransaction, this.transfer.fee, "", function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Multi-Sign" && _this.walletInfo["InnerType"] === "Readonly") {
                    _this.readWallet(data["success"]);
                    return;
                }
                _this.singTx(data["success"]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    RechargeComponent.prototype.singTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.signTransaction(this.masterWalletId, 'ELA', rawTransaction, this.transfer.payPassword, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Standard") {
                    _this.sendTx(data["success"]);
                }
                else if (_this.walletInfo["Type"] === "Multi-Sign") {
                    _this.walletManager.encodeTransactionToString(data["success"], function (raw) {
                        if (raw["success"]) {
                            _this.native.hideLoading();
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": 'ELA', "fee": _this.transfer.fee / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
                        }
                        else {
                            _this.native.info(raw);
                        }
                    });
                }
            }
            else {
                _this.native.info(data);
            }
        });
    };
    RechargeComponent.prototype.sendTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.publishTransaction(this.masterWalletId, 'ELA', rawTransaction, function (data) {
            if (data["success"]) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_1__tabs_tabs_component__["a" /* TabsComponent */]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    RechargeComponent.prototype.openPayModal = function (data) {
        var _this = this;
        var transfer = this.native.clone(data);
        transfer["accounts"] = this.sidechain.accounts;
        var modal = this.modalCtrl.create(__WEBPACK_IMPORTED_MODULE_5__pages_paymentbox_paymentbox__["a" /* PaymentboxPage */], transfer);
        modal.onDidDismiss(function (data) {
            if (data) {
                _this.native.showLoading().then(function () {
                    _this.transfer = _this.native.clone(data);
                    _this.sendRawTransaction();
                });
            }
        });
        modal.present();
    };
    RechargeComponent.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": 'ELA', "fee": _this.transfer.fee / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
            else {
                alert("=====encodeTransactionToString===error===" + JSON.stringify(raw));
            }
        });
    };
    RechargeComponent.prototype.accMul = function (arg1, arg2) {
        var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
        try {
            m += s1.split(".")[1].length;
        }
        catch (e) { }
        try {
            m += s2.split(".")[1].length;
        }
        catch (e) { }
        return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
    };
    RechargeComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-recharge',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/recharge/recharge.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-recharge\' | translate}}</ion-title>\n        <ion-buttons end>\n            <button ion-button icon-only (click)="rightHeader()">\n            <img src="assets/images/icon/ico-scan.svg" style="width: 40px;height:30px">\n            </button>\n        </ion-buttons>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <ion-grid class="margin-top:10px">\n        <ion-row>\n            <ion-col col-12 class="font-size-1" col-auto>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{ \'text-recharge-address\' | translate}}" [(ngModel)]="sidechain.accounts"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n        <ion-row>\n            <ion-col col-4 align-self-center class="font-size-1">\n                <ion-item>\n                    <ion-input type="text" placeholder="{{ \'text-price\' | translate}}" [(ngModel)]="transfer.amount" col-auto></ion-input>\n                </ion-item>\n            </ion-col>\n            <ion-col col-8 align-self-center class="text-right font-size-1">\n                {{\'text-balance\' | translate}}：{{balance/SELA}}({{\'text-rate\' | translate}}：1:{{this.sidechain.rate}})\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-12 align-self-center class="text-right font-size-1">\n                <ion-item>\n                    <textarea placeholder="{{ \'text-remark\' | translate}}" rows="3" [(ngModel)]="transfer.remark" maxlength="20"></textarea>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button style="width: 100%" (click)="onClick(2)">{{ \'text-transfer\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/recharge/recharge.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */],
            __WEBPACK_IMPORTED_MODULE_7__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["j" /* ModalController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */]])
    ], RechargeComponent);
    return RechargeComponent;
}());

//# sourceMappingURL=recharge.component.js.map

/***/ }),

/***/ 469:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return WithdrawComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_paymentbox_paymentbox__ = __webpack_require__(97);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__pages_scan_scan__ = __webpack_require__(66);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__pages_scancode_scancode__ = __webpack_require__(67);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};











var WithdrawComponent = /** @class */ (function () {
    function WithdrawComponent(navCtrl, navParams, walletManager, native, localStorage, modalCtrl, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.modalCtrl = modalCtrl;
        this.events = events;
        this.masterWalletId = "1";
        this.transfer = {
            toAddress: '',
            amount: '',
            memo: '',
            fee: 10000,
            payPassword: '',
            remark: '',
        };
        this.mainchain = {
            accounts: '',
            amounts: 0,
            index: 0,
            rate: 1,
        };
        this.balance = 0;
        this.feePerKb = 10000;
        this.SELA = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA;
        this.walletInfo = {};
        this.init();
    }
    WithdrawComponent.prototype.init = function () {
        var _this = this;
        this.events.subscribe("address:update", function (address) {
            _this.mainchain.accounts = address;
        });
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var transferObj = this.navParams.data;
        this.chianId = transferObj["chianId"];
        this.walletInfo = transferObj["walletInfo"];
        this.initData();
    };
    WithdrawComponent.prototype.rightHeader = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_9__pages_scan_scan__["a" /* ScanPage */], { "pageType": "1" });
    };
    WithdrawComponent.prototype.initData = function () {
        var _this = this;
        this.walletManager.getBalance(this.masterWalletId, this.chianId, __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].total, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.native.info(data);
                _this.balance = data["success"];
            }
            else {
                _this.native.info(data);
            }
        });
    };
    WithdrawComponent.prototype.onClick = function (type) {
        switch (type) {
            // case 1:
            //   this.Go(ContactListComponent);
            //   break;
            case 2:// 转账
                this.checkValue();
                break;
        }
    };
    WithdrawComponent.prototype.checkValue = function () {
        var _this = this;
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.mainchain.accounts)) {
            this.native.toast_trans('correct-address');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.transfer.amount)) {
            this.native.toast_trans('amount-null');
            return;
        }
        if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].number(this.transfer.amount)) {
            this.native.toast_trans('correct-amount');
            return;
        }
        if (this.transfer.amount <= 0) {
            this.native.toast_trans('correct-amount');
            return;
        }
        if (this.transfer.amount > this.balance) {
            this.native.toast_trans('error-amount');
            return;
        }
        if (this.transfer.amount.toString().indexOf(".") > -1 && this.transfer.amount.toString().split(".")[1].length > 8) {
            this.native.toast_trans('correct-amount');
            return;
        }
        this.walletManager.isAddressValid(this.masterWalletId, this.mainchain.accounts, function (data) {
            if (!data['success']) {
                _this.native.toast_trans("contact-address-digits");
                return;
            }
            _this.native.showLoading().then(function () {
                _this.createWithdrawTransaction();
            });
        });
    };
    WithdrawComponent.prototype.createWithdrawTransaction = function () {
        var _this = this;
        var toAmount = 0;
        //toAmount = parseFloat((this.transfer.amount*Config.SELA).toPrecision(16));
        toAmount = this.accMul(this.transfer.amount, __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA);
        var mainchainAddress = this.mainchain.accounts;
        this.walletManager.createWithdrawTransaction(this.masterWalletId, this.chianId, "", toAmount, // user input amount
        mainchainAddress, // user input address
        this.transfer.memo, this.transfer.remark, function (data) {
            if (data['success']) {
                _this.native.info(data);
                _this.rawTransaction = data['success'];
                _this.getFee();
            }
            else {
                _this.native.info(data);
            }
        });
    };
    WithdrawComponent.prototype.getFee = function () {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.feePerKb, function (data) {
            if (data['success']) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.transfer.fee = data['success'];
                _this.transfer.rate = _this.mainchain.rate;
                //let transfer = this.native.clone(this.transfer);
                _this.openPayModal(_this.transfer);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    // getRate(){
    //   this.sidechain.rate = 1;
    // }
    WithdrawComponent.prototype.sendRawTransaction = function () {
        this.updateTxFee();
    };
    WithdrawComponent.prototype.updateTxFee = function () {
        var _this = this;
        this.walletManager.updateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.transfer.fee, "", function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Multi-Sign" && _this.walletInfo["InnerType"] === "Readonly") {
                    _this.readWallet(data["success"]);
                    return;
                }
                _this.singTx(data["success"]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    WithdrawComponent.prototype.singTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.signTransaction(this.masterWalletId, this.chianId, rawTransaction, this.transfer.payPassword, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Standard") {
                    _this.sendTx(data["success"]);
                }
                else if (_this.walletInfo["Type"] === "Multi-Sign") {
                    _this.walletManager.encodeTransactionToString(data["success"], function (raw) {
                        if (raw["success"]) {
                            _this.native.hideLoading();
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.chianId, "fee": _this.transfer.fee / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
                        }
                        else {
                            _this.native.info(raw);
                        }
                    });
                }
            }
            else {
                _this.native.info(data);
            }
        });
    };
    WithdrawComponent.prototype.sendTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.publishTransaction(this.masterWalletId, this.chianId, rawTransaction, function (data) {
            if (data["success"]) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_1__tabs_tabs_component__["a" /* TabsComponent */]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    WithdrawComponent.prototype.openPayModal = function (data) {
        var _this = this;
        var transfer = this.native.clone(data);
        transfer["accounts"] = this.mainchain.accounts;
        //this.transfer["rate"] = this.mainchain.rate;
        var modal = this.modalCtrl.create(__WEBPACK_IMPORTED_MODULE_5__pages_paymentbox_paymentbox__["a" /* PaymentboxPage */], transfer);
        modal.onDidDismiss(function (data) {
            if (data) {
                _this.native.showLoading().then(function () {
                    _this.transfer = data;
                    _this.sendRawTransaction();
                });
            }
        });
        modal.present();
    };
    WithdrawComponent.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.chianId, "fee": _this.transfer.fee / __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
            else {
                alert("=====encodeTransactionToString===error===" + JSON.stringify(raw));
            }
        });
    };
    WithdrawComponent.prototype.accMul = function (arg1, arg2) {
        var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
        try {
            m += s1.split(".")[1].length;
        }
        catch (e) { }
        try {
            m += s2.split(".")[1].length;
        }
        catch (e) { }
        return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
    };
    WithdrawComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-withdraw',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/withdraw/withdraw.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-withdraw\' | translate}}</ion-title>\n        <ion-buttons end>\n            <button ion-button icon-only (click)="rightHeader()">\n            <img src="assets/images/icon/ico-scan.svg" style="width: 40px;height:30px">\n            </button>\n        </ion-buttons>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <ion-grid class="margin-top:10px">\n        <ion-row>\n            <ion-col col-12 class="font-size-1" col-auto>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{ \'text-withdraw-address\' | translate}}" [(ngModel)]="mainchain.accounts"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n        <ion-row>\n            <ion-col col-4 align-self-center class="font-size-1">\n                <ion-item>\n                    <ion-input type="text" placeholder="{{ \'text-price\' | translate}}" [(ngModel)]="transfer.amount" col-auto></ion-input>\n                </ion-item>\n            </ion-col>\n            <ion-col col-8 align-self-center class="text-right font-size-1">\n                {{\'text-balance\' | translate}}：{{balance/SELA}}({{\'text-rate\' | translate}}：1:{{this.mainchain.rate}})\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-12 align-self-center class="text-right font-size-1">\n                <ion-item>\n                    <textarea placeholder="{{ \'text-remark\' | translate}}" rows="3" [(ngModel)]="transfer.remark" maxlength="20"></textarea>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <button ion-button style="width: 100%" (click)="onClick(2)">{{ \'text-transfer\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/withdraw/withdraw.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */],
            __WEBPACK_IMPORTED_MODULE_7__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_8__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["j" /* ModalController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */]])
    ], WithdrawComponent);
    return WithdrawComponent;
}());

//# sourceMappingURL=withdraw.component.js.map

/***/ }),

/***/ 470:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ReceiveComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__wallet_address_address_component__ = __webpack_require__(471);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};







var ReceiveComponent = /** @class */ (function () {
    function ReceiveComponent(navCtrl, navParams, walletManager, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.masterWalletId = "1";
        this.qrcode = null;
        this.init();
    }
    ReceiveComponent.prototype.init = function () {
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.chinaId = this.navParams.get("chianId");
        this.createAddress();
    };
    ReceiveComponent.prototype.onChange = function () {
        if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].number(this.amount)) {
            this.native.toast_trans('correct-amount');
        }
    };
    ReceiveComponent.prototype.onNext = function (type) {
        switch (type) {
            case 0:
                this.native.copyClipboard(this.qrcode);
                this.native.toast_trans('copy-ok');
                break;
            case 1:
                this.createAddress();
                break;
            case 2:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__wallet_address_address_component__["a" /* AddressComponent */], { chinaId: this.chinaId });
                break;
        }
    };
    ReceiveComponent.prototype.createAddress = function () {
        var _this = this;
        this.walletManager.createAddress(this.masterWalletId, this.chinaId, function (data) {
            if (data["success"]) {
                _this.qrcode = data["success"];
                _this.address = data["success"];
            }
            else {
                alert("===createAddress===error" + JSON.stringify(data));
            }
        });
    };
    ReceiveComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-receive',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/receive/receive.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-receive\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <div class="receive-box">\n        <qrcode class="receive-qrocde" [qrdata]="qrcode" [size]="200" [level]="\'M\'"></qrcode>\n        <p class="receive-address" (click)="onNext(0)" style="font-size: 1.2em;">{{address}} <img src="./assets/images/icon/icon-copy.svg"></p>\n        <div class="recevie-bottom" (click)="onNext(2)">\n            <p style="font-size: 1.6em;">{{ \'text-manager-address\' | translate }}</p>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/receive/receive.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_4_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */]])
    ], ReceiveComponent);
    return ReceiveComponent;
}());

//# sourceMappingURL=receive.component.js.map

/***/ }),

/***/ 471:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AddressComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var AddressComponent = /** @class */ (function () {
    function AddressComponent(navCtrl, navParams, walletManager, events, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.events = events;
        this.native = native;
        this.masterWalletId = "1";
        this.addrList = [];
        this.pageNo = 0;
        this.start = 0;
        this.init();
    }
    AddressComponent.prototype.init = function () {
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_1__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.chinaId = this.navParams.get("chinaId");
        this.getAddressList();
    };
    AddressComponent.prototype.getAddressList = function () {
        var _this = this;
        this.walletManager.getAllAddress(this.masterWalletId, this.chinaId, this.start, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var address = JSON.parse(data["success"])['Addresses'];
                _this.MaxCount = JSON.parse(data["success"])['MaxCount'];
                if (!address) {
                    _this.infinites.enable(false);
                    return;
                }
                if (_this.pageNo != 0) {
                    _this.addrList = _this.addrList.concat(JSON.parse(data["success"])['Addresses']);
                }
                else {
                    _this.addrList = JSON.parse(data["success"])['Addresses'];
                }
            }
            else {
                alert("==getAllAddress==error" + JSON.stringify(data));
            }
        });
    };
    AddressComponent.prototype.onItem = function (item) {
        this.native.copyClipboard(item);
        this.native.toast_trans('copy-ok');
    };
    // doRefresh(refresher){
    //    this.pageNo = 0;
    //    this.start = 0;
    //    this.getAddressList();
    //    setTimeout(() => {
    //     refresher.complete();
    //     //toast提示
    //     this.native.toast("加载成功");
    // },2000);
    // }
    AddressComponent.prototype.doInfinite = function (infiniteScroll) {
        var _this = this;
        this.infinites = infiniteScroll;
        setTimeout(function () {
            _this.pageNo++;
            _this.start = _this.pageNo * 20;
            if (_this.start >= _this.MaxCount) {
                _this.infinites.enable(false);
                return;
            }
            _this.getAddressList();
            infiniteScroll.complete();
        }, 500);
    };
    AddressComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-address',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/address/address.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-manager-address\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content style="width:100%">\n    <!-- <ion-refresher (ionRefresh)=\'doRefresh($event)\'>\n\n        <ion-refresher-content pullingIcon="arrow-dropdown" pullingText="下拉刷新" refreshingSpinner="circles" refreshingText="...">\n\n        </ion-refresher-content>\n\n    </ion-refresher> -->\n\n    <ion-list>\n        <ion-item *ngFor="let item of addrList" (click)="onItem(item)">\n            {{item}}\n        </ion-item>\n    </ion-list>\n\n    <ion-infinite-scroll (ionInfinite)="doInfinite($event)">\n        <ion-infinite-scroll-content loadingSpinner="bubbles" loadingText="{{\'load-more\'|translate}}">\n        </ion-infinite-scroll-content>\n    </ion-infinite-scroll>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/address/address.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_2_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */]])
    ], AddressComponent);
    return AddressComponent;
}());

//# sourceMappingURL=address.component.js.map

/***/ }),

/***/ 472:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return RecordinfoComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var RecordinfoComponent = /** @class */ (function () {
    function RecordinfoComponent(navCtrl, navParams, walletManager, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.masterWalletId = "1";
        this.transactionRecord = {};
        this.start = 0;
        this.payStatusIcon = "";
        this.blockchain_url = __WEBPACK_IMPORTED_MODULE_1__providers_Config__["a" /* Config */].BLOCKCHAIN_URL;
        this.jiajian = "";
        this.inputs = [];
        this.outputs = [];
        //this.init();
    }
    RecordinfoComponent.prototype.ionViewWillEnter = function () {
        this.init();
        // this.myInterval = setInterval(()=>{
        //     this.init();
        // },1000);
    };
    RecordinfoComponent.prototype.ionViewDidLeave = function () {
        // clearInterval(this.myInterval);
    };
    RecordinfoComponent.prototype.init = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_1__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var txId = this.navParams.get("txId");
        var chainId = this.navParams.get("chainId");
        this.walletManager.getAllTransaction(this.masterWalletId, chainId, this.start, txId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var allTransaction = JSON.parse(data['success']);
                var transactions = allTransaction['Transactions'];
                var transaction = transactions[0];
                _this.inputs = _this.objtoarr(transaction["Inputs"]);
                console.log("===this===" + JSON.stringify(_this.inputs));
                _this.outputs = _this.objtoarr(transaction["Outputs"]);
                console.log("===this===" + JSON.stringify(_this.outputs));
                var timestamp = transaction['Timestamp'] * 1000;
                var datetime = __WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].dateFormat(new Date(timestamp), 'yyyy-MM-dd HH:mm:ss');
                var status_1 = '';
                switch (transaction["Status"]) {
                    case 'Confirmed':
                        status_1 = 'Confirmed';
                        break;
                    case 'Pending':
                        status_1 = 'Pending';
                        break;
                    case 'Unconfirmed':
                        status_1 = 'Unconfirmed';
                        break;
                }
                var vtype = "";
                switch (transaction["Type"]) {
                    case 0:
                        vtype = "transaction-type-0";
                        break;
                    case 1:
                        vtype = "transaction-type-1";
                        break;
                    case 2:
                        vtype = "transaction-type-2";
                        break;
                    case 3:
                        vtype = "transaction-type-3";
                        break;
                    case 4:
                        vtype = "transaction-type-4";
                        break;
                    case 5:
                        vtype = "transaction-type-5";
                        break;
                    case 6:
                        vtype = "transaction-type-6";
                        break;
                    case 7:
                        vtype = "transaction-type-7";
                        break;
                    case 8:
                        vtype = "transaction-type-8";
                        break;
                    case 9:
                        vtype = "transaction-type-9";
                        break;
                    case 10:
                        vtype = "transaction-type-10";
                        break;
                    case 11:
                        vtype = "transaction-type-11";
                        break;
                    case 12:
                        vtype = "transaction-type-12";
                        break;
                    default:
                        vtype = "transaction-type-13";
                }
                var payStatusIcon = transaction["Direction"];
                if (payStatusIcon === "Received") {
                    _this.payStatusIcon = './assets/images/tx-state/icon-tx-received-outline.svg';
                    _this.jiajian = "+";
                }
                else if (payStatusIcon === "Sent") {
                    _this.payStatusIcon = './assets/images/tx-state/icon-tx-sent.svg';
                    _this.jiajian = "-";
                }
                else if (payStatusIcon === "Moved") {
                    _this.payStatusIcon = './assets/images/tx-state/icon-tx-moved.svg';
                    _this.jiajian = "";
                }
                else if (payStatusIcon === "Deposit") {
                    _this.payStatusIcon = './assets/images/tx-state/icon-tx-moved.svg';
                    if (transaction["Amount"] > 0) {
                        _this.jiajian = "-";
                    }
                    else {
                        _this.jiajian = "";
                    }
                }
                _this.transactionRecord = {
                    name: chainId,
                    status: status_1,
                    resultAmount: __WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].scientificToNumber(transaction["Amount"] / __WEBPACK_IMPORTED_MODULE_1__providers_Config__["a" /* Config */].SELA),
                    txId: txId,
                    transactionTime: datetime,
                    timestamp: timestamp,
                    payfees: __WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].scientificToNumber(transaction['Fee'] / __WEBPACK_IMPORTED_MODULE_1__providers_Config__["a" /* Config */].SELA),
                    confirmCount: transaction["ConfirmStatus"],
                    remark: transaction["Remark"],
                    payType: vtype
                };
            }
            else {
                alert("======getAllTransaction====error" + JSON.stringify(data));
            }
        });
    };
    RecordinfoComponent.prototype.onNext = function (address) {
        this.native.copyClipboard(address);
        this.native.toast_trans('copy-ok');
    };
    RecordinfoComponent.prototype.tiaozhuan = function (txId) {
        self.location.href = this.blockchain_url + 'tx/' + txId;
    };
    RecordinfoComponent.prototype.doRefresh = function (refresher) {
        this.init();
        setTimeout(function () {
            refresher.complete();
        }, 1000);
    };
    RecordinfoComponent.prototype.objtoarr = function (obj) {
        var arr = [];
        if (obj) {
            for (var i in obj) {
                if (arr.length < 3)
                    arr.push({ "address": i, "balance": obj[i] / __WEBPACK_IMPORTED_MODULE_1__providers_Config__["a" /* Config */].SELA });
            }
            if (arr.length > 2) {
                arr.push({ "address": "...........", "balance": "............." });
                return arr;
            }
        }
        return arr;
    };
    RecordinfoComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-recordinfo',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/recordinfo/recordinfo.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-record\'|translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n\n    <ion-refresher (ionRefresh)="doRefresh($event)">\n        <ion-refresher-content pullingIcon="arrow-dropdown" pullingText="" refreshingSpinner="circles" refreshingText="">\n        </ion-refresher-content>\n        <ion-refresher-content>\n        </ion-refresher-content>\n    </ion-refresher>\n\n\n    <div class="recordinfo-top">\n        <img src={{payStatusIcon}} />\n        <p>{{transactionRecord.status | translate}}</p>\n    </div>\n\n    <ion-grid>\n        <ion-row class="font-size-1">\n            <ion-col col-4>\n                {{\'transaction-price\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="text-right">\n                {{jiajian}} {{transactionRecord.resultAmount}} {{transactionRecord.name}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col col-4 *ngIf="inputs.length>0">\n                {{"Inputs"|translate}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row *ngFor="let item of inputs; let i = index">\n            <ion-col col col-12 *ngIf="i<3" (click)="onNext(item[\'address\'])">\n                {{item["address"]}}\n            </ion-col>\n            <ion-col col col-12 class="text-right" *ngIf="i<3">\n                {{item["balance"]}}{{transactionRecord.name}}\n            </ion-col>\n\n            <ion-col col-12 *ngIf="i===3">\n                {{item["address"]}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col col-4>\n                {{"Outputs"|translate}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row *ngFor="let item of outputs; let i = index">\n            <ion-col col col-12 *ngIf="i<3" (click)="onNext(item[\'address\'])">\n                {{item["address"]}}\n            </ion-col>\n            <ion-col col col-12 class="text-right" *ngIf="i<3">\n                {{item["balance"]}}{{transactionRecord.name}}\n            </ion-col>\n\n            <ion-col col-12 *ngIf="i===3">\n                {{item["address"]}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="font-size-1">\n            <ion-col col-4>\n                {{\'transaction-id\' | translate}}\n            </ion-col>\n            <ion-col col-8 (click)="tiaozhuan(transactionRecord.txId)">\n                <a href="#">{{transactionRecord.txId}}</a>\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="font-size-1">\n            <ion-col col-4>\n                {{\'transaction-time\' | translate}}\n            </ion-col>\n            <ion-col col-8 *ngIf="transactionRecord.timestamp!=\'0\'" class="text-right">\n                {{transactionRecord.transactionTime}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="row" class="font-size-1" *ngIf="transactionRecord.payfees > 0">\n            <ion-col col-4>\n                {{\'text-fees\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="text-right">\n                {{transactionRecord.payfees}}\n            </ion-col>\n        </ion-row>\n\n\n        <ion-row class="row" class="font-size-1">\n            <ion-col col-4>\n                {{\'confirm-count\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="text-right">\n                {{transactionRecord.confirmCount}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="row" class="font-size-1">\n            <ion-col col-4>\n                {{\'transaction-type\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="text-right">\n                {{transactionRecord.payType|translate}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="row" class="font-size-1">\n            <ion-col col-4>\n                {{\'text-remark\' | translate}}\n            </ion-col>\n            <ion-col col-8 class="text-right">\n                {{transactionRecord.remark}}\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/recordinfo/recordinfo.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_3_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_3_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_5__providers_Native__["a" /* Native */]])
    ], RecordinfoComponent);
    return RecordinfoComponent;
}());

//# sourceMappingURL=recordinfo.component.js.map

/***/ }),

/***/ 473:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CoinListComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Config__ = __webpack_require__(11);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var CoinListComponent = /** @class */ (function () {
    function CoinListComponent(navCtrl, navParams, walletManager, native, localStorage, modalCtrl, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.modalCtrl = modalCtrl;
        this.events = events;
        this.masterWalletId = "1";
        this.coinList = [];
        this.coinListCache = {};
        this.payPassword = "";
        this.singleAddress = false;
        this.init();
    }
    CoinListComponent.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.navBar.backButtonClick = function (e) {
            _this.navCtrl.pop();
        };
    };
    CoinListComponent.prototype.onSelect = function (item) {
        var _this = this;
        this.native.info(item);
        if (item.open) {
            this.currentCoin = item;
            this.native.showLoading().then(function () {
                _this.createSubWallet();
            });
        }
        else {
            this.native.showLoading().then(function () {
                _this.walletManager.destroySubWallet(_this.masterWalletId, item.name, function (data) {
                    if (data['success']) {
                        _this.native.hideLoading();
                        __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setResregister(_this.masterWalletId, item.name, false);
                        var subWallte = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getSubWallet(_this.masterWalletId);
                        delete (subWallte[item.name]);
                        var walletObj_1 = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].masterWallObj);
                        walletObj_1["id"] = _this.masterWalletId;
                        walletObj_1["wallname"] = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getWalletName(_this.masterWalletId);
                        walletObj_1["Account"] = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getAccountType(_this.masterWalletId);
                        walletObj_1["coinListCache"] = subWallte;
                        _this.localStorage.saveMappingTable(walletObj_1).then(function (data) {
                            var mappingList = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getMappingList());
                            mappingList[_this.masterWalletId] = walletObj_1;
                            _this.native.info(mappingList);
                            __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setMappingList(mappingList);
                        });
                    }
                });
            });
        }
    };
    CoinListComponent.prototype.init = function () {
        var _this = this;
        this.events.subscribe("error:update", function () {
            _this.currentCoin["open"] = false;
        });
        this.events.subscribe("error:destroySubWallet", function () {
            _this.currentCoin["open"] = true;
        });
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var subWallte = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getSubWallet(this.masterWalletId);
        this.walletManager.getSupportedChains(this.masterWalletId, function (data) {
            if (data['success']) {
                _this.native.info(data);
                _this.native.hideLoading();
                var allChains = data['success'];
                for (var index in allChains) {
                    var chain = allChains[index];
                    var isOpen = false;
                    if (subWallte) {
                        isOpen = chain in subWallte ? true : false;
                    }
                    if (chain == "ELA") {
                        isOpen = true;
                    }
                    _this.coinList.push({ name: chain, open: isOpen });
                }
            }
            else {
                _this.native.info(data);
            }
        });
        //});
    };
    CoinListComponent.prototype.createSubWallet = function () {
        var _this = this;
        // Sub Wallet IdChain
        var chainId = this.currentCoin["name"];
        this.walletManager.createSubWallet(this.masterWalletId, chainId, 0, function (data) {
            if (data['success']) {
                if (!__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].isResregister(_this.masterWalletId, chainId)) {
                    _this.registerWalletListener(_this.masterWalletId, chainId);
                }
                _this.native.hideLoading();
                var coin = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getSubWallet(_this.masterWalletId));
                if (coin) {
                    coin[chainId] = { id: chainId };
                }
                else {
                    coin = {};
                    coin[chainId] = { id: chainId };
                }
                var walletObj_2 = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].masterWallObj);
                walletObj_2["id"] = _this.masterWalletId;
                walletObj_2["wallname"] = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getWalletName(_this.masterWalletId);
                walletObj_2["Account"] = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getAccountType(_this.masterWalletId);
                walletObj_2["coinListCache"] = coin;
                _this.localStorage.saveMappingTable(walletObj_2).then(function (data) {
                    var mappingList = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getMappingList());
                    mappingList[_this.masterWalletId] = walletObj_2;
                    __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setMappingList(mappingList);
                });
            }
            else {
                _this.currentCoin["open"] = false;
                _this.native.info(data);
            }
        });
    };
    CoinListComponent.prototype.ionViewDidLeave = function () {
        this.events.unsubscribe("error:update");
        this.events.unsubscribe("error:destroySubWallet");
    };
    CoinListComponent.prototype.registerWalletListener = function (masterId, coin) {
        var _this = this;
        this.walletManager.registerWalletListener(masterId, coin, function (data) {
            //if(!Config.isResregister){
            __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setResregister(masterId, coin, true);
            //}
            _this.events.publish("register:update", masterId, coin, data);
        });
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["m" /* Navbar */])
    ], CoinListComponent.prototype, "navBar", void 0);
    CoinListComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-coin-list',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/coin-list/coin-list.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-coin-list\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <ion-list>\n        <ion-item *ngFor="let item of coinList">\n            <ion-label>{{item.name}}</ion-label>\n            <ion-toggle *ngIf="item.name!=\'ELA\'" [(ngModel)]="item.open" (ionChange)="onSelect(item)"></ion-toggle>\n        </ion-item>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/coin-list/coin-list.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */],
            __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["j" /* ModalController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */]])
    ], CoinListComponent);
    return CoinListComponent;
}());

//# sourceMappingURL=coin-list.component.js.map

/***/ }),

/***/ 474:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return WalltelistPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__launcher_launcher_component__ = __webpack_require__(121);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};








var WalltelistPage = /** @class */ (function () {
    function WalltelistPage(navCtrl, navParams, events, localStorage, native, zone, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.events = events;
        this.localStorage = localStorage;
        this.native = native;
        this.zone = zone;
        this.walletManager = walletManager;
        this.items = [];
        this.masterWalletId = "1";
        this.init();
    }
    WalltelistPage.prototype.ionViewDidLoad = function () {
    };
    WalltelistPage.prototype.init = function () {
        var _this = this;
        //this.items = Config.getMasterWalletIdList();
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var mappList = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getMappingList();
        this.native.info(mappList);
        this.zone.run(function () {
            _this.items = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].objtoarr(mappList);
        });
        this.native.info(this.items);
    };
    WalltelistPage.prototype.itemSelected = function (item) {
        this.native.info(item);
        var id = item["id"];
        __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].setCurMasterWalletId(id);
        this.getAllsubWallet(id);
    };
    WalltelistPage.prototype.saveId = function (id) {
        var _this = this;
        this.localStorage.saveCurMasterId({ masterId: id }).then(function (data) {
            _this.native.info(id);
            __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].setCurMasterWalletId(id);
            _this.masterWalletId = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getCurMasterWalletId();
            _this.navCtrl.pop();
            //this.events.publish("wallte:update",id);
        });
    };
    WalltelistPage.prototype.nextPage = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__launcher_launcher_component__["a" /* LauncherComponent */]);
    };
    WalltelistPage.prototype.registerWalletListener = function (masterId, coin) {
        var _this = this;
        this.walletManager.registerWalletListener(masterId, coin, function (data) {
            __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].setResregister(masterId, coin, true);
            _this.events.publish("register:update", masterId, coin, data);
        });
    };
    WalltelistPage.prototype.getAllsubWallet = function (masterId) {
        this.registerWalletListener(masterId, "ELA");
        var chinas = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getSubWallet(masterId);
        console.log("==========" + JSON.stringify(chinas));
        for (var chain in chinas) {
            this.registerWalletListener(masterId, chain);
        }
        this.saveId(masterId);
    };
    WalltelistPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-walltelist',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/walltelist/walltelist.html"*/'<!--\n  Generated template for the WalltelistPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-wallte-list\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content no-bounce>\n    <ion-list radio-group [(ngModel)]="masterWalletId">\n        <ion-item *ngFor="let item of items">\n            <ion-label>\n                <span style="font-size:16px">{{ item.wallname }}</span>\n                <span *ngIf="item[\'Account\'][\'Type\']===\'Standard\'">\n                    <br><span style="font-size:12px">{{\'text-standard-wallte\' | translate}}</span>\n                </span>\n                <span *ngIf="item[\'Account\'][\'Type\']===\'Multi-Sign\'">\n                    <br><span style="font-size:12px">{{\'text-multi-wallte\' | translate}}</span>\n                </span>\n            </ion-label>\n            <ion-radio (click)="itemSelected(item)" [value]="item.id"></ion-radio>\n        </ion-item>\n    </ion-list>\n</ion-content>\n\n<ion-footer>\n    <button ion-button full (click)="nextPage()">{{\'text-add-wallet\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/walltelist/walltelist.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_5__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */]])
    ], WalltelistPage);
    return WalltelistPage;
}());

//# sourceMappingURL=walltelist.js.map

/***/ }),

/***/ 475:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return MyComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__wallet_manager_manager_component__ = __webpack_require__(476);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__contacts_contact_list_contact_list_component__ = __webpack_require__(198);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__id_launcher_launcher__ = __webpack_require__(216);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__id_home_home__ = __webpack_require__(65);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_publickey_publickey__ = __webpack_require__(215);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12__pages_wallet_language_language__ = __webpack_require__(482);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_13__pages_scan_scan__ = __webpack_require__(66);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_14__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_15__pages_scancode_scancode__ = __webpack_require__(67);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_16__providers_ApiUrl__ = __webpack_require__(43);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};

















var MyComponent = /** @class */ (function () {
    function MyComponent(navCtrl, navParams, walletManager, events, native, localStorage, popupProvider, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.events = events;
        this.native = native;
        this.localStorage = localStorage;
        this.popupProvider = popupProvider;
        this.zone = zone;
        this.masterWalletId = "1";
        this.masterWalletType = "";
        this.readonly = "";
        this.currentLanguageName = "";
        this.isShowDeposit = false;
        this.fee = 0;
        this.feePerKb = 10000;
        this.walletInfo = {};
        this.passworld = "";
        this.available = 0;
        //this.init();
    }
    MyComponent.prototype.ionViewWillEnter = function () {
        this.init();
    };
    MyComponent.prototype.init = function () {
        var _this = this;
        this.localStorage.getLanguage("wallte-language").then(function (val) {
            _this.currentLanguageName = JSON.parse(val)["name"] || "";
            var lang = JSON.parse(val)["isoCode"] || "";
            if (lang == 'en') {
                _this.native.setMnemonicLang("english");
            }
            else if (lang == "zh") {
                _this.native.setMnemonicLang("chinese");
            }
            else {
                _this.native.setMnemonicLang("english");
            }
        });
        this.events.subscribe('language:update', function (item) {
            _this.currentLanguageName = item["name"] || "";
            var lang = item["isoCode"] || "";
            if (lang == 'en') {
                _this.native.setMnemonicLang("english");
            }
            else if (lang == "zh") {
                _this.native.setMnemonicLang("chinese");
            }
            else {
                _this.native.setMnemonicLang("english");
            }
        });
        this.events.subscribe("wallte:update", function (item) {
            _this.masterWalletId = item;
            _this.getMasterWalletBasicInfo();
        });
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.getAllMyTransaction();
        this.getMasterWalletBasicInfo();
    };
    MyComponent.prototype.getMasterWalletBasicInfo = function () {
        var _this = this;
        this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var item_1 = JSON.parse(data["success"])["Account"];
                _this.walletInfo = item_1;
                _this.zone.run(function () {
                    _this.masterWalletType = item_1["Type"];
                    _this.readonly = item_1["InnerType"] || "";
                });
            }
            else {
                _this.native.info(data);
            }
        });
    };
    MyComponent.prototype.onNext = function (type) {
        switch (type) {
            case 0:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__wallet_manager_manager_component__["a" /* ManagerComponent */]);
                break;
            case 1:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__pages_publickey_publickey__["a" /* PublickeyPage */]);
                break;
            case 2:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__contacts_contact_list_contact_list_component__["a" /* ContactListComponent */]);
                break;
            case 3:
                this.sendTX1();
                break;
            case 4:
                this.singTx1();
                break;
            case 6:
                this.getDIDList();
                break;
            case 5:
                this.setLanguage();
                break;
            case 7:
                this.getVoteNode();
                break;
            case 8:
                this.native.Go(this.navCtrl, 'AboutPage');
                break;
            case 9:
                this.getPublicKeyForVote();
                break;
        }
    };
    MyComponent.prototype.getDIDList = function () {
        var _this = this;
        this.localStorage.get("kycId").then(function (val) {
            if (__WEBPACK_IMPORTED_MODULE_11__providers_Util__["a" /* Util */].isNull(val)) {
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__id_launcher_launcher__["a" /* IdLauncherComponent */]);
                return;
            }
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__id_home_home__["a" /* IdHomeComponent */]);
        });
    };
    MyComponent.prototype.singTx1 = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_13__pages_scan_scan__["a" /* ScanPage */], { "pageType": "3" });
    };
    MyComponent.prototype.sendTX1 = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_13__pages_scan_scan__["a" /* ScanPage */], { "pageType": "4" });
    };
    MyComponent.prototype.ionViewDidLeave = function () {
        this.events.unsubscribe("wallte:update");
    };
    MyComponent.prototype.setLanguage = function () {
        var _this = this;
        this.localStorage.getLanguage("wallte-language").then(function (val) {
            var item = JSON.parse(val);
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_12__pages_wallet_language_language__["a" /* LanguagePage */], item);
        });
    };
    MyComponent.prototype.getVoteNode = function () {
        this.getRegisteredProducerInfo();
    };
    MyComponent.prototype.getRegisteredProducerInfo = function () {
        var _this = this;
        this.walletManager.getRegisteredProducerInfo(this.masterWalletId, "ELA", function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.native.info(data);
                var parms = JSON.parse((data["success"]));
                _this.native.Go(_this.navCtrl, 'SuperpointPage', parms);
            }
        });
    };
    MyComponent.prototype.createRetrieveDepositTransaction = function () {
        var _this = this;
        var amount = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].accMul(this.available, __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA) - 10000;
        this.walletManager.createRetrieveDepositTransaction(this.masterWalletId, "ELA", amount, "", "", function (data) {
            _this.native.info(data);
            var raw = data['success'];
            _this.getFee(raw);
        });
    };
    MyComponent.prototype.getAllMyTransaction = function () {
        var _this = this;
        this.walletManager.getAllMyTransaction(this.masterWalletId, "ELA", 0, "", function (data) {
            _this.native.info(data);
            if (data["success"]) {
                var transactions = JSON.parse(data["success"])["Transactions"] || [];
                var item = _this.getBackDeposit(transactions);
                if (item != -1) {
                    var type = item['Type'];
                    var height = item['Height'];
                    var confirms = parseInt(item['ConfirmStatus'].substring(0, 1));
                    _this.native.info(confirms);
                    var jianju = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getEstimatedHeight(_this.masterWalletId, "ELA") - height;
                    _this.native.info(jianju);
                    if (type === 10 && confirms > 1 && jianju >= 2160) {
                        _this.zone.run(function () {
                            _this.isShowDeposit = true;
                        });
                    }
                    else {
                        _this.zone.run(function () {
                            _this.isShowDeposit = false;
                        });
                    }
                }
                else {
                    _this.zone.run(function () {
                        _this.isShowDeposit = false;
                    });
                }
            }
        });
    };
    MyComponent.prototype.getBackDeposit = function (list) {
        for (var index = 0; index < list.length; index++) {
            var item = list[index];
            if (item["Type"] === 12) {
                return item;
            }
            if (item["Type"] === 10) {
                return item;
            }
        }
        return -1;
    };
    //计算手续费
    MyComponent.prototype.getFee = function (rawTransaction) {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, "ELA", rawTransaction, this.feePerKb, function (data) {
            if (data['success']) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.fee = data['success'];
                _this.popupProvider.presentConfirm1(_this.fee / __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA).then(function () {
                    _this.native.showLoading().then(function () {
                        _this.updateTxFee(rawTransaction);
                    });
                });
            }
        });
    };
    MyComponent.prototype.updateTxFee = function (rawTransaction) {
        var _this = this;
        this.walletManager.updateTransactionFee(this.masterWalletId, "ELA", rawTransaction, this.fee, "", function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Multi-Sign" && _this.walletInfo["InnerType"] === "Readonly") {
                    _this.readWallet(data["success"]);
                    return;
                }
                _this.singTx(data["success"]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    MyComponent.prototype.singTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.signTransaction(this.masterWalletId, "ELA", rawTransaction, this.passworld, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Standard") {
                    _this.sendTx(data["success"]);
                }
                else if (_this.walletInfo["Type"] === "Multi-Sign") {
                    _this.walletManager.encodeTransactionToString(data["success"], function (raw) {
                        if (raw["success"]) {
                            _this.native.hideLoading();
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_15__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": "ELA", "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
                        }
                        else {
                            _this.native.info(raw);
                        }
                    });
                }
            }
            else {
                _this.native.info(data);
            }
        });
    };
    MyComponent.prototype.sendTx = function (rawTransaction) {
        var _this = this;
        this.native.info(rawTransaction);
        this.walletManager.publishTransaction(this.masterWalletId, "ELA", rawTransaction, function (data) {
            if (data['success']) {
                _this.native.hideLoading();
                _this.native.toast_trans('send-raw-transaction');
            }
            else {
                _this.native.info(data);
            }
        });
    };
    MyComponent.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_15__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": "ELA", "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
        });
    };
    MyComponent.prototype.getdepositcoin = function (ownerpublickey) {
        var _this = this;
        var parms = { "ownerpublickey": ownerpublickey };
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_16__providers_ApiUrl__["a" /* ApiUrl */].getdepositcoin, parms).toPromise().then(function (data) {
            if (data["status"] === 200) {
                //this.native.info(data);
                var votesResult = JSON.parse(data["_body"]);
                _this.native.info(votesResult);
                if (votesResult["code"] === "0") {
                    //this.native.info(votesResult);
                    _this.available = votesResult["data"]["result"]["available"];
                    //this.native.info(this.available);
                    _this.getBackDepositcoin();
                }
            }
        });
    };
    MyComponent.prototype.getPublicKeyForVote = function () {
        var _this = this;
        this.walletManager.getPublicKeyForVote(this.masterWalletId, "ELA", function (data) {
            _this.native.info(data);
            if (data["success"]) {
                var publickey = data["success"];
                _this.native.info(publickey);
                _this.getdepositcoin(publickey);
            }
        });
    };
    MyComponent.prototype.getBackDepositcoin = function () {
        var _this = this;
        this.popupProvider.presentPrompt().then(function (val) {
            if (__WEBPACK_IMPORTED_MODULE_11__providers_Util__["a" /* Util */].isNull(val)) {
                _this.native.toast_trans("text-id-kyc-prompt-password");
                return;
            }
            _this.passworld = val.toString();
            _this.native.showLoading().then(function () {
                _this.createRetrieveDepositTransaction();
            });
            //this.native.Go(this.navCtrl,'JoinvotelistPage');
        }).catch(function () {
        });
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_7_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["m" /* Navbar */])
    ], MyComponent.prototype, "navBar", void 0);
    MyComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-my',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/tabs/my/my.component.html"*/'<ion-content no-bounce>\n    <div class="my-title">\n        <p style="font-size: 1.6em;">{{\'tab-setting\' | translate }}</p>\n    </div>\n    <ion-list>\n\n        <button ion-item (click)="onNext(5)">\n              <ion-label>\n                <span>{{\'text-language-message\' | translate}}</span>\n              </ion-label>\n              <ion-note *ngIf="currentLanguageName" item-end>\n                {{ currentLanguageName }}\n              </ion-note>\n        </button>\n\n        <button ion-item (click)="onNext(0)">\n          <ion-label>\n            <span>{{\'text-wallet-manager\' | translate }}</span>\n          </ion-label>\n        </button>\n\n        <button ion-item (click)="onNext(2)">\n          <ion-label>\n            <span>{{\'text-contacts\' | translate }}</span>\n          </ion-label>\n        </button>\n\n        <!-- <button *ngIf="!readonly" ion-item (click)="onNext(1)">\n          <ion-label>\n            <span>{{\'text-check-publickey\' | translate }}</span>\n          </ion-label>\n        </button> -->\n\n        <button *ngIf="masterWalletType === \'Multi-Sign\' && readonly!=\'Readonly\'" ion-item (click)="onNext(4)">\n          <ion-label>\n            <span>{{\'text-sing-tx\' | translate }}</span>\n          </ion-label>\n        </button>\n\n        <button *ngIf="masterWalletType === \'Multi-Sign\'" ion-item (click)="onNext(3)">\n          <ion-label>\n            <span>{{\'text-send-tx\' | translate }}</span>\n          </ion-label>\n        </button>\n\n        <!-- <button ion-item (click)="onNext(6)">\n          <ion-label>\n            <span>{{\'text-id-my\' | translate }}</span>\n          </ion-label>\n        </button>-->\n\n        <button ion-item (click)="onNext(7)">\n          <ion-label>\n            <span>{{\'my-vote\' | translate }}</span>\n          </ion-label>\n        </button>\n\n        <button ion-item (click)="onNext(8)">\n          <ion-label>\n            <span>{{\'about\' | translate }}</span>\n          </ion-label>\n        </button>\n\n        <ion-item *ngIf="isShowDeposit" (click)="onNext(9)">\n            <ion-label>\n                <span>{{\'take-back-deposit\' | translate }}</span>\n            </ion-label>\n        </ion-item>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/tabs/my/my.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_7_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_8__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_9__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_10__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_14__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], MyComponent);
    return MyComponent;
}());

//# sourceMappingURL=my.component.js.map

/***/ }),

/***/ 476:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ManagerComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__exprot_prikey_exprot_prikey_component__ = __webpack_require__(477);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__paypassword_reset_paypassword_reset_component__ = __webpack_require__(478);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__launcher_launcher_component__ = __webpack_require__(121);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__pages_modifywalletname_modifywalletname__ = __webpack_require__(479);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12__pages_publickey_publickey__ = __webpack_require__(215);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_13__pages_exportmnemomic_exportmnemomic__ = __webpack_require__(480);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};














var ManagerComponent = /** @class */ (function () {
    function ManagerComponent(navCtrl, navParams, events, localStorage, popupProvider, walletManager, app, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.events = events;
        this.localStorage = localStorage;
        this.popupProvider = popupProvider;
        this.walletManager = walletManager;
        this.app = app;
        this.native = native;
        this.walletName = "";
        this.masterWalletId = "1";
        this.currentLanguageName = "";
        this.readonly = "";
        this.masterWalletType = "";
        this.singleAddress = false;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walletName = __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
        this.getMasterWalletBasicInfo();
    }
    ManagerComponent.prototype.ionViewWillEnter = function () {
        this.walletName = __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
    };
    ManagerComponent.prototype.ionViewDidLeave = function () {
        //this.walletName = Config.getWalletName(this.masterWalletId);
    };
    ManagerComponent.prototype.onItem = function (i) {
        var _this = this;
        switch (i) {
            case 0:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__exprot_prikey_exprot_prikey_component__["a" /* ExprotPrikeyComponent */]);
                break;
            case 1:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_6__paypassword_reset_paypassword_reset_component__["a" /* PaypasswordResetComponent */]);
                break;
            case 2:
                this.popupProvider.ionicConfirm('confirmTitle', 'confirmSubTitle').then(function (data) {
                    if (data) {
                        _this.native.showLoading().then(function () {
                            _this.destroyWallet(_this.masterWalletId);
                        });
                    }
                });
                break;
            case 3:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_12__pages_publickey_publickey__["a" /* PublickeyPage */]);
                break;
            case 4:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_11__pages_modifywalletname_modifywalletname__["a" /* ModifywalletnamePage */]);
                break;
            case 5:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_13__pages_exportmnemomic_exportmnemomic__["a" /* ExportmnemomicPage */]);
                break;
        }
    };
    ManagerComponent.prototype.getAllCreatedSubWallets = function () {
        var _this = this;
        this.walletManager.getAllSubWallets(this.masterWalletId, function (data) {
            if (data["success"]) {
                var chinas = JSON.parse(data["success"]);
                var maxLen = chinas.length;
                for (var index in chinas) {
                    var chain = chinas[index];
                    _this.destroyWalletListener(index, maxLen, _this.masterWalletId, chain);
                }
            }
            else {
                _this.native.hideLoading();
                alert("==getAllSubWallets==error" + JSON.stringify(data));
            }
        });
    };
    ManagerComponent.prototype.destroyWalletListener = function (index, maxLen, masterWalletId, chainId) {
        var _this = this;
        this.walletManager.removeWalletListener(masterWalletId, chainId, function (data) {
            if (data["success"]) {
                if (parseInt(index) === (maxLen - 1)) {
                    _this.destroyWallet(masterWalletId);
                }
            }
            else {
                alert("==getAllSubWallets==error" + JSON.stringify(data));
            }
        });
    };
    ManagerComponent.prototype.destroyWallet = function (masterWalletId) {
        var _this = this;
        //this.localStorage.remove('coinListCache').then(()=>{
        this.walletManager.destroyWallet(masterWalletId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.delWalletListOne(masterWalletId);
            }
            else {
                _this.native.info(data);
            }
        });
        //});
    };
    ManagerComponent.prototype.delWalletListOne = function (masterWalletId) {
        this.native.info(masterWalletId);
        var arr = __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].getMasterWalletIdList();
        var index = arr.indexOf(masterWalletId);
        this.native.info(index);
        if (index > -1) {
            arr.splice(index, 1);
        }
        if (arr.length === 0) {
            this.saveWalletList1();
            return;
        }
        this.native.info(arr);
        __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].setCurMasterWalletId(arr[0]);
        //Config.setMasterWalletIdList(arr);
        var allmastwalle = this.native.clone(__WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].getMappingList());
        delete (allmastwalle[this.masterWalletId]);
        this.native.info(allmastwalle);
        __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].setMappingList(allmastwalle);
        this.saveWalletList(arr[0]);
    };
    ManagerComponent.prototype.saveWalletList = function (masterWalletId) {
        var _this = this;
        this.localStorage.saveCurMasterId({ masterId: masterWalletId }).then(function (data) {
            _this.native.hideLoading();
            __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].setCurMasterWalletId(masterWalletId);
            _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_10__tabs_tabs_component__["a" /* TabsComponent */]);
        });
    };
    ManagerComponent.prototype.saveWalletList1 = function () {
        this.native.hideLoading();
        __WEBPACK_IMPORTED_MODULE_9__providers_Config__["a" /* Config */].setMappingList({});
        this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_7__launcher_launcher_component__["a" /* LauncherComponent */]);
    };
    ManagerComponent.prototype.getMasterWalletBasicInfo = function () {
        var _this = this;
        this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var item = JSON.parse(data["success"])["Account"];
                _this.masterWalletType = item["Type"];
                _this.singleAddress = item["SingleAddress"];
                _this.readonly = item["InnerType"] || "";
            }
            else {
                _this.native.info(data);
            }
        });
    };
    ManagerComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-manager',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/manager/manager.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-wallet-manager\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n    <ion-list>\n        <button ion-item (click)="onItem(4)">\n      <ion-icon item-start>\n        <img src="assets/images/icon-wallet.svg" width="22">\n      </ion-icon>\n      <ion-label>\n        <span>{{\'wallet-name\' | translate}}</span>\n      </ion-label>\n      <ion-note *ngIf="walletName" item-end>\n        {{ walletName }}\n      </ion-note>\n    </button>\n\n        <button ion-item (click)="onItem(3)" *ngIf="singleAddress && !readonly">\n      <ion-icon item-start>\n        <img src="assets/images/icon-language.svg" width="22">\n      </ion-icon>\n      <ion-label>\n        <span>{{\'text-check-publickey\' | translate }}</span>\n      </ion-label>\n    </button>\n\n        <button ion-item (click)="onItem(0)">\n      <ion-icon item-start>\n        <img src=" assets/images/icon-export.svg " width="22 ">\n      </ion-icon>\n      <ion-label>\n        <span>{{\'wallet-export\' | translate}}</span>\n      </ion-label>\n    </button>\n\n        <button ion-item (click)="onItem(5)" *ngIf="readonly!=\'Readonly\'&&readonly!=\'simple\'">\n        <ion-icon item-start>\n          <img src=" assets/images/icon-export.svg " width="22 ">\n        </ion-icon>\n        <ion-label>\n          <span>{{\'text-export-mnemomic\' | translate}}</span>\n        </ion-label>\n      </button>\n\n        <button ion-item (click)="onItem(1)" *ngIf="readonly!=\'Readonly\'">\n      <ion-icon item-start>\n        <img src=" assets/images/icon-aletr.svg " width="22 ">\n      </ion-icon>\n      <ion-label>\n        <span>{{\'wallet-password-reset\' | translate}}</span>\n      </ion-label>\n    </button>\n\n        <!-- <button ion-item (click)="onItem(2)">\n      <ion-icon item-start>\n        <img src=" assets/images/icon-del.svg " width="22 ">\n      </ion-icon>\n      <ion-label>\n        <span style="color:#ff0000">{{\'wallet-delete\' | translate}}</span>\n      </ion-label>\n    </button> -->\n\n        <ion-item (click)="onItem(2)">\n            <ion-icon item-start>\n                <img src=" assets/images/icon-del.svg " width="22 ">\n            </ion-icon>\n            <ion-label>\n                <span style="color:#ff0000">{{\'wallet-delete\' | translate}}</span>\n            </ion-label>\n        </ion-item>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/manager/manager.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_2__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_3__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_4__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["b" /* App */], __WEBPACK_IMPORTED_MODULE_8__providers_Native__["a" /* Native */]])
    ], ManagerComponent);
    return ManagerComponent;
}());

//# sourceMappingURL=manager.component.js.map

/***/ }),

/***/ 477:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ExprotPrikeyComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__ = __webpack_require__(9);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};







var ExprotPrikeyComponent = /** @class */ (function () {
    function ExprotPrikeyComponent(navCtrl, navParams, walletManager, native, localStorage) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.masterWalletId = "1";
        this.readonly = "";
        this.masterWalletType = "";
        this.singleAddress = false;
        this.exprotObj = {
            name: '',
            backupPassWord: '',
            reBackupPassWord: '',
            payPassword: ''
        };
        this.account = {};
        this.onWalletDatainit();
    }
    ExprotPrikeyComponent.prototype.onWalletDatainit = function () {
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.exprotObj.name = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
        this.account = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getAccountType(this.masterWalletId);
        this.getMasterWalletBasicInfo();
    };
    ExprotPrikeyComponent.prototype.checkparms = function () {
        if (__WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].isNull(this.exprotObj.backupPassWord)) {
            this.native.toast_trans("text-wallet-pwd");
            return false;
        }
        if (this.exprotObj.backupPassWord != this.exprotObj.reBackupPassWord) {
            this.native.toast_trans("text-passworld-compare");
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].isNull(this.exprotObj.payPassword) && (this.readonly != "Readonly")) {
            this.native.toast_trans("text-pay-passworld-input");
            return false;
        }
        if (this.readonly === "Readonly") {
            this.exprotObj.payPassword = "s12345678";
        }
        return true;
    };
    ExprotPrikeyComponent.prototype.onDown = function () {
        if (this.checkparms()) {
            this.onExport();
        }
    };
    ExprotPrikeyComponent.prototype.onExport = function () {
        var _this = this;
        this.walletManager.exportWalletWithKeystore(this.masterWalletId, this.exprotObj.backupPassWord, this.exprotObj.payPassword, function (data) {
            if (data["success"]) {
                _this.backupWalletPlainText = data["success"];
            }
        });
    };
    ExprotPrikeyComponent.prototype.onCopay = function () {
        var _this = this;
        this.native.copyClipboard(this.backupWalletPlainText).then(function () {
            _this.native.toast_trans('text-copied-to-clipboard');
        }).catch(function () {
        });
    };
    ExprotPrikeyComponent.prototype.getMasterWalletBasicInfo = function () {
        var _this = this;
        this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var item = JSON.parse(data["success"])["Account"];
                _this.masterWalletType = item["Type"];
                _this.singleAddress = item["SingleAddress"];
                _this.readonly = item["InnerType"] || "";
            }
        });
    };
    ExprotPrikeyComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-exprot-prikey',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/exprot-prikey/exprot-prikey.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-wallet-export\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <div class="coin-info-top-box">\n        <img src="./assets/images/logo-maincolor.svg">\n        <div style="font-size: 1.6em;">{{exprotObj.name}}\n            <span *ngIf="account[\'Type\']===\'Standard\'" style="font-size: 1.3px">{{\'text-standard-wallte\' | translate}}</span>\n            <span *ngIf="account[\'Type\']===\'Multi-Sign\'" style="font-size: 1.3px">{{\'text-multi-wallte\' | translate}}</span></div>\n    </div>\n    <div *ngIf="!backupWalletPlainText">\n        <ion-list>\n            <ion-item>\n                <ion-label stacked>{{\'exportwallet-keystorepassword1-title\' | translate }}</ion-label>\n                <ion-input type="password" placeholder="{{ \'exportwallet-keystorepassword1-placeholder\' | translate }}" [(ngModel)]="exprotObj.backupPassWord"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-input type="password" placeholder="{{ \'exportwallet-keystorepassword2-placeholder\' | translate }}" [(ngModel)]="exprotObj.reBackupPassWord"></ion-input>\n            </ion-item>\n            <ion-item *ngIf="readonly!=\'Readonly\'">\n                <ion-label stacked>{{\'unlock-paypassword-title\' | translate }}</ion-label>\n                <ion-input type="password" placeholder="{{ \'unlock-paypassword-placeholder\' | translate }}" [(ngModel)]="exprotObj.payPassword"></ion-input>\n            </ion-item>\n        </ion-list>\n    </div>\n\n    <div *ngIf="backupWalletPlainText" class="kuangTextArea">\n        <p>{{ \'text-keystroe-message\' | translate }} </p>\n        <textarea rows="10" class="backupWalletTextArea">{{backupWalletPlainText}}</textarea>\n    </div>\n\n</ion-content>\n<ion-footer>\n    <button *ngIf="!backupWalletPlainText" ion-button (click)="onDown()" full>{{ \'text-down\' | translate }}</button>\n    <button *ngIf="backupWalletPlainText" ion-button (click)="onCopay()" full>{{ \'text-copy-to-clipboard\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/exprot-prikey/exprot-prikey.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__["a" /* LocalStorage */]])
    ], ExprotPrikeyComponent);
    return ExprotPrikeyComponent;
}());

//# sourceMappingURL=exprot-prikey.component.js.map

/***/ }),

/***/ 478:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PaypasswordResetComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Config__ = __webpack_require__(11);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var PaypasswordResetComponent = /** @class */ (function () {
    function PaypasswordResetComponent(navCtrl, navParams, walletManager, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.masterWalletId = "1";
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getCurMasterWalletId();
    }
    PaypasswordResetComponent.prototype.onSubmit = function () {
        var _this = this;
        if (!__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].password(this.payPassword)) {
            this.native.toast_trans("text-pwd-validator");
            return;
        }
        if (this.payPassword != this.rePayPassword) {
            this.native.toast_trans("text-repwd-validator");
            return;
        }
        // reset pay password
        this.walletManager.changePassword(this.masterWalletId, this.oldPayPassword, this.payPassword, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.native.toast_trans("reset-pwd-success");
                _this.navCtrl.pop();
            }
            else {
                _this.native.info(data);
            }
        });
    };
    PaypasswordResetComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-paypassword-reset',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/paypassword-reset/paypassword-reset.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-wallet-info\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content no-bounce>\n    <ion-list>\n\n        <ion-item>\n            <ion-label stacked>{{ \'updatepaypassword-origin_paypassword1-title\' | translate }}</ion-label>\n            <ion-input type="password" placeholder="{{ \'updatepaypassword-origin_paypassword1-placeholder\' | translate }}" [(ngModel)]="oldPayPassword"></ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-label stacked>{{ \'updatepaypassword-paypassword1-title\' | translate }}</ion-label>\n            <ion-input type="password" placeholder="{{ \'updatepaypassword-paypassword1-placeholder\' | translate }}" [(ngModel)]="payPassword"></ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-input type="password" placeholder="{{ \'updatepaypassword-paypassword2-placeholder\' | translate }}" [(ngModel)]="rePayPassword"></ion-input>\n        </ion-item>\n\n    </ion-list>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="onSubmit()">{{ \'text-submit\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/paypassword-reset/paypassword-reset.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */]])
    ], PaypasswordResetComponent);
    return PaypasswordResetComponent;
}());

//# sourceMappingURL=paypassword-reset.component.js.map

/***/ }),

/***/ 479:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ModifywalletnamePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Localstorage__ = __webpack_require__(9);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






var ModifywalletnamePage = /** @class */ (function () {
    function ModifywalletnamePage(navCtrl, navParams, native, localStorage, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.walletname = "";
        this.masterWalletId = "1";
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walletname = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
    }
    ModifywalletnamePage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad ModifywalletnamePage');
    };
    ModifywalletnamePage.prototype.modify = function () {
        var _this = this;
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.walletname)) {
            this.native.toast_trans("text-wallet-name-validator");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWalletName(this.walletname)) {
            this.native.toast_trans("text-wallet-name-validator1");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWallNameExit(this.walletname)) {
            this.native.toast_trans("text-wallet-name-validator2");
            return;
        }
        this.native.showLoading().then(function () {
            _this.modifyName();
        });
    };
    ModifywalletnamePage.prototype.modifyName = function () {
        var _this = this;
        var walletObj = this.native.clone(__WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].masterWallObj);
        walletObj["id"] = this.masterWalletId;
        walletObj["Account"] = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getAccountType(this.masterWalletId);
        walletObj["wallname"] = this.walletname;
        var subWallte = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getSubWallet(this.masterWalletId);
        if (subWallte) {
            walletObj["coinListCache"] = subWallte;
        }
        this.localStorage.saveMappingTable(walletObj).then(function (data) {
            var mappingList = _this.native.clone(__WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getMappingList());
            mappingList[_this.masterWalletId] = walletObj;
            __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].setWalletName(_this.masterWalletId, _this.walletname);
            __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].setMappingList(mappingList);
            _this.native.hideLoading();
            _this.navCtrl.pop();
        });
    };
    ModifywalletnamePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-modifywalletname',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/modifywalletname/modifywalletname.html"*/'<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'modify-wallet-name\' | translate }}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n<ion-content padding>\n    <ion-list>\n        <ion-item>\n            <ion-input type="text" placeholder="" [(ngModel)]="walletname"></ion-input>\n        </ion-item>\n    </ion-list>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="modify()">{{ \'confirm\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/modifywalletname/modifywalletname.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */]])
    ], ModifywalletnamePage);
    return ModifywalletnamePage;
}());

//# sourceMappingURL=modifywalletname.js.map

/***/ }),

/***/ 480:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ExportmnemomicPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__pages_checkmnemomic_checkmnemomic__ = __webpack_require__(481);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};







/**
 * Generated class for the ExportmnemomicPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var ExportmnemomicPage = /** @class */ (function () {
    function ExportmnemomicPage(navCtrl, navParams, walletManager, native, events) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.events = events;
        this.payPassword = '';
        this.masterWalletId = "1";
        this.mnemonicList = [];
        this.isShow = true;
        this.mnemonicStr = "";
        this.walltename = "";
        this.account = {};
        this.init();
    }
    ExportmnemomicPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad ExportmnemomicPage');
    };
    ExportmnemomicPage.prototype.ionViewWillEnter = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walltename = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
        this.account = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getAccountType(this.masterWalletId);
        this.events.subscribe("error:update", function () {
            _this.isShow = true;
        });
    };
    ExportmnemomicPage.prototype.init = function () {
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walltename = __WEBPACK_IMPORTED_MODULE_3__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
    };
    ExportmnemomicPage.prototype.checkparms = function () {
        if (!__WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].password(this.payPassword)) {
            this.native.toast_trans("text-pwd-validator");
            return;
        }
        return true;
    };
    ExportmnemomicPage.prototype.onNext = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_6__pages_checkmnemomic_checkmnemomic__["a" /* CheckmnemomicPage */], { mnemonicStr: this.mnemonicStr, mnemonicList: this.mnemonicList });
    };
    ExportmnemomicPage.prototype.onExport = function () {
        var _this = this;
        if (this.checkparms()) {
            this.walletManager.exportWalletWithMnemonic(this.masterWalletId, this.payPassword, function (data) {
                _this.native.info(data);
                if (data["success"]) {
                    _this.mnemonicStr = data["success"].toString();
                    var mnemonicArr = _this.mnemonicStr.split(/[\u3000\s]+/);
                    for (var i = 0; i < mnemonicArr.length; i++) {
                        _this.mnemonicList.push({ "text": mnemonicArr[i], "selected": false });
                        //this.mnemonicList.push(mnemonicArr[i]);
                    }
                    _this.isShow = false;
                }
            });
        }
    };
    ExportmnemomicPage.prototype.ionViewDidLeave = function () {
        this.events.unsubscribe("error:update");
    };
    ExportmnemomicPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-exportmnemomic',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/exportmnemomic/exportmnemomic.html"*/'<!--\n  Generated template for the ExportmnemomicPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'text-export-mnemomic\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content>\n    <div class="coin-info-top-box">\n        <img src="./assets/images/logo-maincolor.svg">\n        <div style="font-size: 1.6em;">{{walltename}}\n            <span *ngIf="account[\'Type\']===\'Standard\'" style="font-size: 1.3px">{{\'text-standard-wallte\' | translate}}</span>\n            <span *ngIf="account[\'Type\']===\'Multi-Sign\'" style="font-size: 1.3px">{{\'text-multi-wallte\' | translate}}</span>\n        </div>\n    </div>\n    <ion-item *ngIf="isShow">\n        <ion-label stacked>{{\'unlock-paypassword-title\' | translate }}</ion-label>\n        <ion-input type="password" placeholder="{{ \'unlock-paypassword-placeholder\' | translate }}" [(ngModel)]="payPassword"></ion-input>\n    </ion-item>\n    <div class="mnemonic" *ngIf="!isShow">\n        <div class="slide-container">\n            <div class="slide-title">{{ \'text-mnemonic-prompt\' | translate}}</div>\n            <div class="slide-body">\n                <div class="phrase-container">\n                    <div class="phrase">\n                        <span *ngFor="let item of mnemonicList;let i=index">\n                      <span>{{item.text}}</span>\n                        </span>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n</ion-content>\n<ion-footer>\n    <button ion-button (click)="onExport()" full *ngIf="isShow">{{ \'text-export-mnemomic\' | translate }}</button>\n    <button ion-button (click)="onNext()" full *ngIf="!isShow">{{ \'text-memory\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/exportmnemomic/exportmnemomic.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */]])
    ], ExportmnemomicPage);
    return ExportmnemomicPage;
}());

//# sourceMappingURL=exportmnemomic.js.map

/***/ }),

/***/ 481:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CheckmnemomicPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};




/**
 * Generated class for the CheckmnemomicPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var CheckmnemomicPage = /** @class */ (function () {
    function CheckmnemomicPage(navCtrl, navParams, native, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.zone = zone;
        this.mnemonicList = [];
        this.selectList = [];
        this.selectComplete = false;
        this.init();
    }
    CheckmnemomicPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad CheckmnemomicPage');
    };
    CheckmnemomicPage.prototype.init = function () {
        this.mnemonicStr = this.native.clone(this.navParams.get("mnemonicStr"));
        this.mnemonicList = this.native.clone(this.navParams.get("mnemonicList")).sort(function () { return 0.5 - Math.random(); });
    };
    CheckmnemomicPage.prototype.addButton = function (index, item) {
        var _this = this;
        var newWord = {
            text: item.text,
            prevIndex: index
        };
        this.zone.run(function () {
            _this.selectList.push(newWord);
            _this.mnemonicList[index].selected = true;
            _this.shouldContinue();
        });
    };
    CheckmnemomicPage.prototype.removeButton = function (index, item) {
        var _this = this;
        this.zone.run(function () {
            _this.selectList.splice(index, 1);
            _this.mnemonicList[item.prevIndex].selected = false;
            _this.shouldContinue();
        });
    };
    CheckmnemomicPage.prototype.shouldContinue = function () {
        this.selectComplete = this.selectList.length === this.mnemonicList.length ? true : false;
        if (this.selectComplete) {
            var mn = "";
            for (var i = 0; i < this.selectList.length; i++) {
                mn += this.selectList[i].text;
            }
            if (!__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNull(mn) && mn == this.mnemonicStr.replace(/\s+/g, "")) {
                this.native.toast_trans('text-export-menmonic-sucess');
                this.navCtrl.popTo(this.navCtrl.getByIndex(this.navCtrl.length() - 3));
            }
            else {
                this.native.toast_trans('text-mnemonic-prompt3');
            }
        }
    };
    CheckmnemomicPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-checkmnemomic',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/checkmnemomic/checkmnemomic.html"*/'<!--\n  Generated template for the CheckmnemomicPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-mnemonic-check\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content>\n    <div class="mnemonic-write">\n\n        <div class="slide-container">\n            <div class="slide-body">\n                <div class="slide-title">{{\'text-mnemonic-prompt2\' | translate}}</div>\n                <div class="phrase-container">\n                    <div class="phrase">\n                        <button ion-button outline *ngFor="let item of selectList; let i = index" (click)="removeButton(i,item)" style="text-transform: none">{{item.text}}</button>\n                    </div>\n                </div>\n            </div>\n\n            <div class="bottom-phrase">\n                <div *ngIf="!selectComplete">\n                    <div class="words">\n                        <button ion-button outline *ngFor="let item of mnemonicList; let i = index" (click)="addButton(i, item)" [disabled]="item.selected" style="text-transform: none">{{item.text}}\n                    </button>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/checkmnemomic/checkmnemomic.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], CheckmnemomicPage);
    return CheckmnemomicPage;
}());

//# sourceMappingURL=checkmnemomic.js.map

/***/ }),

/***/ 482:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return LanguagePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__ = __webpack_require__(9);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};




var LanguagePage = /** @class */ (function () {
    function LanguagePage(navCtrl, translate, navParams, localStorage, events) {
        this.navCtrl = navCtrl;
        this.translate = translate;
        this.navParams = navParams;
        this.localStorage = localStorage;
        this.events = events;
        this.languages = [{
                name: 'English',
                isoCode: 'en'
            }, {
                name: '中文（简体）',
                isoCode: 'zh',
                useIdeograms: true,
            }];
        this.currentLanguage = this.navParams.data["isoCode"] || 'en';
        this.translate.use(this.currentLanguage);
    }
    LanguagePage.prototype.save = function (newLang) {
        var _this = this;
        var item = {};
        if (newLang === 'zh') {
            item = {
                name: '中文（简体）',
                isoCode: 'zh',
            };
        }
        else {
            item = {
                name: 'English',
                isoCode: 'en'
            };
        }
        this.localStorage.set("wallte-language", item).then(function () {
            _this.translate.use(newLang);
            _this.events.publish("language:update", item);
            _this.navCtrl.pop();
        });
    };
    LanguagePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-language',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/language/language.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-language-message\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content>\n    <ion-list radio-group [(ngModel)]="currentLanguage">\n        <ion-item *ngFor="let language of languages">\n            <ion-label>\n                {{ language.name }}\n            </ion-label>\n            <ion-radio (click)="save(language.isoCode)" [value]="language.isoCode"></ion-radio>\n        </ion-item>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/language/language.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_2_ionic_angular__["k" /* NavController */],
            __WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__["c" /* TranslateService */],
            __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["l" /* NavParams */],
            __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__["a" /* LocalStorage */],
            __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["c" /* Events */]])
    ], LanguagePage);
    return LanguagePage;
}());

//# sourceMappingURL=language.js.map

/***/ }),

/***/ 483:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AddprivatekeyPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__pages_scan_scan__ = __webpack_require__(66);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};








var AddprivatekeyPage = /** @class */ (function () {
    function AddprivatekeyPage(navCtrl, navParams, walletManager, native, localStorage, events) {
        var _this = this;
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.masterWalletId = "1";
        this.publicKey = "";
        this.publicKeyArr = [];
        this.name = "";
        this.curIndex = 0;
        this.qrcode = null;
        this.native.info(this.navParams.data);
        this.msobj = this.navParams.data;
        this.name = this.msobj["name"];
        var totalCopayers = this.msobj["totalCopayers"];
        for (var index = 0; index < totalCopayers - 1; index++) {
            var item = { index: index, publicKey: this.publicKey };
            this.publicKeyArr.push(item);
        }
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].uuid(6, 16);
        this.getMultiSignPubKeyWithPrivKey();
        this.events.subscribe("privatekey:update", function (val) {
            _this.publicKeyArr[_this.curIndex]['publicKey'] = val;
        });
    }
    AddprivatekeyPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad AddprivatekeyPage');
    };
    AddprivatekeyPage.prototype.copy = function () {
        this.native.copyClipboard(this.qrcode);
        this.native.toast_trans('copy-ok');
    };
    AddprivatekeyPage.prototype.saomiao = function (index) {
        this.curIndex = index;
        console.log("saomiao=" + index);
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scan_scan__["a" /* ScanPage */], { "pageType": "6" });
    };
    AddprivatekeyPage.prototype.nextPage = function () {
        var _this = this;
        this.native.showLoading().then(function () {
            _this.createWallet();
        });
    };
    AddprivatekeyPage.prototype.createWallet = function () {
        var _this = this;
        var copayers = this.getTotalCopayers();
        this.walletManager.createMultiSignMasterWalletWithPrivKey(this.masterWalletId, this.msobj["importText"], this.msobj["passWord"], copayers, this.msobj["requiredCopayers"], function (data) {
            if (data['success']) {
                //this.native.setRootRouter(TabsComponent);
                _this.createSubWallet("ELA");
            }
            else {
                _this.native.hideLoading();
                alert("=====createMultiSignMasterWalletWithPrivKey===error===" + JSON.stringify(data));
            }
        });
    };
    AddprivatekeyPage.prototype.getTotalCopayers = function () {
        var arr = [];
        for (var index = 0; index < this.publicKeyArr.length; index++) {
            var item = this.publicKeyArr[index];
            var publicKey = item["publicKey"].replace(/^\s+|\s+$/g, "");
            arr.push(publicKey);
        }
        return JSON.stringify(arr);
    };
    AddprivatekeyPage.prototype.createSubWallet = function (chainId) {
        var _this = this;
        // Sub Wallet
        this.walletManager.createSubWallet(this.masterWalletId, chainId, 0, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.registerWalletListener(_this.masterWalletId, chainId);
                _this.saveWalletList();
            }
            else {
                _this.native.hideLoading();
            }
        });
    };
    AddprivatekeyPage.prototype.saveWalletList = function () {
        var _this = this;
        __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getMasterWalletIdList().push(this.masterWalletId);
        this.localStorage.saveCurMasterId({ masterId: this.masterWalletId }).then(function (data) {
            var walletObj = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].masterWallObj);
            walletObj["id"] = _this.masterWalletId;
            walletObj["wallname"] = _this.name;
            walletObj["Account"] = { "SingleAddress": true, "Type": "Multi-Sign", "InnerType": "Simple" };
            _this.localStorage.saveMappingTable(walletObj).then(function (data) {
                var mappingList = _this.native.clone(__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getMappingList());
                mappingList[_this.masterWalletId] = walletObj;
                _this.native.info(mappingList);
                __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setMappingList(mappingList);
                _this.native.hideLoading();
                __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setCurMasterWalletId(_this.masterWalletId);
                _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_3__tabs_tabs_component__["a" /* TabsComponent */]);
            });
        });
    };
    AddprivatekeyPage.prototype.registerWalletListener = function (masterId, coin) {
        var _this = this;
        this.walletManager.registerWalletListener(masterId, coin, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].isResregister(masterId, coin)) {
                __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setResregister(masterId, coin, true);
            }
            _this.events.publish("register:update", masterId, coin, data);
        });
    };
    AddprivatekeyPage.prototype.getMultiSignPubKeyWithPrivKey = function () {
        var _this = this;
        this.walletManager.getMultiSignPubKeyWithPrivKey(this.msobj["importText"], function (data) {
            if (data["success"]) {
                _this.qrcode = data["success"];
            }
            else {
            }
        });
    };
    AddprivatekeyPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-addprivatekey',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/addprivatekey/addprivatekey.html"*/'<!--\n  Generated template for the AddprivatekeyPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-add-publickey-title\' | translate }}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n\n<ion-content>\n    <!-- <ion-list>\n        <ion-item *ngFor="let copayer of publicKeyArr">\n            <ion-input type="text" placeholder="{{\'text-publickey-placeholder\'|translate}}" [(ngModel)]="copayer[\'publicKey\']"></ion-input>\n        </ion-item>\n    </ion-list> -->\n    <ion-row *ngFor="let copayer of publicKeyArr">\n        <ion-col align-self-center col-10>\n            <ion-item>\n                <ion-input type="text" placeholder="{{\'text-publickey-placeholder\'|translate}}" [(ngModel)]="copayer[\'publicKey\']"></ion-input>\n            </ion-item>\n        </ion-col>\n        <ion-col align-self-center col-2 (click)="saomiao(copayer[\'index\'])">\n            <img src="assets/images/icon/ico-scan.svg" style="width: 40px;height:30px">\n        </ion-col>\n    </ion-row>\n\n    <div style="text-align: center;width:100%;margin-top:20px" (click)="copy()">\n        <qrcode class="receive-qrocde" [qrdata]="qrcode" [size]="200" [level]="\'M\'" style="display:inline-block;"></qrcode>\n        <p style="text-align:left;margin-top: 10px;font-size:14px;padding:0px 10px">{{\'my-publickey\'|translate}}：{{qrcode}}</p>\n    </div>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="nextPage()">{{\'text-next-step\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/addprivatekey/addprivatekey.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */]])
    ], AddprivatekeyPage);
    return AddprivatekeyPage;
}());

//# sourceMappingURL=addprivatekey.js.map

/***/ }),

/***/ 484:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ImportComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_popup__ = __webpack_require__(38);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};









var ImportComponent = /** @class */ (function () {
    function ImportComponent(navCtrl, navParams, walletManager, native, localStorage, events, popupProvider, zone) {
        var _this = this;
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.events = events;
        this.popupProvider = popupProvider;
        this.zone = zone;
        this.masterWalletId = "1";
        this.selectedTab = "words";
        this.importFileObj = { payPassword: "", rePayPassword: "", backupPassWord: "", name: "" };
        this.mnemonicObj = { mnemonic: "", payPassword: "", rePayPassword: "", phrasePassword: "", name: "", singleAddress: false };
        this.accontObj = {};
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].uuid(6, 16);
        this.events.subscribe("error:update", function (item) {
            if (item["error"]) {
                if (item["error"]["code"] === 20036) {
                    _this.popupProvider.webKeyPrompt().then(function (val) {
                        console.log("========webKeyStore" + val);
                        if (val === null) {
                            return;
                        }
                        _this.webKeyStore(val.toString());
                    });
                }
            }
        });
    }
    ImportComponent.prototype.toggleShowAdvOpts = function () {
        var _this = this;
        this.zone.run(function () {
            _this.showAdvOpts = !_this.showAdvOpts;
        });
    };
    ImportComponent.prototype.selectTab = function (tab) {
        var _this = this;
        this.zone.run(function () {
            _this.selectedTab = tab;
        });
    };
    ImportComponent.prototype.updateSingleAddress = function (isShow) {
        var _this = this;
        this.zone.run(function () {
            _this.mnemonicObj.singleAddress = isShow;
        });
    };
    ImportComponent.prototype.onImport = function () {
        var _this = this;
        //this.native.showLoading();
        switch (this.selectedTab) {
            case "words":
                if (this.checkWorld()) {
                    this.native.showLoading().then(function () {
                        _this.importWalletWithMnemonic();
                    });
                }
                break;
            case "file":
                if (this.checkImportFile()) {
                    this.native.showLoading().then(function () {
                        _this.importWalletWithKeystore();
                    });
                }
                break;
        }
    };
    ImportComponent.prototype.checkImportFile = function () {
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.keyStoreContent)) {
            //this.native.hideLoading();
            this.native.toast_trans('import-text-keystroe-message');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.importFileObj.name)) {
            //this.native.hideLoading();
            this.native.toast_trans("text-wallet-name-validator");
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isWalletName(this.importFileObj.name)) {
            this.native.toast_trans("text-wallet-name-validator1");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isWallNameExit(this.importFileObj.name)) {
            this.native.toast_trans("text-wallet-name-validator2");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.importFileObj.backupPassWord)) {
            //this.native.hideLoading();
            this.native.toast_trans('text-backup-passworld-input');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.importFileObj.payPassword)) {
            //this.native.hideLoading();
            this.native.toast_trans('text-pay-passworld-input');
            return false;
        }
        if (this.importFileObj.payPassword != this.importFileObj.rePayPassword) {
            //this.native.hideLoading();
            this.native.toast_trans('text-passworld-compare');
            return false;
        }
        return true;
    };
    ImportComponent.prototype.importWalletWithKeystore = function () {
        var _this = this;
        this.walletManager.importWalletWithKeystore(this.masterWalletId, this.keyStoreContent, this.importFileObj.backupPassWord, this.importFileObj.payPassword, function (data) {
            if (data["success"]) {
                _this.accontObj = JSON.parse(data["success"])["Account"];
                _this.walletManager.createSubWallet(_this.masterWalletId, "ELA", 0, function (data) {
                    if (data["success"]) {
                        _this.registerWalletListener(_this.masterWalletId, "ELA");
                        _this.getAllCreatedSubWallets();
                    }
                    else {
                        _this.native.hideLoading();
                        alert("=====createSubWallet=error" + JSON.stringify(data));
                    }
                });
            }
            else {
                _this.native.hideLoading();
                alert("=====importWalletWithKeystore=error" + JSON.stringify(data));
            }
        });
    };
    ImportComponent.prototype.checkWorld = function () {
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.mnemonicObj.name)) {
            //this.native.hideLoading();
            this.native.toast_trans("text-wallet-name-validator");
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isWalletName(this.mnemonicObj.name)) {
            this.native.toast_trans("text-wallet-name-validator1");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isWallNameExit(this.mnemonicObj.name)) {
            this.native.toast_trans("text-wallet-name-validator2");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.mnemonicObj.mnemonic)) {
            //this.native.hideLoading();
            this.native.toast_trans('text-input-mnemonic');
            return false;
        }
        var mnemonic = this.normalizeMnemonic(this.mnemonicObj.mnemonic).replace(/^\s+|\s+$/g, "");
        if (mnemonic.split(/[\u3000\s]+/).length != 12) {
            //this.native.hideLoading();
            this.native.toast_trans('text-mnemonic-validator');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.mnemonicObj.payPassword)) {
            //this.native.hideLoading();
            this.native.toast_trans('text-pay-password');
            return false;
        }
        if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].password(this.mnemonicObj.payPassword)) {
            //this.native.hideLoading();
            this.native.toast_trans("text-pwd-validator");
            return false;
        }
        if (this.mnemonicObj.payPassword != this.mnemonicObj.rePayPassword) {
            //this.native.hideLoading();
            this.native.toast_trans('text-passworld-compare');
            return false;
        }
        return true;
    };
    ImportComponent.prototype.normalizeMnemonic = function (words) {
        if (!words || !words.indexOf)
            return words;
        var isJA = words.indexOf('\u3000') > -1;
        var wordList = words.split(/[\u3000\s]+/);
        return wordList.join(isJA ? '\u3000' : ' ');
    };
    ;
    ImportComponent.prototype.importWalletWithMnemonic = function () {
        var _this = this;
        var mnemonic = this.normalizeMnemonic(this.mnemonicObj.mnemonic);
        this.walletManager.importWalletWithMnemonic(this.masterWalletId, mnemonic, this.mnemonicObj.phrasePassword, this.mnemonicObj.payPassword, this.mnemonicObj.singleAddress, function (data) {
            if (data["success"]) {
                _this.accontObj = JSON.parse(data["success"])["Account"];
                _this.walletManager.createSubWallet(_this.masterWalletId, "ELA", 0, function (data) {
                    if (data["success"]) {
                        _this.native.toast_trans('import-text-world-sucess');
                        _this.registerWalletListener(_this.masterWalletId, "ELA");
                        _this.saveWalletList(null);
                    }
                    else {
                        _this.native.hideLoading();
                        alert("createSubWallet==error" + JSON.stringify(data));
                    }
                });
            }
            else {
                _this.native.hideLoading();
                alert("importWalletWithMnemonic==error" + JSON.stringify(data));
            }
        });
    };
    ImportComponent.prototype.getAllCreatedSubWallets = function () {
        var _this = this;
        this.walletManager.getAllSubWallets(this.masterWalletId, function (data) {
            if (data["success"]) {
                var chinas = _this.getCoinListCache(JSON.parse(data["success"]));
                //this.localStorage.set('coinListCache',chinas).then(()=>{
                _this.native.toast_trans('import-text-keystroe-sucess');
                _this.saveWalletList(chinas);
                //});
            }
            else {
                _this.native.hideLoading();
                alert("==getAllSubWallets==error" + JSON.stringify(data));
            }
        });
    };
    ImportComponent.prototype.getCoinListCache = function (createdChains) {
        var chinas = {};
        for (var index in createdChains) {
            var chain = createdChains[index];
            if (chain != "ELA") {
                chinas[chain] = chain;
            }
        }
        return chinas;
    };
    ImportComponent.prototype.saveWalletList = function (subchains) {
        var _this = this;
        __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getMasterWalletIdList().push(this.masterWalletId);
        this.localStorage.saveCurMasterId({ masterId: this.masterWalletId }).then(function (data) {
            var name = "";
            if (_this.selectedTab === "words") {
                name = _this.mnemonicObj.name;
                _this.accontObj["SingleAddress"] = _this.mnemonicObj.SingleAddress;
            }
            else if (_this.selectedTab === "file") {
                name = _this.importFileObj.name;
            }
            var walletObj = _this.native.clone(__WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].masterWallObj);
            walletObj["id"] = _this.masterWalletId;
            walletObj["wallname"] = name;
            walletObj["Account"] = _this.accontObj;
            if (subchains) {
                walletObj["coinListCache"] = subchains;
                _this.registersubWallet(_this.masterWalletId, subchains);
            }
            _this.localStorage.saveMappingTable(walletObj).then(function (data) {
                var mappingList = _this.native.clone(__WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getMappingList());
                mappingList[_this.masterWalletId] = walletObj;
                _this.native.info(mappingList);
                __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].setMappingList(mappingList);
                _this.native.hideLoading();
                __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].setCurMasterWalletId(_this.masterWalletId);
                _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_5__pages_tabs_tabs_component__["a" /* TabsComponent */]);
            });
        });
    };
    ImportComponent.prototype.registerWalletListener = function (masterId, coin) {
        var _this = this;
        this.walletManager.registerWalletListener(masterId, coin, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].isResregister(masterId, coin)) {
                __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].setResregister(masterId, coin, true);
            }
            _this.events.publish("register:update", masterId, coin, data);
        });
    };
    ImportComponent.prototype.registersubWallet = function (masterId, chinas) {
        for (var index in chinas) {
            var chain = chinas[index];
            this.registerWalletListener(masterId, chain);
        }
    };
    ImportComponent.prototype.ionViewDidLeave = function () {
        this.events.unsubscribe("error:update");
    };
    ImportComponent.prototype.webKeyStore = function (webKeyStore) {
        var _this = this;
        console.log("========webKeyStore" + webKeyStore);
        this.native.showLoading().then(function () {
            _this.walletManager.importWalletWithOldKeystore(_this.masterWalletId, _this.keyStoreContent, _this.importFileObj.backupPassWord, _this.importFileObj.payPassword, webKeyStore, function (data) {
                if (data["success"]) {
                    _this.accontObj = JSON.parse(data["success"])["Account"];
                    _this.walletManager.createSubWallet(_this.masterWalletId, "ELA", 0, function (data) {
                        if (data["success"]) {
                            _this.native.toast_trans('import-text-world-sucess');
                            _this.registerWalletListener(_this.masterWalletId, "ELA");
                            _this.saveWalletList(null);
                        }
                        else {
                            _this.native.hideLoading();
                            alert("createSubWallet==error" + JSON.stringify(data));
                        }
                    });
                }
                else {
                    _this.native.hideLoading();
                    alert("importWalletWithOldKeystore==error" + JSON.stringify(data));
                }
            });
        });
    };
    ImportComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-import',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/import/import.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'launcher-backup-import\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content no-bounce>\n    <div>\n        <ion-segment [(ngModel)]="selectedTab" color="primary" (ionChange)="selectTab(selectedTab)">\n            <ion-segment-button value="words">\n                {{ \'text-mnemonic\' | translate }}\n            </ion-segment-button>\n            <ion-segment-button value="file">\n                {{ \'text-from-keystore\' | translate }}\n            </ion-segment-button>\n        </ion-segment>\n    </div>\n\n    <div *ngIf="selectedTab == \'file\'">\n\n        <div class="kuangTextArea">\n            <textarea rows="4" class="backupWalletTextArea" placeholder="{{ \'import-text-keystroe-message\' | translate}}" [(ngModel)]="keyStoreContent"></textarea>\n        </div>\n        <ion-list>\n            <ion-item>\n                <ion-label stacked>{{ \'addwallet-walletname-title\' | translate }}</ion-label>\n                <ion-input type="text" placeholder="{{ \'addwallet-walletname-placeholder\' | translate }}" [(ngModel)]="importFileObj.name"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-label stacked>{{ \'importkeystore-keystorepassword-title\' | translate }}</ion-label>\n                <ion-input type="password" placeholder="{{ \'importkeystore-optionalpassword-placeholder\' | translate }}" [(ngModel)]="importFileObj.backupPassWord"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-label stacked>{{ \'unlock-paypassword-title\' | translate }}</ion-label>\n                <ion-input type="password" placeholder="{{ \'addwallet-paypassword1-placeholder\' | translate }}" [(ngModel)]="importFileObj.payPassword"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-input type="password" placeholder="{{ \'addwallet-paypassword2-placeholder\' | translate }}" [(ngModel)]="importFileObj.rePayPassword"></ion-input>\n            </ion-item>\n        </ion-list>\n    </div>\n\n    <div *ngIf="selectedTab == \'words\'">\n        <div class="kuangTextArea">\n            <textarea class="backupWalletTextArea" placeholder="{{ \'text-mnemonic-format\' | translate}}" rows="4" [(ngModel)]="mnemonicObj.mnemonic"></textarea>\n        </div>\n        <ion-list>\n            <ion-item>\n                <ion-label stacked>{{ \'addwallet-walletname-title\' | translate }}</ion-label>\n                <ion-input type="text" placeholder="{{ \'addwallet-walletname-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.name"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-label stacked>{{ \'unlock-paypassword-title\' | translate }}</ion-label>\n                <ion-input type="password" placeholder="{{ \'addwallet-paypassword1-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.payPassword"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-input type="password" placeholder="{{ \'addwallet-paypassword2-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.rePayPassword"></ion-input>\n            </ion-item>\n\n            <ion-item>\n                <ion-label>{{\'text-signaddress\' | translate }}</ion-label>\n                <ion-checkbox [(ngModel)]="mnemonicObj.singleAddress" (ionChange)="updateSingleAddress(mnemonicObj.singleAddress)"></ion-checkbox>\n            </ion-item>\n        </ion-list>\n\n        <ion-item (click)="toggleShowAdvOpts()">\n            <ion-label *ngIf="!showAdvOpts">{{\'show-advanced-options\' | translate}}</ion-label>\n            <ion-label *ngIf="showAdvOpts"> {{\'hide-advanced-options\' | translate}}</ion-label>\n        </ion-item>\n\n        <ion-item *ngIf="showAdvOpts">\n            <ion-label stacked>{{ \'importmnes-optionalpassword-title\' | translate }}</ion-label>\n            <ion-input type="password" placeholder="{{ \'importmnes-optionalpassword-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.phrasePassword"></ion-input>\n        </ion-item>\n    </div>\n</ion-content>\n\n<ion-footer>\n    <button ion-button (click)="onImport()" full>{{ \'confirm\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/wallet/import/import.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_8__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], ImportComponent);
    return ImportComponent;
}());

//# sourceMappingURL=import.component.js.map

/***/ }),

/***/ 485:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CreatemultiwalltePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_walltemode_walltemode__ = __webpack_require__(486);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};




var CreatemultiwalltePage = /** @class */ (function () {
    function CreatemultiwalltePage(navCtrl, navParams, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.copayers = [1, 2, 3, 4, 5, 6];
        this.signatures = [1, 2, 3, 4, 5, 6];
        this.totalCopayers = 2;
        this.requiredCopayers = 2;
    }
    CreatemultiwalltePage.prototype.ionViewDidLoad = function () {
    };
    CreatemultiwalltePage.prototype.setTotalCopayers = function () {
    };
    CreatemultiwalltePage.prototype.nextPage = function () {
        if (this.totalCopayers < this.requiredCopayers) {
            this.native.toast_trans("text-multi-error");
            return;
        }
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_walltemode_walltemode__["a" /* WalltemodePage */], { totalCopayers: this.totalCopayers, requiredCopayers: this.requiredCopayers });
    };
    CreatemultiwalltePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-createmultiwallte',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/createmultiwallte/createmultiwallte.html"*/'<!--\n  Generated template for the CreatemultiwalltePage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'signature-wallet\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content no-bounce>\n    <ion-item>\n        <ion-label stacked>{{\'text-multi-title1\' | translate}}</ion-label>\n        <ion-select [(ngModel)]="totalCopayers" (ionChange)="setTotalCopayers()">\n            <ion-option *ngFor="let copayer of copayers" [value]="copayer">{{copayer}}</ion-option>\n        </ion-select>\n    </ion-item>\n\n    <ion-item>\n        <ion-label stacked>{{\'text-multi-title2\' | translate}}</ion-label>\n        <ion-select [(ngModel)]="requiredCopayers">\n            <ion-option *ngFor="let signature of signatures" [value]="signature">{{signature}}</ion-option>\n        </ion-select>\n    </ion-item>\n\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="nextPage()">{{\'text-next-step\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/createmultiwallte/createmultiwallte.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */]])
    ], CreatemultiwalltePage);
    return CreatemultiwalltePage;
}());

//# sourceMappingURL=createmultiwallte.js.map

/***/ }),

/***/ 486:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return WalltemodePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_importprivatekey_importprivatekey__ = __webpack_require__(487);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_wallet_wallet_create_wallet_create_component__ = __webpack_require__(197);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_createwalletname_createwalletname__ = __webpack_require__(488);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_importmnemonic_importmnemonic__ = __webpack_require__(489);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};







var WalltemodePage = /** @class */ (function () {
    function WalltemodePage(navCtrl, navParams, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.native.info(this.navParams.data);
        this.navObj = this.navParams.data;
        this.totalCopayers = this.navParams.data["totalCopayers"];
    }
    WalltemodePage.prototype.ionViewDidLoad = function () {
    };
    WalltemodePage.prototype.wayOne = function () {
        //this.navCtrl.push(WalletCreateComponent,this.navObj);
        //this.navCtrl.push(AddpublickeyPage,this.navObj);
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_wallet_wallet_create_wallet_create_component__["a" /* WalletCreateComponent */], this.navObj);
    };
    WalltemodePage.prototype.wayTwo = function () {
        //this.navCtrl.push(ImportprivatekeyPage,this.navObj);
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_importprivatekey_importprivatekey__["a" /* ImportprivatekeyPage */], this.navObj);
    };
    WalltemodePage.prototype.wayThree = function () {
        //this.navCtrl.push(AddpublickeyPage,this.navObj);
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__pages_createwalletname_createwalletname__["a" /* CreatewalletnamePage */], this.navObj);
    };
    WalltemodePage.prototype.wayFour = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__pages_importmnemonic_importmnemonic__["a" /* ImportmnemonicPage */], this.navObj);
    };
    WalltemodePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-walltemode',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/walltemode/walltemode.html"*/'<!--\n  Generated template for the WalltemodePage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-select-type\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding style="text-align: center;">\n    <div id="wrapper">\n        <div id="cell">\n            <div>\n                <button ion-button full (click)="wayOne()">{{\'text-create-privatekey\'|translate}}</button>\n            </div>\n            <div>\n                <button ion-button full (click)="wayTwo()">{{\'text-import-privatekey\'|translate}}</button>\n            </div>\n            <div>\n                <button ion-button full (click)="wayThree()">{{\'text-observe-wallte\'|translate}}</button>\n            </div>\n            <div>\n                <button ion-button full (click)="wayFour()">{{ \'create-multi-by-mnes\' | translate }}</button>\n            </div>\n        </div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/walltemode/walltemode.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_6__providers_Native__["a" /* Native */]])
    ], WalltemodePage);
    return WalltemodePage;
}());

//# sourceMappingURL=walltemode.js.map

/***/ }),

/***/ 487:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ImportprivatekeyPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_mpublickey_mpublickey__ = __webpack_require__(128);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var ImportprivatekeyPage = /** @class */ (function () {
    function ImportprivatekeyPage(navCtrl, navParams, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.importText = "";
        this.passWord = "";
        this.rePassWorld = "";
        this.name = "";
        this.msobj = this.navParams.data;
    }
    ImportprivatekeyPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad ImportprivatekeyPage');
    };
    ImportprivatekeyPage.prototype.import = function () {
        if (this.checkParms()) {
            this.msobj["importText"] = this.importText.replace(/^\s+|\s+$/g, "");
            this.msobj["passWord"] = this.passWord;
            this.msobj["name"] = this.name;
            //this.navCtrl.push(AddprivatekeyPage,this.msobj);
            this.navCtrl.push(__WEBPACK_IMPORTED_MODULE_4__pages_mpublickey_mpublickey__["a" /* MpublickeyPage */], this.msobj);
        }
    };
    ImportprivatekeyPage.prototype.checkParms = function () {
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.name)) {
            this.native.toast_trans("text-wallet-name-validator");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWalletName(this.name)) {
            this.native.toast_trans("text-wallet-name-validator1");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWallNameExit(this.name)) {
            this.native.toast_trans("text-wallet-name-validator2");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.importText)) {
            this.native.toast_trans('text-import-privatekey-placeholder');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.passWord)) {
            this.native.toast_trans('text-pay-password');
            return false;
        }
        if (this.passWord != this.rePassWorld) {
            this.native.toast_trans('text-passworld-compare');
            return false;
        }
        return true;
    };
    ImportprivatekeyPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-importprivatekey',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/importprivatekey/importprivatekey.html"*/'<!--\n  Generated template for the ImportprivatekeyPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{"text-import-privatekey"|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content no-bounce>\n    <p class="des">{{\'text-import-privatekey-des\'|translate}}</p>\n    <div class="importDiv">\n        <textarea rows="4" class="importTextArea" [(ngModel)]="importText" placeholder="{{ \'text-import-privatekey-placeholder\'|translate}}"></textarea>\n    </div>\n    <div>\n        <ion-list>\n            <ion-item>\n                <ion-label stacked>{{ \'addwallet-walletname-title\' | translate }}</ion-label>\n                <ion-input type="text" placeholder="{{ \'addwallet-walletname-placeholder\' | translate }}" [(ngModel)]="name"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-label stacked>{{ \'addwallet-paypassword1-title\' | translate }}</ion-label>\n                <ion-input type="password" placeholder="{{ \'addwallet-paypassword1-placeholder\' | translate }}" [(ngModel)]="passWord"></ion-input>\n            </ion-item>\n\n            <ion-item>\n                <ion-input type="password" placeholder="{{ \'addwallet-paypassword2-placeholder\' | translate }}" [(ngModel)]="rePassWorld"></ion-input>\n            </ion-item>\n\n        </ion-list>\n    </div>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="import()">{{ \'text-next-step\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/importprivatekey/importprivatekey.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */]])
    ], ImportprivatekeyPage);
    return ImportprivatekeyPage;
}());

//# sourceMappingURL=importprivatekey.js.map

/***/ }),

/***/ 488:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CreatewalletnamePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_addpublickey_addpublickey__ = __webpack_require__(217);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var CreatewalletnamePage = /** @class */ (function () {
    function CreatewalletnamePage(navCtrl, navParams, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.name = "";
        this.navObj = this.navParams.data;
    }
    CreatewalletnamePage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad CreatewalletnamePage');
    };
    CreatewalletnamePage.prototype.import = function () {
        if (this.checkParms()) {
            this.navObj["name"] = this.name;
            this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_addpublickey_addpublickey__["a" /* AddpublickeyPage */], this.navObj);
        }
    };
    CreatewalletnamePage.prototype.checkParms = function () {
        if (__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isNull(this.name)) {
            this.native.toast_trans("text-wallet-name-validator");
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isWalletName(this.name)) {
            this.native.toast_trans("text-wallet-name-validator1");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isWallNameExit(this.name)) {
            this.native.toast_trans("text-wallet-name-validator2");
            return;
        }
        return true;
    };
    CreatewalletnamePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-createwalletname',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/createwalletname/createwalletname.html"*/'<!--\n  Generated template for the CreatewalletnamePage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-observe-wallte\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content no-bounce>\n    <ion-list>\n        <ion-item>\n            <ion-label stacked>{{ \'addwallet-walletname-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="{{ \'addwallet-walletname-placeholder\' | translate }}" [(ngModel)]="name"></ion-input>\n        </ion-item>\n    </ion-list>\n</ion-content>\n\n<ion-footer>\n    <button ion-button full (click)="import()">{{ \'text-next-step\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/createwalletname/createwalletname.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */]])
    ], CreatewalletnamePage);
    return CreatewalletnamePage;
}());

//# sourceMappingURL=createwalletname.js.map

/***/ }),

/***/ 489:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ImportmnemonicPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_mpublickey_mpublickey__ = __webpack_require__(128);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





/**
 * Generated class for the ImportmnemonicPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var ImportmnemonicPage = /** @class */ (function () {
    function ImportmnemonicPage(navCtrl, navParams, native, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.zone = zone;
        this.mnemonicObj = { mnemonic: "", payPassword: "", rePayPassword: "", phrasePassword: "", name: "", singleAddress: true };
        this.exatParm = this.navParams.data;
    }
    ImportmnemonicPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad ImportmnemonicPage');
    };
    ImportmnemonicPage.prototype.checkWorld = function () {
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.mnemonicObj.name)) {
            //this.native.hideLoading();
            this.native.toast_trans("text-wallet-name-validator");
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWalletName(this.mnemonicObj.name)) {
            this.native.toast_trans("text-wallet-name-validator1");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isWallNameExit(this.mnemonicObj.name)) {
            this.native.toast_trans("text-wallet-name-validator2");
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.mnemonicObj.mnemonic)) {
            //this.native.hideLoading();
            this.native.toast_trans('text-input-mnemonic');
            return false;
        }
        var mnemonic = this.normalizeMnemonic(this.mnemonicObj.mnemonic).replace(/^\s+|\s+$/g, "");
        if (mnemonic.split(/[\u3000\s]+/).length != 12) {
            //this.native.hideLoading();
            this.native.toast_trans('text-mnemonic-validator');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.mnemonicObj.payPassword)) {
            //this.native.hideLoading();
            this.native.toast_trans('text-pay-password');
            return false;
        }
        if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].password(this.mnemonicObj.payPassword)) {
            //this.native.hideLoading();
            this.native.toast_trans("text-pwd-validator");
            return false;
        }
        if (this.mnemonicObj.payPassword != this.mnemonicObj.rePayPassword) {
            //this.native.hideLoading();
            this.native.toast_trans('text-passworld-compare');
            return false;
        }
        return true;
    };
    ImportmnemonicPage.prototype.normalizeMnemonic = function (words) {
        if (!words || !words.indexOf)
            return words;
        var isJA = words.indexOf('\u3000') > -1;
        var wordList = words.split(/[\u3000\s]+/);
        return wordList.join(isJA ? '\u3000' : ' ');
    };
    ;
    ImportmnemonicPage.prototype.nextPage = function () {
        if (this.checkWorld()) {
            this.exatParm["mnemonicStr"] = this.normalizeMnemonic(this.mnemonicObj.mnemonic);
            this.exatParm["mnemonicPassword"] = this.mnemonicObj.phrasePassword;
            this.exatParm["payPassword"] = this.mnemonicObj.payPassword;
            this.exatParm["name"] = this.mnemonicObj.name;
            this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__pages_mpublickey_mpublickey__["a" /* MpublickeyPage */], this.exatParm);
        }
    };
    ImportmnemonicPage.prototype.toggleShowAdvOpts = function () {
        var _this = this;
        this.zone.run(function () {
            _this.showAdvOpts = !_this.showAdvOpts;
        });
    };
    ImportmnemonicPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-importmnemonic',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/importmnemonic/importmnemonic.html"*/'<!--\n  Generated template for the ImportmnemonicPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{ \'text-mnemonic\' | translate }}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n    <div class="kuangTextArea">\n        <textarea class="backupWalletTextArea" placeholder="{{ \'text-mnemonic-format\' | translate}}" rows="4" [(ngModel)]="mnemonicObj.mnemonic"></textarea>\n    </div>\n    <ion-list>\n        <ion-item>\n            <ion-label stacked>{{ \'addwallet-walletname-title\' | translate }}</ion-label>\n            <ion-input type="text" placeholder="{{ \'addwallet-walletname-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.name"></ion-input>\n        </ion-item>\n        <ion-item>\n            <ion-label stacked>{{ \'unlock-paypassword-title\' | translate }}</ion-label>\n            <ion-input type="password" placeholder="{{ \'addwallet-paypassword1-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.payPassword"></ion-input>\n        </ion-item>\n        <ion-item>\n            <ion-input type="password" placeholder="{{ \'addwallet-paypassword2-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.rePayPassword"></ion-input>\n        </ion-item>\n\n        <ion-item>\n            <ion-label>{{\'text-signaddress\' | translate }}</ion-label>\n            <ion-checkbox [(ngModel)]="mnemonicObj.singleAddress" disabled="true"></ion-checkbox>\n        </ion-item>\n    </ion-list>\n\n    <ion-item (click)="toggleShowAdvOpts()">\n        <ion-label *ngIf="!showAdvOpts">{{\'show-advanced-options\' | translate}}</ion-label>\n        <ion-label *ngIf="showAdvOpts"> {{\'hide-advanced-options\' | translate}}</ion-label>\n    </ion-item>\n\n    <ion-item *ngIf="showAdvOpts">\n        <ion-label stacked>{{ \'importmnes-optionalpassword-title\' | translate }}</ion-label>\n        <ion-input type="password" placeholder="{{ \'importmnes-optionalpassword-placeholder\' | translate }}" [(ngModel)]="mnemonicObj.phrasePassword"></ion-input>\n    </ion-item>\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="nextPage()">{{\'text-next-step\' | translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/importmnemonic/importmnemonic.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], ImportmnemonicPage);
    return ImportmnemonicPage;
}());

//# sourceMappingURL=importmnemonic.js.map

/***/ }),

/***/ 490:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return DidLoginComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__id_launcher_launcher__ = __webpack_require__(216);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_popup__ = __webpack_require__(38);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};










var DidLoginComponent = /** @class */ (function () {
    function DidLoginComponent(navCtrl, navParams, native, localStorage, walletManager, popupProvider, platform) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.localStorage = localStorage;
        this.walletManager = walletManager;
        this.popupProvider = popupProvider;
        this.platform = platform;
        this.kycIdArr = [];
        this.init();
    }
    DidLoginComponent.prototype.init = function () {
        var _this = this;
        // this.setHeadDisPlay({left: false});
        this.message = __WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].GetQueryString("message");
        this.localStorage.get('kycId').then(function (val) {
            // val = '{"icgQf7G19ZMq97RUbsz3S6Y5sYiCT3qcEb":{"id":"icgQf7G19ZMq97RUbsz3S6Y5sYiCT3qcEb","kyc":{"person":{"order":{"VTT1530900147221199":{"txHash":"375cfb778c9fb114dc098eb15d37d7488bb5ed578813db0c517850af672a1e91","serialNum":"VTT1530900147221199"}}},"company":{"order":{"RLU1530971869338288":{"txHash":"510e0d8cb4195f6d5050a0ca87948bd91eee05f95d7e9143278d8e7909bd7f81","serialNum":"RLU1530971869338288","status":1,"params":{"id":"icgQf7G19ZMq97RUbsz3S6Y5sYiCT3qcEb","appName":"kyc","type":"company","adata":[{"type":"enterprise","result":"success","retdata":{"app":"b1c0b7028c8c4be3beafc4c4812ae92e","signature":"a46616afee601bfd26651dba4afe33c54e865f6a8b504bb3dd042edde934669affcfa77e4b3798d9539c4131c1af545bba6e65987a71e6abefe195ca0435e8af","RegistrationNum":"911101080804655794","legalPerson":"詹克团","word":"北京比特大陆科技有限公司","authid":"12345678","ts":"1532506548"},"message":"认证成功","timestamp":"1532506561601","resultSign":"3045022079b6cab8d7d91ae76813f7da0e725c903288ed5b51cb931591eb23ea2827cc9e022100eb393cadf921c73c0a4fa00317683058250d256f77e771675ffb6120f5ea4cbe"}]}},"TIN1531045028308086":{"txHash":"66cb274d4b50e56293e0de42d982ce808909ba471edb601635193dcbaf840efc","serialNum":"TIN1531045028308086"}}}}},"icLDfCPLE4ukMT98uc6RLBRMbU7kEVS7Jw":{"id":"icLDfCPLE4ukMT98uc6RLBRMbU7kEVS7Jw","kyc":{"person":{"order":{"VMN1530988285253940":{"txHash":"c71a83a5aa50513bffe507d819d0d7657d78c752a73ae7ce41b081d687f2ea83","serialNum":"VMN1530988285253940"},"WIY1531042401043980":{"txHash":"88a3dc5afa44b933118a05b87e9ddd9a9e47c8259dd644bbfd7c28cf4401b5c6","serialNum":"WIY1531042401043980","status":1,"params":{"id":"icLDfCPLE4ukMT98uc6RLBRMbU7kEVS7Jw","appName":"kyc","type":"person","adata":[{"type":"identityCard","result":"fail","retdata":{"app":"b1c0b7028c8c4be3beafc4c4812ae92e","identityNumber":"410426198811151012","signature":"ad9df962257ff74095e2ef57d193d76863a287af9ca63735a94eaad860b310e4e3863bb6779711d7d44d3031d9b77cf6f6ff09a36d337ac437ab50ce80a8c5fd","fullName":"sss","authid":"12345678","ts":"1532575197"},"message":"认证失败","timestamp":"1532575217651","resultSign":"30440220686636a8c7b524f8ebdd97c2a8689f2389554da5e380f1490410c2d80ee141dc022024493c6ac9fb103401cb0ef7f40b6e82a4c4f5f85ea7d7c254b51b409235ecf3"}]}}}}}},"iewY47FYSPkEBCRFSzKFfXG1KksiZThy16":{"id":"iewY47FYSPkEBCRFSzKFfXG1KksiZThy16","kyc":{"person":{"order":{"HVL1531050647361408":{"txHash":"534502cc52e8b49d6f81d6a1cd69f3cceea4708fee34a974335f8b826f080493","serialNum":"HVL1531050647361408","status":1,"params":{"id":"iewY47FYSPkEBCRFSzKFfXG1KksiZThy16","appName":"kyc","type":"person","adata":[{"type":"identityCard","result":"success","retdata":{"app":"b1c0b7028c8c4be3beafc4c4812ae92e","identityNumber":"410426198811151012","signature":"2a19abed07b36348f8d60d4f56dc98d249df1e7e2ee63579f908d69d5fca1dc7ca18781ab842673de20a56ab22786c3450614acca942604f24ec6ea0b5b76b3f","fullName":"宋家准","authid":"12345678","ts":"1532583359"},"message":"认证成功","timestamp":"1532583582624","resultSign":"3044022060f94a0468476128137419cdbce4119447c5a1ab2c3726ea425b52b53260307102204da37c14ba89d2cdcb048c4e6012d0c68fa6c44efb95b11c26d53d368ad6234c"}]}},"EEZ1531051833346236":{"txHash":"fc9ada7d5d009262409bff5e77a899fdc30288de7250e54f56cf90a4d41b6947","serialNum":"EEZ1531051833346236","status":1,"params":{"id":"iewY47FYSPkEBCRFSzKFfXG1KksiZThy16","appName":"kyc","type":"person","adata":[{"type":"identityCard","result":"success","retdata":{"app":"b1c0b7028c8c4be3beafc4c4812ae92e","identityNumber":"410426198811151012","signature":"da12d5d3b15c42ab7cada88810ec578d6745b91e28cf33dfb2a215a60f69fa79ec3116faf47d36e43fd94100b1a80d2e85ea4af52bd483048b327e40b7c5c699","fullName":"宋家准","authid":"12345678","ts":"1532584799"},"message":"认证成功","timestamp":"1532584858522","resultSign":"3045022100b800312fb4d824c4699cf4ff20837e29722e22f50535da6815336de2a9b6605b02204aef5f2476bf12482d4b73568614e3426eb261a8a27b5f171fed928759bae847"},{"type":"phone","result":"success","retdata":{"app":"b1c0b7028c8c4be3beafc4c4812ae92e","identityNumber":"410426198811151012","signature":"428dd9fab4c63a1301609177fc165abc18f3f798ab93b388d7c5c9e89911d249d93bf37122383c47fdd8bdc477a6257d7d7962260dc73471613b2bf6ba8cb694","mobile":"18210230496","fullName":"宋家准","authid":"12345678","ts":"1532584799"},"message":"认证成功","timestamp":"1532584858522","resultSign":"3045022100e5ac2c6bbb5c5042c51cc18696d1f37e20f5f5591f7085fdc3efabad0bc8016b02206f8de35b0a783917e8489a8038cb820c6f08d3d7cd095f26611afb9d0238d79c"}]}},"TNL1531052347373694":{"txHash":"196a23ec728a8b984fc8adf8f108ec1bf534cdbd032cebc48d8bc3c77a2a3b27","serialNum":"TNL1531052347373694","status":1,"params":{"id":"iewY47FYSPkEBCRFSzKFfXG1KksiZThy16","appName":"kyc","type":"person","adata":[{"type":"identityCard","result":"success","retdata":{"app":"b1c0b7028c8c4be3beafc4c4812ae92e","identityNumber":"410426198811151012","signature":"3adb5ef3593541dfcc3af21063227833d48ae50224ff479004748325715d2b942532364e463c3a81a04d05db6a2f8dc40cd521d75eae162a36fec5c2b5a64803","fullName":"宋家准","authid":"12345678","ts":"1532585280"},"message":"认证成功","timestamp":"1532585373718","resultSign":"30460221008d677c0917270b7ed8996a472d905c499e62f79c841468a0c90e34ff9c0fb40e022100a8a6c43eaa48425b27a8c5789a50951db4dc21f744a14607ceb7c7e6b9cd5207"},{"type":"bankCard","result":"fail","retdata":null,"message":"无信息","timestamp":"1532585373718","resultSign":"3046022100b557796782b3392adfc51b9acacc93857cf8dd3ee206bc35613a445809cfd009022100c1f29f71dfbd60a7a36c1d55228f45f4a4bc1bb24fd4889c79aa83548ae9cefe"}]}},"WSE1531054511779122":{"txHash":"11de788a37cd2b8777fca7ed313232681257fe2f380d93c392d6d02f47171e8c","serialNum":"WSE1531054511779122","status":1,"params":{"id":"iewY47FYSPkEBCRFSzKFfXG1KksiZThy16","appName":"kyc","type":"person","adata":[{"type":"identityCard","result":"success","retdata":{"app":"b1c0b7028c8c4be3beafc4c4812ae92e","identityNumber":"410426198811151012","signature":"9f84e0c9546ef01ea0c6c077d60a7d3a9486847a9fad71562890081fd467a02a257950ee563a1298f7f0e6907c88b64c9a50c7d939fb36971751e59fd33e019f","fullName":"宋家准","authid":"12345678","ts":"1532587201"},"message":"认证成功","timestamp":"1532587852623","resultSign":"3045022100aa8addd6408c7389f25e91c21af06e29b23760ac8869980345a51065e00a8fee02205de4240b25ea0837c08b9b9988ef3488fd22937571857959fa887fa0ef9dfa0e"},{"type":"bankCard","result":"fail","retdata":null,"message":"无信息","timestamp":"1532587852623","resultSign":"30440220590221ac2379a412c0086e77e11b3eba0a9a90b0130b21d37d691b55d1c6a98b022017a08d4f68a74894ed6e15e6039350023cba88f5754a47982fd782f1e89b8dec"}]}},"GEB1531056345447618":{"txHash":"aee4106d49b1d1507c7130bb9bb2d9b30a27bbde9ec98414bf2e9e1eed1fd8b7","serialNum":"GEB1531056345447618"}}},"company":{}}},"ioEF4VCSu2whqm9hD44jhkjCMAqd4U8Q3k":{"id":"ioEF4VCSu2whqm9hD44jhkjCMAqd4U8Q3k"}}'
            if (val === null) {
                _this.kycIdArr = [];
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__id_launcher_launcher__["a" /* IdLauncherComponent */]);
            }
            else {
                _this.kycIdArr = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].objtoarr(JSON.parse(val));
            }
        });
    };
    DidLoginComponent.prototype.onItem = function (itemId) {
        var _this = this;
        this.popupProvider.presentPrompt().then(function (val) {
            if (__WEBPACK_IMPORTED_MODULE_1__providers_Util__["a" /* Util */].isNull(val)) {
                _this.native.toast_trans("text-id-kyc-prompt-password");
                return;
            }
            _this.didNum = itemId;
            _this.walletManager.didSign(itemId, _this.message, val.toString(), function (data) {
                _this.sign = data.value;
            });
            _this.walletManager.didGetPublicKey(itemId, function (data) {
                _this.didPubkey = data.value;
            });
            var result = {
                didNum: _this.didNum,
                sign: _this.sign,
                didPubkey: _this.didPubkey
            };
            // return result;
            _this.platform.exitApp();
        });
    };
    DidLoginComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-did-login',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/third-party/did-login/did-login.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-did-login\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <ion-list>\n        <ion-item *ngFor="let item of kycIdArr" (click)="onItem(item.id)">\n            <ion-note item-end>\n                {{item.id}}\n            </ion-note>\n        </ion-item>\n    </ion-list>\n</ion-content>\n'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/third-party/did-login/did-login.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_6_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_6_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_7__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_8__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_6_ionic_angular__["n" /* Platform */]])
    ], DidLoginComponent);
    return DidLoginComponent;
}());

//# sourceMappingURL=did-login.component.js.map

/***/ }),

/***/ 491:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ComponentsModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__progress_bar_progress_bar__ = __webpack_require__(804);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__angular_common__ = __webpack_require__(77);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__nodata_nodata__ = __webpack_require__(805);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var ComponentsModule = /** @class */ (function () {
    function ComponentsModule() {
    }
    ComponentsModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [__WEBPACK_IMPORTED_MODULE_1__progress_bar_progress_bar__["a" /* ProgressBarComponent */],
                __WEBPACK_IMPORTED_MODULE_3__nodata_nodata__["a" /* NodataComponent */]],
            imports: [__WEBPACK_IMPORTED_MODULE_2__angular_common__["b" /* CommonModule */]],
            exports: [__WEBPACK_IMPORTED_MODULE_1__progress_bar_progress_bar__["a" /* ProgressBarComponent */],
                __WEBPACK_IMPORTED_MODULE_3__nodata_nodata__["a" /* NodataComponent */]]
        })
    ], ComponentsModule);
    return ComponentsModule;
}());

//# sourceMappingURL=components.module.js.map

/***/ }),

/***/ 492:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_platform_browser_dynamic__ = __webpack_require__(493);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__app_module__ = __webpack_require__(497);


Object(__WEBPACK_IMPORTED_MODULE_0__angular_platform_browser_dynamic__["a" /* platformBrowserDynamic */])().bootstrapModule(__WEBPACK_IMPORTED_MODULE_1__app_module__["a" /* AppModule */]);
//# sourceMappingURL=main.js.map

/***/ }),

/***/ 497:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* unused harmony export CustomTranslateLoader */
/* unused harmony export TranslateLoaderFactory */
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AppModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_platform_browser__ = __webpack_require__(54);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__ionic_native_splash_screen__ = __webpack_require__(406);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__ionic_native_status_bar__ = __webpack_require__(407);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__angular_http__ = __webpack_require__(364);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_rxjs_Observable__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_rxjs_Observable___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_7_rxjs_Observable__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__assets_i18n_zh__ = __webpack_require__(823);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__assets_i18n_en__ = __webpack_require__(824);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10_angularx_qrcode__ = __webpack_require__(825);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__angular_forms__ = __webpack_require__(42);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12__ionic_storage__ = __webpack_require__(409);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_13__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_14__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_15__ionic_native_clipboard__ = __webpack_require__(273);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_16__angular_platform_browser_animations__ = __webpack_require__(833);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_17__providers_backup__ = __webpack_require__(835);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_18__providers_HttpService__ = __webpack_require__(277);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_19__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_20__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_21__ionic_native_qr_scanner__ = __webpack_require__(411);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_22__app_component__ = __webpack_require__(836);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_23__pages_tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_24__pages_tabs_home_home_component__ = __webpack_require__(415);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_25__pages_tabs_my_my_component__ = __webpack_require__(475);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_26__pages_launcher_launcher_component__ = __webpack_require__(121);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_27__pages_wallet_manager_manager_component__ = __webpack_require__(476);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_28__pages_wallet_paypassword_reset_paypassword_reset_component__ = __webpack_require__(478);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_29__pages_wallet_import_import_component__ = __webpack_require__(484);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_30__pages_wallet_exprot_prikey_exprot_prikey_component__ = __webpack_require__(477);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_31__pages_mnemonic_mnemonic_component__ = __webpack_require__(413);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_32__pages_mnemonic_write_write_component__ = __webpack_require__(414);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_33__pages_wallet_address_address_component__ = __webpack_require__(471);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_34__pages_contacts_contacts_component__ = __webpack_require__(418);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_35__pages_coin_coin_component__ = __webpack_require__(416);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_36__pages_coin_transfer_transfer_component__ = __webpack_require__(70);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_37__pages_coin_payment_confirm_payment_confirm_component__ = __webpack_require__(214);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_38__pages_third_party_did_login_did_login_component__ = __webpack_require__(490);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_39__pages_coin_receive_receive_component__ = __webpack_require__(470);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_40__pages_coin_recharge_recharge_component__ = __webpack_require__(468);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_41__pages_coin_coin_select_coin_select_component__ = __webpack_require__(467);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_42__pages_coin_withdraw_withdraw_component__ = __webpack_require__(469);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_43__pages_contacts_contact_list_contact_list_component__ = __webpack_require__(198);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_44__pages_publickey_publickey__ = __webpack_require__(215);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_45__pages_contacts_contact_create_contact_create_component__ = __webpack_require__(417);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_46__pages_coin_coin_list_coin_list_component__ = __webpack_require__(473);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_47__pages_wallet_wallet_create_wallet_create_component__ = __webpack_require__(197);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_48__pages_coinlistpassword_coinlistpassword__ = __webpack_require__(927);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_49__pages_scancode_scancode__ = __webpack_require__(67);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_50__pages_txdetails_txdetails__ = __webpack_require__(466);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_51__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_52__providers_Logger__ = __webpack_require__(365);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_53__pages_coin_recordinfo_recordinfo_component__ = __webpack_require__(472);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_54__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_55__ionic_native_file_chooser__ = __webpack_require__(928);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_56__pages_testjni_testjni_component__ = __webpack_require__(929);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_57__components_components_module__ = __webpack_require__(491);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_58__pages_initializepage_initializepage__ = __webpack_require__(412);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_59__pages_createwalletname_createwalletname__ = __webpack_require__(488);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_60__pages_id_launcher_launcher__ = __webpack_require__(216);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_61__pages_id_home_home__ = __webpack_require__(65);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_62__pages_id_import_import__ = __webpack_require__(212);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_63__pages_id_manager_manager__ = __webpack_require__(456);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_64__pages_id_kyc_company_company__ = __webpack_require__(458);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_65__pages_id_result_result__ = __webpack_require__(455);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_66__pages_id_kyc_company_write_chain_company_write_chain__ = __webpack_require__(459);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_67__pages_id_kyc_person_write_chain_person_write_chain__ = __webpack_require__(127);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_68__pages_id_pathlist_pathlist__ = __webpack_require__(213);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_69__pages_id_companypathinfo_companypathinfo__ = __webpack_require__(457);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_70__pages_id_bankcardpathinfo_bankcardpathinfo__ = __webpack_require__(460);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_71__pages_id_phonepathinfo_phonepathinfo__ = __webpack_require__(462);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_72__pages_id_identitypathinfo_identitypathinfo__ = __webpack_require__(464);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_73__pages_id_identityauth_identityauth__ = __webpack_require__(465);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_74__pages_id_phoneauth_phoneauth__ = __webpack_require__(463);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_75__pages_id_bankcardauth_bankcardauth__ = __webpack_require__(461);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_76__pages_wallet_language_language__ = __webpack_require__(482);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_77__pages_walltelist_walltelist__ = __webpack_require__(474);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_78__pages_createmultiwallte_createmultiwallte__ = __webpack_require__(485);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_79__pages_walltemode_walltemode__ = __webpack_require__(486);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_80__pages_addpublickey_addpublickey__ = __webpack_require__(217);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_81__pages_addprivatekey_addprivatekey__ = __webpack_require__(483);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_82__pages_importprivatekey_importprivatekey__ = __webpack_require__(487);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_83__pages_paymentbox_paymentbox__ = __webpack_require__(97);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_84__pages_modifywalletname_modifywalletname__ = __webpack_require__(479);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_85__pages_mpublickey_mpublickey__ = __webpack_require__(128);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_86__pages_importmnemonic_importmnemonic__ = __webpack_require__(489);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_87__pages_exportmnemomic_exportmnemomic__ = __webpack_require__(480);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_88__pages_checkmnemomic_checkmnemomic__ = __webpack_require__(481);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_89__pages_scan_scan__ = __webpack_require__(66);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};













/**provider*/









/**pages*/






































/*id相关页面*/






























/*id相关页面*/
/** 通过类引用方式解析国家化文件 */
var CustomTranslateLoader = /** @class */ (function () {
    function CustomTranslateLoader() {
    }
    CustomTranslateLoader.prototype.getTranslation = function (lang) {
        return __WEBPACK_IMPORTED_MODULE_7_rxjs_Observable__["Observable"].create(function (observer) {
            switch (lang) {
                case 'zh':
                default:
                    observer.next(__WEBPACK_IMPORTED_MODULE_8__assets_i18n_zh__["a" /* zh */]);
                    break;
                case 'en':
                    observer.next(__WEBPACK_IMPORTED_MODULE_9__assets_i18n_en__["a" /* en */]);
            }
            observer.complete();
        });
    };
    return CustomTranslateLoader;
}());

function TranslateLoaderFactory() {
    return new CustomTranslateLoader();
}
var AppModule = /** @class */ (function () {
    function AppModule() {
    }
    AppModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_1__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_22__app_component__["a" /* AppComponent */],
                __WEBPACK_IMPORTED_MODULE_23__pages_tabs_tabs_component__["a" /* TabsComponent */],
                __WEBPACK_IMPORTED_MODULE_24__pages_tabs_home_home_component__["a" /* HomeComponent */],
                __WEBPACK_IMPORTED_MODULE_25__pages_tabs_my_my_component__["a" /* MyComponent */],
                __WEBPACK_IMPORTED_MODULE_26__pages_launcher_launcher_component__["a" /* LauncherComponent */],
                __WEBPACK_IMPORTED_MODULE_27__pages_wallet_manager_manager_component__["a" /* ManagerComponent */],
                __WEBPACK_IMPORTED_MODULE_28__pages_wallet_paypassword_reset_paypassword_reset_component__["a" /* PaypasswordResetComponent */],
                __WEBPACK_IMPORTED_MODULE_29__pages_wallet_import_import_component__["a" /* ImportComponent */],
                __WEBPACK_IMPORTED_MODULE_30__pages_wallet_exprot_prikey_exprot_prikey_component__["a" /* ExprotPrikeyComponent */],
                __WEBPACK_IMPORTED_MODULE_31__pages_mnemonic_mnemonic_component__["a" /* MnemonicComponent */],
                __WEBPACK_IMPORTED_MODULE_32__pages_mnemonic_write_write_component__["a" /* WriteComponent */],
                __WEBPACK_IMPORTED_MODULE_33__pages_wallet_address_address_component__["a" /* AddressComponent */],
                __WEBPACK_IMPORTED_MODULE_34__pages_contacts_contacts_component__["a" /* ContactsComponent */],
                __WEBPACK_IMPORTED_MODULE_35__pages_coin_coin_component__["a" /* CoinComponent */],
                __WEBPACK_IMPORTED_MODULE_36__pages_coin_transfer_transfer_component__["a" /* TransferComponent */],
                __WEBPACK_IMPORTED_MODULE_37__pages_coin_payment_confirm_payment_confirm_component__["a" /* PaymentConfirmComponent */],
                __WEBPACK_IMPORTED_MODULE_38__pages_third_party_did_login_did_login_component__["a" /* DidLoginComponent */],
                __WEBPACK_IMPORTED_MODULE_39__pages_coin_receive_receive_component__["a" /* ReceiveComponent */],
                __WEBPACK_IMPORTED_MODULE_40__pages_coin_recharge_recharge_component__["a" /* RechargeComponent */],
                __WEBPACK_IMPORTED_MODULE_41__pages_coin_coin_select_coin_select_component__["a" /* CoinSelectComponent */],
                __WEBPACK_IMPORTED_MODULE_42__pages_coin_withdraw_withdraw_component__["a" /* WithdrawComponent */],
                __WEBPACK_IMPORTED_MODULE_43__pages_contacts_contact_list_contact_list_component__["a" /* ContactListComponent */],
                __WEBPACK_IMPORTED_MODULE_44__pages_publickey_publickey__["a" /* PublickeyPage */],
                __WEBPACK_IMPORTED_MODULE_45__pages_contacts_contact_create_contact_create_component__["a" /* ContactCreateComponent */],
                __WEBPACK_IMPORTED_MODULE_46__pages_coin_coin_list_coin_list_component__["a" /* CoinListComponent */],
                __WEBPACK_IMPORTED_MODULE_47__pages_wallet_wallet_create_wallet_create_component__["a" /* WalletCreateComponent */],
                __WEBPACK_IMPORTED_MODULE_53__pages_coin_recordinfo_recordinfo_component__["a" /* RecordinfoComponent */],
                __WEBPACK_IMPORTED_MODULE_56__pages_testjni_testjni_component__["a" /* TestJniComponent */],
                __WEBPACK_IMPORTED_MODULE_60__pages_id_launcher_launcher__["a" /* IdLauncherComponent */],
                __WEBPACK_IMPORTED_MODULE_61__pages_id_home_home__["a" /* IdHomeComponent */],
                __WEBPACK_IMPORTED_MODULE_62__pages_id_import_import__["a" /* IdImportComponent */],
                __WEBPACK_IMPORTED_MODULE_63__pages_id_manager_manager__["a" /* IdManagerComponent */],
                __WEBPACK_IMPORTED_MODULE_64__pages_id_kyc_company_company__["a" /* IdKycCompanyComponent */],
                __WEBPACK_IMPORTED_MODULE_65__pages_id_result_result__["a" /* IdResultComponent */],
                __WEBPACK_IMPORTED_MODULE_66__pages_id_kyc_company_write_chain_company_write_chain__["a" /* CompanyWriteChainPage */],
                __WEBPACK_IMPORTED_MODULE_67__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */],
                __WEBPACK_IMPORTED_MODULE_68__pages_id_pathlist_pathlist__["a" /* PathlistPage */],
                __WEBPACK_IMPORTED_MODULE_69__pages_id_companypathinfo_companypathinfo__["a" /* CompanypathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_70__pages_id_bankcardpathinfo_bankcardpathinfo__["a" /* BankcardpathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_71__pages_id_phonepathinfo_phonepathinfo__["a" /* PhonepathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_72__pages_id_identitypathinfo_identitypathinfo__["a" /* IdentitypathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_73__pages_id_identityauth_identityauth__["a" /* IdentityauthPage */],
                __WEBPACK_IMPORTED_MODULE_74__pages_id_phoneauth_phoneauth__["a" /* PhoneauthPage */],
                __WEBPACK_IMPORTED_MODULE_75__pages_id_bankcardauth_bankcardauth__["a" /* BankcardauthPage */],
                __WEBPACK_IMPORTED_MODULE_76__pages_wallet_language_language__["a" /* LanguagePage */],
                __WEBPACK_IMPORTED_MODULE_77__pages_walltelist_walltelist__["a" /* WalltelistPage */],
                __WEBPACK_IMPORTED_MODULE_78__pages_createmultiwallte_createmultiwallte__["a" /* CreatemultiwalltePage */],
                __WEBPACK_IMPORTED_MODULE_79__pages_walltemode_walltemode__["a" /* WalltemodePage */],
                __WEBPACK_IMPORTED_MODULE_80__pages_addpublickey_addpublickey__["a" /* AddpublickeyPage */],
                __WEBPACK_IMPORTED_MODULE_81__pages_addprivatekey_addprivatekey__["a" /* AddprivatekeyPage */],
                __WEBPACK_IMPORTED_MODULE_82__pages_importprivatekey_importprivatekey__["a" /* ImportprivatekeyPage */],
                __WEBPACK_IMPORTED_MODULE_48__pages_coinlistpassword_coinlistpassword__["a" /* CoinlistpasswordPage */],
                __WEBPACK_IMPORTED_MODULE_49__pages_scancode_scancode__["a" /* ScancodePage */],
                __WEBPACK_IMPORTED_MODULE_50__pages_txdetails_txdetails__["a" /* TxdetailsPage */],
                __WEBPACK_IMPORTED_MODULE_58__pages_initializepage_initializepage__["a" /* InitializepagePage */],
                __WEBPACK_IMPORTED_MODULE_83__pages_paymentbox_paymentbox__["a" /* PaymentboxPage */],
                __WEBPACK_IMPORTED_MODULE_59__pages_createwalletname_createwalletname__["a" /* CreatewalletnamePage */],
                __WEBPACK_IMPORTED_MODULE_84__pages_modifywalletname_modifywalletname__["a" /* ModifywalletnamePage */],
                __WEBPACK_IMPORTED_MODULE_85__pages_mpublickey_mpublickey__["a" /* MpublickeyPage */],
                __WEBPACK_IMPORTED_MODULE_86__pages_importmnemonic_importmnemonic__["a" /* ImportmnemonicPage */],
                __WEBPACK_IMPORTED_MODULE_87__pages_exportmnemomic_exportmnemomic__["a" /* ExportmnemomicPage */],
                __WEBPACK_IMPORTED_MODULE_88__pages_checkmnemomic_checkmnemomic__["a" /* CheckmnemomicPage */],
                __WEBPACK_IMPORTED_MODULE_89__pages_scan_scan__["a" /* ScanPage */]
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_0__angular_platform_browser__["a" /* BrowserModule */],
                __WEBPACK_IMPORTED_MODULE_5__angular_http__["c" /* HttpModule */],
                __WEBPACK_IMPORTED_MODULE_11__angular_forms__["a" /* FormsModule */],
                __WEBPACK_IMPORTED_MODULE_6__ngx_translate_core__["b" /* TranslateModule */].forRoot({
                    loader: {
                        provide: __WEBPACK_IMPORTED_MODULE_6__ngx_translate_core__["a" /* TranslateLoader */],
                        useFactory: (TranslateLoaderFactory)
                    }
                }),
                __WEBPACK_IMPORTED_MODULE_10_angularx_qrcode__["a" /* QRCodeModule */],
                __WEBPACK_IMPORTED_MODULE_16__angular_platform_browser_animations__["a" /* BrowserAnimationsModule */],
                __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["f" /* IonicModule */].forRoot(__WEBPACK_IMPORTED_MODULE_22__app_component__["a" /* AppComponent */], {
                    backButtonText: "",
                    backButtonIcon: 'arrow-dropleft-circle',
                    iconMode: "ios",
                    mode: "ios",
                    tabsHideOnSubPages: 'true'
                }, {
                    links: [
                        { loadChildren: '../pages/about/about.module#AboutPageModule', name: 'AboutPage', segment: 'about', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/iconpromptbox/iconpromptbox.module#IconpromptboxPageModule', name: 'IconpromptboxPage', segment: 'iconpromptbox', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/inputpassword/inputpassword.module#InputpasswordPageModule', name: 'InputpasswordPage', segment: 'inputpassword', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/inputtickets/inputtickets.module#InputticketsPageModule', name: 'InputticketsPage', segment: 'inputtickets', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/joinvotelist/joinvotelist.module#JoinvotelistPageModule', name: 'JoinvotelistPage', segment: 'joinvotelist', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/lockdetails/lockdetails.module#LockdetailsPageModule', name: 'LockdetailsPage', segment: 'lockdetails', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/myvote/myvote.module#MyvotePageModule', name: 'MyvotePage', segment: 'myvote', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/nodeinformation/nodeinformation.module#NodeinformationPageModule', name: 'NodeinformationPage', segment: 'nodeinformation', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/signup/signup.module#SignupPageModule', name: 'SignupPage', segment: 'signup', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/superpoint.module#SuperpointPageModule', name: 'SuperpointPage', segment: 'superpoint', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/updateproducer/updateproducer.module#UpdateproducerPageModule', name: 'UpdateproducerPage', segment: 'updateproducer', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/votemanage/votemanage.module#VotemanagePageModule', name: 'VotemanagePage', segment: 'votemanage', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/votingrules/votingrules.module#VotingrulesPageModule', name: 'VotingrulesPage', segment: 'votingrules', priority: 'low', defaultHistory: [] },
                        { loadChildren: '../pages/supernodeelection/superpoint/pointvote/pointvote.module#PointvotePageModule', name: 'PointvotePage', segment: 'pointvote', priority: 'low', defaultHistory: [] }
                    ]
                }),
                __WEBPACK_IMPORTED_MODULE_12__ionic_storage__["a" /* IonicStorageModule */].forRoot({
                    name: '__walletdb',
                    driverOrder: ['localstorage', 'indexeddb', 'sqlite', 'websql']
                }),
                __WEBPACK_IMPORTED_MODULE_57__components_components_module__["a" /* ComponentsModule */]
            ],
            bootstrap: [__WEBPACK_IMPORTED_MODULE_2_ionic_angular__["d" /* IonicApp */]],
            entryComponents: [
                __WEBPACK_IMPORTED_MODULE_22__app_component__["a" /* AppComponent */],
                __WEBPACK_IMPORTED_MODULE_23__pages_tabs_tabs_component__["a" /* TabsComponent */],
                __WEBPACK_IMPORTED_MODULE_24__pages_tabs_home_home_component__["a" /* HomeComponent */],
                __WEBPACK_IMPORTED_MODULE_25__pages_tabs_my_my_component__["a" /* MyComponent */],
                __WEBPACK_IMPORTED_MODULE_26__pages_launcher_launcher_component__["a" /* LauncherComponent */],
                __WEBPACK_IMPORTED_MODULE_27__pages_wallet_manager_manager_component__["a" /* ManagerComponent */],
                __WEBPACK_IMPORTED_MODULE_28__pages_wallet_paypassword_reset_paypassword_reset_component__["a" /* PaypasswordResetComponent */],
                __WEBPACK_IMPORTED_MODULE_29__pages_wallet_import_import_component__["a" /* ImportComponent */],
                __WEBPACK_IMPORTED_MODULE_30__pages_wallet_exprot_prikey_exprot_prikey_component__["a" /* ExprotPrikeyComponent */],
                __WEBPACK_IMPORTED_MODULE_31__pages_mnemonic_mnemonic_component__["a" /* MnemonicComponent */],
                __WEBPACK_IMPORTED_MODULE_32__pages_mnemonic_write_write_component__["a" /* WriteComponent */],
                __WEBPACK_IMPORTED_MODULE_33__pages_wallet_address_address_component__["a" /* AddressComponent */],
                __WEBPACK_IMPORTED_MODULE_34__pages_contacts_contacts_component__["a" /* ContactsComponent */],
                __WEBPACK_IMPORTED_MODULE_35__pages_coin_coin_component__["a" /* CoinComponent */],
                __WEBPACK_IMPORTED_MODULE_36__pages_coin_transfer_transfer_component__["a" /* TransferComponent */],
                __WEBPACK_IMPORTED_MODULE_37__pages_coin_payment_confirm_payment_confirm_component__["a" /* PaymentConfirmComponent */],
                __WEBPACK_IMPORTED_MODULE_38__pages_third_party_did_login_did_login_component__["a" /* DidLoginComponent */],
                __WEBPACK_IMPORTED_MODULE_39__pages_coin_receive_receive_component__["a" /* ReceiveComponent */],
                __WEBPACK_IMPORTED_MODULE_40__pages_coin_recharge_recharge_component__["a" /* RechargeComponent */],
                __WEBPACK_IMPORTED_MODULE_41__pages_coin_coin_select_coin_select_component__["a" /* CoinSelectComponent */],
                __WEBPACK_IMPORTED_MODULE_42__pages_coin_withdraw_withdraw_component__["a" /* WithdrawComponent */],
                __WEBPACK_IMPORTED_MODULE_43__pages_contacts_contact_list_contact_list_component__["a" /* ContactListComponent */],
                __WEBPACK_IMPORTED_MODULE_44__pages_publickey_publickey__["a" /* PublickeyPage */],
                __WEBPACK_IMPORTED_MODULE_45__pages_contacts_contact_create_contact_create_component__["a" /* ContactCreateComponent */],
                __WEBPACK_IMPORTED_MODULE_46__pages_coin_coin_list_coin_list_component__["a" /* CoinListComponent */],
                __WEBPACK_IMPORTED_MODULE_47__pages_wallet_wallet_create_wallet_create_component__["a" /* WalletCreateComponent */],
                __WEBPACK_IMPORTED_MODULE_53__pages_coin_recordinfo_recordinfo_component__["a" /* RecordinfoComponent */],
                __WEBPACK_IMPORTED_MODULE_56__pages_testjni_testjni_component__["a" /* TestJniComponent */],
                __WEBPACK_IMPORTED_MODULE_60__pages_id_launcher_launcher__["a" /* IdLauncherComponent */],
                __WEBPACK_IMPORTED_MODULE_61__pages_id_home_home__["a" /* IdHomeComponent */],
                __WEBPACK_IMPORTED_MODULE_62__pages_id_import_import__["a" /* IdImportComponent */],
                __WEBPACK_IMPORTED_MODULE_63__pages_id_manager_manager__["a" /* IdManagerComponent */],
                __WEBPACK_IMPORTED_MODULE_64__pages_id_kyc_company_company__["a" /* IdKycCompanyComponent */],
                __WEBPACK_IMPORTED_MODULE_65__pages_id_result_result__["a" /* IdResultComponent */],
                __WEBPACK_IMPORTED_MODULE_66__pages_id_kyc_company_write_chain_company_write_chain__["a" /* CompanyWriteChainPage */],
                __WEBPACK_IMPORTED_MODULE_67__pages_id_kyc_person_write_chain_person_write_chain__["a" /* PersonWriteChainPage */],
                __WEBPACK_IMPORTED_MODULE_68__pages_id_pathlist_pathlist__["a" /* PathlistPage */],
                __WEBPACK_IMPORTED_MODULE_69__pages_id_companypathinfo_companypathinfo__["a" /* CompanypathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_70__pages_id_bankcardpathinfo_bankcardpathinfo__["a" /* BankcardpathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_71__pages_id_phonepathinfo_phonepathinfo__["a" /* PhonepathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_72__pages_id_identitypathinfo_identitypathinfo__["a" /* IdentitypathinfoPage */],
                __WEBPACK_IMPORTED_MODULE_73__pages_id_identityauth_identityauth__["a" /* IdentityauthPage */],
                __WEBPACK_IMPORTED_MODULE_74__pages_id_phoneauth_phoneauth__["a" /* PhoneauthPage */],
                __WEBPACK_IMPORTED_MODULE_75__pages_id_bankcardauth_bankcardauth__["a" /* BankcardauthPage */],
                __WEBPACK_IMPORTED_MODULE_76__pages_wallet_language_language__["a" /* LanguagePage */],
                __WEBPACK_IMPORTED_MODULE_77__pages_walltelist_walltelist__["a" /* WalltelistPage */],
                __WEBPACK_IMPORTED_MODULE_78__pages_createmultiwallte_createmultiwallte__["a" /* CreatemultiwalltePage */],
                __WEBPACK_IMPORTED_MODULE_79__pages_walltemode_walltemode__["a" /* WalltemodePage */],
                __WEBPACK_IMPORTED_MODULE_80__pages_addpublickey_addpublickey__["a" /* AddpublickeyPage */],
                __WEBPACK_IMPORTED_MODULE_81__pages_addprivatekey_addprivatekey__["a" /* AddprivatekeyPage */],
                __WEBPACK_IMPORTED_MODULE_82__pages_importprivatekey_importprivatekey__["a" /* ImportprivatekeyPage */],
                __WEBPACK_IMPORTED_MODULE_48__pages_coinlistpassword_coinlistpassword__["a" /* CoinlistpasswordPage */],
                __WEBPACK_IMPORTED_MODULE_49__pages_scancode_scancode__["a" /* ScancodePage */],
                __WEBPACK_IMPORTED_MODULE_50__pages_txdetails_txdetails__["a" /* TxdetailsPage */],
                __WEBPACK_IMPORTED_MODULE_58__pages_initializepage_initializepage__["a" /* InitializepagePage */],
                __WEBPACK_IMPORTED_MODULE_83__pages_paymentbox_paymentbox__["a" /* PaymentboxPage */],
                __WEBPACK_IMPORTED_MODULE_59__pages_createwalletname_createwalletname__["a" /* CreatewalletnamePage */],
                __WEBPACK_IMPORTED_MODULE_84__pages_modifywalletname_modifywalletname__["a" /* ModifywalletnamePage */],
                __WEBPACK_IMPORTED_MODULE_85__pages_mpublickey_mpublickey__["a" /* MpublickeyPage */],
                __WEBPACK_IMPORTED_MODULE_86__pages_importmnemonic_importmnemonic__["a" /* ImportmnemonicPage */],
                __WEBPACK_IMPORTED_MODULE_87__pages_exportmnemomic_exportmnemomic__["a" /* ExportmnemomicPage */],
                __WEBPACK_IMPORTED_MODULE_88__pages_checkmnemomic_checkmnemomic__["a" /* CheckmnemomicPage */],
                __WEBPACK_IMPORTED_MODULE_89__pages_scan_scan__["a" /* ScanPage */]
            ],
            providers: [
                __WEBPACK_IMPORTED_MODULE_4__ionic_native_status_bar__["a" /* StatusBar */],
                __WEBPACK_IMPORTED_MODULE_3__ionic_native_splash_screen__["a" /* SplashScreen */],
                __WEBPACK_IMPORTED_MODULE_55__ionic_native_file_chooser__["a" /* FileChooser */],
                __WEBPACK_IMPORTED_MODULE_15__ionic_native_clipboard__["a" /* Clipboard */],
                __WEBPACK_IMPORTED_MODULE_13__providers_Config__["a" /* Config */],
                __WEBPACK_IMPORTED_MODULE_14__providers_Localstorage__["a" /* LocalStorage */],
                __WEBPACK_IMPORTED_MODULE_51__providers_Native__["a" /* Native */],
                __WEBPACK_IMPORTED_MODULE_52__providers_Logger__["a" /* Logger */],
                __WEBPACK_IMPORTED_MODULE_54__providers_WalletManager__["a" /* WalletManager */],
                __WEBPACK_IMPORTED_MODULE_17__providers_backup__["a" /* BackupProvider */],
                __WEBPACK_IMPORTED_MODULE_18__providers_HttpService__["a" /* HttpService */],
                __WEBPACK_IMPORTED_MODULE_19__providers_popup__["a" /* PopupProvider */],
                __WEBPACK_IMPORTED_MODULE_20__providers_DataManager__["a" /* DataManager */],
                __WEBPACK_IMPORTED_MODULE_21__ionic_native_qr_scanner__["a" /* QRScanner */],
                { provide: __WEBPACK_IMPORTED_MODULE_1__angular_core__["u" /* ErrorHandler */], useClass: __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["e" /* IonicErrorHandler */] }
            ]
        })
    ], AppModule);
    return AppModule;
}());

//# sourceMappingURL=app.module.js.map

/***/ }),

/***/ 5:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return Native; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ionic_native_clipboard__ = __webpack_require__(273);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_HttpService__ = __webpack_require__(277);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Logger__ = __webpack_require__(365);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};






/***
 * APP底层交互
 */
var Native = /** @class */ (function () {
    function Native(toastCtrl, clipboard, translate, app, loadingCtrl, http) {
        this.toastCtrl = toastCtrl;
        this.clipboard = clipboard;
        this.translate = translate;
        this.app = app;
        this.loadingCtrl = loadingCtrl;
        this.http = http;
        this.mnemonicLang = "english";
        this.loadingIsOpen = false;
    }
    Native.prototype.info = function (message) {
        __WEBPACK_IMPORTED_MODULE_5__providers_Logger__["a" /* Logger */].info(message);
    };
    Native.prototype.toast = function (_message, duration) {
        if (_message === void 0) { _message = '操作完成'; }
        if (duration === void 0) { duration = 2000; }
        //this.toast.show(message, String(duration), 'bottom').subscribe();
        this.toastCtrl.create({
            message: _message,
            duration: 2000,
            position: 'top'
        }).present();
    };
    Native.prototype.toast_trans = function (_message, duration) {
        if (_message === void 0) { _message = ''; }
        if (duration === void 0) { duration = 2000; }
        //this.toast.show(message, String(duration), 'bottom').subscribe();
        _message = this.translate.instant(_message);
        this.toastCtrl.create({
            message: _message,
            duration: 2000,
            position: 'top'
        }).present();
    };
    /**
     * 复制到剪贴板
     * @param options
     * @constructor
     */
    Native.prototype.copyClipboard = function (text) {
        return this.clipboard.copy(text);
    };
    Native.prototype.Go = function (navCtrl, page, options) {
        if (options === void 0) { options = {}; }
        navCtrl.push(page, options);
    };
    Native.prototype.setRootRouter = function (router) {
        this.app.getRootNav().setRoot(router);
    };
    Native.prototype.getMnemonicLang = function () {
        return this.mnemonicLang;
    };
    Native.prototype.setMnemonicLang = function (lang) {
        this.mnemonicLang = lang;
    };
    Native.prototype.clone = function (myObj) {
        if (typeof (myObj) != 'object')
            return myObj;
        if (myObj == null)
            return myObj;
        var myNewObj;
        if (myObj instanceof (Array)) {
            myNewObj = new Array();
        }
        else {
            myNewObj = new Object();
        }
        for (var i in myObj)
            myNewObj[i] = this.clone(myObj[i]);
        return myNewObj;
    };
    /**
   * 统一调用此方法显示loading
   * @param content 显示的内容
   */
    Native.prototype.showLoading = function (content) {
        if (content === void 0) { content = ''; }
        if (!this.loadingIsOpen) {
            this.loadingIsOpen = true;
            this.loading = this.loadingCtrl.create({
                content: content
            });
            return this.loading.present();
            // setTimeout(() => {//最长显示10秒
            //   this.loadingIsOpen && this.loading.dismiss();
            //   this.loadingIsOpen = false;
            // }, 20000);
        }
    };
    ;
    /**
     * 关闭loading
     */
    Native.prototype.hideLoading = function () {
        this.loadingIsOpen && this.loading.dismiss();
        this.loadingIsOpen = false;
    };
    ;
    Native.prototype.getHttp = function () {
        return this.http;
    };
    Native.prototype.getTimestamp = function () {
        return new Date().getTime().toString();
    };
    Native = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["p" /* ToastController */],
            __WEBPACK_IMPORTED_MODULE_2__ionic_native_clipboard__["a" /* Clipboard */],
            __WEBPACK_IMPORTED_MODULE_3__ngx_translate_core__["c" /* TranslateService */],
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["b" /* App */],
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["i" /* LoadingController */],
            __WEBPACK_IMPORTED_MODULE_4__providers_HttpService__["a" /* HttpService */]])
    ], Native);
    return Native;
}());

//# sourceMappingURL=Native.js.map

/***/ }),

/***/ 65:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return IdHomeComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__pages_id_import_import__ = __webpack_require__(212);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__pages_id_manager_manager__ = __webpack_require__(456);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_id_pathlist_pathlist__ = __webpack_require__(213);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__providers_DataManager__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12__providers_Util__ = __webpack_require__(8);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};













var IdHomeComponent = /** @class */ (function () {
    function IdHomeComponent(navCtrl, navParams, native, walletManager, localStorage, events, dataManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.localStorage = localStorage;
        this.events = events;
        this.dataManager = dataManager;
        this.init();
    }
    IdHomeComponent.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.navBar.backButtonClick = function (e) {
            _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_3__pages_tabs_tabs_component__["a" /* TabsComponent */]);
        };
    };
    IdHomeComponent.prototype.init = function () {
        var _this = this;
        var self = this;
        this.localStorage.get("kycId").then(function (val) {
            var seqNumJsonObj = JSON.parse(val);
            _this.kycIdArr = __WEBPACK_IMPORTED_MODULE_12__providers_Util__["a" /* Util */].objtoarr(seqNumJsonObj);
            console.info("ElastosJs IdHomeComponent val" + val);
            self.initSeqObj(seqNumJsonObj);
            _this.kycIdArr.forEach(function (e) {
                console.info("ElastosJs IdHomeComponent e.id registerIdListener begin  " + e.id);
                self.walletManager.registerIdListener(e.id, function (data) {
                    console.info("home.ts ElastosJs ngOnInit registerIdListener data " + JSON.stringify(data));
                    //alert("home.ts createDID registerIdListener  data  callback"+ JSON.stringify(data));
                    //first commit
                    if (data["path"] == "Added") {
                        var valueObj = JSON.parse(data["value"]);
                        console.info("home.ts ElastosJs ngOnInit registerIdListener valueObj " + JSON.stringify(valueObj));
                        //console.info("home.ts ElastosJs ngOnInit registerIdListener valueObj[\"Contents\"].length  "+ valueObj["Contents"].length);
                        //console.info("home.ts ElastosJs ngOnInit registerIdListener Proof "+ valueObj["Contents"][0]["Values"][0]["Proof"] );
                        if ((valueObj["Contents"].length > 0) && (valueObj["Contents"][0]["Values"].length > 0) && valueObj["Contents"][0]["Values"][0]["Proof"]) {
                            var proofObj = JSON.parse(valueObj["Contents"][0]["Values"][0]["Proof"]);
                            console.info("home.ts ElastosJs ngOnInit proofObj[\"signature\"]  " + proofObj["signature"]);
                            var seqNumObj = self.dataManager.getSeqNumObj(proofObj["signature"]);
                            var serialNum = seqNumObj["serialNum"];
                            console.info("home.ts ElastosJs ngOnInit serialNum " + serialNum);
                            self.setOrderStatus(5, serialNum);
                            ////
                            //let  idJson = self.dataManager.OutPutIDJson(data.id, valueObj["Contents"][0]["Path"], proofObj["signature"]);
                            var idJson = self.dataManager.OutPutIDJson(data.id, valueObj["Contents"][0]["Path"], proofObj["signature"]);
                            self.testDataHash(idJson);
                            ////
                            // self.dataManager.addIdPathJson(data.id, valueObj["Contents"][0]["Path"], valueObj);
                        }
                    }
                    //alert("home.ts createDID registerIdListener ngOnInit data  callback"+ JSON.stringify(data));
                    //console.info("home.ts ElastosJs createDID registerIdListener " + JSON.stringify(data));
                    console.info("home.ts ElastosJs ngOnInit registerIdListener  data  callback !!!!!" + JSON.stringify(data));
                });
                console.info("ElastosJs IdHomeComponent e.id  end registerIdListener" + e.id);
            });
        });
        this.events.subscribe('idhome:update', function () {
            _this.localStorage.get("kycId").then(function (val) {
                _this.kycIdArr = __WEBPACK_IMPORTED_MODULE_12__providers_Util__["a" /* Util */].objtoarr(JSON.parse(val));
            });
        });
    };
    IdHomeComponent.prototype.testDataHash = function (IDJsonObj) {
        // let IDJsonObj = {
        //   "Id": "ihWrYTvJ4FYHBuQ5mwmTNTVXenSfvWHDy9",
        //   "Path": "kyc/enterprise",
        //   "SignContent": {
        //     "type": "enterprise",
        //     "result": "success",
        //     "retdata": {
        //       "app": "b1c0b7028c8c4be3beafc4c4812ae92e",
        //       "signature": "4a2e50905a55e1b6156410e360c083c0a85cad0ef1f089d8a6eea87a8f1e225d74cefcaea92c69ad7c4a77c53dccc4b5fa090019200e5fda4c505ba4eccbc612",
        //       "RegistrationNum": "911101080804655794",
        //       "legalPerson": "詹克团",
        //       "word": "北京比特大陆科技有限公司",
        //       "authid": "12345678",
        //       "ts": "1535103449"
        //     },
        //     "message": "认证成功",
        //     "timestamp": "1535103453088"
        //   },
        //   "DataHash": [{
        //     "hash": "7f6d1d62480d06e939999f33cc9f3802602236dccfb8243a2e74176b9fb905ab",
        //     "KycContent": {
        //       "word": "北京比特大陆科技有限公司",
        //       "legalPerson": "詹克团",
        //       "registrationNum": "911101080804655794"
        //     },
        //     "Proof": "{\"signature\":\"3046022100fb11acd29f09ca0b3d7d64d3baa1eb462aa31ecbf6e36d2950ea75d22b349793022100ee3e38132242a229e093b7ec10305b5104a35c0cdc2c30c8230524eabbfeb32c\",\"notary\":\"COOIX\"}"
        //   }]
        // };
        var DataHashArry = IDJsonObj["DataHash"];
        var DataHashElement = DataHashArry[0];
        console.info("Elastjs testDataHash DataHashElement " + JSON.stringify(DataHashElement));
        var valueObj = {};
        valueObj["Proof"] = DataHashElement["Proof"];
        var kycContent = DataHashElement["KycContent"];
        console.info("Elastjs testDataHash kycContent " + JSON.stringify(kycContent));
        console.info("Elastjs testDataHash valueObj[\"proof\"] " + valueObj["Proof"]);
        var authDataHash = __WEBPACK_IMPORTED_MODULE_6__providers_IDManager__["a" /* IDManager */].hash(JSON.stringify(kycContent) + valueObj["Proof"]);
        valueObj["DataHash"] = __WEBPACK_IMPORTED_MODULE_6__providers_IDManager__["a" /* IDManager */].hash(authDataHash + valueObj["Proof"]);
        console.info("ElastJs testDataHash DataHash " + valueObj["DataHash"] + " targetHash " + IDJsonObj["DataHash"][0]["hash"]);
    };
    IdHomeComponent.prototype.initSeqObj = function (allStoreSeqNumJsonObj) {
        console.info("ElastosJs initSeqObj begin allStoreSeqNumJsonObj" + JSON.stringify(allStoreSeqNumJsonObj));
        var self = this;
        var ids = allStoreSeqNumJsonObj;
        for (var id in ids) {
            var idJsonObj = ids[id];
            if (!idJsonObj["kyc"]) {
                continue;
            }
            var _loop_1 = function (authType) {
                if (!idJsonObj["kyc"][authType]["order"]) {
                    return "continue";
                }
                var order = idJsonObj["kyc"][authType]["order"];
                var _loop_2 = function (prop) {
                    if (order[prop]["params"] && order[prop]["params"]["adata"]) {
                        addataArry = [];
                        addataArry = order[prop]["params"]["adata"];
                        addataArry.forEach(function (value) {
                            if (value && value["retdata"]) {
                                if (value["retdata"]["signature"]) {
                                    var sign = value["retdata"]["signature"];
                                    self.dataManager.addSeqNumObj(sign, order[prop]);
                                    //console.info( "ElastosJs add sign " + sign + " obj "+ JSON.stringify(order[prop]));
                                }
                            }
                        });
                    }
                };
                for (var prop in order) {
                    _loop_2(prop);
                }
            };
            var addataArry;
            for (var authType in idJsonObj["kyc"]) {
                _loop_1(authType);
            }
        }
        console.info("ElastosJs initSeqObj end ");
    };
    IdHomeComponent.prototype.onNext = function (type) {
        switch (type) {
            case 0:
                this.createDID();
                break;
            case 1:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_1__pages_id_import_import__["a" /* IdImportComponent */]);
                break;
            case 2:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_2__pages_id_manager_manager__["a" /* IdManagerComponent */]);
                break;
        }
    };
    IdHomeComponent.prototype.onItem = function (item) {
        //this.Go(IdAppListComponent,{"id":item.id});
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_5__pages_id_pathlist_pathlist__["a" /* PathlistPage */], { "id": item.id });
    };
    IdHomeComponent.prototype.createDID = function () {
        var _this = this;
        this.walletManager.createDID("s12345678", function (result) {
            var idObj = { id: result.didname };
            var self = _this;
            _this.walletManager.registerIdListener(result.didname, function (data) {
                console.info("home.ts ElastosJs createDID registerIdListener " + JSON.stringify(data));
                //alert("home.ts createDID registerIdListener  data  callback"+ JSON.stringify(data));
                //first commit
                if (data["path"] == "Added") {
                    var valueObj = JSON.parse(data["value"]);
                    if ((valueObj["Contents"].length > 0) && (valueObj["Contents"][0]["Values"].length > 0) && valueObj["Contents"][0]["Values"][0]["Proof"]) {
                        var proofObj = JSON.parse(valueObj["Contents"][0]["Values"][0]["Proof"]);
                        console.info("home.ts ElastosJs createDID proofObj[\"signature\"]  " + proofObj["signature"]);
                        var seqNumObj = self.dataManager.getSeqNumObj(proofObj["signature"]);
                        var serialNum = seqNumObj["serialNum"];
                        console.info("home.ts ElastosJs createDID serialNum " + serialNum);
                        self.setOrderStatus(5, serialNum);
                        var idJson = self.dataManager.OutPutIDJson(data.id, valueObj["Contents"][0]["Path"], proofObj["signature"]);
                        self.testDataHash(idJson);
                        //self.dataManager.addIdPathJson(data.id, valueObj["Contents"][0]["Path"], valueObj);
                        //self.dataManager.addSignCont();
                        //alert("home.ts createDID registerIdListener  data  callback"+ JSON.stringify(data));
                        /*for(let ele of valueObj["Contents"]){
                          //get value
            
                          let proofObj = JSON.parse(ele["Proof"])
            
                          //newSeqNumObj这里可能有多个 提交的。 要找到path对应的那个
                          let newSeqNumObj = self.dataManager.getSeqNumObj(proofObj["signature"]);
            
                          //遍历result中的proof 找到对应的seqNumObj 比较这两个seqNumObj中的关键字。如果相同则先删除后添加。
                          //否则添加
                          self.walletManager.didGetValue(data["id"] , ele["Path"] ,(result)=>{
            
                          })
                          //check duplicate
            
                          //setvalue
                        }*/
                        //
                    }
                }
                //console.info("home.ts ElastosJs createDID registerIdListener " + JSON.stringify(data));
                console.info("home.ts ElastosJs createDID registerIdListener  data  callback !!!!!" + JSON.stringify(data));
            });
            _this.localStorage.add("kycId", idObj).then(function () {
                _this.kycIdArr.push({ id: result.didname });
            });
        });
    };
    IdHomeComponent.prototype.getDID = function () {
        var _this = this;
        this.walletManager.getDIDList(function (result) {
            _this.kycIdArr = JSON.parse(result["list"]);
        });
    };
    IdHomeComponent.prototype.setOrderStatus = function (status, serialNum) {
        var _this = this;
        console.info("ElastJs setOrderStatus begin status " + status + " serialNum " + serialNum);
        var serids = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getSerIds();
        var serid = serids[serialNum];
        console.info("ElastJs setOrderStatus serid " + JSON.stringify(serid));
        console.info("ElastJs setOrderStatus serids " + JSON.stringify(serids));
        var did = serid["id"];
        var path = serid["path"];
        console.info("ElastJs setOrderStatus appr " + path);
        var idsObj = {};
        this.localStorage.getKycList("kycId").then(function (val) {
            console.info("ElastJs setOrderStatus getKycList " + val);
            if (val == null || val === undefined || val === {} || val === '') {
                console.info("ElastJs setOrderStatus getKycList err return ");
                return;
            }
            idsObj = JSON.parse(val);
            console.info("ElastJs setOrderStatus before chg status did " + did + " path " + path + " serialNum " + serialNum + " status " + status);
            idsObj[did][path][serialNum]["pathStatus"] = status;
            _this.localStorage.set("kycId", idsObj).then(function () {
                _this.events.publish("order:update", status, path);
                console.info("ElastJs setOrderStatus pulish order ");
            });
        });
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["_8" /* ViewChild */])(__WEBPACK_IMPORTED_MODULE_7_ionic_angular__["m" /* Navbar */]),
        __metadata("design:type", __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["m" /* Navbar */])
    ], IdHomeComponent.prototype, "navBar", void 0);
    IdHomeComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'id-home',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/id/home/home.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-id-home\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <div class="id-box">\n\n        <div class="home-top1">\n            <img class="id-logo" src="./assets/images/1.0logo.png">\n            <div>{{ \'text-id-home-prompt\' | translate }}</div>\n\n        </div>\n\n\n\n        <ul class="navID">\n            <li>\n                <a (click)="onNext(0)">\n                    <i class="new"></i>\n                    <span>{{ \'text-id-create\' | translate }}</span>\n                </a>\n            </li>\n            <li>\n                <a (click)="onNext(1)">\n                    <i class="import"></i>\n                    <span>{{ \'text-id-import\' | translate }}</span>\n                </a>\n            </li>\n            <li class="last-li">\n                <a (click)="onNext(2)">\n                    <i class="guanli"></i>\n                    <span>{{ \'text-id-manager\' | translate }}</span>\n                </a>\n            </li>\n        </ul>\n        <div class="center-id">\n            <h3>{{ \'text-id-my\' | translate }}</h3>\n            <ul class="idList">\n                <li class="item" *ngFor="let item of kycIdArr; let i = index" (click)="onItem(item)">\n                    <a class="tiaozhuan">\n                        <i class="icon-i">{{i+1}}</i>\n                        <div class="item-text">\n                            <span class="item-text-title huan-hang">{{item.id}}</span>\n                            <p *ngIf="item.createType===1">\n                                {{ \'text-update-time\' | translate }}：{{item.updateTiem}}&nbsp;&nbsp; {{item.finshNumber}}/{{item.maxNumber}}&nbsp;&nbsp;{{ \'text-person\' | translate }}\n                            </p>\n                            <p *ngIf="item.createType===2">\n                                {{ \'text-update-time\' | translate }}：{{item.updateTiem}}&nbsp;&nbsp; {{item.finshNumber}}/{{item.maxNumber}}&nbsp;&nbsp;{{ \'text-company\' | translate }}\n                            </p>\n                        </div>\n                        <i class="to-right"></i>\n                    </a>\n                </li>\n            </ul>\n\n        </div>\n        <div style="height: 100px;"></div>\n    </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/id/home/home.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_7_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_9__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_8__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_10__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_7_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_11__providers_DataManager__["a" /* DataManager */]])
    ], IdHomeComponent);
    return IdHomeComponent;
}());

//# sourceMappingURL=home.js.map

/***/ }),

/***/ 66:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ScanPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ionic_native_qr_scanner__ = __webpack_require__(411);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pages_txdetails_txdetails__ = __webpack_require__(466);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var ScanPage = /** @class */ (function () {
    function ScanPage(navCtrl, navParams, qrScanner, viewCtrl, events, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.qrScanner = qrScanner;
        this.viewCtrl = viewCtrl;
        this.events = events;
        this.native = native;
        this.isShow = false; //控制显示背景，避免切换页面卡顿
        //默认为false
        this.light = false;
        this.frontCamera = false;
        this.pageType = this.navParams.get("pageType");
    }
    ScanPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        this.qrScanner.prepare().then(function (status) {
            if (status.authorized) {
                // camera permission was granted
                // start scanning
                var scanSub = _this.qrScanner.scan().subscribe(function (text) {
                    switch (_this.pageType) {
                        case "1":
                            var toaddress = "";
                            if (text.indexOf('elastos') != -1) {
                                toaddress = text.split(":")[1];
                            }
                            else {
                                toaddress = text.split(":")[0];
                            }
                            _this.events.publish("address:update", toaddress);
                            _this.hideCamera();
                            // stop scanning
                            _this.navCtrl.pop();
                            break;
                        case "3":
                            _this.hideCamera();
                            _this.navCtrl.pop();
                            var senddata = { "content": text, type: 4 };
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_txdetails_txdetails__["a" /* TxdetailsPage */], senddata);
                            break;
                        case "4":
                            _this.hideCamera();
                            _this.navCtrl.pop();
                            var senddata1 = { "content": text, type: 3 };
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_3__pages_txdetails_txdetails__["a" /* TxdetailsPage */], senddata1);
                            break;
                        case "5":
                            _this.events.publish("publickey:update", text);
                            _this.hideCamera();
                            // stop scanning
                            _this.navCtrl.pop();
                            break;
                        case "6":
                            _this.events.publish("privatekey:update", text);
                            _this.hideCamera();
                            // stop scanning
                            _this.navCtrl.pop();
                            break;
                    }
                });
                // show camera preview
                _this.qrScanner.show();
                // wait for user to scan something,then the observable callback will be called
            }
            else if (status.denied) {
                // camera permission was permanently denied
                // you must use QRScanner.openSettings() method to guide the user to the settings page
                // then they can grant the permission from there
            }
            else {
                // permission was denied, but not permanently. You can ask for permission again at a later time.
            }
        }).catch(function (e) { return console.log('Error is', e); });
    };
    ScanPage.prototype.ionViewDidEnter = function () {
        //页面可见时才执行
        this.showCamera();
        this.isShow = true; //显示背景
    };
    /** * 闪光灯控制，默认关闭 */
    ScanPage.prototype.toggleLight = function () {
        if (this.light) {
            this.qrScanner.disableLight();
        }
        else {
            this.qrScanner.enableLight();
        }
        this.light = !this.light;
    };
    /** * 前后摄像头互换 */
    ScanPage.prototype.toggleCamera = function () {
        if (this.frontCamera) {
            this.qrScanner.useBackCamera();
        }
        else {
            this.qrScanner.useFrontCamera();
        }
        this.frontCamera = !this.frontCamera;
    };
    ScanPage.prototype.showCamera = function () {
        window.document.querySelector('ion-app').classList.add('cameraView');
    };
    ScanPage.prototype.hideCamera = function () {
        window.document.querySelector('ion-app').classList.remove('cameraView');
        this.qrScanner.hide(); //需要关闭扫描，否则相机一直开着
        this.qrScanner.destroy(); //关闭
    };
    ScanPage.prototype.ionViewWillLeave = function () {
        this.hideCamera();
    };
    ScanPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-scan',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/scan/scan.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title>扫描中……</ion-title>\n    </ion-navbar>\n</ion-header>\n\n<ion-content no-scroll [ngClass]="{\'qrscanner\':isShow}">\n    <div [ngClass]="{\'qrscanner-area\':isShow}"> </div>\n    <div [ngClass]="{\'through-line\':isShow}"></div>\n    <div class="button-bottom"> <button (click)="toggleLight()" ion-fab class="icon-camera" margin-right> <ion-icon name="flash"></ion-icon> </button> <button (click)="toggleCamera()" ion-fab class="icon-camera"> <ion-icon name="reverse-camera"></ion-icon> </button> </div>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/scan/scan.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__ionic_native_qr_scanner__["a" /* QRScanner */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["q" /* ViewController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */]])
    ], ScanPage);
    return ScanPage;
}());

//# sourceMappingURL=scan.js.map

/***/ }),

/***/ 67:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ScancodePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var ScancodePage = /** @class */ (function () {
    function ScancodePage(navCtrl, navParams, native, walletManager, zone, plt) {
        var _this = this;
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.zone = zone;
        this.plt = plt;
        this.qrcode = null;
        this.txHash = "";
        this.toAddress = "";
        this.iwidth = null;
        this.iwidth = (this.plt.width() - 10).toString();
        var params = this.navParams.data;
        this.fee = params["tx"]["fee"];
        var txObj = params["tx"]["raw"];
        this.walletManager.decodeTransactionFromString(txObj, function (raw) {
            if (raw["success"]) {
                _this.native.info(raw);
                _this.txHash = JSON.parse(raw["success"])["TxHash"];
                _this.toAddress = JSON.parse(raw["success"])["Outputs"][0]["Address"];
                _this.amount = JSON.parse(raw["success"])["Outputs"][0]["Amount"] / __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].SELA;
            }
        });
        this.zone.run(function () {
            _this.qrcode = JSON.stringify(params);
        });
        this.native.info(this.navParams.data);
    }
    ScancodePage.prototype.ionViewDidLoad = function () {
    };
    ScancodePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-scancode',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/scancode/scancode.html"*/'<!--\n  Generated template for the ScancodePage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title style="text-align: center">{{\'text-scan-code\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content>\n    <div style="padding-bottom:10px">\n        <qrcode class="receive-qrocde" [qrdata]="qrcode" [size]="iwidth" [level]="\'M\'"></qrcode>\n    </div>\n    <ul>\n        <li>\n            {{\'transaction-id\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{txHash}}\n        </li>\n\n        <li>\n            {{\'transfer-address\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{toAddress}}\n        </li>\n        <li>\n            {{\'text-price\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{amount}}\n        </li>\n        <li>\n            {{\'text-fees\' | translate}}\n        </li>\n        <li class="bottom-border">\n            {{fee}}\n        </li>\n    </ul>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/scancode/scancode.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["n" /* Platform */]])
    ], ScancodePage);
    return ScancodePage;
}());

//# sourceMappingURL=scancode.js.map

/***/ }),

/***/ 7:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return WalletManager; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_ionic_angular__ = __webpack_require__(2);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





/***
 * wallet jni 交互
 *
 * WalletManager.ts -> Wallet.js -> wallet.java -> WalletManager.java
 */
var WalletManager = /** @class */ (function () {
    function WalletManager(native, event, popupProvider) {
        this.native = native;
        this.event = event;
        this.popupProvider = popupProvider;
        this.wallet = cordova.plugins.Wallet;
        //this.wallet = {};
    }
    WalletManager_1 = WalletManager;
    //--------------------------------------------------------------------------------子钱包操作
    /***
     * 创建子钱包
     * @param {string} masterWalletId
     * @param {string} chainID
     * @param {long} feePerKb
     */
    WalletManager.prototype.createSubWallet = function (masterWalletId, chainID, feePerKb, Fun) {
        var _this = this;
        this.wallet.createSubWallet([masterWalletId, chainID, feePerKb], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /***
     * 恢复子钱包
     * @param {string} masterWalletId
     * @param {string} chainID
     * @param {int} limitGap
     * @param {long} feePerKb
     */
    WalletManager.prototype.recoverSubWallet = function (masterWalletId, chainID, limitGap, feePerKb, Fun) {
        var _this = this;
        this.wallet.recoverSubWallet([masterWalletId, chainID, limitGap, feePerKb], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    //----------------------------------------------------------------------- 主钱包操作
    /**
     * 创建主钱包
     * @param {string} masterWalletId
     * @param {string} mnemonic
     * @param {string} phrasePassword
     * @param {string} payPassword
     * @param {boolean} singleAddress
     * @param Fun
     */
    WalletManager.prototype.createMasterWallet = function (masterWalletId, mnemonic, phrasePassword, payPassword, singleAddress, Fun) {
        var _this = this;
        this.wallet.createMasterWallet([masterWalletId, mnemonic, phrasePassword, payPassword, singleAddress], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     * @param {string} keystoreContent
     * @param {string} backupPassword
     * @param {string} payPassword
     * @param Fun
     */
    WalletManager.prototype.importWalletWithKeystore = function (masterWalletId, keystoreContent, backupPassword, payPassword, Fun) {
        var _this = this;
        this.wallet.importWalletWithKeystore([masterWalletId, keystoreContent, backupPassword, payPassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
   * @param {string} masterWalletId
   * @param {string} mnemonic
   * @param {string} phrasePassword
   * @param {string} payPassword
   * @param {string} singleAddress
   * @param Fun
   */
    WalletManager.prototype.importWalletWithMnemonic = function (masterWalletId, mnemonic, phrasePassword, payPassword, singleAddress, Fun) {
        var _this = this;
        this.wallet.importWalletWithMnemonic([masterWalletId, mnemonic, phrasePassword, payPassword, singleAddress], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     * @param {string} backupPassWord
     * @param {string} payPassword
     * @param Fun
     */
    WalletManager.prototype.exportWalletWithKeystore = function (masterWalletId, backupPassWord, payPassword, Fun) {
        var _this = this;
        this.wallet.exportWalletWithKeystore([masterWalletId, backupPassWord, payPassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     * @param {string} payPassWord
     * @param Fun
     */
    WalletManager.prototype.exportWalletWithMnemonic = function (masterWalletId, payPassWord, Fun) {
        var _this = this;
        this.wallet.exportWalletWithMnemonic([masterWalletId, payPassWord], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
    * @param {string} masterWalletId
    * @param {string} chainId
    * @param {number} BalanceType
    * @param Fun
    */
    WalletManager.prototype.getBalance = function (masterWalletId, chainId, balanceType, Fun) {
        var _this = this;
        this.wallet.getBalance([masterWalletId, chainId, balanceType], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
    * @param {string} masterWalletId
    * @param {string} chainId
    * @param Fun
    */
    WalletManager.prototype.createAddress = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.createAddress([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     * @param {string} chainId
     * @param {string} start
     * @param Fun
     */
    WalletManager.prototype.getAllAddress = function (masterWalletId, chainId, start, Fun) {
        var _this = this;
        this.wallet.getAllAddress([masterWalletId, chainId, start, 20], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
    * @param {string} masterWalletId
    * @param {string} chainId
    * @param {string} address
    * @param Fun
    */
    WalletManager.prototype.getBalanceWithAddress = function (masterWalletId, chainId, address, balanceType, Fun) {
        var _this = this;
        this.wallet.getBalanceWithAddress([masterWalletId, chainId, address, balanceType], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createMultiSignTransaction = function (masterWalletId, chainId, fromAddress, toAddress, amount, memo, remark, useVotedUTXO, Fun) {
        var _this = this;
        this.wallet.createMultiSignTransaction([masterWalletId, chainId, fromAddress, toAddress, amount, memo, remark, useVotedUTXO], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     * @param {string} chainId
     * @param {string} start
     * @param {string} addressOrTxId
     * @param Fun
     */
    WalletManager.prototype.getAllTransaction = function (masterWalletId, chainId, start, addressOrTxId, Fun) {
        var _this = this;
        this.wallet.getAllTransaction([masterWalletId, chainId, start, WalletManager_1.PAGECOUNT, addressOrTxId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
    * @param {string} masterWalletId
    * @param {string} chainId
    * @param Fun
    */
    WalletManager.prototype.registerWalletListener = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.registerWalletListener([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.registerIdListener = function (chainId, Fun) {
        var _this = this;
        this.wallet.registerIdListener([chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     * @param {string} chainId
     * @param {string} message
     * @param {string} payPassword
     * @param Fun
     */
    WalletManager.prototype.sign = function (masterWalletId, chainId, message, payPassword, Fun) {
        var _this = this;
        this.wallet.sign([masterWalletId, chainId, message, payPassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
    * @param {string} masterWalletId
    * @param {string} chainId
    * @param {string} publicKey
    * @param {} message
    * @param {} signature
    * @param Fun
    */
    WalletManager.prototype.checkSign = function (masterWalletId, chainId, publicKey, message, signature, Fun) {
        var _this = this;
        this.wallet.checkSign([masterWalletId, chainId, publicKey, message, signature], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     */
    WalletManager.prototype.destroyWallet = function (masterWalletId, Fun) {
        var _this = this;
        this.wallet.destroyWallet([masterWalletId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.deriveIdAndKeyForPurpose = function (purpose, index, payPassword, Fun) {
        var _this = this;
        this.wallet.deriveIdAndKeyForPurpose([purpose, index, payPassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getAllMasterWallets = function (Fun) {
        var _this = this;
        this.wallet.getAllMasterWallets([], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
    * @param {string} masterWalletId
    */
    WalletManager.prototype.getBalanceInfo = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.getBalanceInfo([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     */
    WalletManager.prototype.isAddressValid = function (masterWalletId, address, Fun) {
        var _this = this;
        this.wallet.isAddressValid([masterWalletId, address], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.generateMnemonic = function (language, Fun) {
        var _this = this;
        this.wallet.generateMnemonic([language], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.saveConfigs = function (Fun) {
        var _this = this;
        this.wallet.saveConfigs([], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getAllChainIds = function (Fun) {
        var _this = this;
        this.wallet.getAllChainIds([], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     */
    WalletManager.prototype.getSupportedChains = function (masterWalletId, Fun) {
        var _this = this;
        this.wallet.getSupportedChains([masterWalletId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     */
    WalletManager.prototype.getAllSubWallets = function (masterWalletId, Fun) {
        var _this = this;
        this.wallet.getAllSubWallets([masterWalletId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     */
    WalletManager.prototype.changePassword = function (masterWalletId, oldPassword, newPassword, Fun) {
        var _this = this;
        this.wallet.changePassword([masterWalletId, oldPassword, newPassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createTransaction = function (masterWalletId, chainId, fromAddress, toAddress, amount, memo, remark, useVotedUTXO, Fun) {
        var _this = this;
        this.wallet.createTransaction([masterWalletId, chainId, fromAddress, toAddress, amount, memo, remark, useVotedUTXO], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.calculateTransactionFee = function (masterWalletId, chainId, rawTransaction, feePerKb, Fun) {
        var _this = this;
        this.wallet.calculateTransactionFee([masterWalletId, chainId, rawTransaction, feePerKb], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createDID = function (password, Fun) {
        var _this = this;
        this.wallet.createDID([password], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getDIDList = function (Fun) {
        var _this = this;
        this.wallet.getDIDList([], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.destoryDID = function (did, Fun) {
        var _this = this;
        this.wallet.destoryDID([did], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didSetValue = function (did, keyPath, value, Fun) {
        var _this = this;
        this.wallet.didSetValue([did, keyPath, value], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didGetValue = function (did, keyPath, Fun) {
        var _this = this;
        this.wallet.didGetValue([did, keyPath], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didGetHistoryValue = function (did, keyPath, Fun) {
        var _this = this;
        this.wallet.didGetValue([did, keyPath], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didGetAllKeys = function (did, start, count, Fun) {
        var _this = this;
        this.wallet.didGetAllKeys([did, start, count], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didSign = function (did, message, password, Fun) {
        var _this = this;
        this.wallet.didSign([did, message, password], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didCheckSign = function (did, message, signature, Fun) {
        var _this = this;
        this.wallet.didCheckSign([did, message, signature], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didGetPublicKey = function (did, Fun) {
        var _this = this;
        this.wallet.didGetPublicKey([did], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createIdTransaction = function (masterWalletId, chainId, fromAddress, payloadJson, programJson, memo, remark, Fun) {
        var _this = this;
        this.wallet.createIdTransaction([masterWalletId, chainId, fromAddress, payloadJson, programJson, memo, remark], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createDepositTransaction = function (masterWalletId, chainId, fromAddress, toAddress, amount, sidechainAccounts, memo, remark, useVotedUTXO, Fun) {
        var _this = this;
        this.wallet.createDepositTransaction([masterWalletId, chainId, fromAddress, toAddress, amount, sidechainAccounts, memo, remark, useVotedUTXO], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createWithdrawTransaction = function (masterWalletId, chainId, fromAddress, amount, mainchainAccounts, memo, remark, Fun) {
        var _this = this;
        this.wallet.createWithdrawTransaction([masterWalletId, chainId, fromAddress, amount, mainchainAccounts, memo, remark], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getGenesisAddress = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.getGenesisAddress([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.didGenerateProgram = function (did, message, password, Fun) {
        var _this = this;
        this.wallet.didGenerateProgram([did, message, password], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
      * @param {string} masterWalletId
      */
    WalletManager.prototype.getMasterWalletBasicInfo = function (masterWalletId, Fun) {
        var _this = this;
        this.wallet.getMasterWalletBasicInfo([masterWalletId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createMultiSignMasterWallet = function (masterWalletId, coSigners, requiredSignCount, Fun) {
        var _this = this;
        this.wallet.createMultiSignMasterWallet([masterWalletId, coSigners, requiredSignCount], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createMultiSignMasterWalletWithPrivKey = function (masterWalletId, privKey, payPassword, coSigners, requiredSignCount, Fun) {
        var _this = this;
        this.wallet.createMultiSignMasterWalletWithPrivKey([masterWalletId, privKey, payPassword, coSigners, requiredSignCount], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.updateTransactionFee = function (masterWalletId, chainId, rawTransaction, fee, fromAddress, Fun) {
        var _this = this;
        this.wallet.updateTransactionFee([masterWalletId, chainId, rawTransaction, fee, fromAddress], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.signTransaction = function (masterWalletId, chainId, rawTransaction, payPassword, Fun) {
        var _this = this;
        this.wallet.signTransaction([masterWalletId, chainId, rawTransaction, payPassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.publishTransaction = function (masterWalletId, chainId, rawTransaction, Fun) {
        var _this = this;
        this.wallet.publishTransaction([masterWalletId, chainId, rawTransaction], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getMasterWalletPublicKey = function (masterWalletId, Fun) {
        var _this = this;
        this.wallet.getMasterWalletPublicKey([masterWalletId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getSubWalletPublicKey = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.getSubWalletPublicKey([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createMultiSignMasterWalletWithMnemonic = function (masterWalletId, mnemonic, phrasePassword, payPassword, coSignersJson, requiredSignCount, Fun) {
        var _this = this;
        this.wallet.createMultiSignMasterWalletWithMnemonic([masterWalletId, mnemonic, phrasePassword, payPassword, coSignersJson, requiredSignCount], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    //String txJson
    WalletManager.prototype.encodeTransactionToString = function (txJson, Fun) {
        var _this = this;
        this.wallet.encodeTransactionToString([txJson], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    //String txHexString
    WalletManager.prototype.decodeTransactionFromString = function (txHexString, Fun) {
        var _this = this;
        this.wallet.decodeTransactionFromString([txHexString], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.removeWalletListener = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.removeWalletListener([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.disposeNative = function (Fun) {
        var _this = this;
        this.wallet.disposeNative([], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    // args[0]: String mnemonic
    // args[1]: String phrasePassword
    WalletManager.prototype.getMultiSignPubKeyWithMnemonic = function (mnemonic, phrasePassword, Fun) {
        var _this = this;
        this.wallet.getMultiSignPubKeyWithMnemonic([mnemonic, phrasePassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    // args[0]: String privKey
    WalletManager.prototype.getMultiSignPubKeyWithPrivKey = function (privKey, Fun) {
        var _this = this;
        this.wallet.getMultiSignPubKeyWithPrivKey([privKey], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getTransactionSignedSigners = function (masterWalletId, chainId, txJson, Fun) {
        var _this = this;
        this.wallet.getTransactionSignedSigners([masterWalletId, chainId, txJson], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
   * @param {string} masterWalletId
   * @param {string} keystoreContent
   * @param {string} backupPassword
   * @param {string} payPassword
   * @param {string} phrasePassword
   * @param Fun
   */
    WalletManager.prototype.importWalletWithOldKeystore = function (masterWalletId, keystoreContent, backupPassword, payPassword, phrasePassword, Fun) {
        var _this = this;
        this.wallet.importWalletWithOldKeystore([masterWalletId, keystoreContent, backupPassword, payPassword, phrasePassword], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getVersion = function (Fun) {
        var _this = this;
        this.wallet.getVersion([], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
    * @param {string} masterWalletId
    * @param {string} chainId
    * @param Fun
    */
    WalletManager.prototype.destroySubWallet = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.destroySubWallet([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createCancelProducerTransaction = function (masterWalletId, chainId, fromAddress, payloadJson, memo, remark, useVotedUTXO, Fun) {
        var _this = this;
        this.wallet.createCancelProducerTransaction([masterWalletId, chainId, fromAddress, payloadJson, memo, remark, useVotedUTXO], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createVoteProducerTransaction = function (masterWalletId, chainId, fromAddress, stake, publicKey, memo, remark, useVotedUTXO, Fun) {
        var _this = this;
        this.wallet.createVoteProducerTransaction([masterWalletId, chainId, fromAddress, stake, publicKey, memo, remark, useVotedUTXO], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getVotedProducerList = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.getVotedProducerList([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getRegisteredProducerInfo = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.getRegisteredProducerInfo([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createRegisterProducerTransaction = function (masterWalletId, chainId, fromAddress, payloadJson, amount, memo, remark, useVotedUTXO, Fun) {
        var _this = this;
        this.wallet.createRegisterProducerTransaction([masterWalletId, chainId, fromAddress, payloadJson, amount, memo, remark, useVotedUTXO], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.generateProducerPayload = function (masterWalletId, chainId, publicKey, nodePublicKey, nickName, url, IPAddress, location, payPasswd, Fun) {
        var _this = this;
        this.wallet.generateProducerPayload([masterWalletId, chainId, publicKey, nodePublicKey, nickName, url, IPAddress, location, payPasswd], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.generateCancelProducerPayload = function (masterWalletId, chainId, publicKey, payPasswd, Fun) {
        var _this = this;
        this.wallet.generateCancelProducerPayload([masterWalletId, chainId, publicKey, payPasswd], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.getPublicKeyForVote = function (masterWalletId, chainId, Fun) {
        var _this = this;
        this.wallet.getPublicKeyForVote([masterWalletId, chainId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createRetrieveDepositTransaction = function (masterWalletId, chainId, amount, memo, remark, Fun) {
        var _this = this;
        this.wallet.createRetrieveDepositTransaction([masterWalletId, chainId, amount, memo, remark], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    /**
     * @param {string} masterWalletId
     * @param {string} chainId
     * @param {string} start
     * @param {string} addressOrTxId
     * @param Fun
     */
    WalletManager.prototype.getAllMyTransaction = function (masterWalletId, chainId, start, addressOrTxId, Fun) {
        var _this = this;
        this.wallet.getAllTransaction([masterWalletId, chainId, start, -1, addressOrTxId], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.createUpdateProducerTransaction = function (masterWalletId, chainId, fromAddress, payloadJson, memo, remark, useVotedUTXO, Fun) {
        var _this = this;
        this.wallet.createUpdateProducerTransaction([masterWalletId, chainId, fromAddress, payloadJson, memo, remark, useVotedUTXO], Fun, function (error) {
            _this.errorFun(error);
        });
    };
    WalletManager.prototype.errorFun = function (error) {
        this.native.info(error);
        var key = error["error"]["code"];
        if (key) {
            key = "error-" + key;
        }
        this.native.hideLoading();
        if (error["error"]["code"] === 20013) {
            var amount = error["error"]["Data"] / __WEBPACK_IMPORTED_MODULE_2__Config__["a" /* Config */].SELA;
            this.popupProvider.ionicAlert_data('confirmTitle', key, amount);
        }
        else if (error["error"]["code"] === 20036) {
            //this.event.publish("error:update");
        }
        else {
            this.popupProvider.ionicAlert('confirmTitle', key);
        }
        //alert("错误信息：" + JSON.stringify(error));
        if (error["error"]["code"] === 20036) {
            this.event.publish("error:update", error);
        }
        else if (error["error"]["code"] === 20028) {
            this.event.publish("error:destroySubWallet");
        }
        else {
            this.event.publish("error:update");
        }
    };
    WalletManager.COINTYPE_ELA = 0;
    WalletManager.COINTYPE_ID = 1;
    WalletManager.LIMITGAP = 500;
    WalletManager.FEEPERKb = 500;
    WalletManager.PAGECOUNT = 20;
    WalletManager = WalletManager_1 = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1__Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_4_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_3__popup__["a" /* PopupProvider */]])
    ], WalletManager);
    return WalletManager;
    var WalletManager_1;
}());

//# sourceMappingURL=WalletManager.js.map

/***/ }),

/***/ 70:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return TransferComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__contacts_contact_list_contact_list_component__ = __webpack_require__(198);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__tabs_tabs_component__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_IDManager__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__providers_ApiUrl__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__pages_id_result_result__ = __webpack_require__(455);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__pages_scancode_scancode__ = __webpack_require__(67);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_13__pages_paymentbox_paymentbox__ = __webpack_require__(97);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_14__pages_scan_scan__ = __webpack_require__(66);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};















var TransferComponent = /** @class */ (function () {
    function TransferComponent(navCtrl, navParams, walletManager, native, localStorage, modalCtrl, events, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.walletManager = walletManager;
        this.native = native;
        this.localStorage = localStorage;
        this.modalCtrl = modalCtrl;
        this.events = events;
        this.zone = zone;
        this.masterWalletId = "1";
        this.walletType = "";
        this.transfer = {
            toAddress: '',
            amount: '',
            memo: '',
            fee: 0,
            payPassword: '',
            remark: '',
        };
        this.balance = 0;
        this.feePerKb = 10000;
        this.SELA = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].SELA;
        this.appType = "";
        this.selectType = "";
        this.isInput = false;
        this.walletInfo = {};
        this.useVotedUTXO = false;
        this.init();
    }
    TransferComponent.prototype.init = function () {
        var _this = this;
        this.events.subscribe("address:update", function (address) {
            _this.transfer.toAddress = address;
        });
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var transferObj = this.navParams.data;
        this.chianId = transferObj["chianId"];
        this.transfer.toAddress = transferObj["addr"] || "";
        this.transfer.amount = transferObj["money"] || "";
        this.appType = transferObj["appType"] || "";
        if (this.appType == "") {
            this.isInput = false;
        }
        else {
            this.isInput = true;
        }
        this.selectType = transferObj["selectType"] || "";
        this.parms = transferObj["parms"] || "";
        this.did = transferObj["did"] || "";
        this.walletInfo = transferObj["walletInfo"] || {};
        this.initData();
    };
    TransferComponent.prototype.updateUseVotedUTXO = function (useVotedUTXO) {
        var _this = this;
        this.zone.run(function () {
            _this.useVotedUTXO = useVotedUTXO;
        });
    };
    TransferComponent.prototype.rightHeader = function () {
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_14__pages_scan_scan__["a" /* ScanPage */], { "pageType": "1" });
    };
    TransferComponent.prototype.initData = function () {
        var _this = this;
        this.walletManager.getBalance(this.masterWalletId, this.chianId, __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].total, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.balance = data["success"];
            }
            else {
                alert("===getBalance===error" + JSON.stringify(data));
            }
        });
    };
    TransferComponent.prototype.onClick = function (type) {
        switch (type) {
            case 1:
                this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_4__contacts_contact_list_contact_list_component__["a" /* ContactListComponent */], { "hideButton": true });
                break;
            case 2:// 转账
                this.checkValue();
                break;
        }
    };
    TransferComponent.prototype.checkValue = function () {
        var _this = this;
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.transfer.toAddress)) {
            this.native.toast_trans('correct-address');
            return;
        }
        if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(this.transfer.amount)) {
            this.native.toast_trans('amount-null');
            return;
        }
        if (!__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].number(this.transfer.amount)) {
            this.native.toast_trans('correct-amount');
            return;
        }
        if (this.transfer.amount <= 0) {
            this.native.toast_trans('correct-amount');
            return;
        }
        if (this.transfer.amount > this.balance) {
            this.native.toast_trans('error-amount');
            return;
        }
        if (this.transfer.amount.toString().indexOf(".") > -1 && this.transfer.amount.toString().split(".")[1].length > 8) {
            this.native.toast_trans('correct-amount');
            return;
        }
        this.walletManager.isAddressValid(this.masterWalletId, this.transfer.toAddress, function (data) {
            if (!data['success']) {
                _this.native.toast_trans("contact-address-digits");
                return;
            }
            _this.native.showLoading().then(function () {
                if (_this.walletInfo["Type"] === "Standard") {
                    _this.createTransaction();
                }
                else if (_this.walletInfo["Type"] === "Multi-Sign") {
                    _this.createMultTx();
                }
            });
        });
    };
    TransferComponent.prototype.createTransaction = function () {
        var _this = this;
        var toAmount = 0;
        //toAmount = parseFloat((this.transfer.amount*Config.SELA).toPrecision(16));
        toAmount = this.accMul(this.transfer.amount, __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].SELA);
        this.walletManager.createTransaction(this.masterWalletId, this.chianId, "", this.transfer.toAddress, toAmount, this.transfer.memo, this.transfer.remark, this.useVotedUTXO, function (data) {
            if (data['success']) {
                _this.native.info(data);
                _this.rawTransaction = data['success'];
                _this.getFee();
            }
            else {
                _this.native.info(data);
            }
        });
    };
    TransferComponent.prototype.getFee = function () {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.feePerKb, function (data) {
            if (data['success']) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.transfer.fee = data['success'];
                _this.openPayModal(_this.transfer);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    TransferComponent.prototype.sendRawTransaction = function () {
        if (this.walletInfo["Type"] === "Multi-Sign" && this.walletInfo["InnerType"] === "Readonly") {
            this.updateTxFee();
            return;
        }
        this.updateTxFee();
    };
    TransferComponent.prototype.updateTxFee = function () {
        var _this = this;
        this.walletManager.updateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.transfer.fee, "", function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Multi-Sign" && _this.walletInfo["InnerType"] === "Readonly") {
                    _this.readWallet(data["success"]);
                    return;
                }
                _this.singTx(data["success"]);
            }
            else {
                _this.native.info(data);
            }
        });
    };
    TransferComponent.prototype.singTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.signTransaction(this.masterWalletId, this.chianId, rawTransaction, this.transfer.payPassword, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Standard") {
                    _this.sendTx(data["success"]);
                }
                else if (_this.walletInfo["Type"] === "Multi-Sign") {
                    _this.walletManager.encodeTransactionToString(data["success"], function (raw) {
                        if (raw["success"]) {
                            _this.native.hideLoading();
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_11__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.chianId, "fee": _this.transfer.fee / __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
                        }
                        else {
                            _this.native.info(raw);
                        }
                    });
                }
            }
            else {
                _this.native.info(data);
            }
        });
    };
    TransferComponent.prototype.sendTx = function (rawTransaction) {
        var _this = this;
        this.native.info(rawTransaction);
        this.walletManager.publishTransaction(this.masterWalletId, this.chianId, rawTransaction, function (data) {
            if (data["success"]) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.txId = JSON.parse(data['success'])["TxHash"];
                if (__WEBPACK_IMPORTED_MODULE_6__providers_Util__["a" /* Util */].isNull(_this.appType)) {
                    _this.native.toast_trans('send-raw-transaction');
                    _this.native.setRootRouter(__WEBPACK_IMPORTED_MODULE_5__tabs_tabs_component__["a" /* TabsComponent */]);
                }
                else if (_this.appType === "kyc") {
                    if (_this.selectType === "enterprise") {
                        _this.company();
                    }
                    else {
                        _this.person();
                    }
                }
            }
            else {
                _this.native.info(data);
            }
        });
    };
    TransferComponent.prototype.company = function () {
        this.sendCompanyHttp(this.parms);
    };
    TransferComponent.prototype.person = function () {
        this.sendPersonAuth(this.parms);
    };
    TransferComponent.prototype.sendCompanyHttp = function (params) {
        var _this = this;
        var timestamp = this.native.getTimestamp();
        params["timestamp"] = timestamp;
        params["txHash"] = this.txId;
        params["deviceID"] = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getdeviceID();
        var checksum = __WEBPACK_IMPORTED_MODULE_8__providers_IDManager__["a" /* IDManager */].getCheckSum(params, "asc");
        params["checksum"] = checksum;
        console.info("ElastJs sendCompanyHttp params " + JSON.stringify(params));
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_9__providers_ApiUrl__["a" /* ApiUrl */].AUTH, params).toPromise().then(function (data) {
            if (data["status"] === 200) {
                var authData = JSON.parse(data["_body"]);
                console.info("Elastjs sendCompanyHttp authData" + JSON.stringify(authData));
                if (authData["errorCode"] === "0") {
                    var serialNum = authData["serialNum"];
                    var serIds = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getSerIds();
                    serIds[serialNum] = {
                        "id": _this.did,
                        "path": _this.selectType,
                        "serialNum": serialNum,
                        "txHash": _this.txId
                    };
                    __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].setSerIds(serIds);
                    _this.saveKycSerialNum(serialNum);
                }
                else {
                    alert("sendCompanyHttp 错误码:" + authData["errorCode"]);
                }
            }
        }).catch(function (error) {
            alert("错误码:" + JSON.stringify(error));
            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__pages_id_result_result__["a" /* IdResultComponent */], { 'status': '1' });
        });
    };
    TransferComponent.prototype.sendPersonAuth = function (parms) {
        var _this = this;
        var timestamp = this.native.getTimestamp();
        parms["timestamp"] = timestamp;
        parms["txHash"] = this.txId;
        parms["deviceID"] = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getdeviceID();
        var checksum = __WEBPACK_IMPORTED_MODULE_8__providers_IDManager__["a" /* IDManager */].getCheckSum(parms, "asc");
        parms["checksum"] = checksum;
        this.native.info(parms);
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_9__providers_ApiUrl__["a" /* ApiUrl */].AUTH, parms).toPromise().then(function (data) {
            if (data["status"] === 200) {
                var authData = JSON.parse(data["_body"]);
                console.log('ElastJs sendPersonAuth return data ---authData---' + JSON.stringify(authData));
                if (authData["errorCode"] === "0") {
                    console.log('ElastJs sendPersonAuth errorCode == 0');
                    var serialNum = authData["serialNum"];
                    var serIds = __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].getSerIds();
                    serIds[serialNum] = {
                        "id": _this.did,
                        "path": _this.selectType,
                        "serialNum": serialNum,
                        "txHash": _this.txId
                    };
                    console.log('ElastJs sendPersonAuth selectType ' + _this.selectType + " serialNum " + serialNum);
                    __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].setSerIds(serIds);
                    _this.saveKycSerialNum(serialNum);
                }
                else {
                    alert("错误码:" + authData["errorCode"]);
                }
            }
        }).catch(function (error) {
        });
        this.native.Go(this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__pages_id_result_result__["a" /* IdResultComponent */], { 'status': '0' });
    };
    TransferComponent.prototype.saveKycSerialNum = function (serialNum) {
        var _this = this;
        console.log('ElastJs saveKycSerialNum serialNum begin' + serialNum);
        this.localStorage.get("kycId").then(function (val) {
            var idsObj = JSON.parse(val);
            var serialNumObj = idsObj[_this.did][_this.selectType][serialNum];
            serialNumObj["txHash"] = _this.txId;
            serialNumObj["pathStatus"] = 1;
            _this.localStorage.set("kycId", idsObj).then(function (newVal) {
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_10__pages_id_result_result__["a" /* IdResultComponent */], { 'status': '0', id: _this.did, path: _this.selectType });
            });
        });
    };
    TransferComponent.prototype.createMultTx = function () {
        var _this = this;
        var toAmount = 0;
        //toAmount = parseFloat((this.transfer.amount*Config.SELA).toPrecision(16));
        toAmount = this.accMul(this.transfer.amount, __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].SELA);
        this.walletManager.createMultiSignTransaction(this.masterWalletId, this.chianId, "", this.transfer.toAddress, toAmount, this.transfer.memo, this.transfer.remark, this.useVotedUTXO, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                _this.rawTransaction = data['success'];
                _this.getFee();
            }
            else {
                _this.native.info(data);
            }
        });
    };
    TransferComponent.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_11__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.chianId, "fee": _this.transfer.fee / __WEBPACK_IMPORTED_MODULE_7__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
            else {
                alert("=====encodeTransactionToString===error===" + JSON.stringify(raw));
            }
        });
    };
    // ionViewDidLeave() {
    //    this.events.unsubscribe("error:update");
    // }
    TransferComponent.prototype.openPayModal = function (data) {
        var _this = this;
        var transfer = this.native.clone(data);
        var modal = this.modalCtrl.create(__WEBPACK_IMPORTED_MODULE_13__pages_paymentbox_paymentbox__["a" /* PaymentboxPage */], transfer);
        modal.onDidDismiss(function (data) {
            if (data) {
                _this.native.showLoading().then(function () {
                    _this.transfer = _this.native.clone(data);
                    _this.sendRawTransaction();
                });
            }
        });
        modal.present();
    };
    TransferComponent.prototype.accMul = function (arg1, arg2) {
        var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
        try {
            m += s1.split(".")[1].length;
        }
        catch (e) { }
        try {
            m += s2.split(".")[1].length;
        }
        catch (e) { }
        return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
    };
    TransferComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-transfer',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coin/transfer/transfer.component.html"*/'<ion-header>\n    <ion-navbar>\n        <ion-title style="text-align:center">{{\'text-transfer\' | translate}}</ion-title>\n        <ion-buttons end>\n            <button ion-button icon-only (click)="rightHeader()">\n            <img src="assets/images/icon/ico-scan.svg" style="width: 40px;height:30px">\n            </button>\n        </ion-buttons>\n    </ion-navbar>\n</ion-header>\n<ion-content>\n    <ion-grid class="margin-top:10px">\n        <ion-row>\n            <ion-col col-10 class="font-size-1" col-auto align-self-center>\n                <ion-item>\n                    <ion-input type="text" placeholder="{{ \'text-receiver-address\' | translate}}" [(ngModel)]="transfer.toAddress" [(disabled)]="isInput"></ion-input>\n                </ion-item>\n            </ion-col>\n            <ion-col col-2 align-self-center> <img (click)="onClick(1)" src="./assets/images/icon/icon-account.svg"></ion-col>\n        </ion-row>\n        <ion-row>\n            <ion-col col-8 align-self-center class="font-size-1">\n                <ion-item>\n                    <ion-input type="text" placeholder="{{ \'text-price\' | translate}}" [(ngModel)]="transfer.amount" col-auto></ion-input>\n                </ion-item>\n            </ion-col>\n            <ion-col col-4 align-self-center class="text-right font-size-1">\n                {{\'text-balance\' | translate}}：{{balance/SELA}}\n            </ion-col>\n        </ion-row>\n\n        <ion-row>\n            <ion-col col-12 align-self-center class="text-right font-size-1">\n                <ion-item>\n                    <textarea placeholder="{{ \'text-remark\' | translate}}" rows="3" [(ngModel)]="transfer.remark" maxlength="20"></textarea>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-item>\n            <ion-label>{{\'use-utxo\' | translate }}</ion-label>\n            <ion-checkbox [(ngModel)]="useVotedUTXO" (ionChange)="updateUseVotedUTXO(useVotedUTXO)"></ion-checkbox>\n        </ion-item>\n    </ion-grid>\n\n</ion-content>\n<ion-footer>\n    <button ion-button full (click)="onClick(2)">{{ \'text-transfer\' | translate }}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coin/transfer/transfer.component.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_12_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_12_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1__providers_WalletManager__["a" /* WalletManager */],
            __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_12_ionic_angular__["j" /* ModalController */], __WEBPACK_IMPORTED_MODULE_12_ionic_angular__["c" /* Events */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], TransferComponent);
    return TransferComponent;
}());

//# sourceMappingURL=transfer.component.js.map

/***/ }),

/***/ 8:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return Util; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_Config__ = __webpack_require__(11);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
/**
 * Created by yanxiaojun617@163.com on 3-12.
 */


//import {Validators as angularValidators, AbstractControl} from '@angular/forms';
var Util = /** @class */ (function () {
    function Util() {
    }
    Util.isNull = function (data) {
        return (data === '' || data === undefined || data === null) ? true : false;
    };
    Util.isMnemonicValid = function (mnemonicStr) {
        return mnemonicStr.split(/[\u3000\s]+/).length == 12 ? true : false;
    };
    Util.isAddressValid = function (address) {
        return address.length == 34 ? true : false;
    };
    Util.isEmptyObject = function (obj) {
        for (var key in obj) {
            if (obj.hasOwnProperty(key)) {
                return false;
            }
        }
        return true;
    };
    /**
     * 格式化日期
     * sFormat：日期格式:默认为yyyy-MM-dd     年：y，月：M，日：d，时：h，分：m，秒：s
     * @example  dateFormat(new Date(),'yyyy-MM-dd')   "2017-02-28"
     * @example  dateFormat(new Date(),'yyyy-MM-dd hh:mm:ss')   "2017-02-28 09:24:00"
     * @example  dateFormat(new Date(),'hh:mm')   "09:24"
     * @param date 日期
     * @param sFormat 格式化后的日期字符串
     * @returns {String}
     */
    Util.dateFormat = function (date, sFormat) {
        if (sFormat === void 0) { sFormat = 'yyyy-MM-dd'; }
        var time = {
            Year: 0,
            TYear: '0',
            Month: 0,
            TMonth: '0',
            Day: 0,
            TDay: '0',
            Hour: 0,
            THour: '0',
            hour: 0,
            Thour: '0',
            Minute: 0,
            TMinute: '0',
            Second: 0,
            TSecond: '0',
            Millisecond: 0
        };
        time.Year = date.getFullYear();
        time.TYear = String(time.Year).substr(2);
        time.Month = date.getMonth() + 1;
        time.TMonth = time.Month < 10 ? "0" + time.Month : String(time.Month);
        time.Day = date.getDate();
        time.TDay = time.Day < 10 ? "0" + time.Day : String(time.Day);
        time.Hour = date.getHours();
        time.THour = time.Hour < 10 ? "0" + time.Hour : String(time.Hour);
        time.hour = time.Hour < 13 ? time.Hour : time.Hour - 12;
        time.Thour = time.hour < 10 ? "0" + time.hour : String(time.hour);
        time.Minute = date.getMinutes();
        time.TMinute = time.Minute < 10 ? "0" + time.Minute : String(time.Minute);
        time.Second = date.getSeconds();
        time.TSecond = time.Second < 10 ? "0" + time.Second : String(time.Second);
        time.Millisecond = date.getMilliseconds();
        return sFormat.replace(/yyyy/ig, String(time.Year))
            .replace(/yyy/ig, String(time.Year))
            .replace(/yy/ig, time.TYear)
            .replace(/y/ig, time.TYear)
            .replace(/MM/g, time.TMonth)
            .replace(/M/g, String(time.Month))
            .replace(/dd/ig, time.TDay)
            .replace(/d/ig, String(time.Day))
            .replace(/HH/g, time.THour)
            .replace(/H/g, String(time.Hour))
            .replace(/hh/g, time.Thour)
            .replace(/h/g, String(time.hour))
            .replace(/mm/g, time.TMinute)
            .replace(/m/g, String(time.Minute))
            .replace(/ss/ig, time.TSecond)
            .replace(/s/ig, String(time.Second))
            .replace(/fff/ig, String(time.Millisecond));
    };
    Util.checkCellphone = function (cellphone) {
        if (!(/^1[3|4|5|8|9|7][0-9]\d{4,8}$/.test(cellphone))) {
            return true;
        }
        return false;
    };
    Util.objtoarr = function (obj) {
        var arr = [];
        for (var key in obj) {
            arr.push(obj[key]);
        }
        return arr;
    };
    Util.GetQueryString = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            return decodeURI(r[2]);
        return null;
    };
    Util.isCardNo = function (card) {
        if (!(/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(card))) {
            return true;
        }
        return false;
    };
    Util.isBankCard = function (bankCard) {
        var regex = /^(998801|998802|622525|622526|435744|435745|483536|528020|526855|622156|622155|356869|531659|622157|627066|627067|627068|627069|622588)\d{10}$/;
        if (!regex.test(bankCard)) {
            return true;
        }
        return false;
    };
    Util.isWallNameExit = function (name) {
        var data = __WEBPACK_IMPORTED_MODULE_1__providers_Config__["a" /* Config */].getMappingList();
        if (this.isEmptyObject(data)) {
            return false;
        }
        var isexit = true;
        for (var key in data) {
            var item = data[key];
            if (item["wallname"] === name) {
                isexit = true;
                break;
            }
            else {
                isexit = false;
            }
        }
        return isexit;
    };
    Util.scientificToNumber = function (num) {
        var str = num.toString();
        var reg = /^(\d+)(e)([\-]?\d+)$/;
        var arr, len, zero = '';
        /*6e7或6e+7 都会自动转换数值*/
        if (!reg.test(str)) {
            return num;
        }
        else {
            /*6e-7 需要手动转换*/
            arr = reg.exec(str);
            len = Math.abs(arr[3]) - 1;
            for (var i = 0; i < len; i++) {
                zero += '0';
            }
            return '0.' + zero + arr[1];
        }
    };
    Util.isURL = function (domain) {
        var name = /[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?/;
        if (!(name.test(domain))) {
            return false;
        }
        else {
            return true;
        }
    };
    /*E-mail*/
    Util.email = function (text) {
        var email = /^[a-zA-Z0-9.!#$%&*+=?^_{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        return email.test(text);
    };
    Util.phone = function (text) {
        var mPattern = /^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\d{8}$/;
        return mPattern.test(text);
    };
    Util.username = function (text) {
        var uPattern = /^[a-zA-Z0-9_-]{4,16}$/;
        return uPattern.test(text);
    };
    Util.password = function (text) {
        if (text.length < 8) {
            return false;
        }
        return true;
        //var pPattern = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/;
        //return pPattern.test(text);
    };
    Util.number = function (text) {
        // var numPattern = /^(([1-9]\d*)|0)(\.\d{1,2})?$"/;
        // var numPattern = /^-?\d*\.?\d+$/;
        var numPattern = /^(([1-9]\d*)|\d)(\.\d{1,9})?$/;
        return numPattern.test(text);
    };
    Util.isWalletName = function (text) {
        if (text.length > 30) {
            return true;
        }
        return false;
        //var pPattern = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/;
        //return pPattern.test(text);
    };
    Util.isNodeName = function (text) {
        if (text.length > 30) {
            return true;
        }
        return false;
    };
    Util = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])()
    ], Util);
    return Util;
}());

//# sourceMappingURL=Util.js.map

/***/ }),

/***/ 804:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ProgressBarComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__ = __webpack_require__(51);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


var ProgressBarComponent = /** @class */ (function () {
    function ProgressBarComponent(translate) {
        this.translate = translate;
        this.des = this.translate.instant("text-sycn-message");
        this.length = {
            'width': '0%',
            'transition': 'width 1s',
            '-webkit-transition': 'width 1s'
        };
    }
    ProgressBarComponent.prototype.ngOnInit = function () {
        this.setData();
    };
    ProgressBarComponent.prototype.setData = function () {
        //this.proportion = Math.round(this.amount / this.total * 100);
        this.proportion = this.proportion.replace(/%/g, "");
        if (this.proportion) {
            if (this.proportion === "0" || this.proportion === 0) {
                this.proportion = '0';
            }
            else {
                this.proportion += '%';
            }
        }
        else {
            this.proportion = '0';
        }
        this.length.width = this.proportion;
    };
    /**
   * 数据变化
   */
    ProgressBarComponent.prototype.ngOnChanges = function (changes) {
        //重新更新数据
        this.setData();
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["D" /* Input */])(),
        __metadata("design:type", Object)
    ], ProgressBarComponent.prototype, "proportion", void 0);
    ProgressBarComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'progress-bar',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/components/progress-bar/progress-bar.html"*/'<div class="Bars">\n    <div [ngStyle]="length">\n        <!-- <span>{{des}}：{{proportion}}</span> -->\n        <span>{{proportion}}</span>\n    </div>\n</div>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/components/progress-bar/progress-bar.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__["c" /* TranslateService */]])
    ], ProgressBarComponent);
    return ProgressBarComponent;
}());

//# sourceMappingURL=progress-bar.js.map

/***/ }),

/***/ 805:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return NodataComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__ = __webpack_require__(51);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


/**
 * Generated class for the NodataComponent component.
 *
 * See https://angular.io/api/core/Component for more info on Angular
 * Components.
 */
var NodataComponent = /** @class */ (function () {
    function NodataComponent(translate) {
        this.translate = translate;
        this.keyText = "";
    }
    NodataComponent.prototype.ngOnInit = function () {
        this.text = this.translate.instant(this.keyText);
    };
    __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["D" /* Input */])(),
        __metadata("design:type", String)
    ], NodataComponent.prototype, "keyText", void 0);
    NodataComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'nodata',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/components/nodata/nodata.html"*/'<!-- Generated template for the NodataComponent component -->\n<div class="text-center">\n    <p>{{text}}</p>\n</div>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/components/nodata/nodata.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1__ngx_translate_core__["c" /* TranslateService */]])
    ], NodataComponent);
    return NodataComponent;
}());

//# sourceMappingURL=nodata.js.map

/***/ }),

/***/ 823:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return zh; });
var zh = {
    'welcome': '欢迎使用本应用',
    'tab-home': '首页',
    'tab-setting': '设置',
    'launcher-create-wallet': '创建钱包',
    'launcher-backup-import': '导入钱包',
    'text-wallet-export': '导出钱包',
    'text-down': '导出钱包',
    'text-wallet-manager': '钱包管理',
    'coin-recent-transfer': '最近转账记录',
    'text-receive': '接收',
    'text-transfer': '转账',
    'text-recharge': '侧链充值',
    'text-withdraw': '主链提现',
    'text-recharge-address': '侧链充值地址',
    'text-withdraw-address': '主链提现地址',
    'text-rate': '汇率',
    'text-memory': '已经记下了',
    'text-memo': '备注',
    'text-information': '说明信息',
    'text-mnemonic': '助记词',
    'text-mnemonic-prompt': '请在纸上抄下您的助记词，助记词丢失您将永远失去自己的钱包',
    'text-mnemonic-prompt2': '请按照顺序点击您的助记词',
    'text-mnemonic-ok': '助记词验证成功',
    'text-mnemonic-prompt3': '助记词错误，请重新录入助记词',
    'text-mnemonic-format': '助记词之间使用空格隔开',
    // TODO remove unused items
    // import wallet page
    'text-from-mnemonic': '来自助记词',
    'text-from-keystore': '来自Keystore',
    'text-mnemonic-check': '验证助记词',
    'text-mnemonic-label': '添加助记词密码',
    'text-mnemonic-pwd': '请设置助记词密码',
    'text-mnemonic-repwd': '请再次设置助记词密码',
    'text-password-error': '密码错误',
    'text-coin-list': '币种列表',
    'text-fees-pay': '手续费支付方',
    'text-fees-pay-sender': '我来支付',
    'text-fees-receiver': '对方支付',
    'text-fees': '手续费',
    'text-price': '金额',
    'text-balance': '余额',
    'text-record': '交易记录',
    'text-select-file': '选择文件',
    'text-reselect-file': '重新选择文件',
    'text-select-file-error': '选择文件失败',
    'text-receiver-address': '收款人钱包地址',
    'text-create-address': '我要新地址',
    'text-contacts': '联系人',
    'text-contacts-add': '添加联系人',
    // contacts page
    'contacts-name-title': '姓名',
    'contacts-phone-title': '手机',
    'contacts-email-title': '邮箱',
    'contacts-address-title': '钱包地址',
    'contacts-remark-title': '备注',
    'text-contacts-info': '联系人详情',
    'text-manager-address': '地址列表',
    'text-setting': '设置',
    'text-about': '关于我们',
    'text-help': '使用帮助',
    'text-notice': '消息通知',
    'text-remark': '备注',
    'text-add': '添加',
    //create wallet page
    'addwallet-walletname-title': '钱包名称',
    'addwallet-walletname-placeholder': '设置钱包名称',
    'text-wallet-name-validator': '钱包名不能为空',
    'addwallet-paypassword1-title': '支付密码',
    'addwallet-paypassword1-placeholder': '请设置钱包支付密码',
    'addwallet-paypassword2-placeholder': '请再次设置钱包支付密码',
    'text-pwd-validator': '密码最少8位，建议数字与字母组合',
    'text-repwd-validator': '两次密码不一致',
    //
    'showmnes-optionalpassword1-title': '助记词密码（可选）',
    'showmnes-optionalpassword1-placeholder': '请设置助记词密码',
    'showmnes-optionalpassword2-placeholder': '请重复已输入的助记词密码',
    // import wallet page - mne
    'importmnes-optionalpassword-title': '助记词密码',
    'importmnes-optionalpassword-placeholder': '请输入当前钱包的助记词密码',
    // import wallet page - keystore
    'importkeystore-keystorepassword-title': 'Keystore密码',
    'importkeystore-optionalpassword-placeholder': '请输入Keystore密码',
    //
    'unlock-paypassword-title': '支付密码',
    'unlock-paypassword-placeholder': '请输入当前钱包的支付密码',
    // export wallet page
    'exportwallet-keystorepassword1-title': 'Keystore密码',
    'exportwallet-keystorepassword1-placeholder': '请设置Keystore密码',
    'exportwallet-keystorepassword2-placeholder': '请重复已输入的Keystore密码',
    // change pay passworld
    'updatepaypassword-origin_paypassword1-title': '原支付密码',
    'updatepaypassword-origin_paypassword1-placeholder': '请输入原支付密码',
    'updatepaypassword-paypassword1-title': '新支付密码',
    'updatepaypassword-paypassword1-placeholder': '请设置新的支付密码',
    'updatepaypassword-paypassword2-placeholder': '请重复已输入的新的支付密码',
    'text-pwd': '输入密码',
    'text-wallet-pwd': '请设置私钥文件密码',
    'text-wallet-repwd': '请再次设置私钥文件密码',
    'text-signaddress': '单地址钱包',
    'text-pwd-repeat': '再次输入密码',
    'text-old-pay-password': '请输入原支付密码',
    'reset-pwd-success': '修改密码成功',
    'text-keystore-pwd': '请设置私钥文件密码',
    'text-wallet-create-ok': '钱包创建成功',
    'text-select-key': '请选择私钥文件',
    'text-to-address': '支付地址',
    'text-input-mnemonic': '请输入助记词',
    'text-wait': '正在处理',
    'text-pay-failure': '支付失败',
    'text-pwd-success': '支付成功',
    'text-back-home': '返回首页',
    'text-gesture-pwd': '手势密码',
    'text-language': '语言',
    'confirm': '确定',
    'confirmTitle': '提示',
    'confirmTransaction': '交易已确认',
    'confirmSubTitle': '确定要退出钱包吗？<br/>在退出钱包前，请确认已安全备份助记词及可选加密密码。恢复钱包需要助记词及可选加密密码。任何人无法帮助您恢复钱包',
    'cancel': '取消',
    'copy-ok': '复制成功',
    'correct-amount': '请输入正确的金额',
    'correct-address': '请输入正确的地址',
    'error-address': '无法解析该地址',
    'error-amount': '您的余额不足',
    'transfer-info': '转账详情',
    'text-payment-confirm': '确认转账',
    'text-did-login': '选择DID登录',
    'transfer-address': '转账地址',
    'send-raw-transaction': '交易已发送',
    'transfer-more': '查看更多交易记录',
    'send-info': '发款方',
    'record-info': '收款方',
    'receive-address': '收款地址',
    'utxo-info': '转入转出详情',
    'utxo-incoming': '交易输入',
    'utxo-incoming-address': '输入地址',
    'utxo-outcoming': '交易输出',
    'utxo-outcoming-address': '输出地址',
    'transaction-price': '交易金额',
    'transaction-time': '确认时间',
    'transaction-id': '交易号',
    'confirm-count': '确认次数',
    'transaction-ok': '交易成功',
    'loader-more': '加载更多',
    'update-ok': '刷新成功',
    'Confirmed': '已完成',
    'Pending': '确认中',
    'Unconfirmed': '未确认',
    'contact-name-notnull': '联系人姓名不能为空',
    'contact-address-notnull': '联系人地址不能为空',
    'contact-address-digits': '不正确的钱包地址',
    'amount-null': '金额不能为空',
    'contact-phone-check': '无效的手机号',
    'text-mnemonic-validator': '助记词必须是12个',
    'wallet-name': '钱包名',
    'text-wallet-info': '钱包详情',
    'wallet-export': '导出钱包',
    'wallet-delete': '删除钱包',
    'text-submit': '确认',
    'wallet-password-reset': '更改支付密码',
    'text-id-my': "我的ID",
    'text-id-create': '创建ID',
    'text-id-import': '导入ID',
    'text-id-not': '您还没有ID，请先新建ID或者导入ID',
    'text-id-reimport': '重新导入ID',
    'text-id-home': 'ID中心首页',
    'text-id-home-prompt': '您可以创建多个ID地址，每个ID代表不同的认证身份',
    'text-pwd-please': '请输入密码',
    'text-pwd-rePlease': '请再次输入密码',
    'text-person': '个人',
    'text-company': '企业',
    'text-id-type': '选择认证类型',
    'text-id-import-file': '导入ID文件',
    'text-browsing': '浏览',
    'text-id-manager': 'ID管理',
    'text-update-time': '更新时间',
    'text-export': '导出',
    'text-delete': '删除',
    'text-select-all': '全选',
    'text-kyc-certified': 'KYC认证',
    'text-name': '姓名',
    'text-identity': '身份证',
    'text-certified-identity': '身份认证',
    'text-certified-card': '银行卡认证',
    'text-certified-phone': '手机认证',
    'text-certified-person': '个人认证',
    'text-certified-company': '企业认证',
    'text-phone': '手机',
    'text-card': '银行卡',
    'text-card-debit': '储蓄卡',
    'text-check-code': '验证码',
    'text-get-check-code': '获取验证码',
    'text-phone-reserve': '预留手机',
    'text-pay': '支付',
    'text-company-name': '企业全称',
    'text-company-legal': '企业法人',
    'text-company-code': '社会信用代码',
    'text-id-app-list-name': 'ID应用列表',
    'text-commit-result': '提交结果',
    'text-commit-success': '提交成功',
    'text-commit-wait': '信息已提交，等待认证',
    'text-browsing-failure': '提交失败',
    'text-kyc-result': '认证结果',
    'text-kyc-success': '认证成功',
    'text-kyc-failure': '认证失败',
    'text-kyc-message': '信息如下',
    'show-advanced-options': '显示高级选项',
    'hide-advanced-options': '隐藏高级选项',
    'text-pay-passworld-input': '请输入支付密码',
    'text-passworld-compare': '两次输入内容不一样',
    'text-keystroe-message': '将此文本复制到一个安全的地方（记事本）',
    'text-copy-to-clipboard': '复制到剪贴板',
    'text-copied-to-clipboard': '已复制到剪贴板',
    'text-backup-passworld-input': '请输入私钥文件密码',
    'text-phrase-passworld-input': '请输入助记词密码',
    'import-text-keystroe-message': '将密钥文件复制到文本框',
    'import-text-keystroe-sucess': '导入私钥成功',
    'import-text-world-sucess': '导入助记词成功',
    'text-down-sucess-message': '导出成功',
    'text-down-fail-message': '导出失败',
    'text-down-please-message': '请选择要导出的ID',
    'text-exprot-sucess-message': '导出成功',
    'text-id-chain-prompt1': '您可以将信息写入到ID链，做个有身份的人',
    'text-id-chain-prompt2': '您输入的信息将永久保存到ID链',
    'text-data-chain': '数据上链',
    'text-id-kyc-add': '新增订单',
    'text-id-kyc-check': '查看订单',
    'text-id-kyc-check-operate': "操作记录",
    'text-id-kyc-operation': '操作',
    'text-id-kyc-order-list': "订单列表",
    'text-id-kyc-auth-uncompleted': "认证未完成",
    'text-id-kyc-no-order': "暂无订单",
    'text-id-kyc-import-no-message': "导入内容不能为空",
    'text-id-kyc-import-text-message': "将导入文本复制到文本框",
    'text-id-kyc-import-text-del-message': "删除id成功",
    'text-id-kyc-import-text-del-please-message': '请选择要删除的ID',
    'text-id-kyc-auth-query-timeout': '付费查询失败',
    'text-id-kyc-auth-fee-fail': '付款失败',
    'text-input-please': '请输入',
    'text-debitCard-message-1': '银行卡号不能为空',
    'text-debitCard-message-2': '银行卡号不合法',
    'text-cardNo-message-1': '身份证不能为空',
    'text-cardNo-message-2': '身份证不合法',
    'text-phone-message-1': '手机号不能为空',
    'text-phone-message-2': '手机号不合法',
    'text-sendcode-message-1': '验证码不能为空',
    'text-word-message': '请输入企业全称',
    'text-legalPerson-message': '请输入企业法人',
    'text-registrationN-message': '社会信用代码',
    'text-id-kyc-prompt-title': '确认',
    'text-id-kyc-prompt-password': '输入钱包支付密码',
    'Ok': '确定',
    'text-id-kyc-cochain': '上链需要花费',
    'text-id-kyc-china': '上链提交成功',
    'text-Jpush-kyc-message-1': '交易单号为：',
    'text-Jpush-kyc-message-2': '已认证成功，请去订单列表查看',
    'text-data-chain1': '上链中请耐心等待',
    'text-data-chain2': "上链成功",
    'text-exit-message': "再按一次退出应用",
    'text-path-list': "path列表",
    'text-path-deatils': "path详情",
    'add-path': "添加",
    'text-company-path-deatils': "企业详情",
    'text-bankcard-path-deatils': "银行卡详情",
    'path-status': "状态",
    'path-status-no-pay': "未支付",
    'text-identity-path-deatils': "身份证详情",
    'path-status-authing': "认证中",
    'path-status-authed': "认证通过",
    'phone-path-deatils': "手机认证详情",
    'text-ela-per-message': '正在同步中，同步完成再用',
    'text-sycn-message': '同步状态',
    'text-language-message': "语言",
    'text-wallte-list': "钱包列表",
    'text-add-wallet': "添加钱包",
    'signature-wallet': "创建多签钱包",
    'text-next-step': "下一步",
    'text-select-type': "选择类型",
    'text-publickey-placeholder': "请输入参与者的公钥",
    'text-add-publickey-title': "添加公钥",
    'text-add-private-title': "添加私钥",
    'text-create-privatekey': "创建种子",
    'text-observe-wallte': "只读钱包",
    'text-import-privatekey': "导入私钥",
    'text-import-privatekey-des': "输入Private Key文件内容至输入框。请留意字符大小写",
    'text-import-privatekey-placeholder': "输入明文私钥",
    'text-check-publickey': "查看公钥",
    'text-send-tx': "发送交易",
    'text-sing-tx': "签名交易",
    'text-scan-code': "查看二维码",
    'text-tx-details': "交易详情",
    'text-multi-title1': "拥有者数量",
    'text-multi-title2': "签名数量",
    'text-multi-error': "签名数不能大于拥有者数量",
    'text-delete-contact-confirm': "确定要删除吗？",
    'click-to-load-more': "点击加载更多",
    //error alert
    'error-10000': '(ERR-10000)Action参数Json格式错误',
    'error-10001': '(ERR-10001)Action参数错误',
    'error-10002': '(ERR-10002)无效主钱包',
    'error-10003': '(ERR-10003)无效子钱包',
    'error-10004': '(ERR-10004)创建主钱包错误',
    'error-10005': '(ERR-10005)创建子钱包错误',
    'error-10006': '(ERR-10006)恢复子钱包错误',
    'error-10007': '(ERR-10007)无效的钱包管理器',
    'error-10008': '(ERR-10008)Keystore导入钱包错误',
    'error-10009': '(ERR-10009)助记词导入钱包错误',
    'error-10010': '(ERR-10010)子钱包实例错误',
    'error-10011': '(ERR-10011)无效DID管理器',
    'error-10012': '(ERR-10012)无效DID',
    'error-10013': '(ERR-10013)Action无效',
    'error-20000': '(ERR-20000)SPV未收集异常',
    'error-20001': '(ERR-20001)无效参数',
    'error-20002': '(ERR-20002)无效密码',
    'error-20003': '(ERR-20003)密码错误',
    'error-20004': '(ERR-20004)无效ID',
    'error-20005': '(ERR-20005)SPV创建主钱包错误',
    'error-20006': '(ERR-20006)SPV创建子钱包错误',
    'error-20007': '(ERR-20007)解析JSON数组错误',
    'error-20008': '(ERR-20008)无效助记词',
    'error-20009': '(ERR-20009)公钥格式错误',
    'error-20010': '(ERR-20010)公钥长度错误',
    'error-20011': '(ERR-20011)侧链充值参数错误',
    'error-20012': '(ERR-20012)侧链提现参数错误',
    'error-20013': '(ERR-20013)创建交易过大',
    'error-20014': '(ERR-20014)创建交易错误',
    'error-20015': '(ERR-20015)交易错误',
    'error-20016': '(ERR-20016)目录不存在',
    'error-20017': '(ERR-20017)注册ID payload错误',
    'error-20018': '(ERR-20018)数据库操作错误',
    'error-20019': '(ERR-20019)衍生purpose错误',
    'error-20020': '(ERR-20020)错误账户类型',
    'error-20021': '(ERR-20021)错误网络类型',
    'error-20022': '(ERR-20022)无效币种',
    'error-20023': '(ERR-20023)无当前多签账户',
    'error-20024': '(ERR-20024)多签参与者数量错误',
    'error-20025': '(ERR-20025)多签错误',
    'error-20026': '(ERR-20026)keystore错误',
    'error-20027': '(ERR-20027)limit gap错误',
    'error-20028': '(ERR-20028)私钥错误',
    'error-20029': '(ERR-20029)二进制转字符串错误',
    'error-20030': '(ERR-20030)签名类型错误',
    'error-20031': '(ERR-20031)地址错误',
    'error-20032': '(ERR-20032)签名错误',
    'error-20035': '(ERR-20035)余额不足',
    'error-30000': '(ERR-30000)JSON转换错误',
    'error-20036': '(ERR-20036)Json格式错误',
    'error-20037': '(ERR-20037)无效投票数',
    'error-20038': '(ERR-20038)无效输入',
    'error-20039': '(ERR-20039)无效交易',
    'error-20040': '(ERR-20040)获取内部地址失败',
    'error-20041': '(ERR-20041)账户不支持投票',
    'error-20042': '(ERR-20042)本地交易不属于钱包',
    'error-20043': '(ERR-20043)参选质押金不足',
    'error-29999': '(ERR-29999)其它错误',
    'modify-wallet-name': '修改钱包名字',
    'load-more': '加载更多',
    'txinfo-receive-amount': '接收金额',
    'txinfo-send-amount': '发送金额',
    'txinfo-receive-addr': '接收地址',
    'txinfo-send-addr': '发送地址',
    'no-open-side-chain': '没有打开测链',
    'no-tx-record': '没有交易记录',
    'no-add-contact': '没有添加联系人',
    'suggest-amount': '金额应小于',
    'text-wallet-name-validator1': '钱包名长度超过30字',
    'text-wallet-name-validator2': '钱包名已存在',
    'text-multi-wallte': '(多签钱包)',
    'text-standard-wallte': "(普通钱包)",
    'text-export-mnemomic': "导出助记词",
    'text-export-menmonic-sucess': "助记词验证成功",
    'create-multi-by-mnes': '导入助记词',
    'already-signed-publickey': '已签过的公钥',
    'super-point': '超级节点选举',
    'sign-up-for-election': '报名选举',
    'i-want-to-vote': '我要投票',
    'sing-up': "报名参选",
    'confirmation-of-participation': '确认参选',
    'lock-details': '锁仓详情',
    'input-password': '输入密码',
    'join-vote-list': '节点选举列表',
    'node-information': '节点信息',
    'node-name': '节点名称',
    'node-address': '节点地址',
    'node-declaration': '节点宣言',
    'current-votes': '当前票数',
    'share-voting': '投票占比',
    'country-region': '国家',
    'add-in-list': '加入候选列表',
    'look-over-list': '查看候选列表',
    'please-input-votes': '请输入票数',
    'number-of-votes': '投票数量',
    'maximum-voting-right': '最大表决票权',
    'vote-manage': '选举管理',
    'log-out': '注销',
    'log-out-subTitle': '是否确认注销候选资格？<br/>候选资格一旦注销，所有投票清零且不可恢复。',
    'vote-edit': '编辑',
    'my-vote': '我的投票',
    'electoral-management': '选举管理',
    'please-enter-node-name': '请输入节点名称',
    'please-enter-node-url': '请输入节点官网URL',
    'please-enter-node-declaration': '请输入节点宣言',
    'lock-number': '锁仓数量',
    'remarks-bond': '备注：保证金',
    'I-want-to-vote': '我要投票',
    'voting-rules': '投票规则',
    'voting-rules-text-1': '参与ELA超级节点投票，需锁仓ELA。投票不消耗ELA数量;',
    'voting-rules-text-2': '每次投票最多可选择 36 个超级节点，撤销或更改再次投票生效有一定的延迟。;',
    'change-vote': '重新投票',
    'current-voting-record': '当前投票纪录',
    'this-vote': '本次投票',
    'please-wallet-publickey': '请输入钱包公钥',
    'proportion-of-voting': '全网投票占比',
    'present-quorum-votes': '当前票数',
    'number-of-voting-addresses': '投票地址数量',
    'about': '关于',
    'Version': '版本号',
    'my-publickey': '我的公钥',
    'Inputs': "输入",
    "Outputs": "输出",
    "transaction-type-0": "创币交易",
    "transaction-type-1": "注册资产",
    "transaction-type-2": "普通转账",
    "transaction-type-3": "记录",
    "transaction-type-4": "部署",
    "transaction-type-5": "侧链挖矿",
    "transaction-type-6": "侧链充值",
    "transaction-type-7": "侧链提现",
    "transaction-type-8": "跨链转账",
    "transaction-type-9": "注册参选交易",
    "transaction-type-10": "取消参选交易",
    "transaction-type-11": "更新参选交易",
    "transaction-type-12": "取回参选质押资产",
    "transaction-type-13": "未知交易类型",
    "transaction-type": "交易类型",
    'transaction-deleted': "已删除",
    'txPublished-0': "交易成功",
    'txPublished-1': "交易格式错误",
    'txPublished-16': "无效交易",
    'txPublished-17': "过时的交易",
    'txPublished-18': "交易成功",
    'txPublished-22': "交易未签名",
    'txPublished-64': "非标准交易",
    'txPublished-65': "粉尘交易",
    'txPublished-66': "交易费不足",
    'txPublished-67': "检查点错误",
    'reasons-failure': "失败原因",
    'text-node-name-validator1': '节点名字长度超过30字',
    'enter-node-url-validator': 'url不合法',
    'china-key': '中国',
    'usa-key': '美国',
    'del-in-list': '移出候选列表',
    'no-voting-records': '暂无投票记录',
    'voting-ratio': '全网投票比例',
    'vote-immediately': '立即投票',
    'have-chosen': '已选择',
    'all-election': '全选',
    'please-select-voting-node': '请选择投票节点',
    'ticket': '票',
    'Afghanistan': '阿富汗',
    'Albania': '阿尔巴尼亚',
    'Algeria': '阿尔及利亚',
    'American Samoa': '萨摩亚',
    'Andorra': '安道尔共和国',
    'Angola': '安哥拉',
    'Anguilla': '安圭拉岛',
    'Antarctica': '南极洲',
    'Antigua and Barbuda': '安提瓜和巴布达',
    'Argentina': '阿根廷',
    'Armenia': '亚美尼亚',
    'Aruba': '阿鲁巴',
    'Australia': '阿森松',
    'Austria': '奥地利',
    'Azerbaijan': '阿塞拜疆',
    'Bahamas': '巴哈马',
    'Bahrain': '巴林',
    'Bangladesh': '孟加拉国',
    'Barbados': '巴巴多斯',
    'Belarus': '白俄罗斯',
    'Belgium': '比利时',
    'Belize': '伯利兹城',
    'Benin': '贝宁',
    'Bermuda': '百慕大',
    'Bhutan': '不丹',
    'Bolivia': '玻利维亚',
    'Bosnia and Herzegovina': '波斯尼亚和黑塞哥维那',
    'Botswana': '博茨瓦纳',
    'Brazil': '巴西',
    'British Indian Ocean Territory': '英属印度洋领地',
    'Brunei Darussalam': '文莱达鲁萨兰国',
    'Bulgaria': '保加利亚',
    'Burkina Faso': '布基纳法索',
    'Burundi': '布隆迪',
    'Cambodia': '柬埔寨',
    'Cameroon': '喀麦隆',
    'Canada': '加拿大',
    'Cape Verde': '佛得角',
    'Cayman Islands': '开曼群岛',
    'Central African Republic': '中非共和国',
    'Chad': '乍得',
    'Chile': '智利',
    'China': '中国',
    'Christmas Island': '圣延岛',
    'Cocos (Keeling) Islands': '科科斯群岛',
    'Colombia': '哥伦比亚',
    'Comoros': '科摩罗',
    'Congo': '刚果',
    'Congo, The Democratic Republic Of The': '刚果民主共和国',
    'Cook Islands': '库克群岛',
    'Costa Rica': '哥斯达黎加',
    "Cote D'Ivoire": "Cote D'Ivoire",
    'Croatia (local name: Hrvatska)': '克罗地亚',
    'Cuba': '古巴',
    'Cyprus': '塞浦路斯',
    'Czech Republic': '捷克',
    'Denmark': '丹麦',
    'Djibouti': '吉布提',
    'Dominica': '多米尼克国',
    'Dominican Republic': '多米尼加共和国',
    'East Timor': '东帝汶',
    'Ecuador': '厄瓜多尔',
    'Egypt': '埃及',
    'El Salvador': '萨尔瓦多',
    'Equatorial Guinea': '赤道几内亚',
    'Eritrea': '厄立特里亚国',
    'Estonia': '爱沙尼亚',
    'Ethiopia': '埃塞俄比亚',
    'Falkland Islands (Malvinas)': '福克兰群岛',
    'Faroe Islands': '法罗群岛',
    'Fiji': '斐济',
    'Finland': '芬兰',
    'France': '法国',
    'France Metropolitan': '法国大都会',
    'French Guiana': '法属圭亚那',
    'French Polynesia': '法属玻里尼西亚',
    'Gabon': '加蓬',
    'Gambia': ' 冈比亚',
    'Georgia': '格鲁吉亚',
    'Germany': '德国',
    'Ghana': '加纳',
    'Gibraltar': '直布罗陀',
    'Greece': '希腊',
    'Greenland': '格陵兰',
    'Grenada': '格林纳达',
    'Guadeloupe': '瓜德罗普岛',
    'Guam': '关岛',
    'Guatemala': '危地马拉',
    'Guinea': '几内亚',
    'Guinea-Bissau': '几内亚比绍',
    'Guyana': '圭亚那',
    'Haiti': '海地',
    'Honduras': '洪都拉斯',
    'Hong Kong': '香港',
    'Hungary': '匈牙利',
    'Iceland': '冰岛',
    'India': '印度',
    'Indonesia': '印度尼西亚',
    'Iran (Islamic Republic of)': '伊朗（伊斯兰共和国）',
    'Iraq': '伊拉克',
    'Ireland': '爱尔兰',
    'Israel': '以色列',
    'Italy': '意大利',
    'Jamaica': '牙买加',
    'Japan': '日本',
    'Jordan': '约旦',
    'Kazakhstan': '哈萨克',
    'Kenya': '肯尼亚',
    'Kuwait': '科威特',
    'Kyrgyzstan': '吉尔吉斯',
    'Latvia': '拉脱维亚',
    'Lebanon': '黎巴嫩',
    'Lesotho': '莱索托',
    'Liberia': '利比里亚',
    'Libyan Arab Jamahiriya': '利比亚',
    'Liechtenstein': '列支敦士登',
    'Lithuania': '立陶宛',
    'Luxembourg': '卢森堡',
    'Macau': '澳门地区',
    'Madagascar': '马达加斯加',
    'Malawi': '马拉维',
    'Malaysia': '马来西亚',
    'Maldives': '马尔代夫',
    'Mali': '马里',
    'Malta': '马尔他',
    'Marshall Islands': '马绍尔群岛',
    'Martinique': '马提尼克岛',
    'Mauritania': '毛里塔尼亚',
    'Mauritius': '毛里求斯',
    'Mayotte': '马约特',
    'Mexico': '墨西哥',
    'Micronesia': '密克罗尼西亚',
    'Moldova': '摩尔多瓦',
    'Monaco': '摩纳哥',
    'Mongolia': '外蒙古',
    'Montenegro': '黑山共和国',
    'Montserrat': '蒙特塞拉特',
    'Morocco': '摩洛哥',
    'Mozambique': '莫桑比克',
    'Myanmar': '缅甸',
    'Namibia': '那米比亚',
    'Nauru': '瑙鲁',
    'Nepal': '尼泊尔',
    'Netherlands': '荷兰',
    'Netherlands Antilles': '荷兰安的列斯群岛',
    'New Caledonia': '新喀里多尼亚',
    'New Zealand': '新西兰',
    'Nicaragua': '尼加拉瓜',
    'Niger': '尼日尔',
    'Nigeria': '尼日利亚',
    'Norfolk Island': '诺福克岛',
    'North Korea': '朝鲜',
    'Northern Mariana Islands': '北马里亚纳群岛',
    'Norway': '挪威',
    'Oman': '阿曼',
    'Pakistan': '巴基斯坦',
    'Palau': '帛琉',
    'Palestine': '巴勒斯坦',
    'Panama': '巴拿马',
    'Papua New Guinea': '巴布亚新几内亚',
    'Paraguay': '巴拉圭',
    'Peru': '秘鲁',
    'Philippines': '菲律宾共和国',
    'Pitcairn': '皮特凯恩岛',
    'Poland': '波兰',
    'Portugal': '葡萄牙',
    'Puerto Rico': '波多黎各',
    'Qatar': '卡塔尔',
    'Reunion': '留尼汪岛',
    'Romania': '罗马尼亚',
    'Russian Federation': '俄罗斯联邦',
    'Rwanda': '卢旺达',
    'Samoa': '美属萨摩亚',
    'San Marino': '圣马力诺共和国',
    'Saudi Arabia': '沙特阿拉伯',
    'Senegal': '塞内加尔',
    'Serbia': '塞尔维亚共和国',
    'Seychelles': '塞舌尔',
    'Sierra Leone': '塞拉利昂',
    'Singapore': '新加坡',
    'Slovakia (Slovak Republic)': '斯洛伐克（斯洛伐克人的共和国）',
    'Slovenia': '斯洛文尼亚',
    'Solomon Islands': '索罗门群岛',
    'Somalia': '索马里',
    'South Africa': '南非',
    'South Korea': '韩国',
    'Spain': '西班牙',
    'Sri Lanka': '斯里兰卡',
    'Sudan': '苏丹',
    'Suriname': '苏里南',
    'Swaziland': '斯威士兰',
    'Sweden': '瑞典',
    'Switzerland': '瑞士',
    'Syrian Arab Republic': '叙利亚',
    'Taiwan': '台湾地区',
    'Tajikistan': '塔吉克',
    'Tanzania': '坦桑尼亚',
    'Thailand': '泰国',
    'Togo': '多哥',
    'Tokelau': '托克劳',
    'Tonga': '汤加',
    'Trinidad and Tobago': '特立尼达和多巴哥',
    'Tunisia': '突尼斯',
    'Turkey': '土耳其',
    'Turkmenistan': '土库曼',
    'Turks and Caicos Islands': '土克斯及开科斯群岛',
    'Tuvalu': '图瓦卢',
    'Uganda': '乌干达',
    'Ukraine': '乌克兰',
    'United Arab Emirates': '阿拉伯联合酋长国',
    'United Kingdom': '英国',
    'United States': '美国',
    'Uruguay': '乌拉圭',
    'Uzbekistan': '乌兹别克斯坦',
    'Vanuatu': '瓦努阿图',
    'Vatican City State (Holy See)': '梵蒂冈(罗马教廷)',
    'Venezuela': '委内瑞拉',
    'Vietnam': '越南',
    'Virgin Islands (British)': '维尔京群岛(英国)',
    'Virgin Islands (U.S.)': '维尔京群岛(美国)',
    'Wallis And Futuna Islands': '沃利斯和富图纳群岛',
    'Western Sahara': '西撒哈拉',
    'Yemen': '也门',
    'Yugoslavia': '南斯拉夫',
    'Zambia': '赞比亚',
    'Zimbabwe': '津巴布韦',
    'the Republic of Abkhazia': '阿布哈兹',
    'the Republic of South Ossetia': '南奥赛梯',
    'Bailiwick of Jersey': '泽西岛',
    "Lao People's Democratic Republic": '老挝',
    'The Republic of Macedonia': '马其顿',
    'The Federation of Saint Kitts and Nevis': '圣基茨和尼维斯',
    'Santa Luzia Island': '圣卢西亚岛',
    'Saint Vincent and the Grenadines': '圣文森特和格林纳丁斯',
    'Sao Tome and Principe': '圣多美和普林西比',
    'Saint-Martin': '圣马丁岛',
    'The Republic of South Sudan': '南苏丹共和国',
    'Input value is incorrect': '输入的数值不对',
    'please-node-PublicKey': '请输入节点公钥',
    'text-id-kyc-cochain1': '需要花费',
    'candidate-nodes-error': '最多选择36个候选人节点',
    'please-enter-node-iPAddress': '请输入网络地址',
    'take-back-deposit': "取回质押金",
    'publickey-repeat': '公钥重复',
    'use-utxo': '是否使用投票utxo',
    'total-balance': '总额',
    'vote-balance': '投票占用',
    'update-info': '更新信息',
    'node-iPAddress': '网络地址'
};
//# sourceMappingURL=zh.js.map

/***/ }),

/***/ 824:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return en; });
var en = {
    'tab-home': 'Home',
    'tab-setting': 'Settings',
    'launcher-create-wallet': 'Create Wallet',
    'launcher-backup-import': 'Import Wallet',
    'text-wallet-export': 'Export Wallet',
    'text-down': 'backup wallet',
    'text-wallet-manager': 'Wallet Setting',
    'coin-recent-transfer': 'Recent Transfers',
    'text-receive': 'Receive',
    'text-transfer': 'Send',
    'text-recharge': 'Recharge',
    'text-withdraw': 'Withdraw',
    'text-recharge-address': 'Withdraw to (Address)',
    'text-withdraw-address': 'Recharge From (Address)',
    'text-rate': 'Exchange Rage',
    'text-memory': 'I have written it down',
    'text-memo': 'Memo',
    'text-information': 's_info',
    'text-mnemonic': 'Backup Phrase',
    'text-mnemonic-prompt': 'Please carefully write down this phrase',
    'text-mnemonic-prompt2': 'Please tap each word in the correct order',
    'text-mnemonic-ok': 'Mnemonics Verified',
    'text-mnemonic-prompt3': 'Backup phrase or password incorrectly, Please review your backup and try again.',
    'text-mnemonic-format': 'Spaces are required between characters',
    // TODO remove unused items
    // import wallet page
    'text-from-mnemonic': 'from Mnemonics',
    'text-from-keystore': 'from KeyStore',
    'text-mnemonic-check': 'Mnemonics Verification',
    'text-mnemonic-label': 'Add Optional Password',
    'text-mnemonic-pwd': 'Set Mnemonic Password',
    'text-mnemonic-repwd': 'Repeat Mnemonic Password',
    'text-password-error': 'Wrong Password',
    'text-coin-list': 'Coin List',
    'text-fees-pay': 'transaction fee payer',
    'text-fees-pay-sender': 'transaction fee excluded',
    'text-fees-receiver': 'transaction fee included',
    'text-fees': 'Transaction fee',
    'text-price': 'Amount',
    'text-balance': 'Balance',
    'text-record': 'Transaction records',
    'text-select-file': 'Select file',
    'text-reselect-file': 'Reselect file',
    'text-select-file-error': 'File error',
    'text-receiver-address': 'Target Address',
    'text-create-address': 'Get new address',
    'text-contacts': 'Contacts',
    'text-contacts-add': 'Add contacts',
    // contacts page
    'contacts-name-title': 'Name',
    'contacts-phone-title': 'Phone Number',
    'contacts-email-title': 'Email Address',
    'contacts-address-title': 'Wallet Address',
    'contacts-remark-title': 'Remark',
    'text-contacts-info': 'Contacts Information',
    'text-manager-address': 'Wallet Addresses',
    'text-setting': 'Settings',
    'text-about': 'About',
    'text-help': 'Help',
    'text-notice': 'Notification',
    'text-remark': 'Remark',
    'text-add': 'Add',
    // create wallet page
    'addwallet-walletname-title': 'Wallet Name',
    'addwallet-walletname-placeholder': 'Set an alias for this wallet',
    'text-wallet-name-validator': 'Wallet name can not be empty',
    'addwallet-paypassword1-title': 'Pay Password',
    'addwallet-paypassword1-placeholder': 'Set Pay Password',
    'addwallet-paypassword2-placeholder': 'Repeat Pay Password',
    'text-pwd-validator': 'the length must be 8 or more characters, a mix of letters and numbers are bettter',
    'text-repwd-validator': 'password do not match',
    //
    'showmnes-optionalpassword1-title': 'Mnemonic Optional Passphrase',
    'showmnes-optionalpassword1-placeholder': 'Set an optional passphrase for your mnemonics',
    'showmnes-optionalpassword2-placeholder': 'Repeat the optional passphrase you set',
    // import wallet page - mne
    'importmnes-optionalpassword-title': 'Mnemonic Optional Passphrase',
    'importmnes-optionalpassword-placeholder': 'Enter the optional passphrase of your mnemonics',
    // import wallet page - keystore
    'importkeystore-keystorepassword-title': 'Keystore Password',
    'importkeystore-optionalpassword-placeholder': 'Enter the password of the keystore you entered above',
    //
    'unlock-paypassword-title': 'Pay Password',
    'unlock-paypassword-placeholder': 'Enter the pay password of current wallet',
    // export wallet page
    'exportwallet-keystorepassword1-title': 'Keystore Password',
    'exportwallet-keystorepassword1-placeholder': 'Set a Keystore password for your wallet',
    'exportwallet-keystorepassword2-placeholder': 'Repeat the Keystore password you set',
    // change pay passworld
    'updatepaypassword-origin_paypassword1-title': 'Original Pay Password',
    'updatepaypassword-origin_paypassword1-placeholder': 'Enter the original pay password of current wallet',
    'updatepaypassword-paypassword1-title': 'New Pay Password',
    'updatepaypassword-paypassword1-placeholder': 'Set a new pay password for your wallet',
    'updatepaypassword-paypassword2-placeholder': 'Repeat the new pay password you set',
    'text-pwd': 'Input Password',
    'text-wallet-pwd': 'Set SecretKey Password',
    'text-wallet-repwd': 'Repeat SecretKey Password',
    'text-signaddress': 'Single Address Wallet',
    'text-pwd-repeat': 'Repeat Password',
    'text-old-pay-password': 'Input Original Pay Password',
    'reset-pwd-success': 'Password Updated Successfully',
    'text-keystore-pwd': 'Set KeyStore Password',
    'text-wallet-create-ok': 'Wallet Created and Backuped',
    'text-select-key': 'Select SecretKey File',
    'text-to-address': 'Target Address',
    'text-input-mnemonic': 'Type in Mnemonics',
    'text-wait': 'Processing',
    'text-pay-failure': 'Payment Failed',
    'text-pwd-success': 'Payment Sent',
    'text-back-home': 'Back to Home Page',
    'text-gesture-pwd': 'Guesture Password',
    'text-language': 'Language',
    'confirm': 'Confirm',
    'confirmTitle': 'confirm',
    'confirmTransaction': 'Transaction Confirmed',
    'confirmSubTitle': 'Are you sure you want to log out this wallet? <br/>Before logging out, confirm that you have recorded your backup phrase and optional passphrase securely.To restore your account, both the backup phrase and optional passphrase will be required.Nobody can assist in restoring your account.',
    'cancel': 'Cancel',
    'copy-ok': 'Copied to Clipboard',
    'correct-amount': 'Wrong Amount',
    'correct-address': 'Wrong Address',
    'error-address': 'Address Error',
    'error-amount': 'Amount Error',
    'transfer-info': 'Transfer Info',
    'text-payment-confirm': 'Confirm Payment',
    'text-did-login': 'select DID',
    'transfer-address': 'transfer address',
    'send-raw-transaction': 'transfer sent_',
    'transfer-more': 'transfer Info',
    'send-info': 'sender',
    'record-info': 'receiver',
    'receive-address': 'receive address',
    'utxo-info': 'tx information',
    'utxo-incoming': 'tx input',
    'utxo-incoming-address': 'input address',
    'utxo-outcoming': 'tx output',
    'utxo-outcoming-address': 'output address',
    'transaction-price': 'tx amount',
    'transaction-time': 'confirm time',
    'transaction-id': 'tx id',
    'confirm-count': 'confirm count',
    'transaction-ok': 'tx success',
    'loader-more': 'load more',
    'update-ok': 'updated',
    'Confirmed': 'complete',
    'Pending': 'pending',
    'Unconfirmed': 'unconfirmed',
    'contact-name-notnull': 'contacts name empty',
    'contact-address-notnull': 'contacts address empty',
    'contact-address-digits': 'wrong wallet address',
    'amount-null': 'amount empty',
    'contact-phone-check': 'invalid phone number',
    'text-mnemonic-validator': 'mnemonics is 12 word phrase',
    'wallet-name': 'Wallet Name',
    'text-wallet-info': 'wallet information',
    'wallet-export': 'Export Wallet',
    'wallet-delete': 'Delete Wallet',
    'text-submit': 'submit',
    'wallet-password-reset': 'Change Payment Password',
    'text-id-my': 'my ID',
    'text-id-create': 'create ID',
    'text-id-import': 'import ID',
    'text-id-not': 'ID not found, please create an ID or import one',
    'text-id-reimport': 'reimport ID',
    'text-id-home': 'ID Home',
    'text-id-home-prompt': 'multiple ID address are allowed to create representing multiple authentication',
    'text-pwd-please': 'please input password',
    'text-pwd-rePlease': 'please repeat password',
    'text-person': 'personal',
    'text-company': 'corporate',
    'text-id-type': 'ID type',
    'text-id-import-file': 'import ID file',
    'text-browsing': 'browsing',
    'text-id-manager': 'ID management',
    'text-update-time': 'update time',
    'text-export': 'export',
    'text-delete': 'delete',
    'text-select-all': 'select all',
    'text-kyc-certified': 'KYC',
    'text-name': 'name',
    'text-identity': 'Personal ID Number',
    'text-certified-identity': 'ID authentication',
    'text-certified-card': 'bank card authentication',
    'text-certified-phone': 'mobile phone authenticaiton',
    'text-certified-person': 'personal authentication',
    'text-certified-company': 'corporate authentication',
    'text-phone': 'mobile phone number',
    'text-card': 'bank card number',
    'text-card-debit': 'debit card number',
    'text-check-code': 'verification code',
    'text-get-check-code': 'get verification code',
    'text-phone-reserve': 'bank reserved phone number',
    'text-pay': 'pay',
    'text-company-name': 'company name',
    'text-company-legal': 'enterprise legal person',
    'text-company-code': 'social credit code',
    'text-id-app-list-name': 'ID app list',
    'text-commit-result': 'commit result',
    'text-commit-success': 'commit success',
    'text-commit-wait': 'wait for approvement',
    'text-browsing-failure': 'commit failed',
    'text-kyc-result': 'kyc result',
    'text-kyc-success': 'kyc success',
    'text-kyc-failure': 'kyc failed',
    'text-kyc-message': 'kyc message',
    'show-advanced-options': 'show advanced option',
    'hide-advanced-options': 'hide advanced option',
    'text-pay-passworld-input': 'input paypassword',
    'text-passworld-compare': 'inconformity password',
    'text-keystroe-message': 'please save keystore properly',
    'text-copy-to-clipboard': 'copy to Clipboard',
    'text-copied-to-clipboard': 'copied to Clipboard',
    'text-backup-passworld-input': 'input SecretKey Password',
    'text-phrase-passworld-input': 'input Mnemonics Password',
    'import-text-keystroe-message': 'Paste keystore text in',
    'import-text-keystroe-sucess': 'Wallet imported from SecretKey ',
    'import-text-world-sucess': 'Wallet imported from Mnemonics',
    'text-down-sucess-message': 'Export Successfully',
    'text-down-fail-message': 'Export Failed',
    'text-down-please-message': 'select ID to export',
    'text-exprot-sucess-message': 'export successfully',
    'text-id-chain-prompt1': 'write your information to id chain',
    'text-id-chain-prompt2': 'your info will store to id chain permenently',
    'text-data-chain': 'data update to chain',
    'text-id-kyc-add': 'add',
    'text-id-kyc-check': 'view',
    'text-id-kyc-check-operate': "opration history",
    'text-id-kyc-operation': 'oprate',
    'text-id-kyc-order-list': 'order list',
    'text-id-kyc-auth-uncompleted': 'authentication unfinished',
    'text-id-kyc-no-order': 'no order yet',
    'text-id-kyc-import-no-message': 'import content empty',
    'text-id-kyc-import-text-message': 'import text copy to textfield',
    'text-id-kyc-import-text-del-message': 'id deleted',
    'text-id-kyc-import-text-del-please-message': 'select ID to delete',
    'text-id-kyc-auth-query-timeout': 'auth query timeout',
    'text-id-kyc-auth-fee-fail': 'auth fee fail',
    'text-input-please': 'please input',
    'text-debitCard-message-1': 'debit card number empty',
    'text-debitCard-message-2': 'debit card number invalid',
    'text-cardNo-message-1': 'id card number empty',
    'text-cardNo-message-2': 'id card number invalid',
    'text-phone-message-1': 'mobile phone number empty',
    'text-phone-message-2': 'mobile phone number invalid',
    'text-sendcode-message-1': 'verification code empty',
    'text-word-message': 'type in enterprise name',
    'text-legalPerson-message': 'type in enterprise legal person',
    'text-registrationN-message': 'social credit code',
    'text-id-kyc-prompt-title': 'Confirm',
    'text-id-kyc-prompt-password': 'input wallet pay password',
    'Ok': 'Confirm',
    'text-id-kyc-cochain': 'need service fee',
    'text-id-kyc-china': 'submit success',
    'text-Jpush-kyc-message-1': 'Tx. No.',
    'text-Jpush-kyc-message-2': 'auth success check at order list',
    'text-data-chain1': 'please wait',
    'text-data-chain2': 'success',
    'text-exit-message': 'repeat to exit application',
    'text-path-list': "path list",
    'text-path-deatils': "path details",
    'add-path': "add",
    'text-company-path-deatils': "company details",
    'text-bankcard-path-deatils': "bank card details",
    'path-status': "status",
    'path-status-no-pay': "unpaid",
    'text-identity-path-deatils': "id details",
    'path-status-authing': "authenticating",
    'path-status-authed': "authenticated",
    'phone-path-deatils': "mobile authentication detail",
    'text-ela-per-message': 'Synchronizing, Please Wait',
    'text-sycn-message': 'Sync Status',
    'text-language-message': "Language",
    'text-wallte-list': "Wallet List",
    'text-add-wallet': "Add Wallet",
    'signature-wallet': "Create Multi-sign wallet",
    'text-next-step': "Next Step",
    'text-select-type': "Select Type",
    'text-publickey-placeholder': "Input Public Key of Participants",
    'text-add-publickey-title': "Add Public Key",
    'text-add-private-title': "Add Private Key",
    'text-create-privatekey': "Create a new seed",
    'text-observe-wallte': "Observer wallet (Public Key Only)",
    'text-import-privatekey': "Import Private Key",
    'text-import-privatekey-des': "Input Private Key Text",
    'text-import-privatekey-placeholder': "Input Privkey",
    'text-check-publickey': "Check Public Key",
    'text-send-tx': "Send transaction",
    'text-sing-tx': "Sign transaction",
    'text-scan-code': "Scan QR Code",
    'text-tx-details': "Transaction Details",
    'text-multi-title1': "Total number of owners",
    'text-multi-title2': "Required number of signatures",
    'text-multi-error': "Number of signatures should less than number of public-keys",
    'text-delete-contact-confirm': "Delete this contact ?",
    'click-to-load-more': "click to load more",
    //error alert
    'error-10000': '(ERR-10000)Json parse error of action parameters',
    'error-10001': '(ERR-10001)Parameters error of action',
    'error-10002': '(ERR-10002)Invalid master wallet',
    'error-10003': '(ERR-10003)Invalid sub wallet',
    'error-10004': '(ERR-10004)Create master wallet error',
    'error-10005': '(ERR-10005)Create sub wallet error',
    'error-10006': '(ERR-10006)Recover sub wallet error',
    'error-10007': '(ERR-10007)Invalid master wallet manager',
    'error-10008': '(ERR-10008)Import wallet with keystore error',
    'error-10009': '(ERR-10009)Import wallet with mnemonic error',
    'error-10010': '(ERR-10010)Instance of sub wallet error',
    'error-10011': '(ERR-10011)Invalid DID manager',
    'error-10012': '(ERR-10012)Invalid DID',
    'error-10013': '(ERR-10013)Invalid action',
    'error-20000': '(ERR-20000)SPV other exception',
    'error-20001': '(ERR-20001)Invalid parameters',
    'error-20002': '(ERR-20002)Invalid password',
    'error-20003': '(ERR-20003)Wrong password',
    'error-20004': '(ERR-20004)ID not found',
    'error-20005': '(ERR-20005)SPV create master wallet error',
    'error-20006': '(ERR-20006)SPV create sub wallet error',
    'error-20007': '(ERR-20007)Parse json array error',
    'error-20008': '(ERR-20008)Invalid mnemonic',
    'error-20009': '(ERR-20009)Public key format error',
    'error-20010': '(ERR-20010)Public key length error',
    'error-20011': '(ERR-20011)Side chain deposit parameters error',
    'error-20012': '(ERR-20012)Side chain withdraw parameters error',
    'error-20013': '(ERR-20013)Tx size too large',
    'error-20014': '(ERR-20014)Create tx error',
    'error-20015': '(ERR-20015)Invalid tx',
    'error-20016': '(ERR-20016)Path do not exist',
    'error-20017': '(ERR-20017)Register ID payload error',
    'error-20018': '(ERR-20018)Sqlite error',
    'error-20019': '(ERR-20019)Derive purpose error',
    'error-20020': '(ERR-20020)Wrong account type',
    'error-20021': '(ERR-20021)Wrong net type',
    'error-20022': '(ERR-20022)Invalid coin type',
    'error-20023': '(ERR-20023)No current multi sign account',
    'error-20024': '(ERR-20024)Cosigner count error',
    'error-20025': '(ERR-20025)Multi sign error',
    'error-20026': '(ERR-20026)Key store error',
    'error-20027': '(ERR-20027)Limit gap error',
    'error-20028': '(ERR-20028)Key error',
    'error-20029': '(ERR-20029)Hex to string error',
    'error-20030': '(ERR-20030)Sign type error',
    'error-20031': '(ERR-20031)Address error',
    'error-20032': '(ERR-20032)Sign error',
    'error-20035': '(ERR-20035)Balance is not enough',
    'error-30000': '(ERR-30000)JSON Conversion error',
    'error-20036': '(ERR-20036)Json format error',
    'error-20037': '(ERR-20037)Invalid vote stake',
    'error-20038': '(ERR-20038)Invalid input',
    'error-20039': '(ERR-20039)Invalid transaction',
    'error-20040': '(ERR-20040)Get internal address fail',
    'error-20041': '(ERR-20041)Account not support vote',
    'error-20042': '(ERR-20042)Local tx do not belong to wallet',
    'error-20043': '(ERR-20043)Deposit amount is insufficient',
    'error-29999': '(ERR-29999)Other error',
    'modify-wallet-name': 'Editt Wallet Name',
    'load-more': 'Load More',
    'txinfo-receive-amount': 'Receive Amount',
    'txinfo-send-amount': 'Send Amount',
    'txinfo-receive-addr': 'Receive Address',
    'txinfo-send-addr': 'Send Address',
    'no-open-side-chain': 'Sidechain not opened',
    'no-tx-record': 'No transaction record',
    'no-add-contact': 'No Contact Added',
    'suggest-amount': 'amount should less than',
    'text-wallet-name-validator1': 'Wallet Name with more than 30 characters',
    'text-wallet-name-validator2': 'Wallet Name exist',
    'text-multi-wallte': '(Multi-Sign Wallet)',
    'text-standard-wallte': '(Standard Wallet)',
    'text-export-mnemomic': 'Backup Mnemomics',
    'text-export-menmonic-sucess': "Check Mnemonics Success",
    'create-multi-by-mnes': 'Use Existing Seed (Import Mnemonics) ',
    'already-signed-publickey': 'already signed publickey',
    'super-point': 'super node election',
    'sign-up-for-election': 'sing up for election',
    'i-want-to-vote': 'i want to vote',
    'sing-up': "sing up",
    'confirmation-of-participation': 'confirmation of participation',
    'lock-details': 'lock details',
    'input-password': 'input password',
    'join-vote-list': 'join vote list',
    'node-information': 'node information',
    'node-name': 'node name',
    'node-address': 'node address',
    'node-declaration': 'node declaration',
    'current-votes': 'current votes',
    'share-voting': 'share voting',
    'country-region': 'country',
    'add-in-list': 'add in list',
    'look-over-list': 'look over list',
    'please-input-votes': 'please input votes',
    'number-of-votes': 'number of votes',
    'maximum-voting-right': 'maximum voting right',
    'vote-manage': 'vote manage',
    'log-out': 'log out',
    'log-out-subTitle': 'Do you confirm the cancellation of candidature？<br/>Once the candidature is cancelled, all polls are cleared and cannot be resumed。',
    'vote-edit': 'edit',
    'my-vote': 'my vote',
    'electoral-management': 'electoral management',
    'please-enter-node-name': 'please enter node name',
    'please-enter-node-url': 'please enter node url',
    'please-enter-node-declaration': 'please enter node declaration',
    'lock-number': 'lock number',
    'remarks-bond': 'remarks:bond',
    'I-want-to-vote': 'I want to vote',
    'voting-rules': 'voting rules',
    'voting-rules-text-1': 'To participate in ELA super node voting, we need to lock ELA. Voting does not consume ELA;',
    'voting-rules-text-2': 'Up to 36 super nodes can be selected for each vote, and there is a certain delay in voting for revocation or change. ;',
    'change-vote': 'again vote',
    'current-voting-record': 'current voting record',
    'this-vote': 'this vote',
    'please-wallet-publickey': 'please enter the wallet publickey',
    'proportion-of-voting': 'Proportion of voting',
    'present-quorum-votes': 'present quorum votes',
    'number-of-voting-addresses': 'number of voting addresses',
    'about': 'About',
    'Version': 'Version',
    'my-publickey': 'my publickey',
    'Inputs': "Inputs",
    "Outputs": "Outputs",
    "transaction-type-0": "CoinBase",
    "transaction-type-1": "RegisterAsse",
    "transaction-type-2": "TransferAsset",
    "transaction-type-3": "Record",
    "transaction-type-4": "Deploy",
    "transaction-type-5": "SideChainPow",
    "transaction-type-6": "RechargeToSideChain",
    "transaction-type-7": "WithdrawFromSideChain",
    "transaction-type-8": "TransferCrossChainAsset",
    "transaction-type-9": "RegisterProducer",
    "transaction-type-10": "CanCelProducer",
    "transaction-type-11": "UpdateProducer",
    "transaction-type-12": "ReturnDepositCoin",
    "transaction-type-13": "Unknown Type",
    "transaction-type": "Transaction Type",
    'transaction-deleted': "Deleted",
    'txPublished-0': "Successful Trade",
    'txPublished-1': "Malformed",
    'txPublished-16': "Invalid",
    'txPublished-17': "Obsolete",
    'txPublished-18': "Successful Trade",
    'txPublished-22': "Transaction Not Signed",
    'txPublished-64': "Nonstandard",
    'txPublished-65': "Dust",
    'txPublished-66': "InsufficientFee",
    'txPublished-67': "Checkpoint",
    'reasons-failure': "Reasons failure",
    'text-node-name-validator1': 'Node Name with more than 30 characters',
    'enter-node-url-validator': 'Url Wrongful',
    'china-key': 'China',
    'usa-key': 'U.S.A',
    'del-in-list': 'del in list',
    'no-voting-records': 'No Voting Records',
    'voting-ratio': 'Whole Network Voting Ratio',
    'vote-immediately': 'Vote Immediately',
    'have-chosen': 'Have Chosen',
    'all-election': 'All',
    'please-select-voting-node': 'Please select the voting node',
    'ticket': 'Ticket',
    'Afghanistan': 'Afghanistan',
    'Albania': 'Albania',
    'Algeria': 'Algeria',
    'American Samoa': 'American Samoa',
    'Andorra': 'Andorra',
    'Angola': 'Angola',
    'Anguilla': 'Anguilla',
    'Antarctica': 'Antarctica',
    'Antigua and Barbuda': 'Antigua and Barbuda',
    'Argentina': 'Argentina',
    'Armenia': 'Armenia',
    'Aruba': 'Aruba',
    'Australia': 'Australia',
    'Austria': 'Austria',
    'Azerbaijan': 'Azerbaijan',
    'Bahamas': 'Bahamas',
    'Bahrain': 'Bahrain',
    'Bangladesh': 'Bangladesh',
    'Barbados': 'Barbados',
    'Belarus': 'Belarus',
    'Belgium': 'Belgium',
    'Belize': 'Belize',
    'Benin': 'Benin',
    'Bermuda': 'Bermuda',
    'Bhutan': 'Bhutan',
    'Bolivia': 'Bolivia',
    'Bosnia and Herzegovina': 'Bosnia and Herzegovina',
    'Botswana': 'Botswana',
    'Brazil': 'Brazil',
    'British Indian Ocean Territory': 'British Indian Ocean Territory',
    'Brunei Darussalam': 'Brunei Darussalam',
    'Bulgaria': 'Bulgaria',
    'Burkina Faso': 'Burkina Faso',
    'Burundi': 'Burundi',
    'Cambodia': 'Cambodia',
    'Cameroon': 'Cameroon',
    'Canada': 'Canada',
    'Cape Verde': 'Cape Verde',
    'Cayman Islands': 'Cayman Islands',
    'Central African Republic': 'Central African Republic',
    'Chad': 'Chad',
    'Chile': 'Chile',
    'China': 'China',
    'Christmas Island': 'Christmas Island',
    'Cocos (Keeling) Islands': 'Cocos (Keeling) Islands',
    'Colombia': 'Colombia',
    'Comoros': 'Comoros',
    'Congo': 'Congo',
    'Congo, The Democratic Republic Of The': 'Congo, The Democratic Republic Of The',
    'Cook Islands': 'Cook Islands',
    'Costa Rica': 'Costa Rica',
    "Cote D'Ivoire": "Cote D'Ivoire",
    'Croatia (local name: Hrvatska)': 'Croatia (local name: Hrvatska)',
    'Cuba': 'Cuba',
    'Cyprus': 'Cyprus',
    'Czech Republic': 'Czech Republic',
    'Denmark': 'Denmark',
    'Djibouti': 'Djibouti',
    'Dominica': 'Dominica',
    'Dominican Republic': 'Dominican Republic',
    'East Timor': 'East Timor',
    'Ecuador': 'Ecuador',
    'Egypt': 'Egypt',
    'El Salvador': 'El Salvador',
    'Equatorial Guinea': 'Equatorial Guinea',
    'Eritrea': 'Eritrea',
    'Estonia': 'Estonia',
    'Ethiopia': 'Ethiopia',
    'Falkland Islands (Malvinas)': 'Falkland Islands (Malvinas)',
    'Faroe Islands': 'Faroe Islands',
    'Fiji': 'Fiji',
    'Finland': 'Finland',
    'France': 'France',
    'France Metropolitan': 'France Metropolitan',
    'French Guiana': 'French Guiana',
    'French Polynesia': 'French Polynesia',
    'Gabon': 'Gabon',
    'Gambia': 'Gambia',
    'Georgia': 'Georgia',
    'Germany': 'Germany',
    'Ghana': 'Ghana',
    'Gibraltar': 'Gibraltar',
    'Greece': 'Greece',
    'Greenland': 'Greenland',
    'Grenada': 'Grenada',
    'Guadeloupe': 'Guadeloupe',
    'Guam': 'Guam',
    'Guatemala': 'Guatemala',
    'Guinea': 'Guinea',
    'Guinea-Bissau': 'Guinea-Bissau',
    'Guyana': 'Guyana',
    'Haiti': 'Haiti',
    'Honduras': 'Honduras',
    'Hong Kong': 'Hong Kong',
    'Hungary': 'Hungary',
    'Iceland': 'Iceland',
    'India': 'India',
    'Indonesia': 'Indonesia',
    'Iran (Islamic Republic of)': 'Iran (Islamic Republic of)',
    'Iraq': 'Iraq',
    'Ireland': 'Ireland',
    'Israel': 'Israel',
    'Italy': 'Italy',
    'Jamaica': 'Jamaica',
    'Japan': 'Japan',
    'Jordan': 'Jordan',
    'Kazakhstan': 'Kazakhstan',
    'Kenya': 'Kenya',
    'Kuwait': 'Kuwait',
    'Kyrgyzstan': 'Kyrgyzstan',
    'Latvia': 'Latvia',
    'Lebanon': 'Lebanon',
    'Lesotho': 'Lesotho',
    'Liberia': 'Liberia',
    'Libyan Arab Jamahiriya': 'Libyan Arab Jamahiriya',
    'Liechtenstein': 'Liechtenstein',
    'Lithuania': 'Lithuania',
    'Luxembourg': 'Luxembourg',
    'Macau': 'Macau',
    'Madagascar': 'Madagascar',
    'Malawi': 'Malawi',
    'Malaysia': 'Malaysia',
    'Maldives': 'Maldives',
    'Mali': 'Mali',
    'Malta': 'Malta',
    'Marshall Islands': 'Marshall Islands',
    'Martinique': 'Martinique',
    'Mauritania': 'Mauritania',
    'Mauritius': 'Mauritius',
    'Mayotte': 'Mayotte',
    'Mexico': 'Mexico',
    'Micronesia': 'Micronesia',
    'Moldova': 'Moldova',
    'Monaco': 'Monaco',
    'Mongolia': 'Mongolia',
    'Montenegro': 'Montenegro',
    'Montserrat': 'Montserrat',
    'Morocco': 'Morocco',
    'Mozambique': 'Mozambique',
    'Myanmar': 'Myanmar',
    'Namibia': 'Namibia',
    'Nauru': 'Nauru',
    'Nepal': 'Nepal',
    'Netherlands': 'Netherlands',
    'Netherlands Antilles': 'Netherlands Antilles',
    'New Caledonia': 'New Caledonia',
    'New Zealand': 'New Zealand',
    'Nicaragua': 'Nicaragua',
    'Niger': 'Niger',
    'Nigeria': 'Nigeria',
    'Norfolk Island': 'Norfolk Island',
    'North Korea': 'North Korea',
    'Northern Mariana Islands': 'Northern Mariana Islands',
    'Norway': 'Norway',
    'Oman': 'Oman',
    'Pakistan': 'Pakistan',
    'Palau': 'Palau',
    'Palestine': 'Palestine',
    'Panama': 'Panama',
    'Papua New Guinea': 'Papua New Guinea',
    'Paraguay': 'Paraguay',
    'Peru': 'Peru',
    'Philippines': 'Philippines',
    'Pitcairn': 'Pitcairn',
    'Poland': 'Poland',
    'Portugal': 'Portugal',
    'Puerto Rico': 'Puerto Rico',
    'Qatar': 'Qatar',
    'Reunion': 'Reunion',
    'Romania': 'Romania',
    'Russian Federation': 'Russian Federation',
    'Rwanda': 'Rwanda',
    'Samoa': 'Samoa',
    'San Marino': 'San Marino',
    'Saudi Arabia': 'Saudi Arabia',
    'Senegal': 'Senegal',
    'Serbia': 'Serbia',
    'Seychelles': 'Seychelles',
    'Sierra Leone': 'Sierra Leone',
    'Singapore': 'Singapore',
    'Slovakia (Slovak Republic)': 'Slovakia (Slovak Republic)',
    'Slovenia': 'Slovenia',
    'Solomon Islands': 'Solomon Islands',
    'Somalia': 'Somalia',
    'South Africa': 'South Africa',
    'South Korea': 'South Korea',
    'Spain': 'Spain',
    'Sri Lanka': 'Sri Lanka',
    'Sudan': 'Sudan',
    'Suriname': 'Suriname',
    'Swaziland': 'Swaziland',
    'Sweden': 'Sweden',
    'Switzerland': 'Switzerland',
    'Syrian Arab Republic': 'Syrian Arab Republic',
    'Taiwan': 'Taiwan',
    'Tajikistan': 'Tajikistan',
    'Tanzania': 'Tanzania',
    'Thailand': 'Thailand',
    'Togo': 'Togo',
    'Tokelau': 'Tokelau',
    'Tonga': 'Tonga',
    'Trinidad and Tobago': 'Trinidad and Tobago',
    'Tunisia': 'Tunisia',
    'Turkey': 'Turkey',
    'Turkmenistan': 'Turkmenistan',
    'Turks and Caicos Islands': 'Turks and Caicos Islands',
    'Tuvalu': 'Tuvalu',
    'Uganda': 'Uganda',
    'Ukraine': 'Ukraine',
    'United Arab Emirates': 'United Arab Emirates',
    'United Kingdom': 'United Kingdom',
    'United States': 'United States',
    'Uruguay': 'Uruguay',
    'Uzbekistan': 'Uzbekistan',
    'Vanuatu': 'Vanuatu',
    'Vatican City State (Holy See)': 'Vatican City State (Holy See)',
    'Venezuela': 'Venezuela',
    'Vietnam': 'Vietnam',
    'Virgin Islands (British)': 'Virgin Islands (British)',
    'Virgin Islands (U.S.)': 'Virgin Islands (U.S.)',
    'Wallis And Futuna Islands': 'Wallis And Futuna Islands',
    'Western Sahara': 'Western Sahara',
    'Yemen': 'Yemen',
    'Yugoslavia': 'Yugoslavia',
    'Zambia': 'Zambia',
    'Zimbabwe': 'Zimbabwe',
    'the Republic of Abkhazia': 'the Republic of Abkhazia',
    'the Republic of South Ossetia': 'the Republic of South Ossetia',
    'Bailiwick of Jersey': 'Bailiwick of Jersey',
    "Lao People's Democratic Republic": "Lao People's Democratic Republic",
    'The Republic of Macedonia': 'The Republic of Macedonia',
    'The Federation of Saint Kitts and Nevis': 'The Federation of Saint Kitts and Nevis',
    'Santa Luzia Island': 'Santa Luzia Island',
    'Saint Vincent and the Grenadines': 'Saint Vincent and the Grenadines',
    'Sao Tome and Principe': 'Sao Tome and Principe',
    'Saint-Martin': 'Saint-Martin',
    'The Republic of South Sudan': 'The Republic of South Sudan',
    'Input value is incorrect': 'Input value is incorrect',
    'please-node-PublicKey': 'Please Node PublicKey',
    'text-id-kyc-cochain1': 'need service fee',
    'candidate-nodes-error': 'Choose up to 36 candidate nodes',
    'please-enter-node-iPAddress': 'please enter node network address',
    'take-back-deposit': 'Take back deposit',
    'publickey-repeat': 'publicKey Repeat',
    'use-utxo': 'Whether to use voting utxo',
    'total-balance': 'Total Balance',
    'vote-balance': 'Vote Balance',
    'update-info': 'Update Info',
    'node-iPAddress': 'Net Address'
};
//# sourceMappingURL=en.js.map

/***/ }),

/***/ 835:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return BackupProvider; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};

var BackupProvider = /** @class */ (function () {
    function BackupProvider() {
    }
    BackupProvider.prototype.idsDownload = function (content, fileName) {
        var _this = this;
        return new Promise(function (resolve, reject) {
            _this._download(content, fileName).then(function () {
                return resolve();
            });
        });
    };
    BackupProvider.prototype._download = function (ew, fileName) {
        var _this = this;
        return new Promise(function (resolve, reject) {
            var a = document.createElement("a");
            var blob = _this.NewBlob(ew, 'text/plain;charset=utf-8');
            var url = window.URL.createObjectURL(blob);
            document.body.appendChild(a);
            a.href = url;
            a.download = fileName;
            a.click();
            window.URL.revokeObjectURL(url);
            return resolve();
        });
    };
    BackupProvider.prototype.NewBlob = function (data, datatype) {
        var out;
        try {
            out = new Blob([data], {
                type: datatype
            });
        }
        catch (e) {
            if (e.name == "InvalidStateError") {
                // InvalidStateError (tested on FF13 WinXP)
                out = new Blob([data], {
                    type: datatype
                });
            }
            else {
                // We're screwed, blob constructor unsupported entirely
            }
        }
        return out;
    };
    ;
    BackupProvider = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])()
    ], BackupProvider);
    return BackupProvider;
}());

//# sourceMappingURL=backup.js.map

/***/ }),

/***/ 836:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AppComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ionic_native_status_bar__ = __webpack_require__(407);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__ionic_native_splash_screen__ = __webpack_require__(406);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__ = __webpack_require__(9);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__pages_initializepage_initializepage__ = __webpack_require__(412);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};









var AppComponent = /** @class */ (function () {
    function AppComponent(onicApp, appCtrl, platform, statusBar, splashScreen, localStorage, translate, native) {
        var _this = this;
        this.onicApp = onicApp;
        this.appCtrl = appCtrl;
        this.platform = platform;
        this.localStorage = localStorage;
        this.translate = translate;
        this.native = native;
        this.backButtonPressed = false; //用于判断返回键是否触发
        platform.ready().then(function () {
            // Okay, so the platform is ready and our plugins are available.
            // Here you can do any higher level native things you might need.
            statusBar.styleDefault();
            splashScreen.hide();
            _this.initTranslateConfig();
            _this.init();
            //this.rootPage = ScanPage;
            //this.rootPage = PaymentboxPage;
            //this.initializeApp();
            //this.rootPage =  WalltelistPage;
            //this.rootPage = ImportprivatekeyPage;
            //  this.rootPage =  TabsComponent;
            //this.rootPage =  LauncherComponent;
            //this.rootPage =  ManagerComponent;
            //this.rootPage = ExprotPrikeyComponent;
            //this.rootPage = MyComponent;
            //  this.rootPage = WalletCreateComponent;
            //this.rootPage = TestJniComponent;
            //this.rootPage = MnemonicComponent;
            //this.rootPage = ImportComponent;
            //this.rootPage = ContactCreateComponent;
            //this.rootPage = ContactListComponent;
            //this.rootPage = CoinListComponent;
            //this.rootPage = TxdetailsPage;
            //this.rootPage = WalltemodePage;
            //this.rootPage = ScancodePage;
            //this.rootPage = InitializepagePage;
            //this.rootPage = RecordinfoComponent;
            //this.rootPage = CoinComponent;
            //this.rootPage = CoinSelectComponent;
            //this.rootPage = TransferComponent;
            //this.rootPage = IdLauncherComponent;
            //this.rootPage = PathlistPage;
            //this.rootPage = PhoneauthPage;
            //this.rootPage = PhonepathinfoPage;
            //this.rootPage = IdentityauthPage;
            //this.rootPage = IdentitypathinfoPage;
            //this.rootPage = BankcardauthPage;
            //this.rootPage = BankcardpathinfoPage;
            //this.rootPage = CompanypathinfoPage;
            //this.rootPage = IdKycCompanyComponent;
            //this.rootPage = CompanyWriteChainPage;
            //this.rootPage = PersonWriteChainPage;
            //  this.rootPage = ExportmnemomicPage;
            //init java 2 js plugin
        });
    }
    AppComponent.prototype.init = function () {
        var _this = this;
        //this.initJsPush();
        this.getKycIdList();
        this.localStorage.getProgress().then(function (pdata) {
            if (pdata) {
                __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].perObj = JSON.parse(pdata);
            }
            _this.localStorage.getMappingTable().then(function (data) {
                _this.native.info(data);
                if (data) {
                    __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setMappingList(JSON.parse(data));
                }
                _this.rootPage = __WEBPACK_IMPORTED_MODULE_8__pages_initializepage_initializepage__["a" /* InitializepagePage */];
            });
        });
    };
    //
    AppComponent.prototype.onReceiveJG = function (param) {
        var serialNum = JSON.parse(param)["serialNum"];
        var message1 = this.translate.instant("text-Jpush-kyc-message-1");
        var message2 = this.translate.instant("text-Jpush-kyc-message-2");
        alert(message1 + serialNum + message2);
        //  let serialNum = JSON.parse(param)["serialNum"];
        //  let serids = Config.getSerIds();
        //  let serid = serids[serialNum];
        //  let did = serid["id"];
        //  let appName = serid["appName"];
        //  let appr = serid["appr"];
        //  let idsObj = {};
        //  this.ls.getKycList("kycId").then((val)=>{
        //      if(val == null || val === undefined || val === {} || val === ''){
        //           return;
        //      }
        //   idsObj = JSON.parse(val);
        //   idsObj[did][appName][appr]["order"][serialNum]["status"] = 1;
        //   this.ls.set("kycId",idsObj).then(()=>{
        //   });
        //  });
    };
    AppComponent.prototype.initTranslateConfig = function () {
        var _this = this;
        this.translate.addLangs(["zh", "en"]);
        this.localStorage.getLanguage("wallte-language").then(function (val) {
            if (val == null) {
                var lang_1 = navigator.language.substr(0, 2);
                var languageObj = {
                    name: 'English',
                    isoCode: 'en'
                };
                if (lang_1 == 'en') {
                    languageObj = {
                        name: 'English',
                        isoCode: 'en'
                    };
                }
                else if (lang_1 == 'zh') {
                    languageObj = {
                        name: '中文（简体）',
                        isoCode: 'zh'
                    };
                }
                _this.localStorage.set("wallte-language", languageObj).then(function () {
                    // 设置默认语言
                    _this.translate.setDefaultLang(lang_1);
                    _this.translate.use(lang_1);
                    if (lang_1 == 'en') {
                        _this.native.setMnemonicLang("english");
                    }
                    else if (lang_1 == "zh") {
                        _this.native.setMnemonicLang("chinese");
                    }
                    else {
                        _this.native.setMnemonicLang("english");
                    }
                });
            }
            else {
                var lang = JSON.parse(val)["isoCode"];
                _this.translate.use(lang);
                if (lang == 'en') {
                    _this.native.setMnemonicLang("english");
                }
                else if (lang == "zh") {
                    _this.native.setMnemonicLang("chinese");
                }
                else {
                    _this.native.setMnemonicLang("english");
                }
            }
        });
    };
    AppComponent.prototype.initJsPush = function () {
        cordova.plugins.Java2JSBridge.init(this);
        cordova.plugins.Java2JSBridge.getRegistrationID(succeedCallback);
        function succeedCallback(message) {
            __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setDeviceID(message);
        }
    };
    AppComponent.prototype.getKycIdList = function () {
        this.localStorage.getKycList("kycId").then(function (val) {
            if (val == null || val === undefined || val === {} || val === '') {
                return;
            }
            var serids = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getSertoId(JSON.parse(val));
            __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].setSerIds(serids);
        });
    };
    AppComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/app/app.html"*/'<ion-nav #myNav [root]="rootPage"></ion-nav>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/app/app.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicApp */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["b" /* App */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["n" /* Platform */], __WEBPACK_IMPORTED_MODULE_2__ionic_native_status_bar__["a" /* StatusBar */], __WEBPACK_IMPORTED_MODULE_3__ionic_native_splash_screen__["a" /* SplashScreen */], __WEBPACK_IMPORTED_MODULE_4__providers_Localstorage__["a" /* LocalStorage */], __WEBPACK_IMPORTED_MODULE_6__ngx_translate_core__["c" /* TranslateService */], __WEBPACK_IMPORTED_MODULE_7__providers_Native__["a" /* Native */]])
    ], AppComponent);
    return AppComponent;
}());

//# sourceMappingURL=app.component.js.map

/***/ }),

/***/ 840:
/***/ (function(module, exports) {

/* (ignored) */

/***/ }),

/***/ 842:
/***/ (function(module, exports) {

/* (ignored) */

/***/ }),

/***/ 874:
/***/ (function(module, exports) {

/* (ignored) */

/***/ }),

/***/ 875:
/***/ (function(module, exports) {

/* (ignored) */

/***/ }),

/***/ 9:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return LocalStorage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ionic_storage__ = __webpack_require__(409);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


/***
 * 封装存储操作
 */
var LocalStorage = /** @class */ (function () {
    function LocalStorage(storage) {
        this.storage = storage;
    }
    LocalStorage.prototype.add = function (key, value) {
        var _this = this;
        return this.get(key).then(function (val) {
            var id = value['id'];
            if (val === null) {
                var initObj = {};
                initObj[id] = value;
                return _this.storage.set(key, JSON.stringify(initObj));
            }
            var addObj = JSON.parse(val);
            addObj[id] = value;
            return _this.storage.set(key, JSON.stringify(addObj));
        });
    };
    LocalStorage.prototype.set = function (key, value) {
        return this.storage.set(key, JSON.stringify(value));
    };
    LocalStorage.prototype.get = function (key) {
        return this.storage.get(key);
    };
    // get seqnumobj by id authtype(bankcard phone idcard enterprise) sign
    //key  id
    //appType kyc  and so on
    //authType  person  company
    LocalStorage.prototype.getSeqNumObj = function (sign, id, authType, callback) {
        console.info("ElastosJs localstorage getSeqNumObj begin sign " + sign + " id " + id + " authType " + authType);
        /////////////////
        this.get("kycId").then(function (val) {
            var valObj = JSON.parse(val);
            console.info("ElastosJs getSeqNumObj total     valObj " + JSON.stringify(valObj));
            var idJsonObj = valObj[id];
            //console.info( "ElastosJs localstorage getSeqNumObj idJsonObj " + JSON.stringify(idJsonObj) );
            var seqNumObj;
            if (idJsonObj && idJsonObj[authType]) {
                var seqObjs_1 = idJsonObj[authType];
                console.info("ElastosJs localstorage getSeqNumObj order " + JSON.stringify(seqObjs_1));
                for (var prop in seqObjs_1) {
                    //sign ==
                    //console.info( "ElastosJs localstorage prop " + prop);
                    //console.info( "ElastosJs localstorage prop " + prop + " order.prop.params " + JSON.stringify(order[prop]["params"]));
                    //console.info( "ElastosJs localstorage prop " + prop + " order.prop.params.adata " + JSON.stringify(order[prop]["params"]["adata"]));
                    if (seqObjs_1[prop]["adata"]) {
                        // var addataArry = [];
                        // addataArry = seqObjs[prop]["adata"];
                        seqObjs_1[prop]["adata"].forEach(function (value) {
                            // console.info( "ElastosJs value " + JSON.stringify(value) + " typeof value " + typeof (value));
                            if (value && value["resultSign"]) {
                                console.info("ElastosJs value[\"retdata\"] " + JSON.stringify(value["retdata"]));
                                if (sign == value["resultSign"]) {
                                    seqNumObj = seqObjs_1[prop];
                                    console.info("ElastosJs localstorage getSeqNumObj ok  seqNumObj " + JSON.stringify(seqNumObj));
                                }
                            }
                        });
                    }
                }
            }
            callback(seqNumObj);
            //return seqNumObj;
        });
        ////////////////
    };
    LocalStorage.prototype.remove = function (key) {
        return this.storage.remove(key);
    };
    LocalStorage.prototype.clear = function () {
        return this.storage.clear();
    };
    LocalStorage.prototype.setWallet = function (value) {
        // TODO
        var key = "ELA-Wallet";
        return this.storage.set(key, JSON.stringify(value));
    };
    LocalStorage.prototype.getWallet = function () {
        // TODO
        var key = "ELA-Wallet";
        return this.storage.get(key);
    };
    LocalStorage.prototype.addKyc = function (key, value) {
        return this.storage.set(key, JSON.stringify(value));
    };
    LocalStorage.prototype.getKycList = function (key) {
        return this.storage.get(key);
    };
    LocalStorage.prototype.getLanguage = function (key) {
        return this.storage.get(key);
    };
    LocalStorage.prototype.saveCurMasterId = function (value) {
        // {masterId:"123"}
        var key = "cur-masterId";
        return this.storage.set(key, JSON.stringify(value));
    };
    LocalStorage.prototype.getCurMasterId = function () {
        var key = "cur-masterId";
        return this.storage.get(key);
    };
    LocalStorage.prototype.saveMappingTable = function (obj) {
        var key = "map-table";
        return this.add(key, obj);
    };
    LocalStorage.prototype.getMappingTable = function () {
        var key = "map-table";
        return this.storage.get(key);
    };
    LocalStorage.prototype.setProgress = function (obj) {
        var key = "map-Progress";
        this.storage.set(key, JSON.stringify(obj));
    };
    LocalStorage.prototype.getProgress = function () {
        var key = "map-Progress";
        return this.storage.get(key);
    };
    LocalStorage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1__ionic_storage__["b" /* Storage */]])
    ], LocalStorage);
    return LocalStorage;
}());

//# sourceMappingURL=Localstorage.js.map

/***/ }),

/***/ 927:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CoinlistpasswordPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};



var CoinlistpasswordPage = /** @class */ (function () {
    function CoinlistpasswordPage(viewCtrl, native) {
        this.viewCtrl = viewCtrl;
        this.native = native;
        this.singleAddress = false;
    }
    CoinlistpasswordPage.prototype.click_close = function () {
        //let data = {'foo': ''};
        this.viewCtrl.dismiss({});
    };
    CoinlistpasswordPage.prototype.click_button = function () {
        if (this.payPassword) {
            this.viewCtrl.dismiss({ "password": this.payPassword, "singleAddress": this.singleAddress });
        }
        else {
            this.native.toast_trans('text-pwd-validator');
        }
    };
    CoinlistpasswordPage.prototype.click_vcode = function () {
    };
    CoinlistpasswordPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-coinlistpassword',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/coinlistpassword/coinlistpassword.html"*/'<div class="juzhong">\n    <div class="arrow_mask" (click)=click_close()></div>\n    <div class="kuang">\n        <ion-list>\n            <ion-item>\n                <ion-input type="password" placeholder="{{ \'text-pay-passworld-input\' | translate }}" [(ngModel)]="payPassword"></ion-input>\n            </ion-item>\n            <ion-item>\n                <ion-label>{{\'text-signaddress\' | translate }}</ion-label>\n                <ion-checkbox [(ngModel)]="singleAddress"></ion-checkbox>\n            </ion-item>\n        </ion-list>\n        <div style="text-align: center">\n            <button ion-button (click)="click_button()">{{ \'confirm\' | translate }}</button>\n        </div>\n    </div>\n</div>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/coinlistpassword/coinlistpassword.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["q" /* ViewController */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */]])
    ], CoinlistpasswordPage);
    return CoinlistpasswordPage;
}());

//# sourceMappingURL=coinlistpassword.js.map

/***/ }),

/***/ 929:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return TestJniComponent; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__providers_WalletManager__ = __webpack_require__(7);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


var TestJniComponent = /** @class */ (function () {
    function TestJniComponent(walletManager) {
        this.walletManager = walletManager;
        this.masterWalletId = "1";
        this.phrasePassword = "66666666";
        this.newPassword = "66666666";
        this.payPassword = "66666666";
        this.backupPassword = "66666666";
        this.keystoreContent = "ssssss";
        this.mnemonic = "sssssss";
        this.language = "english";
        this.fromAddress = "sssss";
        this.toAddress = "EWs2TgP4Ds3qZcTzWmBZ5hNsx2PaEyxbui";
        this.chinaId = "ELA";
        this.toadress = "EWs2TgP4Ds3qZcTzWmBZ5hNsx2PaEyxbui";
        this.unit = 100000000;
        this.rawTransaction = "sss";
        this.interfaces = [
            { id: 24, name: "generateMnemonic" },
            { id: 3, name: "createMasterWallet" },
            { id: 0, name: "createSubWallet" },
            { id: 9, name: "createAddress" },
            { id: 41, name: "createTransaction" },
            { id: 42, name: "calculateTransactionFee" },
            { id: 43, name: "sendRawTransaction" },
            { id: 30, name: "createDID" },
            { id: 31, name: "getDIDList" },
            { id: 32, name: "destoryDID" },
            { id: 33, name: "didSetValue" },
            { id: 34, name: "didGetValue" },
            { id: 35, name: "didGetHistoryValue" },
            { id: 37, name: "didGetAllKeys" },
            { id: 38, name: "didSign" },
            { id: 39, name: "didCheckSign" },
            { id: 40, name: "didGetPublicKey" },
            { id: 28, name: "getSupportedChains" },
            { id: 8, name: "getBalance" },
            { id: 29, name: "changePassword" },
            { id: 19, name: "getAllMasterWallets" },
            { id: 1, name: "recoverSubWallet" },
            { id: 4, name: "importWalletWithKeystore" },
            { id: 5, name: "importWalletWithMnemonic" },
            { id: 6, name: "exportWalletWithKeystore" },
            { id: 10, name: "getAllAddress" },
            { id: 11, name: "getBalanceWithAddress" },
            { id: 13, name: "generateMultiSignTransaction" },
            { id: 14, name: "getAllTransaction" },
            { id: 15, name: "registerWalletListener" },
            { id: 16, name: "checkSign" },
            { id: 17, name: "sing" },
            { id: 18, name: "deriveIdAndKeyForPurpose" },
            { id: 20, name: "destroyWallet" },
            { id: 21, name: "isAddressValid" },
            { id: 22, name: "getBalanceInfo" },
            { id: 25, name: "saveConfigs" },
            { id: 26, name: "getWalletId" },
            { id: 27, name: "getAllChainIds" },
            { id: 7, name: "exportWalletWithMnemonic" },
        ];
    }
    TestJniComponent.prototype.onNext = function (type) {
        switch (type) {
            case 41:
                this.createTransaction();
                break;
            case 42:
                this.calculateTransactionFee();
                break;
            case 43:
                this.sendRawTransaction();
                break;
            case 40:
                this.didGetPublicKey();
                break;
            case 39:
                this.didCheckSign();
                break;
            case 38:
                this.didSign();
                break;
            case 37:
                this.didGetAllKeys();
                break;
            case 35:
                this.didGetHistoryValue();
                break;
            case 34:
                this.didGetValue();
            case 33:
                this.didSetValue();
                break;
            case 30:
                this.createDID();
                break;
            case 31:
                this.getDIDList();
                break;
            case 32:
                this.destoryDID(this.did);
                break;
            case 0:
                this.createSubWallet(this.chinaId);
                break;
            case 1:
                this.recoverSubWallet();
            case 3:
                this.createMasterWallet(this.masterWalletId, this.mnemonic, this.phrasePassword, this.payPassword);
                break;
            case 4:
                this.importWalletWithKeystore(this.masterWalletId, "sssss", this.backupPassword, this.payPassword, this.phrasePassword);
                break;
            case 5:
                this.importWalletWithMnemonic(this.masterWalletId, this.mnemonic, this.phrasePassword, this.payPassword);
                break;
            case 6:
                this.exportWalletWithKeystore(this.backupPassword, this.payPassword);
                break;
            case 7:
                this.exportWalletWithMnemonic(this.backupPassword);
                break;
            case 8:
                this.getBalance();
                break;
            case 9:
                this.createAddress(this.chinaId);
                break;
            case 10:
                this.getAllAddress(this.chinaId);
                break;
            case 11:
                this.getBalanceWithAddress(this.chinaId);
                break;
            case 13:
                this.generateMultiSignTransaction();
                break;
            case 14:
                this.getAllTransaction();
                break;
            case 15:
                this.registerWalletListener(this.chinaId);
                break;
            case 16:
                this.checkSign("ssssss", this.singMessage, "sssss", this.payPassword);
                break;
            case 17:
                this.sign("1111111111111", this.payPassword);
                break;
            case 18:
                this.deriveIdAndKeyForPurpose(1, 1, this.payPassword);
                break;
            case 19:
                this.getAllMasterWallets();
                break;
            case 20:
                this.destroyWallet(this.masterWalletId);
                break;
            case 21:
                this.isAddressValid(this.adress);
                break;
            case 22:
                this.getBalanceInfo(this.chinaId);
                break;
            case 24:
                this.generateMnemonic();
                break;
            case 25:
                this.saveConfigs();
                break;
            case 26:
                this.getWalletId();
                break;
            case 27:
                this.getAllChainIds();
                break;
            case 28:
                this.getSupportedChains();
                break;
            case 29:
                this.changePassword();
                break;
        }
    };
    TestJniComponent.prototype.changePassword = function () {
        this.walletManager.changePassword(this.masterWalletId, this.payPassword, this.newPassword, function () {
            alert("修改成功");
        });
    };
    TestJniComponent.prototype.generateMnemonic = function () {
        this.walletManager.generateMnemonic(this.language, function (result) {
            alert("=====generateMnemonic=====" + JSON.stringify(result));
            //this.mnemonic = result.mnemonic.toString();
            //alert("住记词"+JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.destroyWallet = function (masterWalletId) {
        this.walletManager.destroyWallet(masterWalletId, function (result) {
            alert("删除主钱包成功");
        });
    };
    TestJniComponent.prototype.createSubWallet = function (key) {
        this.walletManager.createSubWallet(this.masterWalletId, key, 0, function (result) {
            alert("子钱包");
            alert(JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.recoverSubWallet = function () {
        this.walletManager.recoverSubWallet(this.masterWalletId, this.chinaId, 0, 0, function () {
            alert("恢复子钱包");
        });
    };
    TestJniComponent.prototype.createMasterWallet = function (masterWalletId, mnemonic, phrasePassword, payPassWord) {
        this.walletManager.createMasterWallet(masterWalletId, mnemonic, phrasePassword, payPassWord, false, function (result) {
            alert("创建主钱包成功");
        });
    };
    TestJniComponent.prototype.importWalletWithKeystore = function (masterWalletId, keystoreContent, backupPassWord, payPassWord, phrasePassword) {
        this.walletManager.importWalletWithKeystore(masterWalletId, keystoreContent, backupPassWord, payPassWord, function () {
            alert("导入keystore成功");
        });
    };
    TestJniComponent.prototype.importWalletWithMnemonic = function (masterWalletId, mnemonic, phrasePassword, payPassWord) {
        this.walletManager.importWalletWithMnemonic(masterWalletId, mnemonic, phrasePassword, payPassWord, false, function () {
            alert("导入住记词成功");
        });
    };
    TestJniComponent.prototype.exportWalletWithKeystore = function (backupPassword, payPassWord) {
        this.walletManager.exportWalletWithKeystore(this.masterWalletId, backupPassword, payPassWord, function (result) {
            alert("导出keystore成功" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.exportWalletWithMnemonic = function (backupPassword) {
        this.walletManager.exportWalletWithMnemonic(this.masterWalletId, backupPassword, function (result) {
            alert(JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.createAddress = function (chinaId) {
        var _this = this;
        this.walletManager.createAddress(this.masterWalletId, chinaId, function (result) {
            _this.adress = result.address;
            alert(_this.adress);
        });
    };
    TestJniComponent.prototype.getAllAddress = function (chinaId) {
        alert("===chinaId====" + chinaId);
        this.walletManager.getAllAddress(this.masterWalletId, chinaId, 0, function (result) {
            alert(JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.getBalanceWithAddress = function (chinaId) {
        this.walletManager.getBalanceWithAddress(this.masterWalletId, chinaId, "eeeeeeee", 2, function (result) {
            alert(JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.generateMultiSignTransaction = function () {
    };
    TestJniComponent.prototype.getAllTransaction = function () {
        this.walletManager.getAllTransaction(this.masterWalletId, this.chinaId, 0, "123455", function (result) {
            alert(JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.registerWalletListener = function (chinaId) {
        this.walletManager.registerWalletListener(this.masterWalletId, chinaId, function (resust) {
            alert("监听注册成功");
        });
    };
    TestJniComponent.prototype.checkSign = function (address, message, signature, payPassword) {
        this.walletManager.checkSign(this.masterWalletId, this.chinaId, address, message, signature, function (result) {
            alert(JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.sign = function (message, payPassword) {
        var _this = this;
        this.walletManager.sign(this.masterWalletId, this.chinaId, message, payPassword, function (result) {
            alert(JSON.stringify(result));
            _this.singMessage = result;
        });
    };
    TestJniComponent.prototype.getBalance = function () {
        this.walletManager.getBalance(this.masterWalletId, this.chinaId, 0, function (result) {
            alert("获取余额" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.deriveIdAndKeyForPurpose = function (purpose, index, payPassword) {
        this.walletManager.deriveIdAndKeyForPurpose(purpose, index, payPassword, function (result) {
            alert(JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.getAllMasterWallets = function () {
        this.walletManager.getAllMasterWallets(function (result) {
            alert("allAllMasterWallets" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.isAddressValid = function (address) {
        this.walletManager.isAddressValid(this.masterWalletId, address, function (result) {
            alert("isAddressValid====" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.getBalanceInfo = function (chinaId) {
        this.walletManager.getBalanceInfo(this.masterWalletId, chinaId, function (result) {
            alert("余额信息：" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.saveConfigs = function () {
        this.walletManager.saveConfigs(function (resust) {
            alert("保存配置成功");
        });
    };
    TestJniComponent.prototype.getWalletId = function () {
    };
    TestJniComponent.prototype.getAllChainIds = function () {
        this.walletManager.getAllChainIds(function (result) {
            alert("所有子钱包==" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.getSupportedChains = function () {
        var _this = this;
        this.walletManager.getSupportedChains(this.masterWalletId, function (result) {
            alert("已经支持的所有子钱包==" + JSON.stringify(result));
            for (var key in result) {
                ;
                _this.createSubWallet(key);
            }
        });
    };
    TestJniComponent.prototype.createDID = function () {
        var _this = this;
        this.walletManager.createDID(this.payPassword, function (result) {
            alert("==did==" + JSON.stringify(result));
            _this.did = result.didname;
        });
    };
    TestJniComponent.prototype.getDIDList = function () {
        this.walletManager.getDIDList(function (result) {
            alert('==DIDList==' + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.destoryDID = function (did) {
        this.walletManager.destoryDID(did, function (result) {
            alert("删除成功：" + did);
        });
    };
    TestJniComponent.prototype.didSetValue = function () {
        alert("===didSetValue===" + this.did);
        var obj = {
            "101": {
                "datahash": "datahash1",
                "proof": "hello proof1",
                "sign": "hello sign1"
            },
            "102": {
                "datahash": "datahash2",
                "proof": "hello proof2",
                "sign": "hello sign2"
            },
            "103": {
                "datahash": "datahash3",
                "proof": "hello proof3",
                "sign": "hello sign3"
            }
        };
        this.walletManager.didSetValue(this.did, "1", JSON.stringify(obj), function (result) {
            alert("=====" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.didGetValue = function () {
        this.walletManager.didGetValue(this.did, "1", function (result) {
            alert("===didGetValue====" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.didGetHistoryValue = function () {
        this.walletManager.didGetHistoryValue(this.did, "1", function (result) {
            alert("===didGetHistoryValue====" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.didGetAllKeys = function () {
        this.walletManager.didGetAllKeys(this.did, 0, 2, function (result) {
            alert("===didGetAllKeys====" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.didSign = function () {
        var _this = this;
        this.walletManager.didSign(this.did, "ssssss", this.payPassword, function (result) {
            alert("===didSign===" + JSON.stringify(result));
            _this.signature = "sssss";
        });
    };
    TestJniComponent.prototype.didCheckSign = function () {
        this.walletManager.didCheckSign(this.did, "ssssss", this.signature, function (result) {
            alert("===didCheckSign===" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.didGetPublicKey = function () {
        this.walletManager.didGetPublicKey(this.did, function (result) {
            alert("===didGetPublicKey===" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.createTransaction = function () {
        this.walletManager.createTransaction(this.masterWalletId, this.chinaId, "", this.toAddress, 1 * this.unit, "sssssss", "ssss", false, function (result) {
            alert("=====createTransaction======" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.calculateTransactionFee = function () {
        this.walletManager.calculateTransactionFee(this.masterWalletId, this.chinaId, this.rawTransaction, 0, function (result) {
            alert("===== calculateTransactionFee =====" + JSON.stringify(result));
        });
    };
    TestJniComponent.prototype.sendRawTransaction = function () {
        // this.walletManager.sendRawTransaction(this.masterWalletId,this.chinaId,this.transactionJson,this.fee,this.payPassword,(result)=>{
        //                alert("===sendRawTransaction==="+JSON.stringify(result));
        // });
    };
    TestJniComponent = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'app-testjni',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/testjni/testjni.component.html"*/'<ion-content>\n    <ion-list>\n        <ion-item *ngFor="let item of interfaces" (click)="onNext(item.id)">\n            {{item.name}}\n        </ion-item>\n    </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/testjni/testjni.component.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1__providers_WalletManager__["a" /* WalletManager */]])
    ], TestJniComponent);
    return TestJniComponent;
}());

//# sourceMappingURL=testjni.component.js.map

/***/ }),

/***/ 97:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PaymentboxPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};




var PaymentboxPage = /** @class */ (function () {
    function PaymentboxPage(navCtrl, navParams, viewCtrl, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.viewCtrl = viewCtrl;
        this.native = native;
        this.SELA = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].SELA;
        this.toAddress = "";
        this.walltype = false;
        this.transfer = {
            toAddress: '',
            amount: '',
            memo: '',
            fee: 0,
            payPassword: '',
            remark: '',
            rate: ''
        };
        var masterId = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getCurMasterWalletId();
        var accountObj = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getAccountType(masterId);
        if (accountObj["Type"] === "Multi-Sign" && accountObj["InnerType"] === "Readonly") {
            this.walltype = false;
        }
        else {
            this.walltype = true;
        }
        this.transfer = this.navParams.data;
        if (this.transfer["rate"]) {
            this.toAddress = this.transfer["accounts"];
        }
        else {
            this.toAddress = this.transfer["toAddress"];
        }
    }
    PaymentboxPage.prototype.ionViewDidLoad = function () {
    };
    PaymentboxPage.prototype.ionViewWillEnter = function () {
        this.transfer.payPassword = '';
    };
    PaymentboxPage.prototype.click_close = function () {
        this.viewCtrl.dismiss(null);
    };
    PaymentboxPage.prototype.click_button = function () {
        //this.viewCtrl.dismiss(this.transfer);
        if (!this.walltype) {
            this.viewCtrl.dismiss(this.transfer);
            return;
        }
        if (this.transfer.payPassword) {
            this.viewCtrl.dismiss(this.transfer);
        }
        else {
            this.native.toast_trans('text-pwd-validator');
        }
    };
    PaymentboxPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-paymentbox',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/paymentbox/paymentbox.html"*/'<div class="juzhong">\n    <div class="arrow_mask" (click)=click_close()></div>\n    <div class="kuang">\n        <p class="pay-box-title">{{\'transfer-info\' | translate}}\n            <img class="close" src="./assets/images/icon/icon-close.svg" (click)="click_close()">\n        </p>\n\n        <table border="0" style="width: 100%">\n            <tr class="item">\n                <td class="left">{{\'transfer-address\' | translate}}</td>\n                <td class="right1">{{toAddress}}</td>\n            </tr>\n\n            <tr class="item">\n                <td class="left">{{\'text-price\' | translate}}</td>\n                <td class="right">{{transfer.amount}}</td>\n            </tr>\n\n            <tr class="item">\n                <td class="left">{{\'text-fees\' | translate}}</td>\n                <td class="right">{{transfer.fee/SELA}}</td>\n            </tr>\n\n            <tr class="item" *ngIf="transfer.rate">\n                <td class="left">{{\'text-rate\' | translate}}</td>\n                <td class="right">1 : {{transfer.rate}}</td>\n            </tr>\n\n            <tr class="item" class="font-size-1" *ngIf="walltype">\n                <ion-item>\n                    <ion-input type="password" placeholder="{{ \'text-pay-passworld-input\' | translate }}" [(ngModel)]="transfer.payPassword"></ion-input>\n                </ion-item>\n            </tr>\n\n        </table>\n\n        <div style="text-align: center">\n            <button ion-button full (click)="click_button()">{{ \'confirm\' | translate }}</button>\n        </div>\n    </div>\n</div>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/paymentbox/paymentbox.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["q" /* ViewController */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */]])
    ], PaymentboxPage);
    return PaymentboxPage;
}());

//# sourceMappingURL=paymentbox.js.map

/***/ })

},[492]);
//# sourceMappingURL=main.js.map