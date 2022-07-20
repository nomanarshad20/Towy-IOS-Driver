//
//  OTPManager.swift
//  TOWY Driver
//
//  Created by apple on 11/19/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OTPManager{
    
    static var manager = OTPManager()
    
    func codeVerifyApi(pin:String,completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void){
        let urlString = UtilityManager().getAPIBaseUrl(api:Constants.VERIFY_OTP)
            let header = UtilityManager().getAuthHeader()
            let params = [
                "otp_code": pin,
                "user_id" : UtilityManager().getId()
            ] as [String:Any]
        
        
        
        webServiceManager.manager.postData(url: urlString, param: params, headers: header) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
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
        
    func resendOtpApi(completionHandler:@escaping(_ result:Bool?,_ error:String?)->Void){
            let urlString = UtilityManager().getAPIBaseUrl(api: Constants.RESEND_OTP)
            let header = UtilityManager().getAuthHeader()
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
