(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["pages-level2-level2-module"],{

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/level2/level2.page.html":
/*!*************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/level2/level2.page.html ***!
  \*************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<ion-header no-border>\n  <ion-toolbar mode=\"ios\" color=\"dark\">\n    <ion-buttons slot=\"start\" class=\"header-btns\">\n      <ion-button (click)=\"gameService.minimizeApp()\">\n        <ion-icon name=\"remove-circle\"></ion-icon>\n      </ion-button>\n    </ion-buttons>\n    <ion-title>Level 2</ion-title>\n    <ion-buttons slot=\"end\" class=\"header-btns\">\n      <ion-button (click)=\"gameService.closeApp()\">\n        <ion-icon name=\"close\"></ion-icon>\n      </ion-button>\n    </ion-buttons>\n  </ion-toolbar>\n</ion-header>\n\n<ion-content>\n  <ion-grid>\n\n    <!-- Show loading screen -->\n    <div align=\"center\" *ngIf=\"!startGame\">\n      <br>\n      <h2>Match All Coins!</h2>\n      <p>You have a total of <b>{{ userLife }}</b> tries.</p>\n      <br>\n      <h4>Start in <span style=\"color:#CC0000;font-size:24px;\">{{ countDown }}</span>...</h4>\n    </div>\n\n    <!-- Actual cards display -->\n    <div align=\"center\" *ngIf=\"startGame && gameState === 'init'\">\n      <h2>Match All Coins!</h2>\n      <ion-row align-items-center text-center size=\"8\">\n\n        <ion-col align-self-center size=\"3\" *ngFor=\"let c of cardsArray; let i = index\">\n          <!-- show card background -->\n          <img src=\"../../assets/img/cards/background.jpg\" *ngIf=\"c.pos != selectCard1pos && c.pos != selectCard2pos && c.val > -1\" (click)=\"selectCard(c.pos, c.val, i)\" style=\"width:80px; height:80px; border: solid 2px #000; border-radius: 12px;\">\n          <!-- show card 1 selected -->\n          <img [src]=\"imageDir + gameService.images[c.val] + '.png'\" *ngIf=\"c.pos == selectCard1pos && c.val > -1\" style=\"width:80px; height:80px; border: solid 2px #000; border-radius: 12px;\">\n          <!-- show card 2 selected -->\n          <img [src]=\"imageDir + gameService.images[c.val] + '.png'\" *ngIf=\"c.pos == selectCard2pos && c.val > -1\" style=\"width:80px; height:80px; border: solid 2px #000; border-radius: 12px;\">\n          <!-- show hidden card -->\n          <img *ngIf=\"c.val == -1\" style=\"width:80px; height:80px; border: solid 2px #000; border-radius: 12px;visibility: hidden;\">\n\n        </ion-col>\n      </ion-row>\n    </div>\n\n    <div align=\"center\" *ngIf=\"startGame && gameState === 'init'\">\n      <ion-row>\n        <ion-col col-9 no-padding>\n          <p no-margin>You have <span style=\"color:#00CC00; font-size: 24px;\">{{ userLife }}</span> tries...</p>\n        </ion-col>\n        <ion-col no-padding>\n          <p no-margin><span style=\"color:#CC0000; font-size: 24px;\">{{ shownTime }}</span></p>\n        </ion-col>\n      </ion-row>\n    </div>\n\n    <!-- Show Win screen -->\n    <div *ngIf=\"gameState === 'win'\" align=\"center\">\n      <br>\n      <h2>You <span style=\"color:#00CC00; font-size: 28px;\">WON</span>!</h2>\n      <p>You are halfway there! Ready to proceed?</p>\n      <br>\n      <ion-button mode=\"ios\" size=\"large\" color=\"success\" (click)=\"nextLevel()\">\n        <ion-icon name=\"repeat\"></ion-icon>\n        &nbsp; &nbsp; Level 3\n      </ion-button>\n    </div>\n\n    <!-- Show Lose screen -->\n    <div *ngIf=\"gameState === 'lose'\" align=\"center\">\n      <br>\n      <h2>You <span style=\"color:#CC0000; font-size: 28px;\">LOST</span>!</h2>\n      <p>Would you like to try again?</p>\n      <br>\n      <ion-button mode=\"ios\" size=\"large\" color=\"danger\" routerLink=\"/level1\" routerDirection=\"back\">\n        <ion-icon name=\"repeat\"></ion-icon>\n        &nbsp; &nbsp; Reset Game\n      </ion-button>\n    </div>\n\n  </ion-grid>\n</ion-content>\n");

/***/ }),

/***/ "./src/app/pages/level2/level2.module.ts":
/*!***********************************************!*\
  !*** ./src/app/pages/level2/level2.module.ts ***!
  \***********************************************/
