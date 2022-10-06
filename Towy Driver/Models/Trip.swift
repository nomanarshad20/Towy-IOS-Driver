//
//  Trip.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 19/03/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


class Trip:Codable{
    
//    passenger_first_name
//    vehicle_name
//    actual_fare
//    passenger_last_name
//    booking_type
//    vehicle_registration_number
//    is_driver_rating_given
//    passenger_mobile_no
//    cancel_reason
//    driver_comment_from_passenger
//    is_passenger_rating_given
//     - key : "payment_type"
//    - value : payment_gateway
//  ▿ 31 : 2 elements
//    - key : "passenger_comment_from_driver"
//    - value : <null>
//  ▿ 32 : 2 elements
//    - key : "otp"
//    - value : 8930
//  ▿ 33 : 2 elements
//    - key : "id"
//    - value : 102
//  ▿ 34 : 2 elements
//    - key : "franchise_id"
//    - value : <null>
//  ▿ 35 : 2 elements
//    - key : "passenger_rating"
//    - value : 0

    
    
    var id : Int?
    var booking_unique_id : String?
    var passenger_id : Int?
    var driver_id : Int?
    var franchise_id : Int?
    var pick_up_latitude : String?
    var pick_up_longitude : String?
    var drop_off_latitude : String?
    var drop_off_longitude : String?
    var driver_initial_distance :Double?
    var total_distance : String?
    var estimate_minutes : Double?
    var vehicle_type : String?
    var vehicle_type_id : Int?
    var vehicle_amount : Int?
    var min_ride_fares : Double?
    var payment_type : String?
    var oyla_wallet_pay : String?
    var wallet_pay_amount : Double?
    var driver_ride_status : Int?
    var ride_status_updated_at : String?
    var pick_up_time : String?
    var ride_complete_time : String?
    var ride_cancelled_at : String?
    var waiting_rate : Double?
    var waiting_minuts : Double?
    var estimated_fare : String?
    var final_amount : Double?
    var extra_amount : Double?
    var passenger_cash_paid : Double?
    var passenger_rating_from_driver : Double?
    var booking_changes : Int?
    var ride_status : Int?
    var peak_factor_rate :  Double?
    var descriptions : String?
    var fine_amount : Double?
    var fine_user_type : String?
    var promo_discount :  Double?
    var refresh_logout : Int?
    var created_at : String?
    var updated_at : String?
    var pick_up_area : String?
    var drop_off_area : String?
    
    
    var otp : String?
    var passenger_mobile_no : String?
    var is_driver_rating_given : Int?
    var passenger_rating : Double?
    var booking_type : String?
    var pick_up_date : String?
    var passenger_image : String?
    var passenger_comment_from_driver : String?
    var driver_rating_from_passenger : Double?
    var driver_comment_from_passenger : String?
    var passenger_last_name : String?
    var cancel_reason : String?
    var actual_fare : String?
    var is_passenger_rating_given : Int?
    var passenger_first_name : String?
    var vehicle_registration_number : String?
    var vehicle_name : String?
    
    
    
