import React, { useState } from 'react';
import { IonPage,IonCard, IonContent, IonCardContent, IonCardTitle, IonCardHeader } from '@ionic/react';
declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager:TitleBarPlugin.TitleBarManager;
const Tab3Page: React.FC = () => {
let str = localStorage.getItem("bgColor") || "lightBg";
let [bgColor,setbgColor] = useState(str);
let initTitle=()=>{
  titleBarManager.setupMenuItems([]);
  titleBarManager.setBackgroundColor("#ff9f46");
  titleBarManager.setForegroundMode(TitleBarPlugin.TitleBarForegroundMode.LIGHT);
  titleBarManager.setNavigationMode(TitleBarPlugin.TitleBarNavigationMode.HOME);
  titleBarManager.setTitle("tab3");
  appManager.setVisible("show");
}
document.addEventListener("deviceready", ()=>{
  initTitle();
}, false);

  return (
    <IonPage className='darkBg'>
      <IonContent>
        <div className={bgColor}>
        <IonCard className="welcome-card">
          <IonCardHeader>
            <IonCardTitle>Follow us on Telegram</IonCardTitle>
          </IonCardHeader>
          <IonCardContent>
            <p>https://t.me/elastosbrowser</p>
          </IonCardContent>
        </IonCard>
        </div>
      </IonContent>
    </IonPage>
  );
};

export default Tab3Page;
