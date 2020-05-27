import React, { useEffect, useState } from 'react';
import { IonContent,IonPage, IonGrid} from '@ionic/react';
declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager:TitleBarPlugin.TitleBarManager;
const Tab2: React.FC = () => {
  let str = localStorage.getItem("bgColor") || "lightBg";
  let [bgColor,setbgColor] = useState(str);
  let initTitle=()=>{
    titleBarManager.setupMenuItems([]);
    titleBarManager.setBackgroundColor("#ff9f46");
    titleBarManager.setForegroundMode(0);
    titleBarManager.setNavigationMode(0);
    titleBarManager.setTitle("tab2");
    appManager.setVisible("show");
  }
  document.addEventListener("deviceready", ()=>{
    initTitle();
  }, false);
  return (
    <IonPage>
      <IonContent>
         <div className={bgColor}></div>
      </IonContent>
    </IonPage>
  );
};

export default Tab2;