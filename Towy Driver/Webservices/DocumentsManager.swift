//
//  DocumentsManager.swift
//  TOWY Driver
//
//  Created by apple on 11/20/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DocumentManager{
    
    static var manager = DocumentManager()
    
    func uploadVehicleInfo(params:[String:Any],imagesArray:[String:UIImage],completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void){
         let header = UtilityManager().getAuthHeader()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                for (key,value) in params {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                for (k,v) in imagesArray {
                    if  let imageData = v.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: k, fileName: "\(k).png", mimeType: "image/jpeg")
                       
                    }
                }
        },
            to: Constants.HTTP_CONNECTION_ROOT+Constants.VEHICLE_DOCUMENTS_UPLOAD,
            headers: header,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    
                    upload.responseJSON{
                        response in
                        HIDE_CUSTOM_LOADER()
                        switch response.result {
                        case .success:
                            let swiftyJsonVar = JSON(response.result.value!)
                            if swiftyJsonVar["result"].string == "success"
                            {
                                if let mainDict = swiftyJsonVar["data"].dictionaryObject
                                {
                                    UtilityManager().saveUserSession(userDict: mainDict as NSDictionary, accessToken: swiftyJsonVar["accessToken"].string)
                                        completionHandler(true,nil)
                                }
                            }
                            else
                            {
                                if let mainDict = swiftyJsonVar["error"].dictionaryObject
                                {
                                    if  let userDict = mainDict["message"] as? String{
                                        completionHandler(false,userDict)
                                    }
                                    if  let userDict = mainDict["message"] as? [String]{
                                        completionHandler(false,userDict[0])
                                    }
                                }
                            }
                            break
                        case .failure(let error):
                            completionHandler(false,error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                }
        }
        )
    }
    
    
    
    func uploadUserDocuments(params:[String:Any]?,imagesArray:[String:UIImage],completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void){
         let header = UtilityManager().getAuthHeader()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if params != nil{
                    for (key,value) in params! {
                        if let value = value as? String {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                }
                
                for (k,v) in imagesArray {
                    if  let imageData = v.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: k, fileName: "\(k).png", mimeType: "image/jpeg")
                        
                    }
                }
            },
            to: Constants.HTTP_CONNECTION_ROOT+Constants.USER_DOCUMENTS_UPLOAD,
            headers: header,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    
                    upload.responseJSON{
                        response in
                        switch response.result {
                        case .success:
                            let swiftyJsonVar = JSON(response.result.value!)
                            if swiftyJsonVar["result"].string == "success"
                            {
                                if let mainDict = swiftyJsonVar["data"].dictionaryObject
                                {
                                    UtilityManager().saveUserSession(userDict: mainDict as NSDictionary, accessToken: swiftyJsonVar["accessToken"].string)
                                        completionHandler(true,nil)
                                }
                            }else if swiftyJsonVar["status"].int == 401{
                                completionHandler(false,"Un-Authenticated.")
                            }
                            else
                            {
                                if let mainDict = swiftyJsonVar["error"].dictionaryObject
                                {
                                    if  let userDict = mainDict["message"] as? String{
                                        completionHandler(false,userDict)
                                    }
                                    if  let userDict = mainDict["message"] as? [String]{
                                        completionHandler(false,userDict[0])
                                    }
                                }
                            }
                            break
                        case .failure(let error):
                            completionHandler(false,error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                }
        }
        )
    }
    
    func userDocumentsCompleted(completionHandler:@escaping (_ result : Bool?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.USER_DOCUMENTS_COMPLETED
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
    
    
    func resendRequest(message:String,completionHandler:@escaping (_ result : Bool?, _ message:String?)-> Void)
    {
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.RESEND_APPROVAL_REQUEST
        webServiceManager.manager.postData(url: baseUrl, param: ["message":message], headers: UtilityManager.manager.getAuthHeader()) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["result"].string
            {
                    completionHandler(true,nil)
            }else{
                completionHandler(nil,err)
            }
        }
    }
    
    
}
