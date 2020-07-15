import { Injectable } from '@angular/core';
import { GameService } from '../services/game.service';

@Injectable()
export class GameScene extends Phaser.Scene {

    private gameOver = false;
    private score = 0;

    // Assets
    private platforms: Phaser.Physics.Arcade.StaticGroup;
    private player: Phaser.Physics.Arcade.Sprite;
    private cursors: Phaser.Types.Input.Keyboard.CursorKeys;
    private coins: Phaser.Physics.Arcade.Group;
    private bombs: Phaser.Physics.Arcade.Group;
    private scoreText: Phaser.GameObjects.Text;

    // Controls
    private jumpBtn;
    private leftBtn;
    private rightBtn;

    private leftPressed = false;
    private rightPressed = false;

    constructor() {
        super('GameScene');
        console.log('GameScene.constructor()');
    }

    /***************** Preload Game *****************/
    preload() {
        console.log('Preload Game');

        // Load assets
        this.load.image('background', 'assets/phaser/background.jpg');
        this.load.image('ground', 'assets/phaser/platform.png');
        this.load.image('ela', 'assets/phaser/ela.png');
        this.load.image('bomb', 'assets/phaser/bomb.png');
        this.load.image('jump', 'assets/phaser/jump.png');
        this.load.image('left', 'assets/phaser/left.png');
        this.load.image('right', 'assets/phaser/right.png');
        this.load.spritesheet('dude', 'assets/phaser/dude.png', { frameWidth: 32, frameHeight: 48 });
    }

    /***************** Create Game *****************/
    create() {
        console.log('Create Game');
        //  Background for our game
        this.add.image(400, 300, 'background');

        //  The platforms group contains the ground and the 2 ledges we can jump on
        this.platforms = this.physics.add.staticGroup();

        //  Create the ground.
        //  Scale it to fit the width of the game (the original sprite is 400x32 in size)
        this.platforms.create(100, 698, 'ground').setScale(2).refreshBody();

        //  Create some ledges
        this.platforms.create(-50, 550, 'ground'); // 1st ledge
        this.platforms.create(500, 375, 'ground'); // 2nd ledge
        this.platforms.create(-100, 275, 'ground'); // 3rd ledge
        this.platforms.create(475, 125, 'ground'); // 4th ledge

        // The player and its settings
        this.player = this.physics.add.sprite(100, 450, 'dude');

        //  Player physics properties. Give the little guy a slight bounce.
        this.player.setBounce(0.2);
        this.player.setCollideWorldBounds(true);

        //  Our player animations, turning, walking left and walking right.
        this.anims.create({
            key: 'left',
            frames: this.anims.generateFrameNumbers('dude', { start: 0, end: 3 }),
            frameRate: 10,
            repeat: -1
        });

        this.anims.create({
            key: 'turn',
            frames: [{ key: 'dude', frame: 4 }],
            frameRate: 20
        });

        this.anims.create({
            key: 'right',
            frames: this.anims.generateFrameNumbers('dude', { start: 5, end: 8 }),
            frameRate: 10,
            repeat: -1
        });

        //  Add input events for keyboard
        this.cursors = this.input.keyboard.createCursorKeys();

        // Add input events for touchscreen
        this.input.addPointer(3);
        this.jumpBtn = this.add.image(200, 698, 'jump').setInteractive();
        this.leftBtn = this.add.image(100, 698, 'left').setInteractive();
        this.rightBtn = this.add.image(300, 698, 'right').setInteractive();
        this.leftBtn.on('pointerdown', () => {
            this.leftPressed = true;
            this.rightPressed = false;
        });
        this.rightBtn.on('pointerdown', () => {
            this.rightPressed = true;
            this.leftPressed = false;
        });
        this.leftBtn.on('pointerup', () => {
            this.leftPressed = false;
            this.rightPressed = false;
        });
        this.rightBtn.on('pointerup', () => {
            this.rightPressed = false;
            this.leftPressed = false;
        });
        this.jumpBtn.on('pointerdown', () => {
            this.goUp();
        });

        //  Create coins and settings
        this.coins = this.physics.add.group({
            key: 'ela',
            repeat: 15, // Amount of assets
            setXY: {
                x: 12, // Set asset start on x-axis
                y: 0, // Set asset start on y-axis
                stepX: 25 // Set space between assets
            }
        });

        this.coins.children.iterate((child: Phaser.Physics.Arcade.Sprite) => {
            //  Give each ela a slightly different bounce
            child.setBounceY(Phaser.Math.FloatBetween(0.4, 0.8));
        });

        this.bombs = this.physics.add.group();

        //  The score
        this.scoreText = this.add.text(16, 16, 'ELA Bag: 0', { fontSize: '32px', fontWeight: 'bold', fill: '#FAFAFA' });

        //  Collide the player and the coins with the platforms
        this.physics.add.collider(this.player, this.platforms);
        this.physics.add.collider(this.coins, this.platforms);
        this.physics.add.collider(this.bombs, this.platforms);

        // Checks to see if the player overlaps with any of the coins/bombs, if he does call a function as 3rd agument
        this.physics.add.overlap(this.player, this.coins, this.collectCoin, null, this);
        this.physics.add.collider(this.player, this.bombs, this.hitBomb, null, this);
    }

    /***************** Update Game *****************/
    update() {
        if (this.gameOver) {
            return;
        }
        if (this.cursors.left.isDown || this.leftPressed) {
            this.goLeft();
        }
        else if (this.cursors.right.isDown || this.rightPressed) {
            this.goRight();
        }
        else {
            this.player.setVelocityX(0);
            this.player.anims.play('turn');
        }
        if (this.cursors.up.isDown) {
            this.goUp();
        }
    }

    goLeft() {
        console.log("left");
        this.player.setVelocityX(-160);
        this.player.anims.play('left', true);
    }

    goRight() {
        console.log("right");
        this.player.setVelocityX(160);
        this.player.anims.play('right', true);
    }

    goUp() {
        console.log("up");
        if (this.player.body.touching.down) {
            this.player.setVelocityY(-330);
        }
    }

    collectCoin(player, coin) {
        coin.disableBody(true, true);
        //  Add and update the score
        this.score += 1;
        this.scoreText.setText('ELA Bag: ' + this.score);
        if (this.coins.countActive(true) === 0) {
            //  A new batch of coins to collect
            this.coins.children.iterate((child: Phaser.Physics.Arcade.Sprite) => {
                child.enableBody(true, child.x, 0, true, true);
            });
            const x = Phaser.Math.Between(0, 400);
            const bomb = this.bombs.create(x, -400, 'bomb');
            bomb.setBounce(1);
            bomb.setCollideWorldBounds(true);
            bomb.setVelocity(Phaser.Math.Between(-200, 200), 20);
            bomb.allowGravity = false;
        }
    }

    hitBomb(player, bomb) {
        this.physics.pause();
        player.setTint(0xff0000);
        player.anims.play('turn');

        setTimeout(() => GameService.instance.showScoreboard(this.score), 1000);
    }
}
