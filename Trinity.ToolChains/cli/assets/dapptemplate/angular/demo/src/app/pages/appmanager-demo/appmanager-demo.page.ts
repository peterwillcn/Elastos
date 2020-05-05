import { Component, OnInit } from '@angular/core';
import { AppmanagerService } from 'src/app/services/appmanager.service';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-appmanager-demo',
  templateUrl: './appmanager-demo.page.html',
  styleUrls: ['./appmanager-demo.page.scss'],
})
export class AppmanagerDemoPage implements OnInit {

  constructor(
    public appManagerService: AppmanagerService
  ) { }

  ngOnInit() {
    titleBarManager.setTitle("App Manager Demo");
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

  ionViewWillEnter() {
    titleBarManager.setTitle("App Manager Demo");
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }
}
