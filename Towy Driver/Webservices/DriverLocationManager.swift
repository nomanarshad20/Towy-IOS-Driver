//
//  DriverLocationManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 10/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FirebaseDatabase

class DriverLocationManager{
    
    static var manager = DriverLocationManager()
    
    var counter = 0
    var counterFir = 0
    func updateDriverLoaction(_ serverUpdate:Bool? = true,params:[String:Any],_ FromBG:Bool = false, completionHandler:@escaping (_ result : [String:Any]?, _ message:String?)-> Void)
    {

        guard let lat = params["lat"] as? Double, let lng = params["lng"] as? Double else {return}
        //if need to send location on firebase
//        updateLocalLocation(lat: lat, lng: lng,bearing: params["bearing"] as? String ?? "0.0", completion: {

            let headers = UtilityManager.manager.getAuthHeader()
            let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.DRIVER_COORDINATES_UPDATE
            if serverUpdate!{

                webServiceManager.manager.postData(url: baseUrl, param: params, headers: headers) { (mainDict, err) in
                    self.counter += 1
                    print("From background=",FromBG)
                    print(self.counter)
                    if let data = mainDict?["data"].dictionaryObject
                    {
                        completionHandler(data,nil)
                    }else{
                        completionHandler(nil,err)
                    }
                }
            }
//        })

    }
    
    func updateLocalLocation(lat:Double,lng:Double,bearing:String? = "0.0"){

        if UtilityManager.manager.getDriverStatus() == 2{
            if let bookinginfo = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE){
                let bookingModel = BookingInfo.getRideInfo(dict: bookinginfo)
                if bookingModel.driver_status != 3 || bookingModel.driver_status != 4{
                    RideManager.manager.saveLocations(locations: LocationModel(booking_id: (bookingModel.id)!, driver_status: (bookingModel.driver_status) ?? 0, lat: lat , lng: lng , speed: 0, time: Int(Date().timeIntervalSince1970)))
//                    Database.database().reference().child("\(bookingModel.booking_id!)").child("tracking").setValue(["lat":lat,"lng":lng,"bearing":bearing!])
                }

            }
        }
        
    }
}
