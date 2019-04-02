webpackJsonp([2],{

/***/ 940:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "UpdateproducerPageModule", function() { return UpdateproducerPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__updateproducer__ = __webpack_require__(954);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var UpdateproducerPageModule = /** @class */ (function () {
    function UpdateproducerPageModule() {
    }
    UpdateproducerPageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__updateproducer__["a" /* UpdateproducerPage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__updateproducer__["a" /* UpdateproducerPage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ],
        })
    ], UpdateproducerPageModule);
    return UpdateproducerPageModule;
}());

//# sourceMappingURL=updateproducer.module.js.map

/***/ }),

/***/ 954:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return UpdateproducerPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__ = __webpack_require__(67);
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
 * Generated class for the UpdateproducerPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var UpdateproducerPage = /** @class */ (function () {
    function UpdateproducerPage(navCtrl, navParams, native, popupProvider, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.popupProvider = popupProvider;
        this.walletManager = walletManager;
        this.info = {};
        this.passworld = "";
        this.masterId = "";
        this.curChain = "ELA";
        this.fee = 0;
        this.feePerKb = 10000;
        this.walletInfo = {};
        this.countrys = [];
        this.countrys = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getAllCountry();
        this.info = this.native.clone(this.navParams.data);
        this.masterId = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.init();
    }
    UpdateproducerPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad UpdateproducerPage');
    };
    UpdateproducerPage.prototype.init = function () {
        var _this = this;
        this.walletManager.getMasterWalletBasicInfo(this.masterId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var item = JSON.parse(data["success"])["Account"];
                _this.walletInfo = item;
            }
        });
    };
    UpdateproducerPage.prototype.updateInfo = function () {
        var _this = this;
        if (this.checkParms()) {
            this.popupProvider.presentPrompt().then(function (val) {
                if (__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isNull(val)) {
                    _this.native.toast_trans("text-id-kyc-prompt-password");
                    return;
                }
                _this.passworld = val.toString();
                _this.native.showLoading().then(function () {
                    _this.generateProducerPayload();
                });
                //this.native.Go(this.navCtrl,'JoinvotelistPage');
            }).catch(function () {
            });
        }
    };
    UpdateproducerPage.prototype.generateProducerPayload = function () {
        var _this = this;
        this.walletManager.generateProducerPayload(this.masterId, this.curChain, this.info["ownerpublickey"], this.info["nodepublickey"], this.info["nickname"], this.info["url"], this.info["netaddress"], this.info["location"], this.passworld, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                var payLoad = data["success"];
                _this.createUpdateProducerTransaction(payLoad);
            }
        });
    };
    UpdateproducerPage.prototype.createUpdateProducerTransaction = function (payloadJson) {
        var _this = this;
        this.walletManager.createUpdateProducerTransaction(this.masterId, this.curChain, "", payloadJson, "", "", false, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.getFee(data["success"]);
            }
        });
    };
    //计算手续费
    UpdateproducerPage.prototype.getFee = function (rawTransaction) {
        var _this = this;
        this.walletManager.calculateTransactionFee(this.masterId, this.curChain, rawTransaction, this.feePerKb, function (data) {
            if (data['success']) {
                _this.native.hideLoading();
                _this.native.info(data);
                _this.fee = data['success'];
                _this.popupProvider.presentConfirm1(_this.fee / __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].SELA).then(function () {
                    _this.native.showLoading().then(function () {
                        _this.updateTxFee(rawTransaction);
                    });
                });
            }
        });
    };
    UpdateproducerPage.prototype.updateTxFee = function (rawTransaction) {
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
    UpdateproducerPage.prototype.singTx = function (rawTransaction) {
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
                            _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.curChain, "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
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
    UpdateproducerPage.prototype.sendTx = function (rawTransaction) {
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
    UpdateproducerPage.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.curChain, "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
        });
    };
    UpdateproducerPage.prototype.checkParms = function () {
        if (__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isNull(this.info['nodepublickey'])) {
            this.native.toast_trans('please-node-PublicKey');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isNull(this.info['netaddress'])) {
            this.native.toast_trans('please-enter-node-iPAddress');
            return false;
        }
        return true;
    };
    UpdateproducerPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-updateproducer',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/updateproducer/updateproducer.html"*/'<!--\n  Generated template for the UpdateproducerPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'update-info\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n    <div class="border">\n\n        <ion-row class="padding-top padding-left padding-right">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_position.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-node-PublicKey\'|translate}}" [(ngModel)]="info[\'nodepublickey\']"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n\n        <ion-row class="padding-top padding-left padding-right">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_address.png">\n            </ion-col>\n            <ion-col col-10 align-self-center>\n                <!-- <ion-input placeholder="请输入节点名称"></ion-input> -->\n                <select class="select" [(ngModel)]="info[\'location\']">\n                  <option *ngFor="let item of countrys"   value ="{{item[\'code\']}}">{{ item["key"] |translate}}</option>\n                </select>\n            </ion-col>\n        </ion-row>\n\n\n\n        <ion-row class="padding-top padding-left padding-right padding-bottom">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_url.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-enter-node-url\'|translate}}" [(ngModel)]="info[\'url\']"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="padding-top padding-left padding-right padding-bottom">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_url.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-enter-node-iPAddress\'|translate}}" [(ngModel)]="info[\'netaddress\']"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n    </div>\n</ion-content>\n<ion-footer>\n\n    <ion-row padding>\n\n        <ion-col col-3 class="text-center">\n\n        </ion-col>\n\n        <ion-col col-6 class="text-center">\n            <button ion-button full class="border-radius" (click)="updateInfo()">{{\'update-info\'|translate}}</button>\n        </ion-col>\n\n        <ion-col col-3 class="text-center">\n\n        </ion-col>\n    </ion-row>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/updateproducer/updateproducer.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_popup__["a" /* PopupProvider */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */]])
    ], UpdateproducerPage);
    return UpdateproducerPage;
}());

//# sourceMappingURL=updateproducer.js.map

/***/ })

});
//# sourceMappingURL=2.js.map