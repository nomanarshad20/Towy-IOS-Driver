//
//  DriverStatusManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 08/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DriverStatusManager{
    
    static var manager = DriverStatusManager()
    
    func UpdateStatus(status:Int?, completionHandler:@escaping (_ result : Int?, _ message:String?)-> Void)
    {
       
//        let param = ["user_id":UtilityManager.manager.getId(),"status":status ?? 1] as [String : Any]
        
        SHOW_CUSTOM_LOADER()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.DRIVER_STATUS+"\(status ?? 0)"
        
        webServiceManager.manager.getData(url: baseUrl, param: nil, headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            
            if err != nil && mainDict?["data"] != nil{
                completionHandler(0,err)
            }else if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(data["availability_status"] as? Int,nil)
            }else{
                completionHandler(nil,err)
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
//                            completionHandler(mainDict as? [String : Int],nil)
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
 
    func getCurrnetStatus(completionHandler:@escaping (_ booking : BookingInfo?,_ user:User?, _ message:String?)-> Void){
//        DRIVER_CURRENT_STATUS
        
        
        SHOW_CUSTOM_LOADER()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.DRIVER_CURRENT_STATUS
        
        webServiceManager.manager.getData(url: baseUrl, param: nil, headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            
            if err != nil && mainDict?["data"] != nil{
                completionHandler(nil,nil,err)
            }else if let data = mainDict?["data"].dictionaryObject
            {
                var b:BookingInfo? = nil
                var u:User? = nil
                if data["booking"] as? [String:Any] != nil{
                   b = BookingInfo.getRideInfo(dict: data["booking"] as! [String:Any])
                }
                
                if data["user"] as? [String:Any] != nil{
                    u = User.init(dictionary: data["user"] as! [String:Any])
                }
                completionHandler(b,u,nil)
            }else{
                completionHandler(nil,nil,err)
            }
        }
        
    }
    
    
}
