import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { TitlebarDemoPage } from './titlebar-demo.page';

const routes: Routes = [
  {
    path: '',
    component: TitlebarDemoPage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)
  ],
  declarations: [TitlebarDemoPage]
})
export class TitlebarDemoPageModule {}
