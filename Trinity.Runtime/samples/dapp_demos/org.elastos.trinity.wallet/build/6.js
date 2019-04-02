webpackJsonp([6],{

/***/ 937:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "NodeinformationPageModule", function() { return NodeinformationPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__nodeinformation__ = __webpack_require__(951);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var NodeinformationPageModule = /** @class */ (function () {
    function NodeinformationPageModule() {
    }
    NodeinformationPageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__nodeinformation__["a" /* NodeinformationPage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__nodeinformation__["a" /* NodeinformationPage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ],
        })
    ], NodeinformationPageModule);
    return NodeinformationPageModule;
}());

//# sourceMappingURL=nodeinformation.module.js.map

/***/ }),

/***/ 951:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return NodeinformationPage; });
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




/**
 * Generated class for the NodeinformationPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var NodeinformationPage = /** @class */ (function () {
    function NodeinformationPage(navCtrl, navParams, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.countrys = [];
        this.isStatus = false;
        this.info = {};
        this.masterId = "1";
        this.info = this.navParams.data["info"];
        this.masterId = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.countrys = __WEBPACK_IMPORTED_MODULE_2__providers_Config__["a" /* Config */].getAllCountry();
        //  if(this.navParams.data["status"] === 0){
        //           this.isStatus = false;
        //  }else if(this.navParams.data["status"] === 1){
        //           this.isStatus = true;
        //  }
    }
    NodeinformationPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad NodeinformationPage');
    };
    NodeinformationPage.prototype.lookOver = function () {
        this.navCtrl.pop();
    };
    NodeinformationPage.prototype.delList = function (parms) {
    };
    NodeinformationPage.prototype.addList = function (parms) {
    };
    NodeinformationPage.prototype.getCountryByCode = function (code) {
        for (var index in this.countrys) {
            var item = this.countrys[index];
            if (code === parseInt(item["code"])) {
                return item["key"];
            }
        }
        return "Unknown";
    };
    NodeinformationPage.prototype.copy = function (url) {
        this.native.copyClipboard(url);
        this.native.toast_trans('copy-ok');
    };
    NodeinformationPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-nodeinformation',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/nodeinformation/nodeinformation.html"*/'<!--\n  Generated template for the NodeinformationPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'node-information\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n\n<ion-content>\n    <div class="top">\n        <img src="./assets/images/vote/zhiwen.png" alt="">\n    </div>\n    <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">{{\'node-name\'|translate}}</ion-col>\n        <ion-col col-12 class="row-content">{{info.nickname}}</ion-col>\n    </ion-row>\n\n    <!-- <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">{{\'node-address\'|translate}}</ion-col>\n        <ion-col col-12 class="row-content">{{info.ownerpublickey}}</ion-col>\n    </ion-row> -->\n\n    <!-- <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">{{\'node-declaration\'|translate}}</ion-col>\n        <ion-col col-12 class="row-content">做公平公开公正的全民节点</ion-col>\n    </ion-row> -->\n\n    <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">{{\'current-votes\'|translate}}</ion-col>\n        <ion-col col-12 class="row-content green">{{info.votes}} {{\'ticket\'|translate}}</ion-col>\n    </ion-row>\n\n    <!-- <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">{{\'share-voting\'|translate}}</ion-col>\n        <ion-col col-12 class="row-content green">3.20%</ion-col>\n    </ion-row> -->\n\n    <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">{{\'country-region\'|translate}}</ion-col>\n        <ion-col col-12 class="row-content">{{getCountryByCode(info.location)|translate}}</ion-col>\n    </ion-row>\n\n    <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">URL</ion-col>\n        <ion-col col-12 class="row-content blue" (click)="copy(info.url)">{{info.url}}<span><img src="./assets/images/vote/copy_url.png"></span></ion-col>\n    </ion-row>\n\n    <ion-row padding-left padding-right>\n        <ion-col col-12 class="row-title">{{\'node-iPAddress\'|translate}}</ion-col>\n        <ion-col col-12 class="row-content">{{info.netaddress}}</ion-col>\n    </ion-row>\n\n</ion-content>\n<!-- <ion-footer>\n    <ion-row padding-left padding-right>\n        <ion-col col-6 *ngIf="!isStatus" (click)="addList(\'\')">\n            <button ion-button>\n                <img src="./assets/images/vote/add_in_list.png" alt="" class="add_in_list">{{\'add-in-list\'|translate}}\n          </button>\n        </ion-col>\n        <ion-col col-6 *ngIf="isStatus" (click)="delList(\'\')">\n            <button ion-button>\n              <img src="./assets/images/vote/move_out.png"  alt="" class="add_in_list" >{{\'del-in-list\'|translate}}\n            </button>\n        </ion-col>\n        <ion-col col-6 (click)="lookOver()">\n            <button ion-button>\n                <img src="./assets/images/vote/look_over.png"  alt="" class="add_in_list" >{{\'look-over-list\'|translate}}\n              </button>\n        </ion-col>\n    </ion-row>\n</ion-footer> -->'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/nodeinformation/nodeinformation.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_3__providers_Native__["a" /* Native */]])
    ], NodeinformationPage);
    return NodeinformationPage;
}());

//# sourceMappingURL=nodeinformation.js.map

/***/ })

});
//# sourceMappingURL=6.js.map