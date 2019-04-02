webpackJsonp([7],{

/***/ 936:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "MyvotePageModule", function() { return MyvotePageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__myvote__ = __webpack_require__(950);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var MyvotePageModule = /** @class */ (function () {
    function MyvotePageModule() {
    }
    MyvotePageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__myvote__["a" /* MyvotePage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__myvote__["a" /* MyvotePage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ],
        })
    ], MyvotePageModule);
    return MyvotePageModule;
}());

//# sourceMappingURL=myvote.module.js.map

/***/ }),

/***/ 950:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return MyvotePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_Config__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_ApiUrl__ = __webpack_require__(43);
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
 * Generated class for the MyvotePage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var MyvotePage = /** @class */ (function () {
    function MyvotePage(navCtrl, navParams, native, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.native = native;
        this.walletManager = walletManager;
        this.masterWalletId = "1";
        this.walletName = "";
        this.totalNum = 1100;
        this.voteList = [];
        this.selectNode = [];
        this.masterWalletId = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.walletName = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getWalletName(this.masterWalletId);
        this.init();
    }
    MyvotePage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad MyvotePage');
    };
    MyvotePage.prototype.changevote = function () {
        console.log("=============" + JSON.stringify(this.selectNode));
        this.native.Go(this.navCtrl, "PointvotePage", { "selectNode": this.selectNode });
    };
    MyvotePage.prototype.getVotedProducerList = function (list) {
        var _this = this;
        // let productList = JSON.parse("{\"03b273e27a6820b55fe5a6b7a445814f7c1db300e961661aaed3a06cbdfd3dca5d\":110000000}");
        // this.selectNode = this.objtoArr(productList);
        // this.voteList = this.getVoteList(productList,list);
        this.walletManager.getVotedProducerList(this.masterWalletId, "ELA", function (data) {
            if (data["success"]) {
                _this.native.info(data);
                var productList = JSON.parse(data["success"]);
                _this.selectNode = _this.objtoArr(productList);
                _this.voteList = _this.getVoteList(productList, list);
            }
        });
    };
    MyvotePage.prototype.init = function () {
        var _this = this;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_5__providers_ApiUrl__["a" /* ApiUrl */].listproducer).toPromise().then(function (data) {
            if (data["status"] === 200) {
                _this.native.info(data);
                var votesResult = JSON.parse(data["_body"]);
                if (votesResult["code"] === "0") {
                    _this.native.info(votesResult);
                    var list = votesResult["data"]["result"]["producers"] || [];
                    _this.getVotedProducerList(list);
                }
            }
        });
    };
    MyvotePage.prototype.objtoArr = function (obj) {
        var arr = [];
        for (var key in obj) {
            arr.push(key);
        }
        return arr;
    };
    MyvotePage.prototype.getVoteList = function (obj, list) {
        var arr = [];
        for (var key in obj) {
            var name_1 = __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].getNickname(key, list);
            if (name_1 != "") {
                var item = { "name": name_1, "votes": obj[key] / __WEBPACK_IMPORTED_MODULE_4__providers_Config__["a" /* Config */].SELA };
                arr.push(item);
            }
        }
        return arr;
    };
    MyvotePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-myvote',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/myvote/myvote.html"*/'<!--\n  Generated template for the MyvotePage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'my-vote\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n<ion-content padding>\n    <!-- <div class="wallet">\n        <div class="name">\n            <div class="big">{{walletName}}</div>\n             <div class="small">A6ESh9uaN...wnxzYKuKPjX</div>\n            <div class="data">\n                <img src="./assets/images/vote/going_on.png">\n                 <div class="power">{{\'this-vote\'|translate}}：<span>{{totalNum}}</span></div>\n            </div>\n        </div>\n        <div class="logo">\n            <div class="logo_img">\n                <img src="./assets/images/vote/waiting_img.png">\n            </div>\n        </div>\n    </div> -->\n    <ion-row align-items-center padding-top *ngIf="voteList.length === 0" class="text-center no-data">\n        <ion-col>\n            <img src="./assets/images/vote/empty_page.png">\n            <div class="empty_history">{{\'no-voting-records\'|translate}}</div>\n        </ion-col>\n    </ion-row>\n\n    <!-- <ion-row align-items-center padding-top *ngIf="voteList.length > 0">\n        <ion-col col-4 class="text-left title">\n            {{\'current voting record\'|translate}}\n        </ion-col>\n        <ion-col col-8 class="text-right title-number">\n\n        </ion-col>\n    </ion-row> -->\n\n    <ion-row align-items-center class="border-bottom" padding-top padding-bottom *ngFor="let item of voteList; let i = index">\n        <ion-col col-4 class="text-left list">\n            {{item.name}}\n        </ion-col>\n        <ion-col col-8 class="text-right rank">\n            {{item.votes}}\n        </ion-col>\n    </ion-row>\n</ion-content>\n<ion-footer>\n    <ion-row padding-left padding-right (click)="changevote()">\n        <ion-col col-12 class="text-center">\n            <button ion-button full class="border-radius">{{\'change-vote\'|translate}}</button>\n        </ion-col>\n    </ion-row>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/myvote/myvote.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */], __WEBPACK_IMPORTED_MODULE_3__providers_WalletManager__["a" /* WalletManager */]])
    ], MyvotePage);
    return MyvotePage;
}());

//# sourceMappingURL=myvote.js.map

/***/ })

});
//# sourceMappingURL=7.js.map