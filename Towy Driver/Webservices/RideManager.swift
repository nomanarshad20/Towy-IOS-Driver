//
//  RideManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 11/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class RideManager{
    static var manager = RideManager()
    
    func sendNotificationToUser(params:[String:Any], completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        let headers = UtilityManager.manager.getAuthHeader()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.ACCEPT_RIDE
        var param = params
        if let lat = Constants.DEFAULT_LAT,let long = Constants.DEFAULT_LONG{
            param.updateValue("\(lat)", forKey: "lat")
            param.updateValue("\(long)", forKey: "lng")
           
        }
        
        webServiceManager.manager.postData(url: baseUrl, param: param, headers: headers) { (mainDict, err) in
            
            if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(data,nil)
            }else{
                completionHandler(nil,err)
            }
        }
        
    }
    
    
    func cancelBooking(params:[String:Any], completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        
        let headers = UtilityManager.manager.getAuthHeader()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.DRIVER_CANCEL_BOOKING
        
        
        webServiceManager.manager.postData(url: baseUrl, param: params, headers: headers) { (mainDict, err) in
            
            if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(data,nil)
            }else{
                completionHandler(nil,err)
            }
        }
        
    }
    
    func updateRideStatus(params:[String:Any], completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        
        let headers = UtilityManager.manager.getAuthHeader()
        var baseUrl = Constants.HTTP_CONNECTION_ROOT
        
        switch params["driver_status"] as? String {
        case Constants.RideStatus.REACHED_PICKUP.rawValue :
             baseUrl = baseUrl + "setRideReachedStatus"
        case Constants.RideStatus.RIDE_START.rawValue :
             baseUrl = baseUrl + "setRideStartStatus"
        case Constants.RideStatus.RIDE_COMPLETED.rawValue :
             baseUrl = baseUrl + "setRideCompleteStatus"
        default:
            baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.UPDATE_RIDE_STATUS
        }
        
        
        var param = params
        if let lat = Constants.DEFAULT_LAT,let long = Constants.DEFAULT_LONG{
            param.updateValue("lat", forKey: "\(lat)")
            param.updateValue("lng", forKey: "\(long)")
        }
        
        SHOW_CUSTOM_LOADER()
        webServiceManager.manager.postData(url: baseUrl, param: param, headers: headers) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            // here we receive bookin info //driver info // vehicle infor
            if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(data,nil)
            }else{
                completionHandler(nil,err)
            }
        }
        
    }
   
    func getFinalFare(params:[String:Any], completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        
        let headers = UtilityManager.manager.getAuthHeader()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_CALCULATED_FARE
        
        SHOW_CUSTOM_LOADER()
        if let lat = Constants.DEFAULT_LAT,let lng = Constants.DEFAULT_LONG{
            var para = params
            para.updateValue(lat, forKey: "lat")
            para.updateValue(lng, forKey: "lng")
            webServiceManager.manager.postData(url: baseUrl, param: para, headers: headers) { (mainDict, err) in
                HIDE_CUSTOM_LOADER()
                // here we receive bookin info //driver info // vehicle infor
                if let data = mainDict?["data"].dictionaryObject
                {
                    completionHandler(data,nil)
                }else{
                    completionHandler(nil,err)
                }
            }
        }
    }
    
    
    func getLastRide(completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {
        
        
        let headers = UtilityManager.manager.getAuthHeader()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.CHECK_BOOKING_STATUS
        
        let params = ["driver_id":UtilityManager.manager.getId()]
        
        webServiceManager.manager.postData(url: baseUrl, param: params, headers: headers) { (mainDict, err) in
            
            if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(data,nil)
            }else{
                completionHandler(nil,err)
            }
        }
        
    }
    
    func getSchedualRide(completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void){
        
        
        let headers = UtilityManager.manager.getAuthHeader()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_SCHEDUAL_RIDE
        
        webServiceManager.manager.getData(url: baseUrl, param: nil, headers: headers) { (mainDict, err) in
            
            if let data = mainDict?["data"].dictionaryObject
            {
                completionHandler(data,nil)
            }else{
                completionHandler(nil,err)
            }
        }
        
    }
    
   
    func getTempRide(completionHandler:@escaping(_ result:[String:Any]?,_ error:String?)->Void){
        let headers = UtilityManager.manager.getAuthHeader()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_TEMP_RIDE
        
        webServiceManager.manager.postData(url: baseUrl, param: nil, headers: headers) { (mainDict, err) in
            
            if let data = mainDict?["data"].dictionaryObject
            {
                
                if mainDict?["status"].int == 401{
                    completionHandler(nil,"error")
                }else{
                    completionHandler(data,nil)
                }
            }else{
                completionHandler(nil,err)
            }
        }
    }
    
    
    func setDualCatInfo(params:[String:String],completionHandler:@escaping(_ result:[String:Any]?,_ error:String?)->Void){
         let headers = UtilityManager.manager.getAuthHeader()
         let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_DUAL_CAT_ID
         
         webServiceManager.manager.postData(url: baseUrl, param: params, headers: headers) { (mainDict, err) in
             
             if let data = mainDict?["data"].dictionaryObject
             {
                 completionHandler(data,nil)
             }else{
                 completionHandler(nil,err)
             }
         }
     }
    
    func saveLocations(locations:LocationModel){
        
        var predata = getPreviousLocations()
        predata.append(locations)
        
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: predata)
        userDefaults.set(encodedData, forKey: Constants.RIDE_LOCATIONS)
        userDefaults.synchronize()
    }
    
   
    func getPreviousLocations(sorted:Bool? = false)->[LocationModel]{
        let userDefaults = UserDefaults.standard
        if let decoded  = userDefaults.data(forKey: Constants.RIDE_LOCATIONS){
            guard let decodedLocations = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [LocationModel] else{
                return []
            }
//            print("driver Status",decodedLocations.last?.driver_status ?? 0)
//            print("dataaa",decoded.base64EncodedData())
            if sorted!{
                return decodedLocations.sorted(by: { $0.time > $1.time })
            }else{
                return decodedLocations
            }
        }
       return []
    }
    
}
