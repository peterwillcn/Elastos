(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["pages-titlebar-titlebar-module"],{

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/titlebar/titlebar.page.html":
/*!*****************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/titlebar/titlebar.page.html ***!
  \*****************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<ion-content>\n  <ion-grid class=\"container\">\n    <ion-card>\n      <ion-card-title>Titlebar Manager</ion-card-title>\n      <ion-card-content>\n        Just like a web browser, elastOS applications have a titlebar above which can be managed by developers such as changing the title and color or setting up navigation or menu items.\n      </ion-card-content>\n    </ion-card>\n\n    <h1>How to Setup</h1>\n    <p>To use Titlebar Manager, just simply add the line of code below to any typescript file that needs its service.</p>\n    <img src=\"assets/titlebar/declare.png\"/>\n\n    <h1>How to Use</h1>\n    <p>With Titlebar Manager declared, it's best used under a page life cycle or upon app render</p>\n    <img src=\"assets/titlebar/sample.png\"/>\n\n    <h1>Titlebar Options</h1>\n    <ion-row class=\"type\">\n      <ion-col size=\"5.9\" *ngFor=\"let manager of titlebarService.managers\" (click)=\"titlebarService.openManager(manager)\">\n        <ion-label>{{ manager.type }}</ion-label>\n      </ion-col>\n    </ion-row>\n\n\n  </ion-grid>\n</ion-content>\n");

/***/ }),

/***/ "./src/app/pages/titlebar/titlebar.module.ts":
/*!***************************************************!*\
  !*** ./src/app/pages/titlebar/titlebar.module.ts ***!
  \***************************************************/
/*! exports provided: TitlebarPageModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "TitlebarPageModule", function() { return TitlebarPageModule; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/fesm5/common.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/fesm5/forms.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/fesm5/router.js");
/* harmony import */ var _ionic_angular__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ionic/angular */ "./node_modules/@ionic/angular/dist/fesm5.js");
/* harmony import */ var _titlebar_page__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./titlebar.page */ "./src/app/pages/titlebar/titlebar.page.ts");
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
        component: _titlebar_page__WEBPACK_IMPORTED_MODULE_5__["TitlebarPage"]
    }
];
var TitlebarPageModule = /** @class */ (function () {
    function TitlebarPageModule() {
    }
    TitlebarPageModule = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"])({
            imports: [
                _angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
                _angular_forms__WEBPACK_IMPORTED_MODULE_2__["FormsModule"],
                _ionic_angular__WEBPACK_IMPORTED_MODULE_4__["IonicModule"],
                _angular_router__WEBPACK_IMPORTED_MODULE_3__["RouterModule"].forChild(routes)
            ],
            declarations: [_titlebar_page__WEBPACK_IMPORTED_MODULE_5__["TitlebarPage"]]
        })
    ], TitlebarPageModule);
    return TitlebarPageModule;
}());



/***/ }),

