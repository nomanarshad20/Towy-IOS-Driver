//
//  WebServiceManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 14/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class webServiceManager{
    
    static var manager = webServiceManager()
    
    func postData(url:String,param:[String:Any]?,headers:[String:String]?,completionHandler:@escaping (_ result : JSON?, _ message:String?)-> Void){
        
//        print(url)
//        print(param)
//        print(headers)
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    let swiftyJsonVar = JSON(response.result.value!)
                    if swiftyJsonVar["status"].int == 200
                    {
                        completionHandler(swiftyJsonVar,nil)
                        
                    }else if swiftyJsonVar["status"].int == 300{
                        completionHandler(swiftyJsonVar,nil)
                        
                    }else if swiftyJsonVar["status"].int == 420{
                        completionHandler(["data":swiftyJsonVar["error"]["message"].string ?? "User is disable by Admin due to unclearance"],swiftyJsonVar["error"]["message"].string ?? "User is disable by Admin due to unclearance")
                    }else if swiftyJsonVar["status"].int == 500{
                        completionHandler(nil ,"Plesae Try Again.")
                    }else{
                        
                        if let mainDict = swiftyJsonVar["error"].dictionaryObject
                        {
                            if  let userDict = mainDict["message"] as? String{
                                completionHandler(nil,userDict)
                            }else if  let userDict = mainDict["messages"] as? String{
                                completionHandler(nil,userDict)
                            }else if  let userDict = mainDict["message"] as? [String]{
                                completionHandler(nil,userDict[0])
                            }else if  let userDict = mainDict["messages"] as? [String]{
                                completionHandler(nil,userDict[0])
                            }
                        }else{
                            completionHandler(nil,"something went wrong.")
                        }
                    }
                    break
                case .failure(let error):
                    completionHandler(nil,error.localizedDescription)
                }
            }
    }
    
    
    
    func getData(url:String,param:[String:Any]?,headers:[String:String]?,completionHandler:@escaping (_ result : JSON?, _ message:String?)-> Void){
        Alamofire.request(url, method: .get, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    let swiftyJsonVar = JSON(response.result.value!)
                    if swiftyJsonVar["status"].int == 200
                    {
                        completionHandler(swiftyJsonVar,nil)
                        
                    }else if swiftyJsonVar["status"].int == 300
                    {
                        completionHandler(swiftyJsonVar,nil)
                        
                    }else{
                        
                        if let mainDict = swiftyJsonVar["error"].dictionaryObject
                        {
                            if  let userDict = mainDict["message"] as? String{
                                completionHandler(nil,userDict)
                            }else if  let userDict = mainDict["messages"] as? String{
                                completionHandler(nil,userDict)
                            }else if  let userDict = mainDict["message"] as? [String]{
                                completionHandler(nil,userDict[0])
                            }else if  let userDict = mainDict["messages"] as? [String]{
                                completionHandler(nil,userDict[0])
                            }
                        }else{
                            completionHandler(nil,"something went wrong.")
                        }
                    }
                    break
                case .failure(let error):
                    completionHandler(nil,error.localizedDescription)
                }
            }
    }
    
    
}

//if swiftyJsonVar["status"].int == 300
//   {
//       
//       completionHandler(swiftyJsonVar,nil)
//       
//   }else if swiftyJsonVar["status"].int == 401
//   {
//       
//       completionHandler(swiftyJsonVar,nil)
//       
//   }else
