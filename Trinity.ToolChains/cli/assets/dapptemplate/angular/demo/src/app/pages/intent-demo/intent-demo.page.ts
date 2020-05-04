import { Component, OnInit } from '@angular/core';
import { IntentService } from 'src/app/services/intent.service';

declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-intent-demo',
  templateUrl: './intent-demo.page.html',
  styleUrls: ['./intent-demo.page.scss'],
})
export class IntentDemoPage implements OnInit {

  constructor(
    public intentService: IntentService
  ) { }

  ngOnInit() {
    titleBarManager.setTitle("Intent Demo");
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }
}
