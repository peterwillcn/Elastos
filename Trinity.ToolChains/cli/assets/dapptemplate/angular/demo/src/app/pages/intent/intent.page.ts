import { Component, OnInit } from '@angular/core';
import { IntentService } from 'src/app/services/intent.service';

declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-intent',
  templateUrl: './intent.page.html',
  styleUrls: ['./intent.page.scss'],
})
export class IntentPage implements OnInit {

  constructor(
    public intentService: IntentService
  ) { }

  ngOnInit() {
    titleBarManager.setTitle("Intent Guide");
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }
}