/*! exports provided: Level2PageModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "Level2PageModule", function() { return Level2PageModule; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/fesm5/common.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/fesm5/forms.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/fesm5/router.js");
/* harmony import */ var _ionic_angular__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ionic/angular */ "./node_modules/@ionic/angular/dist/fesm5.js");
/* harmony import */ var _level2_page__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./level2.page */ "./src/app/pages/level2/level2.page.ts");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __importDefault = (undefined && undefined.__importDefault) || function (mod) {
  return (mod && mod.__esModule) ? mod : { "default": mod };
};






var routes = [
    {
        path: '',
        component: _level2_page__WEBPACK_IMPORTED_MODULE_5__["Level2Page"]
    }
];
var Level2PageModule = /** @class */ (function () {
    function Level2PageModule() {
    }
    Level2PageModule = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"])({
            imports: [
                _angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
                _angular_forms__WEBPACK_IMPORTED_MODULE_2__["FormsModule"],
                _ionic_angular__WEBPACK_IMPORTED_MODULE_4__["IonicModule"],
                _angular_router__WEBPACK_IMPORTED_MODULE_3__["RouterModule"].forChild(routes)
            ],
            declarations: [_level2_page__WEBPACK_IMPORTED_MODULE_5__["Level2Page"]]
        })
    ], Level2PageModule);
    return Level2PageModule;
}());



/***/ }),

/***/ "./src/app/pages/level2/level2.page.scss":
/*!***********************************************!*\
  !*** ./src/app/pages/level2/level2.page.scss ***!
  \***********************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("h2 {\n  font-weight: 800; }\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9Vc2Vycy9icGlldHRlL0RvY3VtZW50cy9QZXJzby9EZXYvZWxhc3Rvcy9HaXRodWJzL0VsYXN0b3MuVHJpbml0eS9Ub29sQ2hhaW5zL2NsaS9zcmMvYXNzZXRzL2RhcHB0ZW1wbGF0ZS9hbmd1bGFyL2dhbWUvc3JjL2FwcC9wYWdlcy9sZXZlbDIvbGV2ZWwyLnBhZ2Uuc2NzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtFQUNFLGdCQUFnQixFQUFBIiwiZmlsZSI6InNyYy9hcHAvcGFnZXMvbGV2ZWwyL2xldmVsMi5wYWdlLnNjc3MiLCJzb3VyY2VzQ29udGVudCI6WyJoMiB7XG4gIGZvbnQtd2VpZ2h0OiA4MDA7XG59XG4iXX0= */");

/***/ }),

/***/ "./src/app/pages/level2/level2.page.ts":
/*!*********************************************!*\
  !*** ./src/app/pages/level2/level2.page.ts ***!
  \*********************************************/
/*! exports provided: Level2Page */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "Level2Page", function() { return Level2Page; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var src_app_services_game_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/app/services/game.service */ "./src/app/services/game.service.ts");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/fesm5/router.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __importDefault = (undefined && undefined.__importDefault) || function (mod) {
  return (mod && mod.__esModule) ? mod : { "default": mod };
};



