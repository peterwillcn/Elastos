import { Injectable } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { IntentDemoPage } from '../pages/intent/intent-demo/intent-demo.page';

declare let appManager: AppManagerPlugin.AppManager;

@Injectable({
  providedIn: 'root'
})
export class IntentService {

  public intents = [
    {
      type: 'Scan',
      title: 'Scan QR Code',
      intent: 'scanqrcode',
      example: 'assets/intents/scan.png',
      message: 'Using this intent will open the Scanner app. This is useful for scanning QR Codes such as DIDs, Carrier & Wallet addresses',
      message2: 'Once a proper QR code is scanned, the intent will return its data in which you can handle accordingly.',
      message3: null,
    },
    {
      type: 'Pay',
      title: 'Send ELA',
      intent: 'pay',
      example: 'assets/intents/pay.png',
      message: 'There are many intents that can be sent to the wallet such as fetching balances and declaring votes but the most common use case is sending payments.',
      message2: "With the pay intent, you must assign a receiver and an amount in the intent\'s parameters which will be sent to the wallet for confirmation.",
      message3: 'In this intent, we will ask the wallet to send an ELA address 0.1 ELA.',
    },
    {
      type: 'Register',
      title: 'Register App',
      intent: 'registerapplicationprofile',
      example: 'assets/intents/register.png',
      message: 'As an elastOS user, it would be nice to show off your followers what amazing apps you are using. This intent is meant for this case; to register the current app you are using to your DID profile which will reveal in your Contact\'s profile.',
      message2: "As shown in the example above, an 'identifier' and 'connectactiontitle' parameter is required to present how you want to reveal this app to your followers. Once these are filled, this intent will open the Identity app to register this app under the signed DID profile.",
      message3: null,
    },
    {
      type: 'Invite',
      title: 'Invite Contacts',
      intent: 'pickfriend',
      example: 'assets/intents/pickfriend.png',
      message: 'When it comes to social media and other apps alike, the ability to invite friends is integral. This intent allows you to invite your contacts for chat groups, gaming, etc.',
      message2: "To use this intent to your advantage, you may declare this intent as a single or multiple invitation (singleSelection) with the option to filter contacts (filter) in your criteria. For example, the filter parameter above uses a key type 'credentialType' with the value of 'ApplicationProfileCredential' which will tell the Contact's app to only invite contacts that have the current app registered. If parameters are not given, the default intent sent will be a single invite without filter.",
      message3: 'In this intent, we won\'t provide any parameters.',
    },
    {
      type: 'Sign In',
      title: 'Sign In',
      intent: 'credaccess',
      example: 'assets/intents/credaccess.png',
      message: 'Nowadays, almost every app out theres requires a user log-in in order to access the app. Unlike those apps, this intent gives both the app and user the benefit to access the user\'s DID data without having to create an account or have the user\'s privacy invaded.',
      message2: 'Once this intent is submitted, it will invoke the Identity app for permission of accessing the signed-in DID\'s data and return it in response.',
      message3: null,
    },
    {
      type: 'Browse',
      title: 'Browse Application',
      intent: 'app',
      example: 'assets/intents/app.png',
      message: 'This intent is used to prompt another app that\'s given for the user to browse.',
      message2: 'It simply works by providing the intent an existing app id, which is handled by the browser to find and open once ready.',
      message3: 'In this intent, we will check out the ELA Explorer.',
    }
  ]

  constructor(
    private modalCtrl: ModalController
  ) { }

  async openIntent(intent: any) {
    const modal = await this.modalCtrl.create({
      component: IntentDemoPage,
      componentProps: {
        intent: intent
      },
    });

    modal.present();
  }

  /******************* SEND INTENT EXAMPLES *******************/

  /** 'registerapplicationprofile' intent **/
  register() {
    appManager.sendIntent("registerapplicationprofile", {
      identifier: "App title Here...",
      connectactiontitle: "App Description Here..."
    }, {});
  }

  /** 'scanqrcode' intent **/
  scan() {
    appManager.sendIntent("scanqrcode",
    {}, {}, (res) => {
      console.log("Got scan result", res);
    }, (err: any) => {
      console.error(err);
    })
  }

  /** 'app' intent **/
  browse(id: string) {
    appManager.sendIntent(
      "app",
      { id: id },
      {}
    );
  }

  /** 'pickfriend' intent **/
  invite() {
    appManager.sendIntent(
      "pickfriend",
      {}, {},
      (res) => {
        // Handle response here...
        console.log(res);
      },
      (err) => { console.log(err); }
    );
  }

  /** 'pay' intent **/
  pay() {
    appManager.sendIntent(
      "pay",
      {
        receiver: 'ESe59nqkGkUVxX4jxNRM9tUQjXVQgyju99',
        amount: '0.1',
        memo: null,
      },
     {},
      (res) => { console.log(res); },
      (err) => { console.log(err); }
    );
  }

  /** 'credaccess' intent **/
  signIn() {
    appManager.sendIntent("credaccess", {
      claims: {
        name: true, // Mandatory to receive
        email: {
          required: false, // User can choose to tell us his email address or not
          reason: "Add reason for email..."
        }
      }
    }, {}, (res: any) => {
      console.log("User data received", res);
    });
  }

  /** 'sign' intent **/
  signData() {
    appManager.sendIntent("sign", {
      data: 'Add data to sign...'
    }, {}, (res) => {
      console.log("Got intent response:", res);
      // Handle response
    }, (err)=>{
      console.error(err);
    });
  }
}
