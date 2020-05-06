(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["pages-appmanager-appmanager-module"],{

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/appmanager/appmanager.page.html":
/*!*********************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/appmanager/appmanager.page.html ***!
  \*********************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<ion-content>\n  <ion-grid class=\"container\">\n    <ion-card>\n      <ion-card-title>App Manager</ion-card-title>\n      <ion-card-content>\n        App Manager is a plugin that provides developers the methods to manage their app relating to the elastOS ecosystem.\n      </ion-card-content>\n    </ion-card>\n\n    <h1>How to Setup</h1>\n    <p>To use App Manager, just simply add the line of code below to any typescript file that needs its service.</p>\n    <img src=\"assets/appmanager/declare.png\"/>\n\n    <h1>How to Use</h1>\n    <p>With App Manager declared, you can now use its methods such as sending intents or closing this application.</p>\n    <img src=\"assets/appmanager/sample.png\"/>\n\n    <h1>App Manager Options</h1>\n    <ion-row class=\"type\">\n      <ion-col size=\"5.9\" *ngFor=\"let manager of appManagerService.managers\" (click)=\"appManagerService.openManager(manager)\">\n        <ion-label>{{ manager.type }}</ion-label>\n      </ion-col>\n    </ion-row>\n\n  </ion-grid>\n</ion-content>\n");

/***/ }),

/***/ "./src/app/pages/appmanager/appmanager.module.ts":
/*!*******************************************************!*\
  !*** ./src/app/pages/appmanager/appmanager.module.ts ***!
  \*******************************************************/
/*! exports provided: AppmanagerPageModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "AppmanagerPageModule", function() { return AppmanagerPageModule; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/fesm5/common.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/fesm5/forms.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/fesm5/router.js");
/* harmony import */ var _ionic_angular__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ionic/angular */ "./node_modules/@ionic/angular/dist/fesm5.js");
/* harmony import */ var _appmanager_page__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./appmanager.page */ "./src/app/pages/appmanager/appmanager.page.ts");
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
        component: _appmanager_page__WEBPACK_IMPORTED_MODULE_5__["AppmanagerPage"]
    }
];
var AppmanagerPageModule = /** @class */ (function () {
    function AppmanagerPageModule() {
    }
    AppmanagerPageModule = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"])({
            imports: [
                _angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
                _angular_forms__WEBPACK_IMPORTED_MODULE_2__["FormsModule"],
                _ionic_angular__WEBPACK_IMPORTED_MODULE_4__["IonicModule"],
                _angular_router__WEBPACK_IMPORTED_MODULE_3__["RouterModule"].forChild(routes)
            ],
            declarations: [_appmanager_page__WEBPACK_IMPORTED_MODULE_5__["AppmanagerPage"]]
        })
    ], AppmanagerPageModule);
    return AppmanagerPageModule;
}());



/***/ }),

