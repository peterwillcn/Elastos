import { Injectable } from '@angular/core';
import { StorageService } from './storage.service';
import { Scoreboard } from '../models/scoreboard.model';
import { Router } from '@angular/router';

declare let appManager;

@Injectable({
  providedIn: 'root'
})
export class GameService {

  // Inject service to classes
  static instance: GameService;

  public scores: Scoreboard[] = [];

  constructor(
    private storage: StorageService,
    private router: Router,
  ) {
    GameService.instance = this;
  }

  init() {
    this.getStoredScores();
  }

  minimizeApp() {
    appManager.launcher();
  }

  closeApp() {
    appManager.close();
  }

  // Save scores and show scoreboard
  getStoredScores = () => {
    this.storage.getScores().then(_scores => {
      console.log('Fetched stored scores', _scores);
      if (_scores) {
        this.scores = _scores;
      }
    });
  }

  showScoreboard = (score) => {
    this.scores = this.scores.concat(
      [{
        time: new Date(),
        ela: score
      }]
    );
    // Save scores
    this.storage.setScores(this.scores);
    this.router.navigate(['/scoreboard']);
  }
}
