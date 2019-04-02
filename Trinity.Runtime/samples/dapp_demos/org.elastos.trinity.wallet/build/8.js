webpackJsonp([8],{

/***/ 935:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LockdetailsPageModule", function() { return LockdetailsPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__lockdetails__ = __webpack_require__(949);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var LockdetailsPageModule = /** @class */ (function () {
    function LockdetailsPageModule() {
    }
    LockdetailsPageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__lockdetails__["a" /* LockdetailsPage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__lockdetails__["a" /* LockdetailsPage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ]
        })
    ], LockdetailsPageModule);
    return LockdetailsPageModule;
}());

//# sourceMappingURL=lockdetails.module.js.map

/***/ }),

/***/ 949:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return LockdetailsPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Util__ = __webpack_require__(8);
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






/**
 * Generated class for the LockdetailsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var LockdetailsPage = /** @class */ (function () {
    function LockdetailsPage(navCtrl, navParams, viewCtrl, walletManager, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.viewCtrl = viewCtrl;
        this.walletManager = walletManager;
        this.native = native;
        this.deposit = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].deposit;
    }
    LockdetailsPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad LockdetailsPage');
    };
    LockdetailsPage.prototype.ionViewWillEnter = function () {
        this.getBalance();
    };
    LockdetailsPage.prototype.click_close = function () {
        console.log("click_close");
        this.viewCtrl.dismiss(null);
    };
    LockdetailsPage.prototype.click_button = function () {
        if (this.balance > this.deposit) {
            this.viewCtrl.dismiss(1);
        }
        else {
            this.native.toast_trans("error-amount");
        }
    };
    LockdetailsPage.prototype.getBalance = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walletManager.getBalance(this.masterWalletId, 'ELA', 0, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_4__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.native.info(data);
                _this.balance = data["success"];
            }
            else {
                _this.native.info(data);
            }
        });
    };
    LockdetailsPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-lockdetails',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/lockdetails/lockdetails.html"*/'<!--\n  Generated template for the LockdetailsPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<div class="juzhong">\n    <div class="arrow_mask" (click)="click_close()"></div>\n    <div class="kuang">\n        <p class="pay-box-title">{{\'lock-details\' | translate}}\n            <img class="close" src="./assets/images/icon/icon-close.svg" (click)="click_close()">\n        </p>\n        <ion-row padding>\n            <ion-col col-4 align-self-center>\n                {{\'lock-number\'|translate}}\n            </ion-col>\n            <ion-col col-8 align-self-center class="text-align-right">\n                {{deposit}} ELA\n            </ion-col>\n            <ion-col class="border-bottom"></ion-col>\n        </ion-row>\n\n        <ion-row padding-left>\n            <ion-col col-4>\n                <span class="blue">{{\'remarks-bond\'|translate}}</span>\n            </ion-col>\n        </ion-row>\n        <div padding>\n            <button ion-button round block (click)="click_button()">{{\'text-next-step\'|translate}}</button>\n        </div>\n    </div>\n</div>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/lockdetails/lockdetails.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["q" /* ViewController */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */], __WEBPACK_IMPORTED_MODULE_5__providers_Native__["a" /* Native */]])
    ], LockdetailsPage);
    return LockdetailsPage;
}());

//# sourceMappingURL=lockdetails.js.map

/***/ })

});
//# sourceMappingURL=8.js.map