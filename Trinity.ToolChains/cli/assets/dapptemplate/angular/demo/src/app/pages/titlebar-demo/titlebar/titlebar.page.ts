import { Component, OnInit } from '@angular/core';
import { NavParams } from '@ionic/angular';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-titlebar',
  templateUrl: './titlebar.page.html',
  styleUrls: ['./titlebar.page.scss'],
})
export class TitlebarPage implements OnInit {

  public manager;

  constructor(
    private navParams: NavParams
  ) { }

  ngOnInit() {
    this.manager = this.navParams.get('manager');
    console.log('Titlebar Example', this.manager);
  }

  ionViewWillEnter() {
    titleBarManager.setTitle('Titlebar ' + this.manager.type);
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

  ionViewWillLeave() {
    titleBarManager.setTitle("Demo Template");
  }

}
