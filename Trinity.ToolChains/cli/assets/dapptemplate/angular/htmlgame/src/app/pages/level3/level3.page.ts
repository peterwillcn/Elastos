import { Component, OnInit } from '@angular/core';
import { GameService } from 'src/app/services/game.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-level3',
  templateUrl: './level3.page.html',
  styleUrls: ['./level3.page.scss'],
})
export class Level3Page implements OnInit {

  public gameState;  // Keep track of current game state
  public startGame;  // Will set to false to display intro
  public countDown;  // Lets show 3 second countDown
  public totalTime;  // How long the player has to win
  public countTime;  // Elapsed time while game is playing
  public shownTime;  // Time shown as string format
  public interTime;  // Timer: 1 second for in game tracking
  public interCount; // Timer: 1 second for in game counter

  public cardsTotal = 16;	// Total cards to match (divided by 2)
  public cardsArray = [];	// Store all card pairs
  public userLife = 6;		// Total amount of tries user gets
  public imageDir = '../../assets/img/coins/';

  public selectCard1pos = -1;	// Selected card #1 position
  public selectCard1val = -1;	// Selected card #1 value
  public selectCard2pos = -1;	// Selected card #2 position
  public selectCard2val = -1;	// Selected card #2 value
  public selectOldPosix = -1; // Store old position

  public debugText = "Debug text goes here! :)"

  constructor(
    public gameService: GameService,
    private router: Router,
  ) { }

  ngOnInit() {
  	this.restartGame();
  }

  // Function to populate cards array with
  // position and value pairs from 0 to 6
  populateCards() {
  	this.cardsArray = [];
  	var x = 0;
  	var y = 0;
  	for (var i = 0; i < this.cardsTotal; i++) {
  		// Push card to array and assign value
  		this.cardsArray.push({pos:i, val:y});
  		// Flip x to assign next card same value
  		if (x === 0) x = 1;
  		else { x = 0; y++ }
  	}
  }

  // Function to select a card
  selectCard(pos, val, i) {
    var actOne = false;

    // Code to select the second card
    if (this.selectCard1pos > -1 && this.selectCard2pos == -1) {
      this.selectCard2pos = pos;
      this.selectCard2val = val;
      actOne = true;
    }

  	// Code to select the first card
    if (this.selectCard1pos == -1 && !actOne) {
    	this.selectCard1pos = pos;
    	this.selectCard1val = val;
      this.selectOldPosix = i;
    }

    // If we have both cards selected, check for match or fail
    if (actOne && this.selectCard1pos > -1 && this.selectCard2pos > -1) {
      setTimeout(() => {
        // if the cards match, do this...
        if (this.selectCard1val === this.selectCard2val) {
          this.debugText = "Cards match!";
          this.cardsArray.splice(this.selectOldPosix, 1, {pos: this.selectOldPosix, val: -1});
          this.cardsArray.splice(i, 1, {pos: i, val: -1});
          this.resetSelects();
          this.winCon();
        }
        // Otherwise, take a life and reset
        else {
          this.debugText = "Cards don't match!";
          this.userLife -= 1;
          this.resetSelects();
          if (this.userLife <= 0) this.loseCon();
        }
      }, 1000);
    }
  }

    // Function to shuffle an array
    shuffle(a) {
	    var j, x, i;
	    for (i = a.length; i; i--) {
	        j = Math.floor(Math.random() * i);
	        x = a[i - 1];
	        a[i - 1] = a[j];
	        a[j] = x;
	    }
  }

  nextLevel() {
    this.restartGame();
    this.router.navigate(['level4'])
  }

  // Function to restart the game
  restartGame() {
    this.gameState = 'load';      // Keep track of current game state
    this.startGame = false;       // Will set to false to display intro
    this.countDown = 3;           // Lets show 3 second countDown
    this.totalTime = 60;          // How long the player has to win
    this.countTime = 0;           // Elapsed time while game is playing
    this.shownTime = 0;           // Time shown as string format
    this.interCount = null;       // Timer: 1 second for in game counter

    this.userLife = 6;
    this.resetSelects();
    this.populateCards();
    this.shuffle(this.cardsArray);
    this.shuffle(this.gameService.images);

    setTimeout(() => {
      this.startGame = true;    // Actually start the game
      this.gameState = 'init';  // Game has been initialized
    }, this.countDown*1000);

    // This will subtract 1 from countdown start time
    this.interCount = setInterval(() => {
      if (this.countDown === 0) {
        clearInterval(this.interCount);
        this.interCount = null;
      }
      else this.countDown -= 1;
    }, 1000);

    // This timer will keep track of time once the game starts
    setTimeout(() => {
      this.interTime = setInterval(() => {
        if (this.countTime >= this.totalTime) this.loseCon();
        if (this.gameState == 'init') {
          this.countTime += 1;  // Add 1 second to counter
          var minutes = Math.floor((this.totalTime-this.countTime) / 60);
          var seconds = (this.totalTime-this.countTime) - minutes * 60;
          this.shownTime = minutes.toString() + ":" + seconds.toString();
        }
        else {
          clearInterval(this.interTime);
          this.interTime = null;
        }
      }, 1000);
    }, this.countDown*1000+200);
  }

  // Win condition
  winCon() {
    var winCheck = false;
    // If at least 1 or more cards have not been solved,
    // then user hasn't won yet
    for (var i = 0; i < this.cardsArray.length; i++)
      if (this.cardsArray[i].val != -1) winCheck = true;
    // if winCheck is false, player has won the game
    if (winCheck == false) this.gameState = 'win';
  }

  // Lose condition
  loseCon() {
    this.gameState = 'lose';
  }

	// Function to reset selected cards
	resetSelects() {
		this.selectCard1pos = -1;	// Selected card #1 position
  		this.selectCard1val = -1;	// Selected card #1 value
  		this.selectCard2pos = -1;	// Selected card #2 position
  		this.selectCard2val = -1;	// Selected card #2 value
	}
}
