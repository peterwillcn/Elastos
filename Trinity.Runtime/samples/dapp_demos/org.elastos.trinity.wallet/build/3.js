webpackJsonp([3],{

/***/ 939:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "SuperpointPageModule", function() { return SuperpointPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__superpoint__ = __webpack_require__(953);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var SuperpointPageModule = /** @class */ (function () {
    function SuperpointPageModule() {
    }
    SuperpointPageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__superpoint__["a" /* SuperpointPage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__superpoint__["a" /* SuperpointPage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild(),
            ],
            exports: [
                __WEBPACK_IMPORTED_MODULE_3__superpoint__["a" /* SuperpointPage */]
            ]
        })
    ], SuperpointPageModule);
    return SuperpointPageModule;
}());

//# sourceMappingURL=superpoint.module.js.map

/***/ }),

/***/ 953:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return SuperpointPage; });
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



var SuperpointPage = /** @class */ (function () {
    function SuperpointPage(navCtrl, navParams, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.isExitNode = this.navParams.data["Status"];
        this.info = this.navParams.data["Info"];
    }
    SuperpointPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad SuperpointPage');
    };
    SuperpointPage.prototype.vote = function () {
        console.log('ionViewDidLoad SuperpointPage1');
        this.native.Go(this.navCtrl, 'JoinvotelistPage');
    };
    SuperpointPage.prototype.singup = function () {
        console.log('ionViewDidLoad SuperpointPage2');
        this.native.Go(this.navCtrl, 'SignupPage');
    };
    SuperpointPage.prototype.emanagement = function () {
        this.native.Go(this.navCtrl, 'VotemanagePage', this.info);
    };
    SuperpointPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-superpoint',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/superpoint.html"*/'<!--\n  Generated template for the SuperpointPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'super-point\' | translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content>\n    <div class="logo">\n        <img src="./assets/images/vote/ela_logo.png" alt="">\n    </div>\n</ion-content>\n\n<ion-footer padding>\n    <button ion-button round block (click)="singup()" *ngIf="isExitNode ===\'Unregistered\'">{{\'sign-up-for-election\' | translate}}</button>\n    <button ion-button round block (click)="emanagement()" *ngIf="isExitNode===\'Registered\'">{{\'electoral-management\' | translate}}</button>\n    <button ion-button round block (click)="vote()">{{\'i-want-to-vote\'|translate}}</button>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/superpoint.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */]])
    ], SuperpointPage);
    return SuperpointPage;
}());

//# sourceMappingURL=superpoint.js.map

/***/ })

});
//# sourceMappingURL=3.js.map