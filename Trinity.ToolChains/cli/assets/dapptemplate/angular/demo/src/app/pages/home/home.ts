import { Component } from '@angular/core';
import { NavController, ModalController } from '@ionic/angular';
import { DAppService } from 'src/app/services/dapp.service';
import { IntentPage } from '../intent/intent.page';
import { IntentService } from 'src/app/services/intent.service';
import { AppmanagerService } from 'src/app/services/appmanager.service';
import { TitlebarService } from 'src/app/services/titlebar.service';

declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'page-home',
  templateUrl: 'home.html',
  styleUrls: ['home.scss']
})

export class HomePage {

  constructor(
    public navCtrl: NavController,
    private modalCtrl: ModalController,
    public dappService: DAppService,
    public intentService: IntentService,
    public appManagerService: AppmanagerService,
    public titlebarService: TitlebarService
  ) {
  }

  ionViewWillEnter() {
    // When the main screen is ready to be displayed, ask the app manager to make the app visible,
    // in case it was started hidden while loading.
    if (typeof appManager !== 'undefined') {
      appManager.setVisible("show");
    }

    // Update system status bar every time we re-enter this screen.
    if (typeof titleBarManager !== 'undefined') {
      titleBarManager.setTitle("Demo Template");
      titleBarManager.setBackgroundColor("#181d20");
      titleBarManager.setForegroundMode(TitleBarPlugin.TitleBarForegroundMode.LIGHT);
      titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.HOME);
    }
  }
}
