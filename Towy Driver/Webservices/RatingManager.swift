//
//  SignupManager.swift
//  TOWY Driver
//
//  Created by apple on 11/18/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RatingManager {
    
    static var manager = RatingManager();
    
    func RateAndReview(params:[String:Any],completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.RATE_PASSENGER
        webServiceManager.manager.postData(url: baseUrl, param: params, headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(true,nil)

            }else{
                completionHandler(false,err)
            }
        }
 
    }
}
