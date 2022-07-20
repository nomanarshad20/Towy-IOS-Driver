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

class SignUpManager {
    
    static var manager = SignUpManager();
    
    func signup(params:User,completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void)
    {
        var param:[String:Any] = User.getDictFromUser(user: params)
        param.updateValue(UtilityManager.manager.getFcmToken(), forKey: "fcm_token")
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.DRIVER_REGISTERATION
        webServiceManager.manager.postData(url: baseUrl, param: param, headers: nil) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                if  let userDict = data["user"] as? NSDictionary{
                    UtilityManager().saveUserSession(userDict: userDict, accessToken: mainDict?["accessToken"].string ?? "")
                    completionHandler(true,nil)
                }
            }else{
                completionHandler(false,err)
            }
        }
    }
    
    func getAllFranchises(params:[String:String],completionHandler:@escaping (_ result : [Franchise]?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.ALL_FRANCHISES
        webServiceManager.manager.postData(url: baseUrl, param: params, headers: nil) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                if  let franshiseDict = data["franchises"] as? [[String:Any]]{
                    completionHandler(Franchise.getFranchiseArr(dict: franshiseDict),nil)
                }
            }else{
                completionHandler(nil,err)
            }
        }
    }
    
    
}