/***/ "./src/app/pages/titlebar/titlebar.page.scss":
/*!***************************************************!*\
  !*** ./src/app/pages/titlebar/titlebar.page.scss ***!
  \***************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = (".container {\n  min-height: 100%;\n  background-image: linear-gradient(to top, #e6e9f0 0%, #eef1f5 100%);\n  padding: 30px 15px;\n  display: flex;\n  flex-direction: column;\n  justify-content: flex-start;\n  align-items: flex-start; }\n  .container ion-card {\n    margin: 0;\n    min-width: 66%;\n    padding: 25px;\n    display: flex;\n    flex-direction: column;\n    justify-content: center;\n    align-items: center;\n    border-radius: 15px;\n    background: #181d20; }\n  .container ion-card ion-card-title {\n      margin: 0;\n      text-align: center;\n      color: white;\n      letter-spacing: 0.3px;\n      font-size: 26px;\n      font-weight: 800; }\n  .container ion-card ion-card-content {\n      margin: 15px 15px 0;\n      padding: 0;\n      text-align: center;\n      color: white;\n      letter-spacing: 0.3px;\n      font-size: 13px;\n      font-weight: 500; }\n  .container h1 {\n    margin: 30px 5px 0;\n    font-size: 20px;\n    font-weight: 800; }\n  .container p {\n    margin: 5px;\n    font-size: 13px;\n    font-weight: 600;\n    line-height: 1.53; }\n  .container img {\n    border-radius: 10px; }\n  .container .type {\n    width: 100%;\n    margin-top: 5px;\n    display: flex;\n    justify-content: space-between; }\n  .container .type ion-col {\n      background: linear-gradient(to bottom, #181d20 0%, #21313d 100%);\n      border-radius: 15px;\n      margin-bottom: 5px;\n      padding: 15px;\n      display: flex;\n      align-items: center; }\n  .container .type ion-col ion-label {\n        color: white;\n        font-size: 12px;\n        font-weight: 500;\n        letter-spacing: 2px; }\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9Vc2Vycy9jaGFkcmFjZWxpcy9Db2RpbmcvVHJpbml0eS9Ccm93c2VyL1Rvb2xjaGFpbnMvRWxhc3Rvcy5UcmluaXR5LlRvb2xDaGFpbnMvY2xpL2Fzc2V0cy9kYXBwdGVtcGxhdGUvYW5ndWxhci9kZW1vL3NyYy9hcHAvcGFnZXMvdGl0bGViYXIvdGl0bGViYXIucGFnZS5zY3NzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0VBQ0UsZ0JBQWdCO0VBQ2hCLG1FQUFtRTtFQUNuRSxrQkFBa0I7RUFDbEIsYUFBYTtFQUNiLHNCQUFzQjtFQUN0QiwyQkFBMkI7RUFDM0IsdUJBQXVCLEVBQUE7RUFQekI7SUFVSSxTQUFTO0lBQ1QsY0FBYztJQUNkLGFBQWE7SUFDYixhQUFhO0lBQ2Isc0JBQXNCO0lBQ3RCLHVCQUF1QjtJQUN2QixtQkFBbUI7SUFDbkIsbUJBQW1CO0lBQ25CLG1CQUFtQixFQUFBO0VBbEJ2QjtNQXFCTSxTQUFTO01BQ1Qsa0JBQWtCO01BQ2xCLFlBQVk7TUFDWixxQkFBcUI7TUFDckIsZUFBZTtNQUNmLGdCQUFnQixFQUFBO0VBMUJ0QjtNQThCTSxtQkFBbUI7TUFDbkIsVUFBVTtNQUNWLGtCQUFrQjtNQUNsQixZQUFZO01BQ1oscUJBQXFCO01BQ3JCLGVBQWU7TUFDZixnQkFBZ0IsRUFBQTtFQXBDdEI7SUF5Q0ksa0JBQWtCO0lBQ2xCLGVBQWU7SUFDZixnQkFBZ0IsRUFBQTtFQTNDcEI7SUErQ0ksV0FBVztJQUNYLGVBQWU7SUFDZixnQkFBZ0I7SUFDaEIsaUJBQWlCLEVBQUE7RUFsRHJCO0lBc0RJLG1CQUFtQixFQUFBO0VBdER2QjtJQTBESSxXQUFXO0lBQ1gsZUFBZTtJQUNmLGFBQWE7SUFDYiw4QkFBOEIsRUFBQTtFQTdEbEM7TUFnRU0sZ0VBQWlFO01BQ2pFLG1CQUFtQjtNQUNuQixrQkFBa0I7TUFDbEIsYUFBYTtNQUNiLGFBQWE7TUFDYixtQkFBbUIsRUFBQTtFQXJFekI7UUF3RVEsWUFBWTtRQUNaLGVBQWU7UUFDZixnQkFBZ0I7UUFDaEIsbUJBQW1CLEVBQUEiLCJmaWxlIjoic3JjL2FwcC9wYWdlcy90aXRsZWJhci90aXRsZWJhci5wYWdlLnNjc3MiLCJzb3VyY2VzQ29udGVudCI6WyIuY29udGFpbmVyIHtcbiAgbWluLWhlaWdodDogMTAwJTtcbiAgYmFja2dyb3VuZC1pbWFnZTogbGluZWFyLWdyYWRpZW50KHRvIHRvcCwgI2U2ZTlmMCAwJSwgI2VlZjFmNSAxMDAlKTtcbiAgcGFkZGluZzogMzBweCAxNXB4O1xuICBkaXNwbGF5OiBmbGV4O1xuICBmbGV4LWRpcmVjdGlvbjogY29sdW1uO1xuICBqdXN0aWZ5LWNvbnRlbnQ6IGZsZXgtc3RhcnQ7XG4gIGFsaWduLWl0ZW1zOiBmbGV4LXN0YXJ0O1xuXG4gIGlvbi1jYXJkIHtcbiAgICBtYXJnaW46IDA7XG4gICAgbWluLXdpZHRoOiA2NiU7XG4gICAgcGFkZGluZzogMjVweDtcbiAgICBkaXNwbGF5OiBmbGV4O1xuICAgIGZsZXgtZGlyZWN0aW9uOiBjb2x1bW47XG4gICAganVzdGlmeS1jb250ZW50OiBjZW50ZXI7XG4gICAgYWxpZ24taXRlbXM6IGNlbnRlcjtcbiAgICBib3JkZXItcmFkaXVzOiAxNXB4O1xuICAgIGJhY2tncm91bmQ6ICMxODFkMjA7XG5cbiAgICBpb24tY2FyZC10aXRsZSB7XG4gICAgICBtYXJnaW46IDA7XG4gICAgICB0ZXh0LWFsaWduOiBjZW50ZXI7XG4gICAgICBjb2xvcjogd2hpdGU7XG4gICAgICBsZXR0ZXItc3BhY2luZzogMC4zcHg7XG4gICAgICBmb250LXNpemU6IDI2cHg7XG4gICAgICBmb250LXdlaWdodDogODAwO1xuICAgIH1cblxuICAgIGlvbi1jYXJkLWNvbnRlbnQge1xuICAgICAgbWFyZ2luOiAxNXB4IDE1cHggMDtcbiAgICAgIHBhZGRpbmc6IDA7XG4gICAgICB0ZXh0LWFsaWduOiBjZW50ZXI7XG4gICAgICBjb2xvcjogd2hpdGU7XG4gICAgICBsZXR0ZXItc3BhY2luZzogMC4zcHg7XG4gICAgICBmb250LXNpemU6IDEzcHg7XG4gICAgICBmb250LXdlaWdodDogNTAwO1xuICAgIH1cbiAgfVxuXG4gIGgxIHtcbiAgICBtYXJnaW46IDMwcHggNXB4IDA7XG4gICAgZm9udC1zaXplOiAyMHB4O1xuICAgIGZvbnQtd2VpZ2h0OiA4MDA7XG4gIH1cblxuICBwIHtcbiAgICBtYXJnaW46IDVweDtcbiAgICBmb250LXNpemU6IDEzcHg7XG4gICAgZm9udC13ZWlnaHQ6IDYwMDtcbiAgICBsaW5lLWhlaWdodDogMS41MztcbiAgfVxuXG4gIGltZyB7XG4gICAgYm9yZGVyLXJhZGl1czogMTBweDtcbiAgfVxuXG4gIC50eXBlIHtcbiAgICB3aWR0aDogMTAwJTtcbiAgICBtYXJnaW4tdG9wOiA1cHg7XG4gICAgZGlzcGxheTogZmxleDtcbiAgICBqdXN0aWZ5LWNvbnRlbnQ6IHNwYWNlLWJldHdlZW47XG5cbiAgICBpb24tY29sIHtcbiAgICAgIGJhY2tncm91bmQ6IGxpbmVhci1ncmFkaWVudCh0byBib3R0b20sICMxODFkMjAgMCUsICAjMjEzMTNkIDEwMCUpO1xuICAgICAgYm9yZGVyLXJhZGl1czogMTVweDtcbiAgICAgIG1hcmdpbi1ib3R0b206IDVweDtcbiAgICAgIHBhZGRpbmc6IDE1cHg7XG4gICAgICBkaXNwbGF5OiBmbGV4O1xuICAgICAgYWxpZ24taXRlbXM6IGNlbnRlcjtcblxuICAgICAgaW9uLWxhYmVsIHtcbiAgICAgICAgY29sb3I6IHdoaXRlO1xuICAgICAgICBmb250LXNpemU6IDEycHg7XG4gICAgICAgIGZvbnQtd2VpZ2h0OiA1MDA7XG4gICAgICAgIGxldHRlci1zcGFjaW5nOiAycHg7XG4gICAgICB9XG4gICAgfVxuICB9XG59XG4iXX0= */");

