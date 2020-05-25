import React from 'react';
import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from '@ionic/react';
declare let appManager: AppManagerPlugin.AppManager;
declare let titleBarManager:TitleBarPlugin.TitleBarManager;
let initTitle=()=>{
  titleBarManager.setupMenuItems([]);
  titleBarManager.setTitle("tab2");
  appManager.setVisible("show");
}
const Tab2: React.FC = () => {
initTitle();
  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonTitle>About</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent>
      
      </IonContent>
    </IonPage>
  );
};

export default Tab2;