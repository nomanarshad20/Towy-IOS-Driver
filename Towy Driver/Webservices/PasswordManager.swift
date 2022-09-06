//
//  PasswordManager.swift
//  TOWY Driver
//
//  Created by apple on 11/19/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PasswordManager{
    
    static var manager = PasswordManager()
    
    func verifyOtp(pin:String,id:Int,completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void){
        let urlString = UtilityManager().getAPIBaseUrl(api:Constants.VERIFY_OTP_FORGOT_PASSWORD)
            let header = UtilityManager().getAuthHeader()
            SHOW_CUSTOM_LOADER()
            let params = [
                "otp_code": pin,
                "user_id": id] as [String:Any]
        
        
        
        webServiceManager.manager.postData(url: urlString, param: params, headers: header) { (mainDict, err) in
            if let data = mainDict?["data"].dictionaryObject
            {
                if  (data["user"] as? NSDictionary) != nil{
                    completionHandler(true,nil)
                }
            }else{
                completionHandler(false,err)
            }
        }
        
        }
       
    
    func getOtp(params:[String:Any],completionHandler:@escaping (_ user : User?, _ message:String?)-> Void){
        let urlString = UtilityManager().getAPIBaseUrl(api:Constants.GET_OTP_FORGOT_PASSWORD)
            let header = UtilityManager().getAuthHeader()
            SHOW_CUSTOM_LOADER()
        
        webServiceManager.manager.postData(url: urlString, param: params, headers: header) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                if  (data["user"] as? NSDictionary) != nil{
                    
                    completionHandler(User(dictionary: data["user"] as! [String : Any] ),nil)
                    
                }
            }else{
                completionHandler(nil,err)
            }
        }
        
        }
    
    
    func updatePassword(params:[String:Any],completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void){
        let urlString = UtilityManager().getAPIBaseUrl(api:Constants.RESET_PASSWORD)
            let header = UtilityManager().getAuthHeader()
        SHOW_CUSTOM_LOADER()
        webServiceManager.manager.postData(url: urlString, param: params, headers: header) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["result"].string
            {
                if  data == "success"{
                    completionHandler(true,nil)
                }else{
                    completionHandler(false,err)
                }
            }else{
                completionHandler(false,err)
            }
        }
        
        }
    
    func resendOtpApi(completionHandler:@escaping(_ result:Bool?,_ error:String?)->Void){
            let urlString = UtilityManager().getAPIBaseUrl(api: Constants.RESEND_OTP)
            let header = UtilityManager().getAuthHeader()
            HIDE_CUSTOM_LOADER()
        let params = [
                "user_id": UtilityManager().getId(),
                "mobile_no" : UtilityManager().getNumber()
            ] as [String:Any]
            Alamofire.request(urlString, method: .post, parameters:params,encoding: JSONEncoding.default, headers: header).responseJSON {
                response in
            HIDE_CUSTOM_LOADER()
                switch response.result {
                case .success:
                    let swiftyJsonVar = JSON(response.result.value!)
//                    print("response",response)
                    if swiftyJsonVar["status"].int == 200
                    {
                        
                        if let data = swiftyJsonVar["data"].dictionaryObject{
                            let msg = data["successMsg"]
                           completionHandler(true,msg as? String ?? "")
                        }
                    }
                    break
                case .failure(let error):
                    completionHandler(false,error.localizedDescription)
                }
            }
        }
    
}
