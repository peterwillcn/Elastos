import { Injectable } from '@angular/core';
import { FirstGameSceneModule } from './firstgame.scene.module';

declare let appManager: any;

@Injectable({
    providedIn: FirstGameSceneModule,
})
export class FirstGameScene extends Phaser.Scene {

    private gameOver = false;
    private score = 0;

    // Controls
    private jumpBtn;
    private leftBtn;
    private rightBtn;

    private platforms: Phaser.Physics.Arcade.StaticGroup;
    private player: Phaser.Physics.Arcade.Sprite;
    private cursors: Phaser.Types.Input.Keyboard.CursorKeys;
    private coins: Phaser.Physics.Arcade.Group;
    private bombs: Phaser.Physics.Arcade.Group;
    private scoreText: Phaser.GameObjects.Text;

    private leftPressed = false;
    private rightPressed = false;

    constructor() {
        super('FirstGameScene');
        console.log('FirstGameScene.constructor()');
    }

    ionViewDidEnter() {
        appManager.setVisible("show", ()=>{}, (err)=>{});
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
        this.platforms.create(100, 600, 'ground').setScale(2).refreshBody();

        //  Create some ledges
        this.platforms.create(400, 450, 'ground');
        this.platforms.create(-100, 300, 'ground');
        this.platforms.create(450, 150, 'ground');

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
        this.input.addPointer(2);
        this.jumpBtn = this.add.image(200, 600, 'jump').setInteractive();
        this.leftBtn = this.add.image(100, 600, 'left').setInteractive();
        this.rightBtn = this.add.image(300, 600, 'right').setInteractive();
        this.leftBtn.on('pointerdown', () => {
            this.leftPressed = true;
        });
        this.rightBtn.on('pointerdown', () => {
            this.rightPressed = true;
        });
        this.leftBtn.on('pointerup', () => {
            this.leftPressed = false;
        });
        this.rightBtn.on('pointerup', () => {
            this.rightPressed = false;
        });
        this.jumpBtn.on('pointerdown', () => {
            this.goUp();
        });

        //  Some coins to collect, 12 in total, evenly spaced 40 pixels apart along the x axis
        this.coins = this.physics.add.group({
            key: 'ela',
            repeat: 11,
            setXY: { x: 12, y: 0, stepX: 30 }
        });

        this.coins.children.iterate((child: Phaser.Physics.Arcade.Sprite) => {
            //  Give each ela a slightly different bounce
            child.setBounceY(Phaser.Math.FloatBetween(0.4, 0.8));
        });

        this.bombs = this.physics.add.group();

        //  The score
        this.scoreText = this.add.text(16, 16, 'ELA Bag: 0', { fontSize: '32px', fill: '#FAFAFA' });

        //  Collide the player and the coins with the platforms
        this.physics.add.collider(this.player, this.platforms);
        this.physics.add.collider(this.coins, this.platforms);
        this.physics.add.collider(this.bombs, this.platforms);

        //  Checks to see if the player overlaps with any of the coins, if he does call the collectCoin function
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
        console.log("left")
        this.player.setVelocityX(-160);
        this.player.anims.play('left', true);
    }

    goRight() {
        this.player.setVelocityX(160);
        this.player.anims.play('right', true);
    }

    goUp() {
        console.log("up")
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
            const x = (player.x < 400) ? Phaser.Math.Between(400, 800) : Phaser.Math.Between(0, 400);
            const bomb = this.bombs.create(x, 16, 'bomb');
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
        this.gameOver = true;
    }
}
