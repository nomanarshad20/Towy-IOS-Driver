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
    
    func signup(params:[String:Any],completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void)
    {
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.DRIVER_REGISTERATION
        webServiceManager.manager.postData(url: baseUrl, param: params, headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                UtilityManager().saveUserSession(userDict: data as NSDictionary, accessToken: mainDict?["accessToken"].string ?? "")
                    completionHandler(true,nil)
                
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
    
    
    func sendSSN(ssn:String,completionHandler:@escaping (_ result : Bool?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.SEND_SSN+ssn
        webServiceManager.manager.getData(url: baseUrl, param: nil, headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                    completionHandler(true,nil)
            }else{
                completionHandler(nil,err)
            }
        }
    }
    
    func setUserType(type:String,completionHandler:@escaping (_ result : Bool?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.UPDATE_USER_TYPE+type
        webServiceManager.manager.getData(url: baseUrl, param: nil, headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let _ = mainDict?["data"].dictionaryObject
            {
                    completionHandler(true,nil)
            }else{
                completionHandler(nil,err)
            }
        }
    }
    
    
}