var Level2Page = /** @class */ (function () {
    function Level2Page(gameService, router) {
        this.gameService = gameService;
        this.router = router;
        this.cardsTotal = 12; // Total cards to match (divided by 2)
        this.cardsArray = []; // Store all card pairs
        this.userLife = 5; // Total amount of tries user gets
        this.imageDir = '../../assets/img/coins/';
        this.selectCard1pos = -1; // Selected card #1 position
        this.selectCard1val = -1; // Selected card #1 value
        this.selectCard2pos = -1; // Selected card #2 position
        this.selectCard2val = -1; // Selected card #2 value
        this.selectOldPosix = -1; // Store old position
        this.debugText = "Debug text goes here! :)";
    }
    Level2Page.prototype.ngOnInit = function () {
        this.restartGame();
    };
    // Function to populate cards array with
    // position and value pairs from 0 to 6
    Level2Page.prototype.populateCards = function () {
        this.cardsArray = [];
        var x = 0;
        var y = 0;
        for (var i = 0; i < this.cardsTotal; i++) {
            // Push card to array and assign value
            this.cardsArray.push({ pos: i, val: y });
            // Flip x to assign next card same value
            if (x === 0)
                x = 1;
            else {
                x = 0;
                y++;
            }
        }
    };
    // Function to select a card
    Level2Page.prototype.selectCard = function (pos, val, i) {
        var _this = this;
        var actOne = false;
        // Code to select the second card
        if (this.selectCard1pos > -1 && this.selectCard2pos == -1) {
            this.selectCard2pos = pos;
            this.selectCard2val = val;
            actOne = true;
        }
        // Code to select the first card
        if (this.selectCard1pos == -1 && !actOne) {
            this.selectCard1pos = pos;
            this.selectCard1val = val;
            this.selectOldPosix = i;
        }
        // If we have both cards selected, check for match or fail
        if (actOne && this.selectCard1pos > -1 && this.selectCard2pos > -1) {
            setTimeout(function () {
                // if the cards match, do this...
                if (_this.selectCard1val === _this.selectCard2val) {
                    _this.debugText = "Cards match!";
                    _this.cardsArray.splice(_this.selectOldPosix, 1, { pos: _this.selectOldPosix, val: -1 });
                    _this.cardsArray.splice(i, 1, { pos: i, val: -1 });
                    _this.resetSelects();
                    _this.winCon();
                }
                // Otherwise, take a life and reset
                else {
                    _this.debugText = "Cards don't match!";
                    _this.userLife -= 1;
                    _this.resetSelects();
                    if (_this.userLife <= 0)
                        _this.loseCon();
                }
            }, 1000);
        }
    };
    // Function to shuffle an array
    Level2Page.prototype.shuffle = function (a) {
        var j, x, i;
        for (i = a.length; i; i--) {
            j = Math.floor(Math.random() * i);
            x = a[i - 1];
            a[i - 1] = a[j];
            a[j] = x;
        }
    };
    Level2Page.prototype.nextLevel = function () {
        this.restartGame();
        this.router.navigate(['level3']);
    };
    // Function to restart the game
    Level2Page.prototype.restartGame = function () {
        var _this = this;
        this.gameState = 'load'; // Keep track of current game state
        this.startGame = false; // Will set to false to display intro
        this.countDown = 3; // Lets show 3 second countDown
        this.totalTime = 60; // How long the player has to win
        this.countTime = 0; // Elapsed time while game is playing
        this.shownTime = 0; // Time shown as string format
        this.interCount = null; // Timer: 1 second for in game counter
        this.userLife = 5;
        this.resetSelects();
        this.populateCards();
        this.shuffle(this.cardsArray);
        this.shuffle(this.gameService.images);
        setTimeout(function () {
            _this.startGame = true; // Actually start the game
            _this.gameState = 'init'; // Game has been initialized
        }, this.countDown * 1000);
        // This will subtract 1 from countdown start time
        this.interCount = setInterval(function () {
            if (_this.countDown === 0) {
                clearInterval(_this.interCount);
                _this.interCount = null;
            }
            else
                _this.countDown -= 1;
        }, 1000);
        // This timer will keep track of time once the game starts
        setTimeout(function () {
            _this.interTime = setInterval(function () {
                if (_this.countTime >= _this.totalTime)
                    _this.loseCon();
                if (_this.gameState == 'init') {
                    _this.countTime += 1; // Add 1 second to counter
                    var minutes = Math.floor((_this.totalTime - _this.countTime) / 60);
                    var seconds = (_this.totalTime - _this.countTime) - minutes * 60;
                    _this.shownTime = minutes.toString() + ":" + seconds.toString();
                }
                else {
                    clearInterval(_this.interTime);
                    _this.interTime = null;
                }
            }, 1000);
        }, this.countDown * 1000 + 200);
    };
    // Win condition
    Level2Page.prototype.winCon = function () {
        var winCheck = false;
        // If at least 1 or more cards have not been solved,
        // then user hasn't won yet
        for (var i = 0; i < this.cardsArray.length; i++)
            if (this.cardsArray[i].val != -1)
                winCheck = true;
        // if winCheck is false, player has won the game
        if (winCheck == false)
            this.gameState = 'win';
    };
    // Lose condition
    Level2Page.prototype.loseCon = function () {
        this.gameState = 'lose';
    };
    // Function to reset selected cards
    Level2Page.prototype.resetSelects = function () {
        this.selectCard1pos = -1; // Selected card #1 position
        this.selectCard1val = -1; // Selected card #1 value
        this.selectCard2pos = -1; // Selected card #2 position
        this.selectCard2val = -1; // Selected card #2 value
    };
    Level2Page.ctorParameters = function () { return [
        { type: src_app_services_game_service__WEBPACK_IMPORTED_MODULE_1__["GameService"] },
        { type: _angular_router__WEBPACK_IMPORTED_MODULE_2__["Router"] }
    ]; };
    Level2Page = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-level2',
            template: __importDefault(__webpack_require__(/*! raw-loader!./level2.page.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/level2/level2.page.html")).default,
            styles: [__importDefault(__webpack_require__(/*! ./level2.page.scss */ "./src/app/pages/level2/level2.page.scss")).default]
        }),
        __metadata("design:paramtypes", [src_app_services_game_service__WEBPACK_IMPORTED_MODULE_1__["GameService"],
            _angular_router__WEBPACK_IMPORTED_MODULE_2__["Router"]])
    ], Level2Page);
    return Level2Page;
}());



/***/ })

}]);
//# sourceMappingURL=pages-level2-level2-module.js.map