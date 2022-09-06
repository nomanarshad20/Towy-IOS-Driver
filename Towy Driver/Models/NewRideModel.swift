//
//  NewRideModel.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 11/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


class NewRide{
    
    
    //    "":
    
    var vehicle_amount:Int?
    var amount:Int?
    var driver_id:Int?
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
    var ride_complete_time:Int?
    var estimated_amount:Int?
    var final_amount:Int?
    var oyla_wallet_pay:Int?
    var descriptions:String?
    var booking_unique_id:String?
    var booking_changes:Int?
    var payment_type:String?
    var pre_book : Bool?
    var peak_factor_rate:String?
    var passenger_name : String?
    var passenger_ratings : Double?
    var passenger_profile_pic : String?
    var status : Int?
    var passenger_mobile_no : Int?
    var is_skip_dropoff : Int?
    var distance_radius : Int?
    
    
    
    
    
    
    init() {
        self.vehicle_amount = nil
        self.amount = nil
        self.driver_id = nil
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
        self.ride_complete_time = nil
        self.estimated_amount = nil
        self.estimate_minutes = nil
        self.final_amount = nil
        self.oyla_wallet_pay = nil
        self.descriptions = nil
        self.booking_unique_id = nil
        self.payment_type = nil
        self.booking_changes = nil
        self.pre_book = nil
        self.peak_factor_rate = nil
        self.passenger_name = nil
        self.passenger_ratings = nil
        self.passenger_profile_pic = nil
        self.status = nil
        self.passenger_mobile_no = nil
        self.is_skip_dropoff = nil
        self.distance_radius = nil
    }
    
    
    init(vehicle_amount: Int? = nil, amount: Int? = nil, driver_id: Int? = nil, pickup_longitude: String? = nil, temp_id: Int? = nil, passenger_id: Int? = nil, vehicle_type: String? = nil, oyla_pay: String? = nil, dropoff_latitude: String? = nil, user_id: String? = nil, distance_kilomiters: Double? = nil, pickup_latitude: String? = nil, estimate_minutes: String? = nil, dropoff_longitude: String? = nil, booking_id: Int? = nil, driver_status: Int? = nil, ride_complete_time: Int? = nil, estimated_amount: Int? = nil, final_amount: Int? = nil, oyla_wallet_pay: Int? = nil, descriptions: String? = nil, booking_unique_id: String? = nil, booking_changes: Int? = nil, payment_type: String? = nil, pre_book: Bool? = nil, peak_factor_rate: String? = nil, passenger_name: String? = nil, passenger_ratings: Double? = nil, passenger_profile_pic: String? = nil, status: Int? = nil, passenger_mobile_no: Int? = nil,is_skip_dropoff : Int? = nil,distance_radius : Int? = nil) {
        self.vehicle_amount = vehicle_amount
        self.amount = amount
        self.driver_id = driver_id
        self.pickup_longitude = pickup_longitude
        self.temp_id = temp_id
        self.passenger_id = passenger_id
        self.vehicle_type = vehicle_type
        self.oyla_pay = oyla_pay
        self.dropoff_latitude = dropoff_latitude
        self.user_id = user_id
        self.distance_kilomiters = distance_kilomiters
        self.pickup_latitude = pickup_latitude
        self.estimate_minutes = estimate_minutes
        self.dropoff_longitude = dropoff_longitude
        self.booking_id = booking_id
        self.driver_status = driver_status
        self.ride_complete_time = ride_complete_time
        self.estimated_amount = estimated_amount
        self.final_amount = final_amount
        self.oyla_wallet_pay = oyla_wallet_pay
        self.descriptions = descriptions
        self.booking_unique_id = booking_unique_id
        self.booking_changes = booking_changes
        self.payment_type = payment_type
        self.pre_book = pre_book
        self.peak_factor_rate = peak_factor_rate
        self.passenger_name = passenger_name
        self.passenger_ratings = passenger_ratings
        self.passenger_profile_pic = passenger_profile_pic
        self.status = status
        self.passenger_mobile_no = passenger_mobile_no
        self.is_skip_dropoff = is_skip_dropoff
        self.distance_radius = distance_radius
    }
    
    
    class func getRideInfo(dict:[String: Any])->NewRide{
        let r = NewRide()
        r.vehicle_amount =  dict["vehicle_amount"] as? Int ?? nil
        r.amount = dict["amount"] as? Int ?? nil
        r.driver_id = dict["driver_id"] as? Int ??  nil
        r.pickup_longitude = dict["pick_up_longitude"] as? String ?? nil
        r.temp_id = dict["temp_id"] as? Int ?? nil
        r.passenger_id = dict["passenger_id"] as? Int ?? nil
        r.vehicle_type = dict["vehicle_type"] as? String ?? ""
        r.oyla_pay = dict["oyla_pay"] as? String ?? ""
        r.dropoff_latitude = dict["drop_off_latitude"] as? String ?? ""
        r.user_id = dict["user_id"] as? String ?? ""
        r.distance_kilomiters = dict["total_distance"] as? Double ?? nil
        r.pickup_latitude = dict["pick_up_latitude"] as? String ?? nil
        r.estimate_minutes = dict["estimate_minutes"] as? String ?? ""
        r.dropoff_longitude = dict["drop_off_longitude"] as? String ?? ""
        r.booking_id = dict["booking_detail_id"] as? Int ?? nil
        r.passenger_mobile_no = dict["passenger_mobile_no"] as? Int ?? nil
        
