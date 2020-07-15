import { Injectable } from '@angular/core';
import { PopoverController, ModalController } from '@ionic/angular';
import { Router } from '@angular/router';
import { HelpComponent } from '../components/help/help.component';

declare let appManager: AppManagerPlugin.AppManager;

@Injectable({
    providedIn: 'root'
})
export class DAppService {

    constructor(
      private popoverController: PopoverController,
      private router: Router,
      private modalCtrl: ModalController
    ) {
    }

    // Use this for initial load, declared in app component
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

    // Example of using popup components
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
