import { Component } from '@angular/core';
import 'phaser';

import { FirstGameScene } from './firstgame.scene';
import { GameService } from '../services/game.service';

declare let appManager: any;

@Component({
  selector: 'app-firstgame',
  templateUrl: 'firstgame.page.html',
  styleUrls: ['firstgame.page.scss'],
})
export class FirstGamePage {

  private config: Phaser.Types.Core.GameConfig = {
    width: 800,
    height: 800,
    type: Phaser.AUTO,
    parent: 'firstgame-container',
    physics: {
      default: 'arcade',
      arcade: {
        gravity: { y: 300 }, // gravity force
        debug: false // debug shows outline of collision box
      }
    },
    scene: [FirstGameScene]
  };

  private game: Phaser.Game;

  constructor(public gameService: GameService) { }

  ionViewDidEnter() {
    this.game = new Phaser.Game(this.config);
    appManager.setVisible("show", () => {}, (err) => {});
  }

  ionViewDidLeave() {
    this.game.destroy(true);
  }

}
