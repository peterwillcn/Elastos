import { Injectable } from '@angular/core';

declare let appManager: any;

@Injectable({
  providedIn: 'root'
})
export class GameService {

  constructor() { }

  minimizeApp() {
    appManager.launcher();
  }

  closeApp() {
    appManager.close();
  }
}
