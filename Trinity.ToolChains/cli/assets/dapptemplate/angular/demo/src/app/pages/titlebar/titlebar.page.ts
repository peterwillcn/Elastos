import { Component, OnInit } from '@angular/core';

declare let titleBarManager: TitleBarPlugin.TitleBarManager;

@Component({
  selector: 'app-titlebar',
  templateUrl: './titlebar.page.html',
  styleUrls: ['./titlebar.page.scss'],
})
export class TitlebarPage implements OnInit {

  constructor() { }

  ngOnInit() {
  }

}
