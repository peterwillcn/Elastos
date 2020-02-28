import { Injectable } from '@angular/core';
import { Storage } from '@ionic/storage';

@Injectable({
  providedIn: 'root'
})
export class StorageService {

  constructor(private storage: Storage) {
  }

  public setScores(value: any) {
    return this.storage.set("scores", JSON.stringify(value)).then((data) => {
      console.log('Stored Scores', data);
    });
  }

  public getScores(): Promise<any> {
    return this.storage.get("scores").then((data) => {
      console.log(data);
      return JSON.parse(data);
    });
  }
}
