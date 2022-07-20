//
//  LeadgerManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 13/01/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LedgerManager {
    
    static var manager = LedgerManager();
    
    func getLeadgerInfo(params:[String:Any],completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_PARTNER_LEDGER
        webServiceManager.manager.postData(url: baseUrl, param: params, headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(data,nil)

            }else{
                completionHandler(nil,err)
            }
        }
 
    }
}


