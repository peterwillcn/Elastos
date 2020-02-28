import { Injectable } from '@angular/core';
import { StorageService } from './storage.service';
import { Scoreboard } from '../models/scoreboard.model';

// declare let appManager: AppManagerPlugin.AppManager;
declare let appManager: any;

@Injectable({
  providedIn: 'root'
})
export class GameService {

  public gameOver = false;
  public scores: Scoreboard[] = [];

  constructor(
    public storage: StorageService,
  ) { }

  init() {
    // this.getStoredScores();
  }

  minimizeApp() {
    appManager.launcher();
  }

  closeApp() {
    appManager.close();
  }

  /* TO DO - Save scores and show scoreboard */
  getStoredScores = () => {
    this.storage.getScores().then(_scores => {
      console.log('Fetched stored scores', _scores);
      if (_scores) {
        this.scores = _scores;
      }
    });
  }
}