/***/ "./src/app/pages/appmanager/appmanager.page.scss":
/*!*******************************************************!*\
  !*** ./src/app/pages/appmanager/appmanager.page.scss ***!
  \*******************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = (".container {\n  min-height: 100%;\n  background-image: linear-gradient(to top, #e6e9f0 0%, #eef1f5 100%);\n  padding: 30px 15px;\n  display: flex;\n  flex-direction: column;\n  justify-content: flex-start;\n  align-items: flex-start; }\n  .container ion-card {\n    margin: 0;\n    min-width: 66%;\n    padding: 25px;\n    display: flex;\n    flex-direction: column;\n    justify-content: center;\n    align-items: center;\n    border-radius: 15px;\n    background: #181d20; }\n  .container ion-card ion-card-title {\n      margin: 0;\n      text-align: center;\n      color: white;\n      letter-spacing: 0.3px;\n      font-size: 26px;\n      font-weight: 800; }\n  .container ion-card ion-card-content {\n      margin: 15px 15px 0;\n      padding: 0;\n      text-align: center;\n      color: white;\n      letter-spacing: 0.3px;\n      font-size: 13px;\n      font-weight: 500; }\n  .container h1 {\n    margin: 30px 5px 0;\n    font-size: 20px;\n    font-weight: 800; }\n  .container p {\n    margin: 5px;\n    font-size: 13px;\n    font-weight: 600;\n    line-height: 1.53; }\n  .container img {\n    border-radius: 10px; }\n  .container .type {\n    width: 100%;\n    margin-top: 5px;\n    display: flex;\n    justify-content: space-between; }\n  .container .type ion-col {\n      background: linear-gradient(to bottom, #181d20 0%, #21313d 100%);\n      border-radius: 15px;\n      margin-bottom: 5px;\n      padding: 15px;\n      display: flex;\n      align-items: center; }\n  .container .type ion-col ion-label {\n        color: white;\n        font-size: 12px;\n        font-weight: 500;\n        letter-spacing: 2px; }\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9Vc2Vycy9jaGFkcmFjZWxpcy9Db2RpbmcvVHJpbml0eS9Ccm93c2VyL1Rvb2xjaGFpbnMvRWxhc3Rvcy5UcmluaXR5LlRvb2xDaGFpbnMvY2xpL2Fzc2V0cy9kYXBwdGVtcGxhdGUvYW5ndWxhci9kZW1vL3NyYy9hcHAvcGFnZXMvYXBwbWFuYWdlci9hcHBtYW5hZ2VyLnBhZ2Uuc2NzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtFQUNFLGdCQUFnQjtFQUNoQixtRUFBbUU7RUFDbkUsa0JBQWtCO0VBQ2xCLGFBQWE7RUFDYixzQkFBc0I7RUFDdEIsMkJBQTJCO0VBQzNCLHVCQUF1QixFQUFBO0VBUHpCO0lBVUksU0FBUztJQUNULGNBQWM7SUFDZCxhQUFhO0lBQ2IsYUFBYTtJQUNiLHNCQUFzQjtJQUN0Qix1QkFBdUI7SUFDdkIsbUJBQW1CO0lBQ25CLG1CQUFtQjtJQUNuQixtQkFBbUIsRUFBQTtFQWxCdkI7TUFxQk0sU0FBUztNQUNULGtCQUFrQjtNQUNsQixZQUFZO01BQ1oscUJBQXFCO01BQ3JCLGVBQWU7TUFDZixnQkFBZ0IsRUFBQTtFQTFCdEI7TUE4Qk0sbUJBQW1CO01BQ25CLFVBQVU7TUFDVixrQkFBa0I7TUFDbEIsWUFBWTtNQUNaLHFCQUFxQjtNQUNyQixlQUFlO01BQ2YsZ0JBQWdCLEVBQUE7RUFwQ3RCO0lBeUNJLGtCQUFrQjtJQUNsQixlQUFlO0lBQ2YsZ0JBQWdCLEVBQUE7RUEzQ3BCO0lBK0NJLFdBQVc7SUFDWCxlQUFlO0lBQ2YsZ0JBQWdCO0lBQ2hCLGlCQUFpQixFQUFBO0VBbERyQjtJQXNESSxtQkFBbUIsRUFBQTtFQXREdkI7SUEwREksV0FBVztJQUNYLGVBQWU7SUFDZixhQUFhO0lBQ2IsOEJBQThCLEVBQUE7RUE3RGxDO01BZ0VNLGdFQUFpRTtNQUNqRSxtQkFBbUI7TUFDbkIsa0JBQWtCO01BQ2xCLGFBQWE7TUFDYixhQUFhO01BQ2IsbUJBQW1CLEVBQUE7RUFyRXpCO1FBd0VRLFlBQVk7UUFDWixlQUFlO1FBQ2YsZ0JBQWdCO1FBQ2hCLG1CQUFtQixFQUFBIiwiZmlsZSI6InNyYy9hcHAvcGFnZXMvYXBwbWFuYWdlci9hcHBtYW5hZ2VyLnBhZ2Uuc2NzcyIsInNvdXJjZXNDb250ZW50IjpbIi5jb250YWluZXIge1xuICBtaW4taGVpZ2h0OiAxMDAlO1xuICBiYWNrZ3JvdW5kLWltYWdlOiBsaW5lYXItZ3JhZGllbnQodG8gdG9wLCAjZTZlOWYwIDAlLCAjZWVmMWY1IDEwMCUpO1xuICBwYWRkaW5nOiAzMHB4IDE1cHg7XG4gIGRpc3BsYXk6IGZsZXg7XG4gIGZsZXgtZGlyZWN0aW9uOiBjb2x1bW47XG4gIGp1c3RpZnktY29udGVudDogZmxleC1zdGFydDtcbiAgYWxpZ24taXRlbXM6IGZsZXgtc3RhcnQ7XG5cbiAgaW9uLWNhcmQge1xuICAgIG1hcmdpbjogMDtcbiAgICBtaW4td2lkdGg6IDY2JTtcbiAgICBwYWRkaW5nOiAyNXB4O1xuICAgIGRpc3BsYXk6IGZsZXg7XG4gICAgZmxleC1kaXJlY3Rpb246IGNvbHVtbjtcbiAgICBqdXN0aWZ5LWNvbnRlbnQ6IGNlbnRlcjtcbiAgICBhbGlnbi1pdGVtczogY2VudGVyO1xuICAgIGJvcmRlci1yYWRpdXM6IDE1cHg7XG4gICAgYmFja2dyb3VuZDogIzE4MWQyMDtcblxuICAgIGlvbi1jYXJkLXRpdGxlIHtcbiAgICAgIG1hcmdpbjogMDtcbiAgICAgIHRleHQtYWxpZ246IGNlbnRlcjtcbiAgICAgIGNvbG9yOiB3aGl0ZTtcbiAgICAgIGxldHRlci1zcGFjaW5nOiAwLjNweDtcbiAgICAgIGZvbnQtc2l6ZTogMjZweDtcbiAgICAgIGZvbnQtd2VpZ2h0OiA4MDA7XG4gICAgfVxuXG4gICAgaW9uLWNhcmQtY29udGVudCB7XG4gICAgICBtYXJnaW46IDE1cHggMTVweCAwO1xuICAgICAgcGFkZGluZzogMDtcbiAgICAgIHRleHQtYWxpZ246IGNlbnRlcjtcbiAgICAgIGNvbG9yOiB3aGl0ZTtcbiAgICAgIGxldHRlci1zcGFjaW5nOiAwLjNweDtcbiAgICAgIGZvbnQtc2l6ZTogMTNweDtcbiAgICAgIGZvbnQtd2VpZ2h0OiA1MDA7XG4gICAgfVxuICB9XG5cbiAgaDEge1xuICAgIG1hcmdpbjogMzBweCA1cHggMDtcbiAgICBmb250LXNpemU6IDIwcHg7XG4gICAgZm9udC13ZWlnaHQ6IDgwMDtcbiAgfVxuXG4gIHAge1xuICAgIG1hcmdpbjogNXB4O1xuICAgIGZvbnQtc2l6ZTogMTNweDtcbiAgICBmb250LXdlaWdodDogNjAwO1xuICAgIGxpbmUtaGVpZ2h0OiAxLjUzO1xuICB9XG5cbiAgaW1nIHtcbiAgICBib3JkZXItcmFkaXVzOiAxMHB4O1xuICB9XG5cbiAgLnR5cGUge1xuICAgIHdpZHRoOiAxMDAlO1xuICAgIG1hcmdpbi10b3A6IDVweDtcbiAgICBkaXNwbGF5OiBmbGV4O1xuICAgIGp1c3RpZnktY29udGVudDogc3BhY2UtYmV0d2VlbjtcblxuICAgIGlvbi1jb2wge1xuICAgICAgYmFja2dyb3VuZDogbGluZWFyLWdyYWRpZW50KHRvIGJvdHRvbSwgIzE4MWQyMCAwJSwgICMyMTMxM2QgMTAwJSk7XG4gICAgICBib3JkZXItcmFkaXVzOiAxNXB4O1xuICAgICAgbWFyZ2luLWJvdHRvbTogNXB4O1xuICAgICAgcGFkZGluZzogMTVweDtcbiAgICAgIGRpc3BsYXk6IGZsZXg7XG4gICAgICBhbGlnbi1pdGVtczogY2VudGVyO1xuXG4gICAgICBpb24tbGFiZWwge1xuICAgICAgICBjb2xvcjogd2hpdGU7XG4gICAgICAgIGZvbnQtc2l6ZTogMTJweDtcbiAgICAgICAgZm9udC13ZWlnaHQ6IDUwMDtcbiAgICAgICAgbGV0dGVyLXNwYWNpbmc6IDJweDtcbiAgICAgIH1cbiAgICB9XG4gIH1cbn1cbiJdfQ== */");