    init(id: Int? = nil, booking_unique_id: String? = nil, passenger_id: Int? = nil, driver_id: Int? = nil, franchise_id: Int? = nil, pick_up_latitude: String? = nil, pick_up_longitude: String? = nil, drop_off_latitude: String? = nil, drop_off_longitude: String? = nil, driver_initial_distance: Double? = nil, total_distance: String? = nil, estimate_minutes: Double? = nil, vehicle_type: String? = nil, vehicle_type_id: Int? = nil, vehicle_amount: Int? = nil, min_ride_fares: Double? = nil, payment_type: String? = nil, oyla_wallet_pay: String? = nil, wallet_pay_amount: Double? = nil, driver_ride_status: Int? = nil, ride_status_updated_at: String? = nil, pick_up_time: String? = nil, ride_complete_time: String? = nil, ride_cancelled_at: String? = nil, waiting_rate: Double? = nil, waiting_minuts: Double? = nil, estimated_fare: String? = nil, final_amount: Double? = nil, extra_amount: Double? = nil, passenger_cash_paid: Double? = nil, passenger_rating_from_driver: Double? = nil, booking_changes: Int? = nil, ride_status: Int? = nil, peak_factor_rate: Double? = nil, descriptions: String? = nil, fine_amount: Double? = nil, fine_user_type: String? = nil, promo_discount: Double? = nil, refresh_logout: Int? = nil, created_at: String? = nil, updated_at: String? = nil, pick_up_area : String? = "DHA Phase 5 street no 1" , drop_off_area : String? = "Model Town ATR Heights",is_driver_rating_given : Int? = nil,passenger_rating:Double? = nil,booking_type:String? = nil,pick_up_date:String? = nil,passenger_image:String? = nil,passenger_comment_from_driver:String? = nil,driver_rating_from_passenger:Double? = nil,driver_comment_from_passenger:String? = nil,passenger_last_name:String? = nil,cancel_reason:String? = nil,actual_fare:String? = nil,is_passenger_rating_given:Int? = nil,passenger_first_name:String? = nil,vehicle_registration_number:String? = nil,vehicle_name:String? = nil) {
        self.id = id
        self.booking_unique_id = booking_unique_id
        self.passenger_id = passenger_id
        self.driver_id = driver_id
        self.franchise_id = franchise_id
        self.pick_up_latitude = pick_up_latitude
        self.pick_up_longitude = pick_up_longitude
        self.drop_off_latitude = drop_off_latitude
        self.drop_off_longitude = drop_off_longitude
        self.driver_initial_distance = driver_initial_distance
        self.total_distance = total_distance
        self.estimate_minutes = estimate_minutes
        self.vehicle_type = vehicle_type
        self.vehicle_type_id = vehicle_type_id
        self.vehicle_amount = vehicle_amount
        self.min_ride_fares = min_ride_fares
        self.payment_type = payment_type
        self.oyla_wallet_pay = oyla_wallet_pay
        self.wallet_pay_amount = wallet_pay_amount
        self.driver_ride_status = driver_ride_status
        self.ride_status_updated_at = ride_status_updated_at
        self.pick_up_time = pick_up_time
        self.ride_complete_time = ride_complete_time
        self.ride_cancelled_at = ride_cancelled_at
        self.waiting_rate = waiting_rate
        self.waiting_minuts = waiting_minuts
        self.estimated_fare = estimated_fare
        self.final_amount = final_amount
        self.extra_amount = extra_amount
        self.passenger_cash_paid = passenger_cash_paid
        self.passenger_rating_from_driver = passenger_rating_from_driver
        self.booking_changes = booking_changes
        self.ride_status = ride_status
        self.peak_factor_rate = peak_factor_rate
        self.descriptions = descriptions
        self.fine_amount = fine_amount
        self.fine_user_type = fine_user_type
        self.promo_discount = promo_discount
        self.refresh_logout = refresh_logout
        self.created_at = created_at
        self.updated_at = updated_at
        self.pick_up_area = pick_up_area
        self.drop_off_area = drop_off_area
        self.is_passenger_rating_given = is_passenger_rating_given
        
        self.is_driver_rating_given = is_driver_rating_given
        self.passenger_rating = passenger_rating
        self.booking_type = booking_type
        self.pick_up_date = pick_up_date
        self.passenger_image = passenger_image
        self.passenger_comment_from_driver = passenger_comment_from_driver
        self.driver_rating_from_passenger = driver_rating_from_passenger
        self.driver_comment_from_passenger = driver_comment_from_passenger
        self.passenger_last_name = passenger_last_name
        self.cancel_reason = cancel_reason
        self.actual_fare = actual_fare
        self.passenger_first_name = passenger_first_name
        self.vehicle_registration_number = vehicle_registration_number
        self.vehicle_name = vehicle_name
    }
    
    
   
