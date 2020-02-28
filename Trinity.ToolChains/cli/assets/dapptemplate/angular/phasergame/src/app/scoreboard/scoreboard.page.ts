import { Component, OnInit } from '@angular/core';
import * as moment from 'moment';

import { GameService } from '../services/game.service';
import { Scoreboard } from '../models/scoreboard.model';

@Component({
  selector: 'app-scoreboard',
  templateUrl: './scoreboard.page.html',
  styleUrls: ['./scoreboard.page.scss'],
})
export class ScoreboardPage implements OnInit {

  constructor(public gameService: GameService) { }

  ngOnInit() {}

  // Sort scores by most ELA collected
  fixScores(): Scoreboard[] {
    return [...this.gameService.scores].sort((a, b) => {
      return b.ela - a.ela;
    });
  }

  fixTime(time) {
    return moment(time).format("MMM Do YY");
  }
}
