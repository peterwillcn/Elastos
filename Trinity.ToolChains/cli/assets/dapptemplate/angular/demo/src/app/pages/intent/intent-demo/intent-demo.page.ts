import { Component, OnInit } from '@angular/core';
import { NavParams } from '@ionic/angular';
import { DAppService } from 'src/app/services/dapp.service';
import { IntentService } from 'src/app/services/intent.service';
import { THIS_EXPR } from '@angular/compiler/src/output/output_ast';

declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-intent',
  templateUrl: './intent-demo.page.html',
  styleUrls: ['./intent-demo.page.scss'],
})
export class IntentDemoPage implements OnInit {

  public intent;

  constructor(
    private navParams: NavParams,
    public dappService: DAppService,
    public intentService: IntentService
  ) { }

  ngOnInit() {
    this.intent = this.navParams.get('intent');
    console.log('Intent Example', this.intent);
  }

  ionViewWillEnter() {
    titleBarManager.setTitle('Intent Demo');
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

  ionViewWillLeave() {
    titleBarManager.setTitle("Demo Template");
    titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.BACK);
  }

  testIntent() {
    console.log('Test intent', this.intent.intent);
    if(this.intent.intent === 'scanqrcode') {
      this.intentService.scan();
    }
    if(this.intent.intent === 'pay') {
      this.intentService.pay();
    }
    if(this.intent.intent === 'registerapplicationprofile') {
      this.intentService.register();
    }
    if(this.intent.intent === 'pickfriend') {
      this.intentService.invite();
    }
    if(this.intent.intent === 'credaccess') {
      this.intentService.signIn();
    }
    if(this.intent.intent === 'app') {
      this.intentService.browse('org.elastos.trinity.dapp.blockchain');
    }
  }

}
