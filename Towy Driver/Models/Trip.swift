//
//  Trip.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 19/03/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


class Trip:Codable{
    
    
    var id : Int?
    var booking_unique_id : String?
    var passenger_id : Int?
    var driver_id : Int?
    var franchise_id : Int?
    var pickup_latitude : String?
    var pickup_longitude : String?
    var dropoff_latitude : String?
    var dropoff_longitude : String?
    var driver_initial_distance :Double?
    var distance_kilomiters : Double?
    var estimate_minutes : Double?
    var vehicle_type : String?
    var vehicle_type_id : Int?
    var vehicle_amount : Int?
    var min_ride_fares : Double?
    var payment_type : String?
    var oyla_wallet_pay : String?
    var wallet_pay_amount : Double?
    var driver_status : Int?
    var status_updated_at : String?
    var pickup_time : String?
    var ride_complete_time : String?
    var ride_cancelled_at : String?
    var waiting_rate : Double?
    var waiting_minuts : Double?
    var estimated_amount : Double?
    var final_amount : Double?
    var extra_amount : Double?
    var passenger_cash_paid : Double?
    var rating : Double?
    var booking_changes : Int?
    var status : Int?
    var peak_factor_rate :  Double?
    var descriptions : String?
    var cancel_fine_amount : String?
    var fine_user_type : String?
    var promo_discount :  Double?
    var refresh_logout : Int?
    var created_at : String?
    var updated_at : String?
    var pickup_address : String?
    var dropoff_address : String?
    
    
    
    init(id: Int? = nil, booking_unique_id: String? = nil, passenger_id: Int? = nil, driver_id: Int? = nil, franchise_id: Int? = nil, pickup_latitude: String? = nil, pickup_longitude: String? = nil, dropoff_latitude: String? = nil, dropoff_longitude: String? = nil, driver_initial_distance: Double? = nil, distance_kilomiters: Double? = nil, estimate_minutes: Double? = nil, vehicle_type: String? = nil, vehicle_type_id: Int? = nil, vehicle_amount: Int? = nil, min_ride_fares: Double? = nil, payment_type: String? = nil, oyla_wallet_pay: String? = nil, wallet_pay_amount: Double? = nil, driver_status: Int? = nil, status_updated_at: String? = nil, pickup_time: String? = nil, ride_complete_time: String? = nil, ride_cancelled_at: String? = nil, waiting_rate: Double? = nil, waiting_minuts: Double? = nil, estimated_amount: Double? = nil, final_amount: Double? = nil, extra_amount: Double? = nil, passenger_cash_paid: Double? = nil, rating: Double? = nil, booking_changes: Int? = nil, status: Int? = nil, peak_factor_rate: Double? = nil, descriptions: String? = nil, cancel_fine_amount: String? = nil, fine_user_type: String? = nil, promo_discount: Double? = nil, refresh_logout: Int? = nil, created_at: String? = nil, updated_at: String? = nil, pickup_address : String? = nil , dropoff_address : String? = nil) {
        self.id = id
        self.booking_unique_id = booking_unique_id
        self.passenger_id = passenger_id
        self.driver_id = driver_id
        self.franchise_id = franchise_id
        self.pickup_latitude = pickup_latitude
        self.pickup_longitude = pickup_longitude
        self.dropoff_latitude = dropoff_latitude
        self.dropoff_longitude = dropoff_longitude
        self.driver_initial_distance = driver_initial_distance
        self.distance_kilomiters = distance_kilomiters
        self.estimate_minutes = estimate_minutes
        self.vehicle_type = vehicle_type
        self.vehicle_type_id = vehicle_type_id
        self.vehicle_amount = vehicle_amount
        self.min_ride_fares = min_ride_fares
        self.payment_type = payment_type
        self.oyla_wallet_pay = oyla_wallet_pay
        self.wallet_pay_amount = wallet_pay_amount
        self.driver_status = driver_status
        self.status_updated_at = status_updated_at
        self.pickup_time = pickup_time
        self.ride_complete_time = ride_complete_time
        self.ride_cancelled_at = ride_cancelled_at
        self.waiting_rate = waiting_rate
        self.waiting_minuts = waiting_minuts
        self.estimated_amount = estimated_amount
        self.final_amount = final_amount
        self.extra_amount = extra_amount
        self.passenger_cash_paid = passenger_cash_paid
        self.rating = rating
        self.booking_changes = booking_changes
        self.status = status
        self.peak_factor_rate = peak_factor_rate
        self.descriptions = descriptions
        self.cancel_fine_amount = cancel_fine_amount
        self.fine_user_type = fine_user_type
        self.promo_discount = promo_discount
        self.refresh_logout = refresh_logout
        self.created_at = created_at
        self.updated_at = updated_at
        self.pickup_address = pickup_address
        self.dropoff_address = dropoff_address
    }
    
    
   
