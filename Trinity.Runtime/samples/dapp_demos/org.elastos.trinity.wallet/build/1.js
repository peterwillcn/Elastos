webpackJsonp([1],{

/***/ 941:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "VotemanagePageModule", function() { return VotemanagePageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__votemanage__ = __webpack_require__(955);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var VotemanagePageModule = /** @class */ (function () {
    function VotemanagePageModule() {
    }
    VotemanagePageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__votemanage__["a" /* VotemanagePage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__votemanage__["a" /* VotemanagePage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ],
        })
    ], VotemanagePageModule);
    return VotemanagePageModule;
}());

//# sourceMappingURL=votemanage.module.js.map

/***/ }),

/***/ 955:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return VotemanagePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__ = __webpack_require__(67);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__providers_ApiUrl__ = __webpack_require__(43);
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
 * Generated class for the VotemanagePage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var VotemanagePage = /** @class */ (function () {
    function VotemanagePage(navCtrl, navParams, popupProvider, native, walletManager, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.popupProvider = popupProvider;
        this.native = native;
        this.walletManager = walletManager;
        this.zone = zone;
        this.passworld = "";
        this.masterId = "1";
        this.publickey = "";
        this.curChain = "ELA";
        this.fee = 0;
        this.feePerKb = 10000;
        this.info = {};
        this.walletInfo = {};
        this.voteList = [];
        this.countrys = [];
        this.masterId = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.countrys = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getAllCountry();
        this.getVoteList();
        this.init();
        //this.getRegisteredProducerInfo();
        //this.getPublicKeyForVote();
    }
    VotemanagePage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad VotemanagePage');
    };
    VotemanagePage.prototype.init = function () {
        var _this = this;
        this.walletManager.getMasterWalletBasicInfo(this.masterId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var item = JSON.parse(data["success"])["Account"];
                _this.walletInfo = item;
            }
        });
    };
    VotemanagePage.prototype.logout = function () {
        var _this = this;
        this.popupProvider.ionicConfirm('confirmTitle', 'log-out-subTitle').then(function (data) {
            if (data) {
                _this.popupProvider.presentPrompt().then(function (val) {
                    if (__WEBPACK_IMPORTED_MODULE_5__providers_Util__["a" /* Util */].isNull(val)) {
                        _this.native.toast_trans("text-id-kyc-prompt-password");
                        return;
                    }
                    _this.passworld = val.toString();
                    _this.native.showLoading().then(function () {
                        _this.generateCancelProducerPayload();
                    });
                    //this.native.Go(this.navCtrl,'JoinvotelistPage');
                }).catch(function () {
                });
            }
        });
    };
    VotemanagePage.prototype.getPublicKeyForVote = function () {
        var _this = this;
        this.walletManager.getPublicKeyForVote(this.masterId, this.curChain, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.publickey = data["success"];
            }
        });
    };
    VotemanagePage.prototype.generateCancelProducerPayload = function () {
        var _this = this;
        this.walletManager.generateCancelProducerPayload(this.masterId, this.curChain, this.publickey, this.passworld, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.createCancelProducerTransaction(data["success"]);
            }
        });
    };
    VotemanagePage.prototype.createCancelProducerTransaction = function (payloadJson) {
        var _this = this;
        this.walletManager.createCancelProducerTransaction(this.masterId, this.curChain, "", payloadJson, "", "", false, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.getFee(data["success"]);
            }
        });
    };
    //计算手续费
    VotemanagePage.prototype.getFee = function (rawTransaction) {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterId, this.curChain, rawTransaction, this.feePerKb, function (data) {
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
    VotemanagePage.prototype.updateTxFee = function (rawTransaction) {
        var _this = this;
        this.walletManager.updateTransactionFee(this.masterId, this.curChain, rawTransaction, this.fee, "", function (data) {
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
    VotemanagePage.prototype.singTx = function (rawTransaction) {
        var _this = this;
        this.walletManager.signTransaction(this.masterId, this.curChain, rawTransaction, this.passworld, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                if (_this.walletInfo["Type"] === "Standard") {
                    _this.sendTx(data["success"]);
                }
                else if (_this.walletInfo["Type"] === "Multi-Sign") {
                    _this.walletManager.encodeTransactionToString(data["success"], function (raw) {
                        if (raw["success"]) {
                            _this.native.hideLoading();
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.curChain, "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
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
    VotemanagePage.prototype.sendTx = function (rawTransaction) {
        var _this = this;
        this.native.info(rawTransaction);
        this.walletManager.publishTransaction(this.masterId, this.curChain, rawTransaction, function (data) {
            if (data['success']) {
                _this.native.hideLoading();
                _this.native.toast_trans('send-raw-transaction');
            }
            else {
                _this.native.info(data);
            }
        });
    };
    VotemanagePage.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.curChain, "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
        });
    };
    VotemanagePage.prototype.getRegisteredProducerInfo = function () {
        // this.zone.run(()=>{
        //   this.info = this.getCurProducerInfo("0341315fe4e1f26ba09c5c56bf76e1e97aaee992f59407b33c4fc9d42e11634bdc");
        // });
        var _this = this;
        // console.log(JSON.stringify(this.info));
        //this.native.info(this.info);
        this.walletManager.getRegisteredProducerInfo(this.masterId, "ELA", function (data) {
            _this.native.info(data);
            if (data["success"]) {
                var item = JSON.parse(data["success"]);
                var publicKey = item["Info"]["OwnerPublicKey"];
                _this.publickey = item["Info"]["OwnerPublicKey"];
                _this.native.info(_this.publickey);
                _this.info = _this.getCurProducerInfo(publicKey);
                _this.native.info(_this.info);
            }
        });
    };
    VotemanagePage.prototype.getCurProducerInfo = function (publicKey) {
        for (var index = 0; index < this.voteList.length; index++) {
            var item = this.voteList[index];
            if (publicKey === item["ownerpublickey"]) {
                return item;
            }
        }
        return {};
    };
    VotemanagePage.prototype.getVoteList = function () {
        var _this = this;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_8__providers_ApiUrl__["a" /* ApiUrl */].listproducer).toPromise().then(function (data) {
            if (data["status"] === 200) {
                //this.native.info(data);
                var votesResult = JSON.parse(data["_body"]);
                if (votesResult["code"] === "0") {
                    //this.native.info(votesResult);
                    _this.voteList = votesResult["data"]["result"]["producers"] || [];
                    //console.log(JSON.stringify(this.voteList));
                    _this.native.info(_this.voteList);
                    _this.getRegisteredProducerInfo();
                }
            }
        });
    };
    VotemanagePage.prototype.getCountryByCode = function (code) {
        for (var index in this.countrys) {
            var item = this.countrys[index];
            if (code === parseInt(item["code"])) {
                return item["key"];
            }
        }
        return "Unknown";
    };
    VotemanagePage.prototype.updateInfo = function () {
        this.native.Go(this.navCtrl, 'UpdateproducerPage', this.info);
    };
    VotemanagePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-votemanage',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/votemanage/votemanage.html"*/'<!--\n  Generated template for the VotemanagePage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'vote-manage\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n    <div class="border">\n        <ion-row padding-left padding-right padding-top align-items-center>\n            <ion-col col-2>\n                <div class="general">\n                    <img src="./assets/images/vote/point_name.png" alt="">\n                </div>\n            </ion-col>\n\n            <ion-col col-10>\n                <div class="pargaph">{{info.nickname}}</div>\n            </ion-col>\n        </ion-row>\n\n        <!-- <ion-row padding-left padding-right align-items-center>\n            <ion-col col-2>\n                <div class="general">\n                    <img src="./assets/images/vote/point_position.png" alt="">\n                </div>\n            </ion-col>\n\n            <ion-col col-10>\n                <div class="pargaph">{{info.ownerpublickey}}</div>\n            </ion-col>\n        </ion-row> -->\n\n        <ion-row padding-left padding-right align-items-center>\n            <ion-col col-2>\n                <div class="general">\n                    <img src="./assets/images/vote/point_address.png" alt="">\n                </div>\n            </ion-col>\n\n            <ion-col col-10>\n                <div class="pargaph">{{getCountryByCode(info.location)|translate}}</div>\n            </ion-col>\n        </ion-row>\n\n        <ion-row padding-left padding-right align-items-center>\n            <ion-col col-2>\n                <div class="general">\n                    <img src="./assets/images/vote/point_url.png" alt="">\n                </div>\n            </ion-col>\n\n            <ion-col col-10>\n                <div class="pargaph">{{info.url}}</div>\n            </ion-col>\n        </ion-row>\n\n        <ion-row padding-left padding-right align-items-center>\n            <ion-col col-2>\n                <div class="general">\n                    <img src="./assets/images/vote/percentage.png" alt="">\n                </div>\n            </ion-col>\n\n            <ion-col col-10>\n                <div class="pargaph">{{info.votes}} {{\'ticket\'|translate}}</div>\n            </ion-col>\n        </ion-row>\n\n        <ion-row padding-left padding-right align-items-center>\n            <ion-col col-2>\n                <div class="general">\n                    <img src="./assets/images/vote/ranking.png" alt="">\n                </div>\n            </ion-col>\n\n            <ion-col col-10>\n                <div class="pargaph">NO.{{(info.index+1)}}</div>\n            </ion-col>\n        </ion-row>\n\n        <ion-row padding-left padding-right padding-bottom align-items-center>\n            <ion-col col-2>\n                <div class="general">\n                    <img src="./assets/images/vote/point_url.png" alt="">\n                </div>\n            </ion-col>\n\n            <ion-col col-10>\n                <div class="pargaph">{{info.netaddress}} </div>\n            </ion-col>\n        </ion-row>\n\n    </div>\n</ion-content>\n<ion-footer>\n    <ion-row>\n        <ion-col col-6 class="text-center">\n            <button ion-button full class="border-radius" (click)="updateInfo()">{{\'update-info\'|translate}}</button>\n        </ion-col>\n\n        <ion-col col-6 class="text-center">\n            <button ion-button full class="border-radius" color="danger" (click)="logout()">{{\'log-out\'|translate}}</button>\n        </ion-col>\n    </ion-row>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/votemanage/votemanage.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["M" /* NgZone */]])
    ], VotemanagePage);
    return VotemanagePage;
}());

//# sourceMappingURL=votemanage.js.map

/***/ })

});
//# sourceMappingURL=1.js.map