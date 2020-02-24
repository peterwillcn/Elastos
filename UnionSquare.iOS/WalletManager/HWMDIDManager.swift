//
//  HWMDIDManager.swift
//  elastos wallet
//
//  Created by 韩铭文 on 2020/2/20.
//

import Foundation
import ElastosDIDSDK
 
 var store: DIDStore!

func resolve() -> Void {
    do {
      
        var dids : Array<DID> = try store.listDids(DIDStore.DID_ALL);
        var did = NSNull.self;
        var didurl = <#value#>
        
        
    } catch  {
        
    }

 
    
}
