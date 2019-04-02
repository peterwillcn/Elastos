webpackJsonp([9],{

/***/ 934:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "JoinvotelistPageModule", function() { return JoinvotelistPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__joinvotelist__ = __webpack_require__(948);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var JoinvotelistPageModule = /** @class */ (function () {
    function JoinvotelistPageModule() {
    }
    JoinvotelistPageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__joinvotelist__["a" /* JoinvotelistPage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__joinvotelist__["a" /* JoinvotelistPage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild()
            ],
        })
    ], JoinvotelistPageModule);
    return JoinvotelistPageModule;
}());

//# sourceMappingURL=joinvotelist.module.js.map

/***/ }),

/***/ 948:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return JoinvotelistPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_ApiUrl__ = __webpack_require__(43);
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
 * Generated class for the JoinvotelistPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var JoinvotelistPage = /** @class */ (function () {
    function JoinvotelistPage(navCtrl, navParams, modalCtrl, native) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.modalCtrl = modalCtrl;
        this.native = native;
        this.nodelist = [];
        //this.init();
    }
    JoinvotelistPage.prototype.init = function () {
        this.getVoteList();
    };
    JoinvotelistPage.prototype.ionViewDidLoad = function () {
    };
    JoinvotelistPage.prototype.ionViewWillEnter = function () {
        var _this = this;
        this.init();
        this.myInterval = setInterval(function () {
            _this.init();
        }, 60000);
    };
    JoinvotelistPage.prototype.ionViewDidLeave = function () {
        clearInterval(this.myInterval);
    };
    JoinvotelistPage.prototype.votingRules = function () {
        this.openPayModal();
    };
    JoinvotelistPage.prototype.myvote = function () {
        this.native.Go(this.navCtrl, 'MyvotePage');
    };
    JoinvotelistPage.prototype.tovote = function () {
        this.native.Go(this.navCtrl, 'PointvotePage');
    };
    JoinvotelistPage.prototype.openPayModal = function () {
        var modal = this.modalCtrl.create("VotingrulesPage", {});
        modal.onDidDismiss(function (data) {
            if (data) {
            }
        });
        modal.present();
    };
    JoinvotelistPage.prototype.jumpNodeInformation = function (item) {
        this.native.info(item);
        this.native.Go(this.navCtrl, 'NodeinformationPage', { "info": item });
    };
    JoinvotelistPage.prototype.getVoteList = function () {
        var _this = this;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_3__providers_ApiUrl__["a" /* ApiUrl */].listproducer).toPromise().then(function (data) {
            if (data["status"] === 200) {
                _this.native.info(data);
                var votesResult = JSON.parse(data["_body"]);
                if (votesResult["code"] === "0") {
                    _this.native.info(votesResult);
                    _this.nodelist = votesResult["data"]["result"]["producers"] || [];
                }
            }
        });
    };
    JoinvotelistPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-joinvotelist',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/joinvotelist/joinvotelist.html"*/'<!--\n  Generated template for the JoinvotelistPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'super-point\' | translate}}</ion-title>\n    </ion-navbar>\n</ion-header>\n\n\n<ion-content padding>\n    <!-- <div class="top">\n        <ion-row padding-left padding-right padding-top>\n            <ion-col col-4 class="text-center title">{{\'proportion-of-voting\'|translate}}</ion-col>\n            <ion-col col-4 class="text-center title">{{\'present-quorum-votes\'|translate}}</ion-col>\n            <ion-col col-4 class="text-center title">{{\'number-of-voting-addresses\'|translate}}</ion-col>\n        </ion-row>\n\n        <ion-row padding>\n            <ion-col col-4 class="text-center border-right number">3.20%</ion-col>\n            <ion-col col-4 class="text-center border-right number">1635458</ion-col>\n            <ion-col col-4 class="text-center number">14452</ion-col>\n        </ion-row>\n    </div> -->\n\n\n    <ion-grid>\n        <ion-row padding-top>\n\n            <!-- <ion-col col col-4 col-auto class="col-bottom" *ngFor="let item of nodelist; let i = index" (click)="jumpNodeInformation(0)" [ngClass]="{\'ticket\': (i+1)%3===1,\'ticket_second left-right-border\':(i+1)%3===2,\'ticket_first\':(i+1)%3===0}"> -->\n            <ion-col col col-4 col-auto class="col-bottom ticket_first" *ngFor="let item of nodelist; let i = index" (click)="jumpNodeInformation(item)" [ngClass]="{\'left-right-border\':(i+1)%3===2,\'bg1\':!item[\'active\']}">\n                <div class="pic" style="margin-top:40px">\n                    <!-- <img src="./assets/images/vote/ticket.png" alt=""> -->\n                </div>\n                <div class="title">{{item.nickname}}</div>\n                <div class="value">{{item.votes}} ELA</div>\n                <div class="ticket_num">{{item.votes}} {{\'ticket\'|translate}}</div>\n                <div class="rank_img"><img src="./assets/images/vote/rank_img.png" alt=""></div>\n                <div class="rank_num">No.{{(item.index+1)}}</div>\n            </ion-col>\n        </ion-row>\n    </ion-grid>\n</ion-content>\n<ion-footer>\n    <ion-row>\n        <ion-col col-4 class="text-center my_vote" (click)="myvote()">\n            <img src="./assets/images/vote/my_vote.png"> {{\'my-vote\'|translate}}\n        </ion-col>\n        <ion-col col-4 class="text-center vote_rule" (click)="votingRules()">\n            <img src="./assets/images/vote/vote_rule.png">{{\'voting-rules\'|translate}}\n        </ion-col>\n        <ion-col col-4 class="text-center to_vote" (click)="tovote()">\n            <img src="./assets/images/vote/to_vote.png">{{\'I-want-to-vote\'|translate}}\n        </ion-col>\n    </ion-row>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/joinvotelist/joinvotelist.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["j" /* ModalController */], __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */]])
    ], JoinvotelistPage);
    return JoinvotelistPage;
}());

//# sourceMappingURL=joinvotelist.js.map

/***/ })

});
//# sourceMappingURL=9.js.map