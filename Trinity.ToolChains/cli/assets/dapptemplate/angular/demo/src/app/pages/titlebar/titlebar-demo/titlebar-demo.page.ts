import { Component, OnInit } from '@angular/core';
import { NavParams } from '@ionic/angular';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-titlebar-demo',
  templateUrl: './titlebar-demo.page.html',
  styleUrls: ['./titlebar-demo.page.scss'],
})
export class TitlebarDemoPage implements OnInit {

  public manager;

  constructor(
    private navParams: NavParams
  ) { }

  ngOnInit() {
    this.manager = this.navParams.get('manager');
    console.log('Titlebar Example', this.manager);
  }

  ionViewWillEnter() {
    titleBarManager.setTitle('Titlebar Demo');
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

  ionViewWillLeave() {
    titleBarManager.setTitle("Demo Template");
  }

}
