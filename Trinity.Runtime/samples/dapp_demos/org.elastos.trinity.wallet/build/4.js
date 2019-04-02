webpackJsonp([4],{

/***/ 938:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "SignupPageModule", function() { return SignupPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__signup__ = __webpack_require__(952);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var SignupPageModule = /** @class */ (function () {
    function SignupPageModule() {
    }
    SignupPageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__signup__["a" /* SignupPage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__signup__["a" /* SignupPage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ],
        })
    ], SignupPageModule);
    return SignupPageModule;
}());

//# sourceMappingURL=signup.module.js.map

/***/ }),

/***/ 952:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return SignupPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Native__ = __webpack_require__(5);
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
 * Generated class for the SignupPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var SignupPage = /** @class */ (function () {
    function SignupPage(navCtrl, navParams, modalCtrl, popupProvider, native, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.modalCtrl = modalCtrl;
        this.popupProvider = popupProvider;
        this.native = native;
        this.walletManager = walletManager;
        this.nodeName = "";
        this.publickey = "";
        this.nodePublicKey = "";
        this.location = 1;
        this.url = "";
        this.countrys = [];
        this.masterId = "";
        this.curChain = "ELA";
        this.fee = 0;
        this.feePerKb = 10000;
        this.walletInfo = {};
        this.iPAddress = "";
        this.deposit = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].deposit;
        this.countrys = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getAllCountry();
        this.masterId = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.getPublicKeyForVote();
        this.init();
    }
    SignupPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad SignupPage');
    };
    SignupPage.prototype.init = function () {
        var _this = this;
        this.walletManager.getMasterWalletBasicInfo(this.masterId, function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var item = JSON.parse(data["success"])["Account"];
                _this.walletInfo = item;
            }
        });
    };
    SignupPage.prototype.election = function () {
        if (this.checkParms()) {
            this.openPayModal();
        }
    };
    SignupPage.prototype.openPayModal = function () {
        var _this = this;
        var modal = this.modalCtrl.create("LockdetailsPage", {});
        modal.onDidDismiss(function (data) {
            if (data) {
                _this.popupProvider.presentPrompt().then(function (val) {
                    if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNull(val)) {
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
        });
        modal.present();
    };
    SignupPage.prototype.checkParms = function () {
        if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNull(this.nodeName)) {
            this.native.toast_trans('please-enter-node-name');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNodeName(this.nodeName)) {
            this.native.toast_trans('text-node-name-validator1');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNull(this.nodePublicKey)) {
            this.native.toast_trans('please-node-PublicKey');
            return false;
        }
        if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNull(this.iPAddress)) {
            this.native.toast_trans('please-enter-node-iPAddress');
            return false;
        }
        return true;
    };
    SignupPage.prototype.getPublicKeyForVote = function () {
        var _this = this;
        this.walletManager.getPublicKeyForVote(this.masterId, this.curChain, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.publickey = data["success"];
            }
        });
    };
    SignupPage.prototype.generateProducerPayload = function () {
        var _this = this;
        this.walletManager.generateProducerPayload(this.masterId, this.curChain, this.publickey, this.nodePublicKey, this.nodeName, this.url, this.iPAddress, this.location, this.passworld, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                var payLoad = data["success"];
                _this.createRegisterProducerTransaction(payLoad);
            }
        });
    };
    SignupPage.prototype.createRegisterProducerTransaction = function (payloadJson) {
        var _this = this;
        var deposit = __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].accMul(this.deposit, __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].SELA);
        this.walletManager.createRegisterProducerTransaction(this.masterId, this.curChain, "", payloadJson, deposit, "", "", false, function (data) {
            _this.native.info(data);
            if (data["success"]) {
                _this.getFee(data["success"]);
            }
        });
    };
    //计算手续费
    SignupPage.prototype.getFee = function (rawTransaction) {
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
    SignupPage.prototype.updateTxFee = function (rawTransaction) {
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
    SignupPage.prototype.singTx = function (rawTransaction) {
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
    SignupPage.prototype.sendTx = function (rawTransaction) {
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
    SignupPage.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.curChain, "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_5__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
        });
    };
    SignupPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-signup',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/signup/signup.html"*/'<!--\n  Generated template for the SignupPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'sing-up\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n    <div class="border">\n        <ion-row class="padding-top padding-left padding-right">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_name.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-enter-node-name\'|translate}}" [(ngModel)]="nodeName"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="padding-top padding-left padding-right">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_position.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-node-PublicKey\'|translate}}" [(ngModel)]="nodePublicKey"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n        <!-- <ion-row class="padding-top padding-left padding-right">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_position.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-wallet-publickey\'|translate}}" [(ngModel)]="publickey"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row> -->\n\n        <!-- <ion-row class="padding-top padding-left padding-right">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_appeal.png">\n            </ion-col>\n            <ion-col col-10 align-self-center>\n                <textarea rows="10" class="backupWalletTextArea" placeholder="{{\'please-enter-node-declaration\'|translate}}"></textarea>\n            </ion-col>\n        </ion-row> -->\n\n        <ion-row class="padding-top padding-left padding-right">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_address.png">\n            </ion-col>\n            <ion-col col-10 align-self-center>\n                <!-- <ion-input placeholder="请输入节点名称"></ion-input> -->\n                <select class="select" [(ngModel)]="location">\n                  <option *ngFor="let item of countrys"   value ="{{item[\'code\']}}">{{ item["key"] |translate}}</option>\n                </select>\n            </ion-col>\n        </ion-row>\n\n        <ion-row class="padding-top padding-left padding-right padding-bottom">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_url.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-enter-node-url\'|translate}}" [(ngModel)]="url"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n\n        <ion-row class="padding-top padding-left padding-right padding-bottom">\n            <ion-col col-2 align-self-center>\n                <img src="./assets/images/vote/point_url.png">\n            </ion-col>\n            <ion-col col-10 align-self-center class="border-bottom">\n                <ion-item>\n                    <ion-input placeholder="{{\'please-enter-node-iPAddress\'|translate}}" [(ngModel)]="iPAddress"></ion-input>\n                </ion-item>\n            </ion-col>\n        </ion-row>\n\n    </div>\n</ion-content>\n\n<ion-footer padding>\n    <button ion-button round block (click)="election()">{{\'confirmation-of-participation\'|translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/signup/signup.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["j" /* ModalController */], __WEBPACK_IMPORTED_MODULE_2__providers_popup__["a" /* PopupProvider */],
            __WEBPACK_IMPORTED_MODULE_4__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_6__providers_WalletManager__["a" /* WalletManager */]])
    ], SignupPage);
    return SignupPage;
}());

//# sourceMappingURL=signup.js.map

/***/ })

});
//# sourceMappingURL=4.js.map