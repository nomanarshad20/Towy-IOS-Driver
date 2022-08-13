//
//  TrucksManager.swift
//  Towy Driver
//
//  Created by Macbook Pro on 27/07/2022.
//


import Foundation
import Alamofire
import SwiftyJSON

class TruckManager{
    static var manager = TruckManager()
    
    func getTruckTypes(completionHandler:@escaping (_ result : [Truck]?, _ message:String?)-> Void)
    {
       
        let header = UtilityManager().getAuthHeader()
        SHOW_CUSTOM_LOADER()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_VEHICLE_TYPE
        
        
        
        webServiceManager.manager.getData(url: baseUrl, param: nil, headers: header) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].arrayObject
            {
                completionHandler(Truck().getTrucksFromArray(data: data as! [[String:Any]]),nil)

            }else{
                completionHandler(nil,err)
            }
        }
    }
        func saveTruckType(truckId:String, completionHandler:@escaping (_ result : Bool?, _ message:String?)-> Void)
        {
           
            let header = UtilityManager().getAuthHeader()
            SHOW_CUSTOM_LOADER()
            let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.SAVE_VEHICLE_TYPE+"vehicle_type_id="+truckId
            
            
//            ["vehicle_type_id":truckId]
            webServiceManager.manager.getData(url: baseUrl, param: nil, headers: header) { (mainDict, err) in
                HIDE_CUSTOM_LOADER()
                if let data = mainDict?["data"].dictionary
                {
                    completionHandler(true,nil)

                }else{
                    completionHandler(nil,err)
                }
            }
            
        }
        
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
