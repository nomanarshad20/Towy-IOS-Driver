//
//  TransactionsManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 29/06/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TransactionsManager {
    
    static var manager = TransactionsManager();
    
    func getHistory(completionHandler:@escaping (_ result : [String:[Transaction]]?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_TRANSACTION_HISTORY
        webServiceManager.manager.postData(url: baseUrl, param: ["user_id":UtilityManager.manager.getId()], headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                let transationArr = Transaction.getTransactionFromDict(dict: data)
                completionHandler(transationArr,nil)
            }else{
                completionHandler(nil,err)
            }
        }
 
    }

}