        if let status = dict["driver_status"] as? Int {
             r.driver_status = status
        }else{
            if let status = dict["driver_status"] as? String{
                r.driver_status = Int(status)
            }else{
                r.driver_status = nil
            }
        }
        r.ride_complete_time = dict["ride_complete_time"] as? Int ?? nil
        r.final_amount = dict["final_amount"] as? Int ?? nil
        r.oyla_wallet_pay = dict["oyla_wallet_pay"] as? Int ?? nil
        r.descriptions = dict["descriptions"] as? String ?? nil
        r.booking_unique_id = dict["booking_unique_id"] as? String ?? nil
        r.payment_type = dict["payment_type"] as? String ?? nil
        r.estimated_amount = dict["estimated_fare"] as? Int ?? nil
        r.booking_changes = dict["booking_changes"] as? Int ?? nil
        r.pre_book =  dict["pre_book"] as? Bool ?? nil
        r.peak_factor_rate = dict["peak_factor_rate"] as? String ?? nil
        r.passenger_name = dict["passenger_name"] as? String ?? nil
        r.passenger_ratings = dict["passenger_ratings"] as? Double ?? nil
        r.passenger_profile_pic = dict["passenger_profile_pic"] as? String ?? nil
        r.status = dict["status"] as? Int ?? nil
        r.is_skip_dropoff = dict["is_skip_dropoff"] as? Int ?? nil
        r.distance_radius = dict["distance_radius"] as? Int ?? nil
        
        return r
    }
    
    class func getBookingDict(r: NewRide)->[String:Any]{
        var dict = [String:Any]()
        dict["ride_complete_time"]  = r.ride_complete_time
        dict["final_amount"]  = r.final_amount
        dict["oyla_wallet_pay"]  = r.oyla_wallet_pay
        dict["descriptions"]  = r.descriptions
        dict["temp_id"]  = r.temp_id
        dict["driver_id"]  = r.driver_id
        dict["booking_unique_id"]  = r.booking_unique_id
        dict["payment_type"]  = r.payment_type
        dict["estimated_amount"]  = r.estimated_amount
        dict["booking_changes"]  = r.booking_changes
        dict["amount"]  = r.amount
        dict["vehicle_amount"]  = r.vehicle_amount
        dict["pick_up_longitude"]  = r.pickup_longitude
        dict["passenger_id"] = r.passenger_id
        dict["vehicle_type"] = r.vehicle_type
        dict["oyla_pay"] = r.oyla_pay
        dict["drop_off_latitude"] = r.dropoff_latitude
        dict["user_id"] = r.user_id
        dict["total_distance"] = r.distance_kilomiters
        dict["pick_up_latitude"] =  r.pickup_latitude
        dict["estimate_minutes"] = r.estimate_minutes
        dict["drop_off_longitude"] = r.dropoff_longitude
        dict["booking_detail_id"] = r.booking_id
        dict["driver_status"] = r.driver_status
        dict["pre_book"] = r.pre_book
        dict["peak_factor_rate"] = r.peak_factor_rate
        dict["passenger_name"] = r.passenger_name
        dict["passenger_ratings"] = r.passenger_ratings
        dict["passenger_profile_pic"] = r.passenger_profile_pic
        dict["status"] = r.status
        dict["passenger_mobile_no"] = r.passenger_mobile_no
        dict["is_skip_dropoff"] = r.is_skip_dropoff
        dict["distance_radius"] = r.distance_radius

        
        return dict
    }
}
