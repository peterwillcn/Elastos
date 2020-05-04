import { Injectable } from '@angular/core';

declare let appManager: AppManagerPlugin.AppManager;

@Injectable({
  providedIn: 'root'
})
export class AppmanagerService {

  constructor() { }

  closeApp() {
    appManager.close();
  }

}
