import { Component } from '@angular/core';
import { GameScene } from '../game-scene/game.scene';
import { GameService } from 'src/app/services/game.service';
import 'phaser';

declare let appManager: AppManagerPlugin.AppManager;

@Component({
  selector: 'app-home',
  templateUrl: './home.page.html',
  styleUrls: ['./home.page.scss'],
})
export class HomePage {

  private config: Phaser.Types.Core.GameConfig = {
    width: 800,
    height: 800,
    type: Phaser.AUTO,
    parent: 'game-container',
    physics: {
      default: 'arcade',
      arcade: {
        gravity: { y: 300 }, // gravity force
        debug: false // debug shows outline of collision box
      }
    },
    scene: [GameScene]
  };

  private game: Phaser.Game;

  constructor(public gameService: GameService) { }

  ionViewDidEnter() {
    this.game = new Phaser.Game(this.config);
    appManager.setVisible("show", ()=>{}, (err)=>{});
  }

  ionViewDidLeave() {
    this.game.destroy(true);
  }

}
