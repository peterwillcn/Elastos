import { Component, OnInit } from '@angular/core';
import { GameService } from '../services/game.service';

@Component({
  selector: 'app-scoreboard',
  templateUrl: './scoreboard.component.html',
  styleUrls: ['./scoreboard.component.scss'],
})
export class ScoreboardComponent implements OnInit {

  constructor(public gameService: GameService) { }

  ngOnInit() {}

  getDate(timestamp: number) {
    return new Date(timestamp * 1000).toLocaleString();
  }
}
