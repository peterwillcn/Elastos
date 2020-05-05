import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

import { HomePage } from './pages/home/home';

const routes: Routes = [
  { path: 'home', component: HomePage },
  { path: 'appmanager-demo', loadChildren: './pages/appmanager-demo/appmanager-demo.module#AppmanagerDemoPageModule' },
  { path: 'appmanager', loadChildren: './pages/appmanager-demo/appmanager/appmanager.module#AppmanagerPageModule' },

  { path: 'titlebar-demo', loadChildren: './pages/titlebar-demo/titlebar-demo.module#TitlebarDemoPageModule' },
  { path: 'titlebar', loadChildren: './pages/titlebar-demo/titlebar/titlebar.module#TitlebarPageModule' },

  { path: 'intent-demo', loadChildren: './pages/intent-demo/intent-demo.module#IntentDemoPageModule' },
  { path: 'intent', loadChildren: './pages/intent-demo/intent/intent.module#IntentPageModule' },
  { path: 'core', loadChildren: './pages/core/core.module#CorePageModule' },

];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}
