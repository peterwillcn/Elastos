import { Injectable } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { AppmanagerDemoPage } from '../pages/appmanager/appmanager-demo/appmanager-demo.page';
import { Router } from '@angular/router';

declare let appManager: AppManagerPlugin.AppManager;

enum MessageType {
  INTERNAL = 1,
  IN_RETURN = 2,
  IN_REFRESH = 3,

  EXTERNAL = 11,
  EX_LAUNCHER = 12,
  EX_INSTALL = 13,
  EX_RETURN = 14,
}


@Injectable({
  providedIn: 'root'
})
export class AppmanagerService {

  public managers = [
    {
      type: 'Exit',
      title: 'Exit App',
      method: 'close/launcher',
      message: 'There are two ways of exiting your app. You can either minimize the app and keep it running or terminate it and reset its state. Both methods will exit the app and return to the browser.',
      message2: 'Since the Titlebar Manager can handle this with navigation, it\'s up to you if you need to use this method or not.',
      example: 'assets/appmanager/exit.png'
    },
    {
      type: 'Visibility',
      title: 'Set Visibility',
      method: 'setVisible',
      message: 'As the app starts, initial screens are required to set the visibility, otherwise the app will remain invisible. This is useful to get your app ready before presenting the app to the user.',
      message2: "Just simply add 'show' to your method in any initial page after all necessary rendering is completed.",
      example: 'assets/appmanager/visible.png'
    },
    {
      type: 'Intent',
    },
    {
      type: 'Listener',
      title: 'Set Listener',
      method: 'setListener/setIntentListener',
      message: 'Setting a listener is essential when it comes to handling incoming intents (setIntentListener) or listening to certain actions (setListener).',
      message2: 'This is done by using the methods in the example above, then handling the received intents or actions below.',
      message3: "Using the method, setIntentListener is necessary if your app is handling intents. On the other hand, using setListener is only relevant for actions such as handling display or language changes or modifying the Titlebar navigation. You may choose to handle these changes or ignore it.",
      example: 'assets/appmanager/listener.png',
      example2: 'assets/appmanager/listener2.png',
    },
    {
      type: 'Preference',
      title: 'Get Preference',
      method: 'getPreference/getLocale',
      message: 'Preferences such as display mode and language in elastOS are handled in the Settings app. If these preferences are important to your app, you can fetch them by using the following methods.',
      message2: "It's important to note that if you choose to handle any of these preferences, make sure to handle them during the app's load process.",
      example: 'assets/appmanager/preference.png',
    }
  ];

  async openManager(manager: any) {
    if(manager.type === 'Intent') {
      this.router.navigate(['intent']);
    } else {
      const modal = await this.modalCtrl.create({
        component: AppmanagerDemoPage,
        componentProps: {
          manager: manager
        },
      });

      modal.present();
    }
  }

  constructor(private modalCtrl: ModalController, private router: Router) { }

  /******************* Message and Intent Listerner *******************/
  init() {
    // Receive Messages
    appManager.setListener((ret) => {
      this.onMessageReceived(ret);
    });

    // Receive Intents
    appManager.setIntentListener((ret) => {
      this.onIntentReceived(ret);
    });
  }

  onIntentReceived(ret: AppManagerPlugin.ReceivedIntent) {
    console.log('Received external intent', ret);
    switch (ret.action) {
      case 'app':
        console.log('App intent', ret);
        // Handle intent
      break;
    }
  }

  onMessageReceived(ret: AppManagerPlugin.ReceivedMessage) {
    let params: any = ret.message;
    if (typeof (params) === 'string') {
      try {
        params = JSON.parse(params);
      } catch (e) {
        console.log('Params are not JSON format: ', params);
      }
    }
    console.log(params);
    switch (ret.type) {
      case MessageType.INTERNAL:
        switch (ret.message) {
          case 'navback':
            // Handle titlebar navigation back action
            break;
        }
        break;

      case MessageType.IN_REFRESH:
        switch (params.action) {
          case 'currentLocaleChanged':
            // Handle language change
            break;
          case 'preferenceChanged':
            // Handle preference change from settings such as display mode
            break;
        }
        break;
      }
  }

  /******************* Get Preference *******************/
  getPreference() {
    // Get preference for display mode
    appManager.getPreference("ui.darkmode", (value) => {
      console.log("Display mode preference", value)
    });

    // Get preference for language
    appManager.getLocale(
      (defaultLang, currentLang, systemLang) => {
        console.log("Language preference", currentLang);
    });
  }

  /******************* Exit App *******************/
  leaveApp() {
    // Terminate app
    appManager.close();

    // Minimize app
    appManager.launcher();
  }
}
