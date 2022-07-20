//
//  HelpManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 31/03/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HelpManager {
    
    static var manager = HelpManager();
    
    func getHelpContent(params:[String:Any],completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_HELP_DATA
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
