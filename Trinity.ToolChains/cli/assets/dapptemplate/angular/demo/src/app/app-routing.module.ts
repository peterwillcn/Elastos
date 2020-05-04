import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

import { HomePage } from './pages/home/home';

const routes: Routes = [
  { path: 'home', component: HomePage },
  { path: 'appmanager', loadChildren: './pages/appmanager/appmanager.module#AppmanagerPageModule' },
  { path: 'titlebar', loadChildren: './pages/titlebar/titlebar.module#TitlebarPageModule' },
  { path: 'intent', loadChildren: './pages/intent/intent.module#IntentPageModule' },
  { path: 'intent-demo', loadChildren: './pages/intent-demo/intent-demo.module#IntentDemoPageModule' },
  { path: 'appmanager-demo', loadChildren: './pages/appmanager-demo/appmanager-demo.module#AppmanagerDemoPageModule' },
  { path: 'titlebar-demo', loadChildren: './pages/titlebar-demo/titlebar-demo.module#TitlebarDemoPageModule' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}