    init(dict:[String:Any]) {
        self.id = dict["id"] as? Int
        self.booking_unique_id = dict["booking_unique_id"] as? String ?? nil
        self.passenger_id = dict["passenger_id"] as? Int ?? nil
        self.driver_id = dict["driver_id"] as? Int ?? nil
        self.franchise_id = dict["franchise_id"] as? Int ?? nil
        self.pickup_latitude = dict["pickup_latitude"] as? String ?? ""
        self.pickup_longitude = dict["pickup_longitude"] as? String ?? ""
        self.dropoff_latitude = dict["dropoff_latitude"] as? String ?? ""
        self.dropoff_longitude = dict["dropoff_longitude"] as? String ?? ""
        
        self.driver_initial_distance = dict["driver_initial_distance"] as? Double ?? 0
        self.distance_kilomiters = dict["distance_kilomiters"] as? Double ?? 0
        self.estimate_minutes = dict["estimate_minutes"] as? Double ?? 0
        self.vehicle_type = dict["vehicle_type"] as? String ?? ""
        self.vehicle_type_id = dict["vehicle_type_id"] as? Int ?? 0
        self.vehicle_amount = dict["vehicle_amount"] as? Int ?? 0
        self.min_ride_fares = dict["min_ride_fares"] as? Double ?? 0
        self.payment_type = dict["payment_type"] as? String ?? ""
        self.oyla_wallet_pay = dict["oyla_wallet_pay"] as? String ?? ""
        self.wallet_pay_amount = dict["wallet_pay_amount"] as? Double ?? 0
        self.driver_status = dict["driver_status"] as? Int ?? nil
        self.status_updated_at = dict["status_updated_at"] as? String ?? ""
        self.pickup_time = dict["pickup_time"] as? String ?? ""
        self.ride_complete_time = dict["ride_complete_time"] as? String ?? ""
        self.ride_cancelled_at = dict["ride_cancelled_at"] as? String ?? ""
        self.waiting_rate = dict["waiting_rate"] as? Double ?? 0
        self.waiting_minuts = dict["waiting_minuts"] as? Double
            ?? 0
        self.estimated_amount = dict["estimated_amount"] as? Double ?? 0
        self.final_amount = dict["final_amount"] as? Double ?? 0
        self.extra_amount = dict["extra_amount"] as? Double ?? 0
        self.passenger_cash_paid = dict["passenger_cash_paid"] as? Double ?? 0
        self.rating = dict["rating"] as? Double ?? 0
        self.booking_changes = dict["booking_changes"] as? Int ?? 0
        self.status = dict["status"] as? Int ?? 0
        self.peak_factor_rate = dict["peak_factor_rate"] as? Double ?? 0
        self.descriptions = dict["descriptions"] as? String ?? ""
        self.cancel_fine_amount = dict["cancel_fine_amount"] as? String ?? ""
        self.fine_user_type = dict["fine_user_type"] as? String ?? ""
        self.promo_discount = dict["promo_discount"] as? Double ?? 0
        self.refresh_logout = dict["refresh_logout"] as? Int ?? 0
        self.created_at = dict["created_at"] as? String ?? ""
        self.updated_at = dict["updated_at"] as? String ?? ""
        self.pickup_address = dict["pickup_address"] as? String ?? ""
        self.dropoff_address = dict["dropoff_address"] as? String ?? ""

    }
    
    
    
    
     
    
    
}
