import { Component, OnInit } from '@angular/core';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-titlebar-demo',
  templateUrl: './titlebar-demo.page.html',
  styleUrls: ['./titlebar-demo.page.scss'],
})
export class TitlebarDemoPage implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  ionViewWillEnter() {
    titleBarManager.setTitle("Titlebar Demo");
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

}


