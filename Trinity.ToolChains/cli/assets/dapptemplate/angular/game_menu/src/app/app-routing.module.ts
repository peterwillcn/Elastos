import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', loadChildren: './pages/home/home.module#HomePageModule' },

  /** First Game - Basic HTML/JS Demo **/
  { path: 'first-game', loadChildren: './pages/first-game/home/home.module#HomePageModule' },
  { path: 'first-game/level1', loadChildren: './pages/first-game/level1/level1.module#Level1PageModule' },
  { path: 'first-game/level2', loadChildren: './pages/first-game/level2/level2.module#Level2PageModule' },
  { path: 'first-game/level3', loadChildren: './pages/first-game/level3/level3.module#Level3PageModule' },
  { path: 'first-game/level4', loadChildren: './pages/first-game/level4/level4.module#Level4PageModule' },

  /** Second Game - Phaser Library Demo **/
  { path: 'second-game', loadChildren: './pages/second-game/home/home.module#HomePageModule' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
