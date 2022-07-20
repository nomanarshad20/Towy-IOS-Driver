//
//  LoginManager.swift
//  TOWY Driver
//
//  Created by apple on 11/19/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginManager{
    
    static var manager = LoginManager()
    
    func Login(param:[String:Any],completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void)
    {
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.DRIVER_LOGIN
        
        webServiceManager.manager.postData(url: baseUrl, param: param, headers: nil) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                if  let userDict = data["user"] as? NSDictionary{
                    UtilityManager().saveUserSession(userDict: userDict, accessToken: mainDict?["accessToken"].string ?? "")
                    completionHandler(true,"\(userDict["is_varified"] as? Int ?? 0)")
                }
            }else{
                completionHandler(false,err)
            }
        }
        
//        Alamofire.request(baseUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
//            .responseJSON {
//                response in
//                HIDE_CUSTOM_LOADER()
//                switch response.result {
//                case .success:
//                    let swiftyJsonVar = JSON(response.result.value!)
//                    LoadingOverlay.shared.hideOverlayView()
//                    if swiftyJsonVar["status"].int == 200
//                    {
//                        if let mainDict = swiftyJsonVar["data"].dictionaryObject
//                        {
//                            if  let userDict = mainDict["user"] as? NSDictionary{
//                                UtilityManager().saveUserSession(userDict: userDict, accessToken: swiftyJsonVar["accessToken"].string ?? "")
//                                completionHandler(true,"\(userDict["is_varified"] as? Int ?? 1)")
//                            }
//                        }
//                    }else{
//
//                        if let mainDict = swiftyJsonVar["error"].dictionaryObject
//                        {
//                            if  let error = mainDict["message"] as? String{
//                                completionHandler(false,error)
//                                break
//                            }
//                            if  let error = mainDict["messages"] as? [String]{
//                                completionHandler(false,error[0])
//                            }
//                        }
//                    }
//
//                    break
//                case .failure(let error):
//                    completionHandler(false,error.localizedDescription)
//                    HIDE_CUSTOM_LOADER()
//                }
//        }
        
        
    }
    
}
