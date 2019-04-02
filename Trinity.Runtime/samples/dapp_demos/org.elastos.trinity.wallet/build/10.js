webpackJsonp([10],{

/***/ 933:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "InputticketsPageModule", function() { return InputticketsPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__inputtickets__ = __webpack_require__(947);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var InputticketsPageModule = /** @class */ (function () {
    function InputticketsPageModule() {
    }
    InputticketsPageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__inputtickets__["a" /* InputticketsPage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__inputtickets__["a" /* InputticketsPage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ],
        })
    ], InputticketsPageModule);
    return InputticketsPageModule;
}());

//# sourceMappingURL=inputtickets.module.js.map

/***/ }),

/***/ 947:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return InputticketsPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
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
 * Generated class for the InputticketsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var InputticketsPage = /** @class */ (function () {
    function InputticketsPage(navCtrl, navParams, viewCtrl, native, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.viewCtrl = viewCtrl;
        this.native = native;
        this.walletManager = walletManager;
    }
    InputticketsPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad InputticketsPage');
    };
    InputticketsPage.prototype.click_close = function () {
        this.viewCtrl.dismiss(null);
    };
    InputticketsPage.prototype.click_button = function () {
        if (__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(this.votes)) {
            this.native.toast_trans("please-input-votes");
            return;
        }
        if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].number(this.votes)) {
            this.native.toast_trans('Input value is incorrect');
            return;
        }
        if (this.votes.toString().indexOf(".") > -1 && this.votes.toString().split(".")[1].length > 8) {
            this.native.toast_trans('Input value is incorrect');
            return;
        }
        // if(parseFloat(this.votes) > this.balance){
        //   this.native.toast_trans("Input value is incorrect");
        //    return;
        // }
        this.viewCtrl.dismiss({ "votes": this.votes });
    };
    InputticketsPage.prototype.getBalance = function () {
        var _this = this;
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walletManager.getBalance(this.masterWalletId, 'ELA', 0, function (data) {
            if (!__WEBPACK_IMPORTED_MODULE_2__providers_Util__["a" /* Util */].isNull(data["success"])) {
                _this.native.info(data);
                _this.balance = data["success"] / __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].SELA;
            }
            else {
                _this.native.info(data);
            }
        });
    };
    InputticketsPage.prototype.ionViewWillEnter = function () {
        this.getBalance();
    };
    InputticketsPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-inputtickets',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/inputtickets/inputtickets.html"*/'<!--\n  Generated template for the InputticketsPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<!-- <ion-content> -->\n<div class="juzhong">\n    <div class="arrow_mask" (click)="click_close()"></div>\n    <div class="kuang">\n        <p class="pay-box-title">{{\'please-input-votes\'|translate}}\n            <img class="close" src="./assets/images/icon/icon-close.svg" (click)="click_close()">\n        </p>\n        <ion-row padding-left padding-right>\n            <ion-col col-4 align-self-center>\n                <span class="line">{{\'number-of-votes\'|translate}}</span>\n            </ion-col>\n            <ion-col col-2 align-self-center>\n\n            </ion-col>\n            <ion-col col-6 align-self-center>\n                <ion-input placeholder="{{\'please-input-votes\'|translate}}" [(ngModel)]="votes"></ion-input>\n            </ion-col>\n            <!-- <ion-col col-2 align-self-center class="text-right blue">\n                MAX\n            </ion-col> -->\n        </ion-row>\n\n        <ion-row padding-left padding-right padding-bottom>\n            <ion-col col-12 align-self-center class="text-right line2">\n                最大表决票权 200,000\n            </ion-col>\n        </ion-row>\n        <div padding>\n            <button ion-button round block (click)="click_button()">{{\'text-next-step\'|translate}}</button>\n        </div>\n    </div>\n</div>\n<!-- </ion-content> -->'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/inputtickets/inputtickets.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["q" /* ViewController */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */]])
    ], InputticketsPage);
    return InputticketsPage;
}());

//# sourceMappingURL=inputtickets.js.map

/***/ })

});
//# sourceMappingURL=10.js.map