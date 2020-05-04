import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { AppmanagerDemoPage } from './appmanager-demo.page';

const routes: Routes = [
  {
    path: '',
    component: AppmanagerDemoPage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)
  ],
  declarations: [AppmanagerDemoPage]
})
export class AppmanagerDemoPageModule {}
