import { Injectable } from '@angular/core';

declare let appManager: AppManagerPlugin.AppManager;

@Injectable({
  providedIn: 'root'
})
export class GameService {

  constructor() { }

  public images = [
    'ela', 'ltc', 'btc', 'doge', 'xlm', 'xrp', 'eth', 'neo', 'ada', 'xmr',
    'dash', 'bch', 'bsv', 'eos', 'holo', 'icon', 'iota', 'kmd', 'nas', 'nuls',
    'xtz', 'zcash', 'zil'
  ];

  minimizeApp() {
    appManager.launcher();
  }

  closeApp() {
    appManager.close();
  }
}