/***/ }),

/***/ "./src/app/pages/titlebar/titlebar.page.ts":
/*!*************************************************!*\
  !*** ./src/app/pages/titlebar/titlebar.page.ts ***!
  \*************************************************/
/*! exports provided: TitlebarPage */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "TitlebarPage", function() { return TitlebarPage; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var src_app_services_titlebar_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! src/app/services/titlebar.service */ "./src/app/services/titlebar.service.ts");
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


var TitlebarPage = /** @class */ (function () {
    function TitlebarPage(titlebarService) {
        this.titlebarService = titlebarService;
    }
    TitlebarPage.prototype.ngOnInit = function () {
    };
    TitlebarPage.prototype.ionViewWillEnter = function () {
        titleBarManager.setTitle("Titlebar Demo");
        titleBarManager.setNavigationMode(2 /* BACK */);
    };
    TitlebarPage.ctorParameters = function () { return [
        { type: src_app_services_titlebar_service__WEBPACK_IMPORTED_MODULE_1__["TitlebarService"] }
    ]; };
    TitlebarPage = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-titlebar',
            template: __importDefault(__webpack_require__(/*! raw-loader!./titlebar.page.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/titlebar/titlebar.page.html")).default,
            styles: [__importDefault(__webpack_require__(/*! ./titlebar.page.scss */ "./src/app/pages/titlebar/titlebar.page.scss")).default]
        }),
        __metadata("design:paramtypes", [src_app_services_titlebar_service__WEBPACK_IMPORTED_MODULE_1__["TitlebarService"]])
    ], TitlebarPage);
    return TitlebarPage;
}());



/***/ })

}]);
//# sourceMappingURL=pages-titlebar-titlebar-module.js.map