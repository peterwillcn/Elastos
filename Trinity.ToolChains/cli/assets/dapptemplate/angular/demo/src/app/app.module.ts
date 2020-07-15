import { NgModule, ErrorHandler } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { IonicStorageModule } from '@ionic/storage';
import { RouteReuseStrategy } from '@angular/router';
import { IonicModule, IonicRouteStrategy, Platform } from '@ionic/angular';
import { AppRoutingModule } from './app-routing.module';
import { FormsModule } from '@angular/forms';
import { StatusBar } from '@ionic-native/status-bar/ngx';
import { SplashScreen } from '@ionic-native/splash-screen/ngx';
import { HttpClientModule } from '@angular/common/http';

import { MyApp } from './app.component';

// Initial Page
import { HomePage } from './pages/home/home';

// Guide Pages
import { AppmanagerPage } from './pages/appmanager/appmanager.page';
import { TitlebarPage } from './pages/titlebar/titlebar.page';
import { IntentPage } from './pages/intent/intent.page';
import { CorePage } from './pages/core/core.page';

// Demo Pages
import { IntentDemoPage } from './pages/intent/intent-demo/intent-demo.page';
import { TitlebarDemoPage } from './pages/titlebar/titlebar-demo/titlebar-demo.page';
import { AppmanagerDemoPage } from './pages/appmanager/appmanager-demo/appmanager-demo.page';

// Sample Component
import { HelpComponent } from './components/help/help.component';



@NgModule({
  declarations: [
    MyApp,
    HomePage,

    // Guide Pages
    AppmanagerPage,
    TitlebarPage,
    IntentPage,
    CorePage,

    // Demo Pages
    AppmanagerDemoPage,
    TitlebarDemoPage,
    IntentDemoPage,
    HelpComponent,
  ],
  imports: [
    CommonModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    IonicStorageModule.forRoot(),
    IonicModule.forRoot()
  ],
  bootstrap: [MyApp],
  entryComponents: [
    MyApp,

    // Demo Pages
    AppmanagerDemoPage,
    TitlebarDemoPage,
    IntentDemoPage,
    HelpComponent,
  ],
  providers: [
    StatusBar,
    SplashScreen,
    Platform,
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    {provide: ErrorHandler, useClass: ErrorHandler}
  ]
})
export class AppModule {}