    init(dict:[String:Any]) {
        self.id = dict["id"] as? Int
        self.booking_unique_id = dict["booking_unique_id"] as? String ?? nil
        self.passenger_id = dict["passenger_id"] as? Int ?? nil
        self.driver_id = dict["driver_id"] as? Int ?? nil
        self.franchise_id = dict["franchise_id"] as? Int ?? nil
        self.pick_up_latitude = dict["pick_up_latitude"] as? String ?? nil
        self.pick_up_longitude = dict["pick_up_longitude"] as? String ?? nil
        self.drop_off_latitude = dict["drop_off_latitude"] as? String ?? nil
        self.drop_off_longitude = dict["drop_off_longitude"] as? String ?? nil
        
        self.driver_initial_distance = dict["driver_initial_distance"] as? Double ?? 0
        self.total_distance = dict["total_distance"] as? String ?? nil
        self.estimate_minutes = dict["estimate_minutes"] as? Double ?? 0
        self.vehicle_type = dict["vehicle_type"] as? String ?? ""
        self.vehicle_type_id = dict["vehicle_type_id"] as? Int ?? 0
        self.vehicle_amount = dict["vehicle_amount"] as? Int ?? 0
        self.min_ride_fares = dict["min_ride_fares"] as? Double ?? 0
        self.payment_type = dict["payment_type"] as? String ?? ""
        self.oyla_wallet_pay = dict["oyla_wallet_pay"] as? String ?? ""
        self.wallet_pay_amount = dict["wallet_pay_amount"] as? Double ?? 0
        self.driver_ride_status = dict["driver_ride_status"] as? Int ?? nil
        self.ride_status_updated_at = dict["ride_status_updated_at"] as? String ?? ""
        self.pick_up_time = dict["pick_up_time"] as? String ?? ""
        self.ride_complete_time = dict["ride_complete_time"] as? String ?? ""
        self.ride_cancelled_at = dict["ride_cancelled_at"] as? String ?? ""
        self.waiting_rate = dict["waiting_rate"] as? Double ?? 0
        self.waiting_minuts = dict["waiting_minuts"] as? Double
            ?? 0
        self.estimated_fare = dict["estimated_fare"] as? String ?? "0"
        self.final_amount = dict["final_amount"] as? Double ?? 0
        self.extra_amount = dict["extra_amount"] as? Double ?? 0
        self.passenger_cash_paid = dict["passenger_cash_paid"] as? Double ?? 0
        self.passenger_rating_from_driver = dict["passenger_rating_from_driver"] as? Double ?? 0
        self.booking_changes = dict["booking_changes"] as? Int ?? 0
        self.ride_status = dict["ride_status"] as? Int ?? 0
        self.peak_factor_rate = dict["peak_factor_rate"] as? Double ?? 0
        self.descriptions = dict["descriptions"] as? String ?? ""
        self.fine_amount = dict["fine_amount"] as? Double ?? nil
        self.fine_user_type = dict["fine_user_type"] as? String ?? ""
        self.promo_discount = dict["promo_discount"] as? Double ?? 0
        self.refresh_logout = dict["refresh_logout"] as? Int ?? 0
        self.created_at = dict["created_at"] as? String ?? ""
        self.updated_at = dict["updated_at"] as? String ?? ""
        self.pick_up_area = dict["pick_up_area"] as? String ?? ""
        self.drop_off_area = dict["drop_off_area"] as? String ?? ""
        
        self.is_passenger_rating_given = dict["is_passenger_rating_given"] as? Int ?? 0
        
        self.is_driver_rating_given = dict["is_driver_rating_given"] as? Int ?? 0
        self.passenger_rating = dict["passenger_rating"] as? Double ?? 0
        self.booking_type = dict["booking_type"] as? String ?? ""
        self.pick_up_date = dict["pick_up_date"] as? String ?? ""
        self.passenger_image = dict["passenger_image"] as? String ?? ""
        self.passenger_comment_from_driver = dict["passenger_comment_from_driver"] as? String ?? ""
        self.driver_rating_from_passenger = dict["driver_rating_from_passenger"] as? Double ?? 0.0
        self.driver_comment_from_passenger = dict["driver_comment_from_passenger"] as? String ?? ""
        self.passenger_last_name = dict["passenger_last_name"] as? String ?? ""
        self.cancel_reason = dict["cancel_reason"] as? String ?? ""
        self.actual_fare = dict["actual_fare"] as? String ?? nil
        self.passenger_first_name = dict["passenger_first_name"] as? String ?? ""
        self.vehicle_registration_number = dict["vehicle_registration_number"] as? String ?? ""
        self.vehicle_name = dict["vehicle_name"] as? String ?? ""

        

    }
    
    
    
    
     
    
    
}
