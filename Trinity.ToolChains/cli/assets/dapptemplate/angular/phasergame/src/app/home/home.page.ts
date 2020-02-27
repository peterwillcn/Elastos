import { Component } from '@angular/core';

declare let appManager: any;

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor() { }

  ionViewDidEnter() {
    appManager.setVisible("show", ()=>{}, (err)=>{});
  }
}
