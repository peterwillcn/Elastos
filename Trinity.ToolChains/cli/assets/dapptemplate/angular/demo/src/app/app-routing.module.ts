import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

import { HomePage } from './pages/home/home';

import { AppmanagerPage } from './pages/appmanager/appmanager.page';
import { AppmanagerDemoPage } from './pages/appmanager/appmanager-demo/appmanager-demo.page';
import { TitlebarPage } from './pages/titlebar/titlebar.page';
import { TitlebarDemoPage } from './pages/titlebar/titlebar-demo/titlebar-demo.page';
import { IntentPage } from './pages/intent/intent.page';
import { IntentDemoPage } from './pages/intent/intent-demo/intent-demo.page';
import { CorePage } from './pages/core/core.page';

const routes: Routes = [
  { path: 'home', component: HomePage },

  { path: 'appmanager', component: AppmanagerPage },
  { path: 'appmanager-demo', component: AppmanagerDemoPage },

  { path: 'titlebar', component: TitlebarPage },
  { path: 'titlebar-demo', component: TitlebarDemoPage },

  { path: 'intent', component: IntentPage },
  { path: 'intent-demo', component: IntentDemoPage },

  { path: 'core', component: CorePage },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}
