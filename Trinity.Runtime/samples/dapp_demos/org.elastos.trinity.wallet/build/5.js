webpackJsonp([5],{

/***/ 943:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "PointvotePageModule", function() { return PointvotePageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__pointvote__ = __webpack_require__(957);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__components_components_module__ = __webpack_require__(491);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};





var PointvotePageModule = /** @class */ (function () {
    function PointvotePageModule() {
    }
    PointvotePageModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__pointvote__["a" /* PointvotePage */],
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_3__pointvote__["a" /* PointvotePage */]),
                __WEBPACK_IMPORTED_MODULE_2__ngx_translate_core__["b" /* TranslateModule */].forChild(),
                __WEBPACK_IMPORTED_MODULE_4__components_components_module__["a" /* ComponentsModule */]
            ],
        })
    ], PointvotePageModule);
    return PointvotePageModule;
}());

//# sourceMappingURL=pointvote.module.js.map

/***/ }),

/***/ 957:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return PointvotePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_Native__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_Util__ = __webpack_require__(8);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__providers_popup__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__ = __webpack_require__(7);
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
 * Generated class for the PointvotePage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var PointvotePage = /** @class */ (function () {
    function PointvotePage(navCtrl, navParams, modalCtrl, native, popupProvider, walletManager) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.modalCtrl = modalCtrl;
        this.native = native;
        this.popupProvider = popupProvider;
        this.walletManager = walletManager;
        this.voteList = [];
        this.selectNum = 0;
        this.idChainPer = "100";
        this.selectVoteObj = {};
        this.isAllchecked = false;
        this.selectNode = [];
        this.passworld = "";
        this.masterId = "";
        this.curChain = "ELA";
        this.stake = 10;
        this.publickeys = [];
        this.rawTransaction = "";
        this.fee = 0;
        this.feePerKb = 10000;
        this.walletInfo = {};
        this.countrys = [];
        this.useVotedUTXO = true;
        this.masterId = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getCurMasterWalletId();
        this.countrys = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].getAllCountry();
        this.getVoteList();
        this.selectNode = this.navParams.data["selectNode"] || [];
        if (this.selectNode.length > 0) {
            this.useVotedUTXO = true;
        }
        else {
            this.useVotedUTXO = true;
        }
        this.setSelectArr(this.selectNode);
        this.selectNum = this.getSelectNum();
        if (this.selectNum > 0) {
            this.isAllchecked = true;
        }
        else {
            this.isAllchecked = false;
        }
        this.init();
    }
    PointvotePage.prototype.init = function () {
        var _this = this;
        this.walletManager.getMasterWalletBasicInfo(this.masterId, function (data) {
            if (data["success"]) {
                var item = JSON.parse(data["success"])["Account"];
                _this.walletInfo = item;
            }
        });
    };
    PointvotePage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad PointvotePage');
    };
    PointvotePage.prototype.ionViewWillEnter = function () {
        var _this = this;
        this.myInterval = setInterval(function () {
            _this.getVoteList();
        }, 60000);
    };
    PointvotePage.prototype.ionViewDidLeave = function () {
        clearInterval(this.myInterval);
    };
    PointvotePage.prototype.vote = function () {
        if (this.selectNum > 36) {
            this.native.toast_trans("candidate-nodes-error");
            return;
        }
        if (this.selectNum > 0) {
            this.openPayModal();
        }
        else {
            this.native.toast_trans("please-select-voting-node");
        }
    };
    PointvotePage.prototype.setSelectAll = function () {
        this.native.info(this.isAllchecked);
        for (var index in this.voteList) {
            var id = this.voteList[index]["ownerpublickey"];
            this.selectVoteObj[id] = this.isAllchecked;
        }
        this.selectNum = this.getSelectNum();
        console.log(JSON.stringify(this.selectVoteObj));
    };
    PointvotePage.prototype.getSelectNum = function () {
        var index = 0;
        for (var key in this.selectVoteObj) {
            this.native.info(key);
            if (this.selectVoteObj[key]) {
                index++;
            }
        }
        return index;
    };
    PointvotePage.prototype.setSelect = function (ischecked, id) {
        this.selectVoteObj[id] = ischecked;
        this.selectNum = this.getSelectNum();
        if (this.selectNum > 0) {
            this.isAllchecked = true;
        }
        else {
            this.isAllchecked = false;
        }
    };
    PointvotePage.prototype.openPayModal = function () {
        var _this = this;
        var modal = this.modalCtrl.create("InputticketsPage", {});
        modal.onDidDismiss(function (data) {
            if (data) {
                _this.native.info(data);
                _this.stake = data["votes"];
                _this.popupProvider.presentPrompt().then(function (val) {
                    if (__WEBPACK_IMPORTED_MODULE_3__providers_Util__["a" /* Util */].isNull(val)) {
                        _this.native.toast_trans("text-id-kyc-prompt-password");
                        return;
                    }
                    _this.passworld = val.toString();
                    _this.native.showLoading().then(function () {
                        _this.createTx();
                    });
                    //this.native.Go(this.navCtrl,'JoinvotelistPage');
                }).catch(function () {
                });
            }
        });
        modal.present();
    };
    PointvotePage.prototype.setSelectArr = function (arr) {
        for (var index = 0; index < arr.length; index++) {
            var id = arr[index];
            this.selectVoteObj[id] = true;
        }
    };
    //创建交易
    PointvotePage.prototype.createTx = function () {
        var _this = this;
        this.publickeys = this.getSelectPublics();
        var votes = __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].accMul(this.stake, __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA);
        var parms = { "1": this.masterId, "2": this.curChain, "3": votes, "4": JSON.stringify(this.publickeys), "5": "", "6": this.useVotedUTXO };
        this.native.info(parms);
        this.walletManager.createVoteProducerTransaction(this.masterId, this.curChain, "", votes, JSON.stringify(this.publickeys), "", "", this.useVotedUTXO, function (data) {
            _this.native.info(data);
            if (data['success']) {
                var raw = data['success'];
                _this.getFee(raw);
            }
        });
    };
    //计算手续费
    PointvotePage.prototype.getFee = function (rawTransaction) {
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
    PointvotePage.prototype.updateTxFee = function (rawTransaction) {
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
    PointvotePage.prototype.singTx = function (rawTransaction) {
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
    PointvotePage.prototype.sendTx = function (rawTransaction) {
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
    PointvotePage.prototype.readWallet = function (raws) {
        var _this = this;
        this.walletManager.encodeTransactionToString(raws, function (raw) {
            if (raw["success"]) {
                _this.native.hideLoading();
                _this.native.Go(_this.navCtrl, __WEBPACK_IMPORTED_MODULE_7__pages_scancode_scancode__["a" /* ScancodePage */], { "tx": { "chianId": _this.curChain, "fee": _this.fee / __WEBPACK_IMPORTED_MODULE_6__providers_Config__["a" /* Config */].SELA, "raw": raw["success"] } });
            }
        });
    };
    PointvotePage.prototype.getVoteList = function () {
        var _this = this;
        this.native.getHttp().postByAuth(__WEBPACK_IMPORTED_MODULE_8__providers_ApiUrl__["a" /* ApiUrl */].listproducer).toPromise().then(function (data) {
            if (data["status"] === 200) {
                //this.native.info(data);
                var votesResult = JSON.parse(data["_body"]);
                if (votesResult["code"] === "0") {
                    //this.native.info(votesResult);
                    _this.voteList = votesResult["data"]["result"]["producers"] || [];
                }
            }
        });
    };
    PointvotePage.prototype.getCountryByCode = function (code) {
        for (var index in this.countrys) {
            var item = this.countrys[index];
            if (code === parseInt(item["code"])) {
                return item["key"];
            }
        }
        return "Unknown";
    };
    PointvotePage.prototype.getSelectPublics = function () {
        var arr = [];
        for (var key in this.selectVoteObj) {
            this.native.info(key);
            if (this.selectVoteObj[key]) {
                arr.push(key);
            }
        }
        return arr;
    };
    PointvotePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-pointvote',template:/*ion-inline-start:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/pointvote/pointvote.html"*/'<!--\n  Generated template for the PointvotePage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n    <ion-navbar>\n        <ion-title>{{\'super-point\'|translate}}</ion-title>\n    </ion-navbar>\n\n</ion-header>\n\n<ion-content padding>\n    <!-- <ion-row align-items-center padding-bottom>\n        <ion-col col-4>\n            {{\'voting-ratio\'|translate}}：\n        </ion-col>\n\n        <ion-col col-8>\n            <progress-bar proportion="{{idChainPer}}"></progress-bar>\n        </ion-col>\n    </ion-row> -->\n    <div *ngFor="let item of voteList">\n        <ion-row class="vote_data" align-items-center *ngIf="item[\'active\']">\n            <ion-col col-2 class=" text-center ">\n                <div class="duigou">\n                    <ion-checkbox [(ngModel)]="selectVoteObj[item.ownerpublickey]" (ionChange)="setSelect(selectVoteObj[item.ownerpublickey],item.ownerpublickey)"></ion-checkbox>\n                </div>\n            </ion-col>\n            <!-- <ion-col col-2>\n            <div class="logo "><img src="./assets/images/vote/logo_yuan.png "></div>\n        </ion-col> -->\n            <ion-col col-4 class="text-center ">\n                <div class="address ">{{item.nickname}}</div>\n                <div class="fu "><span><img src="./assets/images/vote/location.png "></span>{{getCountryByCode(item.location)|translate}}</div>\n            </ion-col>\n\n            <ion-col col-6 class="text-center">\n                <div class="rank ">NO.{{(item.index+1)}}</div>\n                <div class="rate "><span><img src="./assets/images/vote/rate.png "></span>{{item.votes}} {{\'ticket\'|translate}}</div>\n            </ion-col>\n\n            <!-- <ion-col col-1>\n            <div class="del">\n                <img src="./assets/images/vote/delete.png ">\n            </div>\n        </ion-col> -->\n\n        </ion-row>\n    </div>\n</ion-content>\n<ion-footer>\n    <ion-row class="border-top ">\n        <ion-col col class="rule-vote ">\n            <ion-checkbox [(ngModel)]="isAllchecked" class="vertical-align" (click)="setSelectAll()"></ion-checkbox>{{\'all-election\'|translate}}(<span class="thirty ">30</span>/<span class="all ">{{selectNum}}</span>)</ion-col>\n        <ion-col col class="rule-vote " align-self-center><span class="chose ">{{selectNum}}</span>{{\'have-chosen\'|translate}}</ion-col>\n        <ion-col col class="rule-vote2 " [ngClass]="{ \'bule\':selectNum> 0}" (click)="vote()">{{\'vote-immediately\'|translate}}</ion-col>\n    </ion-row>\n</ion-footer>'/*ion-inline-end:"/Users/kuit/Elastos/wallet/android/src/pages/supernodeelection/superpoint/pointvote/pointvote.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["k" /* NavController */],
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["l" /* NavParams */],
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["j" /* ModalController */],
            __WEBPACK_IMPORTED_MODULE_2__providers_Native__["a" /* Native */],
            __WEBPACK_IMPORTED_MODULE_4__providers_popup__["a" /* PopupProvider */],
            __WEBPACK_IMPORTED_MODULE_5__providers_WalletManager__["a" /* WalletManager */]])
    ], PointvotePage);
    return PointvotePage;
}());

//# sourceMappingURL=pointvote.js.map

/***/ })

});
//# sourceMappingURL=5.js.map