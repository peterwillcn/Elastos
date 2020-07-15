import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';
import { GamePage } from './game.page';
import { GameScene } from './game.scene';

@NgModule({
  providers: [GameScene],
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild([
      {
        path: '',
        component: GamePage
      }
    ]),
  ],
  declarations: [GamePage]
})
export class GamePageModule {}
