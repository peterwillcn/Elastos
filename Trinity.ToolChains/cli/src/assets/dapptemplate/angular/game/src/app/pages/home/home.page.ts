import { Component } from '@angular/core';
import { GameService } from 'src/app/services/game.service';

declare let appManager: AppManagerPlugin.AppManager;

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor(
    public gameService: GameService
  ) {}

  ionViewDidEnter() {
    appManager.setVisible("show", ()=>{}, (err)=>{});
  }

}
