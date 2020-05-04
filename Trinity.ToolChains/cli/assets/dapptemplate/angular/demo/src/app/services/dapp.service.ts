import { Injectable, NgZone, Directive } from '@angular/core';
import { Platform, PopoverController, ModalController } from '@ionic/angular';
import { NavController } from '@ionic/angular';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Storage } from '@ionic/storage';

import { Router } from '@angular/router';
import { HelpComponent } from '../components/help/help.component';

declare let appManager: AppManagerPlugin.AppManager;
declare let didManager: DIDPlugin.DIDManager;

@Injectable({
    providedIn: 'root'
})
export class DAppService {

    constructor(
        private platform: Platform,
        private navController: NavController,
        private popoverController: PopoverController,
        public zone: NgZone,
        private storage: Storage,
        private router: Router,
        private http: HttpClient,
        private modalCtrl: ModalController
    ) {
    }

    public init(): Promise<any> {
        return new Promise(async (resolve, reject) => {
            appManager.setListener(msg => {
                this.onMessageReceived(msg);
            });

            resolve();
        });
    }

    private onMessageReceived(msg: AppManagerPlugin.ReceivedMessage) {
        if (msg.message == "navback") {
          this.modalCtrl.dismiss();
          this.router.navigate(['/home']);
        }
    }

    public async showHelp(ev: any, helpMessage: string) {
      const popover = await this.popoverController.create({
        mode: 'ios',
        component: HelpComponent,
        cssClass: 'helpComponent',
        event: ev,
        componentProps: {
          message: helpMessage
        },
        translucent: false
      });
      return await popover.present();
    }
}
