import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';


declare let appService: any;
declare var device: any;



function onReceive(ret) {
    display_msg("receive message:" + ret.message + ". from: " + ret.from);
};

function display_msg(content) {
    console.log("ElastosJS  HomePage === msg " + content);
};



@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  constructor(public navCtrl: NavController) {

        document.addEventListener("deviceready", onDeviceReady, false);

        function onDeviceReady() {
            display_msg(device.cordova);
            appService.setListener(onReceive);
        }

  }

  backHome() {
    appService.launcher();
  }

  closeApp() {
    appService.close();
  }

}
