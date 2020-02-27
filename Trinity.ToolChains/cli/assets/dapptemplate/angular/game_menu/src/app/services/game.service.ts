import { Injectable } from '@angular/core';

declare let appManager: AppManagerPlugin.AppManager;

@Injectable({
  providedIn: 'root'
})
export class GameService {

  constructor() { }

  /** Basic Demo **/
  public images = [
    'ela', 'ltc', 'btc', 'doge', 'xlm', 'xrp', 'eth', 'neo', 'ada', 'xmr',
    'dash', 'bch', 'bsv', 'eos', 'holo', 'icon', 'iota', 'kmd', 'nas', 'nuls',
    'xtz', 'zcash', 'zil', '0x', 'aelf', 'aion', 'bat', 'eng', 'enj', 'grin',
    'knc', 'link', 'lsk', 'mana', 'nem', 'omg', 'ont', 'qnt', 'qtum', 'tron',
    'wan', 'xzc', 'mkr', 'dai'
  ];

  /** Phase Demo **/

  /** appManager **/
  minimizeApp() {
    appManager.launcher();
  }

  closeApp() {
    appManager.close();
  }
}
