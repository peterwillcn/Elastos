import { Component, OnInit } from '@angular/core';
import { TitlebarService } from 'src/app/services/titlebar.service';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-titlebar-demo',
  templateUrl: './titlebar-demo.page.html',
  styleUrls: ['./titlebar-demo.page.scss'],
})
export class TitlebarDemoPage implements OnInit {

  constructor(
    public titlebarService: TitlebarService
  ) { }

  ngOnInit() {
  }

  ionViewWillEnter() {
    titleBarManager.setTitle("Titlebar Demo");
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

}


