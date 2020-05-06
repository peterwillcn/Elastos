import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

import { HomePage } from './pages/home/home';

const routes: Routes = [
  { path: 'home', component: HomePage },

  { path: 'appmanager', loadChildren: './pages/appmanager/appmanager.module#AppmanagerPageModule' },
  { path: 'appmanager-demo', loadChildren: './pages/appmanager/appmanager-demo/appmanager-demo.module#AppmanagerDemoPageModule' },

  { path: 'titlebar', loadChildren: './pages/titlebar/titlebar.module#TitlebarPageModule' },
  { path: 'titlebar-demo', loadChildren: './pages/titlebar/titlebar-demo/titlebar-demo.module#TitlebarDemoPageModule' },

  { path: 'intent', loadChildren: './pages/intent/intent.module#IntentPageModule' },
  { path: 'intent-demo', loadChildren: './pages/intent/intent-demo/intent-demo.module#IntentDemoPageModule' },

  { path: 'core', loadChildren: './pages/core/core.module#CorePageModule' },

];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}
