import { Component } from '@angular/core';
import 'phaser';

import { GameScene } from './game.scene';
import { GameService } from '../services/game.service';

declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-game',
  templateUrl: 'game.page.html',
  styleUrls: ['game.page.scss'],
})
export class GamePage {

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

  ionViewWillEnter() {
    titleBarManager.setTitle('Phaser Game Demo');
    titleBarManager.setBackgroundColor("#222428");
  }

  ionViewDidEnter() {
    this.game = new Phaser.Game(this.config);
    appManager.setVisible('show', () => {}, (err) => {});
  }

  ionViewDidLeave() {
    this.game.destroy(true);
  }

  resetGame() {
    this.game.destroy(true);
    this.game = new Phaser.Game(this.config);
  }
}
