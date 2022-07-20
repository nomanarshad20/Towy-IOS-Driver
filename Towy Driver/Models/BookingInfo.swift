//
//  BookingInfo.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 16/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation

class BookingInfo1{
    
        var pickup_longitude:String?
        var temp_id:Int?
        var passenger_id:Int?
        var vehicle_type:String?
        var oyla_pay:String?
        var dropoff_latitude:String?
        var user_id:String?
        var distance_kilomiters:Double?
        var pickup_latitude:String?
        var estimate_minutes:String?
        var dropoff_longitude:String?
        var booking_id:Int?
        var driver_status:Int?
    
        init() {

            self.pickup_longitude = nil
            self.temp_id = nil
            self.passenger_id = nil
            self.vehicle_type = nil
            self.oyla_pay = nil
            self.dropoff_latitude = nil
            self.user_id = nil
            self.distance_kilomiters = nil
            self.pickup_latitude = nil
            self.estimate_minutes = nil
            self.dropoff_longitude = nil
            self.booking_id = nil
            self.driver_status = nil
        }
        
        class func getRideInfo(dict:[String: Any])->BookingInfo1{
           let r = BookingInfo1()
            r.pickup_longitude = dict["pickup_longitude"] as? String ?? nil
            r.temp_id = dict["temp_id"] as? Int ?? nil
            r.passenger_id = dict["passenger_id"] as? Int ?? nil
            r.vehicle_type = dict["vehicle_type"] as? String ?? ""
            r.oyla_pay = dict["oyla_pay"] as? String ?? ""
            r.dropoff_latitude = dict["dropoff_latitude"] as? String ?? nil
            r.user_id = dict["user_id"] as? String ?? ""
            r.distance_kilomiters = dict["distance_kilomiters"] as? Double ?? nil
            r.pickup_latitude = dict["pickup_latitude"] as? String ?? nil
            r.estimate_minutes = dict["estimate_minutes"] as? String ?? ""
            r.dropoff_longitude = dict["dropoff_longitude"] as? String ?? nil
            r.booking_id = dict["booking_id"] as? Int ?? nil
            r.driver_status = dict["driver_status"] as? Int ?? nil
            return r
        }
        
    class func getBookinDict(r:BookingInfo1)->[String:Any]{
        var dict = [String:Any]()
        dict["pickup_longitude"]  = r.pickup_longitude
        r.temp_id = dict["temp_id"] as? Int ?? nil
        dict["passenger_id"] = r.passenger_id
        dict["vehicle_type"] = r.vehicle_type
        dict["oyla_pay"] = r.oyla_pay
        dict["dropoff_latitude"] = r.dropoff_latitude
        dict["user_id"] = r.user_id
        dict["distance_kilomiters"] = r.distance_kilomiters
        dict["pickup_latitude"] =  r.pickup_latitude
        dict["estimate_minutes"] = r.estimate_minutes
        dict["dropoff_longitude"] = r.dropoff_longitude
        dict["booking_id"] = r.booking_id
        dict["driver_status"] = r.driver_status
        
        return dict
    }
    
    }
