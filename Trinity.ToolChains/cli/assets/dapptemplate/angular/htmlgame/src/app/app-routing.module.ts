import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', loadChildren: './pages/home/home.module#HomePageModule' },
  { path: 'level1', loadChildren: './pages/level1/level1.module#Level1PageModule' },
  { path: 'level2', loadChildren: './pages/level2/level2.module#Level2PageModule' },
  { path: 'level3', loadChildren: './pages/level3/level3.module#Level3PageModule' },
  { path: 'level4', loadChildren: './pages/level4/level4.module#Level4PageModule' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
