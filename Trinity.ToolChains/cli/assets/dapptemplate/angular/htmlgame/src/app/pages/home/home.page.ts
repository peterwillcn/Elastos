import { Component } from '@angular/core';
import { GameService } from 'src/app/services/game.service';

declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor(
    public gameService: GameService
  ) {}

  ionViewWillEnter() {
    titleBarManager.setTitle('HTML Game Demo');
    titleBarManager.setBackgroundColor("#222428");
  }

  ionViewDidEnter() {
    appManager.setVisible("show", ()=>{}, (err)=>{});
  }

}