/***/ }),

/***/ "./src/app/pages/appmanager/appmanager.page.ts":
/*!*****************************************************!*\
  !*** ./src/app/pages/appmanager/appmanager.page.ts ***!
  \*****************************************************/
/*! exports provided: AppmanagerPage */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "AppmanagerPage", function() { return AppmanagerPage; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var src_app_services_appmanager_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/app/services/appmanager.service */ "./src/app/services/appmanager.service.ts");
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


var AppmanagerPage = /** @class */ (function () {
    function AppmanagerPage(appManagerService) {
        this.appManagerService = appManagerService;
    }
    AppmanagerPage.prototype.ngOnInit = function () {
        titleBarManager.setTitle("App Manager Demo");
        titleBarManager.setNavigationMode(2 /* BACK */);
    };
    AppmanagerPage.prototype.ionViewWillEnter = function () {
        titleBarManager.setTitle("App Manager Demo");
        titleBarManager.setNavigationMode(2 /* BACK */);
    };
    AppmanagerPage.ctorParameters = function () { return [
        { type: src_app_services_appmanager_service__WEBPACK_IMPORTED_MODULE_1__["AppmanagerService"] }
    ]; };
    AppmanagerPage = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-appmanager',
            template: __importDefault(__webpack_require__(/*! raw-loader!./appmanager.page.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/appmanager/appmanager.page.html")).default,
            styles: [__importDefault(__webpack_require__(/*! ./appmanager.page.scss */ "./src/app/pages/appmanager/appmanager.page.scss")).default]
        }),
        __metadata("design:paramtypes", [src_app_services_appmanager_service__WEBPACK_IMPORTED_MODULE_1__["AppmanagerService"]])
    ], AppmanagerPage);
    return AppmanagerPage;
}());



/***/ })

}]);
//# sourceMappingURL=pages-appmanager-appmanager-module.js.map