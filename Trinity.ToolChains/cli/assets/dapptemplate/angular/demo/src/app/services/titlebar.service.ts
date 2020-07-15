import { Injectable } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { TitlebarDemoPage } from '../pages/titlebar/titlebar-demo/titlebar-demo.page';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Injectable({
  providedIn: 'root'
})
export class TitlebarService {

  public managers = [
    {
      type: 'Title',
      title: 'Customize Title',
      method: 'setTitle',
      message: 'The title of your app can be changed whenever and wherever. This can be useful to display the title of your page, the occuring action or anything you desire.',
      message2: null,
      example: 'assets/titlebar/title.png'
    },
    {
      type: 'Color',
      title: 'Customize Color',
      method: 'setBackgroundColor/setForegroundMode',
      message: 'At any time, you can customize the background and title color of your titlebar to match the theme of your app.',
      message2: null,
      example: 'assets/titlebar/color.png'
    },
    {
      type: 'Navigation',
      title: 'Customize Navigation',
      method: 'setNavigationMode',
      message: 'You have three simple options to navigate through your app: return to the browser, return to the previous page or just close the app. Declaring any of these options will add a back or close key to the left corner of your titlebar.',
      message2: 'It\'s pretty straight forward on how they work. If you declare your navigation as HOME in your app page, the back key will return you to the browser and minimize the app. Declaring BACK will navigate to the previous page and declaring CLOSE will terminate the app.',
      example: 'assets/titlebar/navigation.png'
    },
    {
      type: 'Items',
      title: 'Customize Items',
      method: 'setupMenuItems',
      message: 'One of the best ways to customize your titlebar is to add menu items in it. Declaring this will add an options key to the right corner of your titlebar that displays a list of menu items you provided.',
      message2: 'This will give you the ability to add a list of actions with a custom icon in your title bar which can trigger a callback you have set for it.',
      example: 'assets/titlebar/items.png'
    }
  ];

  async openManager(manager: any) {
    const modal = await this.modalCtrl.create({
      component: TitlebarDemoPage,
      componentProps: {
        manager: manager
      },
    });

    modal.present();
  }

  constructor(private modalCtrl: ModalController) { }


  /******************** Set Title ********************/
  setTitle() {
    // Set title
    titleBarManager.setTitle("Titlebar Title");
  }

  /******************** Set Color ********************/
  setColor() {
    // Set background color
    titleBarManager.setBackgroundColor("#181d20");
    // Set title color
    titleBarManager.setForegroundMode(TitleBarPlugin.TitleBarForegroundMode.LIGHT);
  }

  /******************** Set Navigation ********************/
  setBackNavigation() {
    // Set as app's home page and page's navigation back to browser
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.HOME);
    // Set page's navigation to previous page
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
    // Set page's navigation to close app
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.CLOSE);
  }

  /******************** Set Menu Items ********************/
  setMenuItems() {
    titleBarManager.setupMenuItems(
      [
        {
          key: "", // Add uniqute item key
          iconPath: "", // Add path to item icon
          title: "" // Add item title
        }
      ],
      this.itemFunction // Add item callback
    );
  }

  itemFunction() {
    // Handle menu item
  }
}
