//
//  LogoutManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 09/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LogoutManager{
    static var manager = LogoutManager()
    
    func LogoutUser(completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        let param = ["user_id":UtilityManager.manager.getId()] as [String : Any]
        let header = UtilityManager().getAuthHeader()
        SHOW_CUSTOM_LOADER()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.USER_LOGOUT
        
        webServiceManager.manager.postData(url: baseUrl, param: param, headers: header) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                    completionHandler(data,nil)
            }else{
                completionHandler(nil,err)
            }
        }
        
//
//        Alamofire.request(baseUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
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
//                            completionHandler(mainDict,nil)
//                        }
//                    }else if swiftyJsonVar["status"].int == 422{
//
//                        if let mainDict = swiftyJsonVar["error"].dictionaryObject
//                        {
//                            if  let error = mainDict["message"] as? String{
//                                completionHandler(nil,error)
//                                break
//                            }
//                            if  let error = mainDict["messages"] as? [String]{
//                                completionHandler(nil,error[0])
//                            }
//                        }
//                    }
//                    else
//                    {
//                        completionHandler(nil,response.error?.localizedDescription)
//                    }
//                    break
//                case .failure(let error):
//                    completionHandler(nil,error.localizedDescription)
//                    HIDE_CUSTOM_LOADER()
//                }
//        }
        
        
    }
}
