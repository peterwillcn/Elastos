

export declare class AppManager {
    close():void;
    sendUrlIntent(url: string, success: ()=>void, error: (err:any)=>void): void;
    sendIntent(action: string, data: any, success: ()=>void, error: (err:any)=>void): void;
}
