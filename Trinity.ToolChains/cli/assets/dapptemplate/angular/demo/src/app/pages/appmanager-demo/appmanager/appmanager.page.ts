import { Component, OnInit } from '@angular/core';
import { NavParams } from '@ionic/angular';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-appmanager',
  templateUrl: './appmanager.page.html',
  styleUrls: ['./appmanager.page.scss'],
})
export class AppmanagerPage implements OnInit {

  public manager;

  constructor(
    private navParams: NavParams
  ) { }

  ngOnInit() {
    this.manager = this.navParams.get('manager');
    console.log('App Manager Example', this.manager);
  }

  ionViewWillEnter() {
    titleBarManager.setTitle(this.manager.type);
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

  ionViewWillLeave() {
    titleBarManager.setTitle("Demo Template");
  }
}
