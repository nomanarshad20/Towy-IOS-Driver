//
//  BookingInfo.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 16/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation

class BookingInfo{
    
    
    var id : Int?
    var booking_unique_id: String?
    var passenger_id : Int?
    var franchise_id : Int?
    var vehicle_type_id : Int?
    var booking_type : String?
    var pick_up_area : String?
    var pick_up_latitude : String?
    var pick_up_longitude : String?
    var pick_up_date:String?
    var pick_up_time:String?
    var drop_off_area : String?
    var drop_off_latitude : String?
    var drop_off_longitude : String?
    var total_distance : String?
    var payment_type : String?
    var estimated_fare : String?
    var actual_fare : String?
    var ride_status : Int?
    var created_at : String?
    var created_ago : String?
    var booking_detail_id : Int?
    var waiting_price_per_min : Int?
    var vehicle_tax : Int?
    var vehicle_per_km_rate : Int?
    var vehicle_per_min_rate : Int?
    var min_vehicle_fare : Int?
    var passenger_first_name : String?
    var passenger_last_name : String?
    var driver_first_name : String?
    var driver_last_name : String?
    var driver_status : Int?
    var driver_id : Int?
    var peak_factor_rate : String?
    var driver_waiting_time : String?
    var ride_pick_up_time : String?
    var ride_start_time : String?
    var ride_end_time : String?
    var total_minutes_to_reach_pick_up_point : String?
    var total_ride_minutes : String?
    var initial_distance_rate : String?
    var initial_time_rate : String?
    var total_calculated_distance : String?
    var p2p_before_pick_up_distance : String?
    var p2p_after_pick_up_distance : String?
    var is_passenger_rating_given : String?
    var is_driver_rating_given : Int?
    var passenger_image : String?
    var passenger_mobile_no : String?
    var passenger_rating : String?
    var driver_image : String?
    var driver_mobile_no : String?
    var driver_rating : String?
    var vehicle_name : String?
    var vehicle_registration_number : String?
    var driver_rating_from_passenger : String?
    var driver_comment_from_passenger : String?
    var passenger_rating_from_driver : String?
    var passenger_comment_from_driver : String?
    var otp : String?
    
    
    init(){
        self.id = nil
        self.booking_unique_id = nil
        self.passenger_id = nil
        self.franchise_id = nil
        self.vehicle_type_id = nil
        self.booking_type = nil
        self.pick_up_area = nil
        self.pick_up_latitude = nil
        self.pick_up_longitude = nil
        self.pick_up_date = nil
        self.pick_up_time = nil
        self.drop_off_area = nil
        self.drop_off_latitude = nil
        self.drop_off_longitude = nil
        self.total_distance = nil
        self.payment_type = nil
        self.estimated_fare = nil
        self.actual_fare = nil
        self.ride_status = nil
        self.created_at = nil
        self.created_ago = nil
        self.booking_detail_id = nil
        self.waiting_price_per_min = nil
        self.vehicle_tax = nil
        self.vehicle_per_km_rate = nil
        self.vehicle_per_min_rate = nil
        self.min_vehicle_fare = nil
        self.passenger_first_name = nil
        self.passenger_last_name = nil
        self.driver_first_name = nil
        self.driver_last_name = nil
        self.driver_status = nil
        self.driver_id = nil
        self.peak_factor_rate = nil
        self.driver_waiting_time = nil
        self.ride_pick_up_time = nil
        self.ride_start_time = nil
        self.ride_end_time = nil
        self.total_minutes_to_reach_pick_up_point = nil
        self.total_ride_minutes = nil
        self.initial_distance_rate = nil
        self.initial_time_rate = nil
        self.total_calculated_distance = nil
        self.p2p_before_pick_up_distance = nil
        self.p2p_after_pick_up_distance = nil
        self.is_passenger_rating_given = nil
        self.is_driver_rating_given = nil
        self.passenger_image = nil
        self.passenger_mobile_no = nil
        self.passenger_rating = nil
        self.driver_image = nil
        self.driver_mobile_no = nil
        self.driver_rating = nil
        self.vehicle_name = nil
        self.vehicle_registration_number = nil
        self.driver_rating_from_passenger = nil
        self.driver_comment_from_passenger = nil
        self.passenger_rating_from_driver = nil
        self.passenger_comment_from_driver = nil
        self.otp = nil
    }
    
     init(id: Int, booking_unique_id: String, passenger_id: Int? = nil, franchise_id: Int? = nil, vehicle_type_id: Int? = nil, booking_type: String? = nil, pick_up_area: String? = nil, pick_up_latitude: String? = nil, pick_up_longitude: String? = nil, pick_up_date: String? = nil, pick_up_time: String? = nil, drop_off_area: String, drop_off_latitude: String? = nil, drop_off_longitude: String? = nil, total_distance: String? = nil, payment_type: String? = nil, estimated_fare: String? = nil, actual_fare: String? = nil, ride_status: Int? = nil, created_at: String, created_ago: String, booking_detail_id: Int? = nil, waiting_price_per_min: Int? = nil, vehicle_tax: Int? = nil, vehicle_per_km_rate: Int? = nil, vehicle_per_min_rate: Int? = nil, min_vehicle_fare: Int? = nil, passenger_first_name: String? = nil, passenger_last_name: String? = nil, driver_first_name: String? = nil, driver_last_name: String? = nil, driver_status: Int? = nil, driver_id: Int? = nil, peak_factor_rate: String? = nil, driver_waiting_time: String? = nil, ride_pick_up_time: String? = nil, ride_start_time: String? = nil, ride_end_time: String? = nil, total_minutes_to_reach_pick_up_point: String? = nil, total_ride_minutes: String? = nil, initial_distance_rate: String? = nil, initial_time_rate: String? = nil, total_calculated_distance: String? = nil, p2p_before_pick_up_distance: String? = nil, p2p_after_pick_up_distance: String? = nil, is_passenger_rating_given: String? = nil, is_driver_rating_given: Int? = nil, passenger_image: String? = nil, passenger_mobile_no: String? = nil, passenger_rating: String? = nil, driver_image: String? = nil, driver_mobile_no: String? = nil, driver_rating: String? = nil, vehicle_name: String? = nil, vehicle_registration_number: String? = nil, driver_rating_from_passenger: String? = nil, driver_comment_from_passenger: String? = nil, passenger_rating_from_driver: String? = nil, passenger_comment_from_driver: String? = nil, otp: String? = nil) {
        self.id = id
        self.booking_unique_id = booking_unique_id
        self.passenger_id = passenger_id
        self.franchise_id = franchise_id
        self.vehicle_type_id = vehicle_type_id
        self.booking_type = booking_type
        self.pick_up_area = pick_up_area
        self.pick_up_latitude = pick_up_latitude
        self.pick_up_longitude = pick_up_longitude
        self.pick_up_date = pick_up_date
        self.pick_up_time = pick_up_time
        self.drop_off_area = drop_off_area
        self.drop_off_latitude = drop_off_latitude
        self.drop_off_longitude = drop_off_longitude
        self.total_distance = total_distance
        self.payment_type = payment_type
        self.estimated_fare = estimated_fare
        self.actual_fare = actual_fare
        self.ride_status = ride_status
        self.created_at = created_at
        self.created_ago = created_ago
        self.booking_detail_id = booking_detail_id
        self.waiting_price_per_min = waiting_price_per_min
        self.vehicle_tax = vehicle_tax
        self.vehicle_per_km_rate = vehicle_per_km_rate
        self.vehicle_per_min_rate = vehicle_per_min_rate
        self.min_vehicle_fare = min_vehicle_fare
        self.passenger_first_name = passenger_first_name
        self.passenger_last_name = passenger_last_name
        self.driver_first_name = driver_first_name
        self.driver_last_name = driver_last_name
        self.driver_status = driver_status
        self.driver_id = driver_id
        self.peak_factor_rate = peak_factor_rate
        self.driver_waiting_time = driver_waiting_time
        self.ride_pick_up_time = ride_pick_up_time
        self.ride_start_time = ride_start_time
        self.ride_end_time = ride_end_time
        self.total_minutes_to_reach_pick_up_point = total_minutes_to_reach_pick_up_point
        self.total_ride_minutes = total_ride_minutes
        self.initial_distance_rate = initial_distance_rate
        self.initial_time_rate = initial_time_rate
        self.total_calculated_distance = total_calculated_distance
        self.p2p_before_pick_up_distance = p2p_before_pick_up_distance
        self.p2p_after_pick_up_distance = p2p_after_pick_up_distance
        self.is_passenger_rating_given = is_passenger_rating_given
        self.is_driver_rating_given = is_driver_rating_given
        self.passenger_image = passenger_image
        self.passenger_mobile_no = passenger_mobile_no
        self.passenger_rating = passenger_rating
        self.driver_image = driver_image
        self.driver_mobile_no = driver_mobile_no
        self.driver_rating = driver_rating
        self.vehicle_name = vehicle_name
        self.vehicle_registration_number = vehicle_registration_number
        self.driver_rating_from_passenger = driver_rating_from_passenger
        self.driver_comment_from_passenger = driver_comment_from_passenger
        self.passenger_rating_from_driver = passenger_rating_from_driver
        self.passenger_comment_from_driver = passenger_comment_from_driver
        self.otp = otp
    }

    
    class func getRideInfo(dict:[String: Any])->BookingInfo{
        let r = BookingInfo()

        r.id = dict["id"] as? Int ?? nil
        r.booking_unique_id = dict["booking_unique_id"] as? String ?? nil
        r.passenger_id = dict["passenger_id"] as? Int ?? nil
        r.franchise_id = dict["franchise_id"] as? Int ?? nil
        r.vehicle_type_id = dict["vehicle_type_id"] as? Int ?? nil
        r.booking_type = dict["booking_type"] as? String ?? nil
        r.pick_up_area = dict["pick_up_area"] as? String ?? nil
        r.pick_up_latitude = dict["pick_up_latitude"] as? String ?? nil
        r.pick_up_longitude = dict["pick_up_longitude"] as? String ?? nil
        r.pick_up_date = dict["pick_up_date"] as? String ?? nil
        r.pick_up_time = dict["pick_up_time"] as? String ?? nil
        r.drop_off_area = dict["drop_off_area"] as? String ?? nil
        r.drop_off_latitude = dict["drop_off_latitude"] as? String ?? nil
        r.drop_off_longitude = dict["drop_off_longitude"] as? String ?? nil
        r.total_distance = dict["total_distance"] as? String ?? nil
        r.payment_type = dict["payment_type"] as? String ?? nil
        r.estimated_fare = dict["estimated_fare"] as? String ?? nil
        r.actual_fare = dict["actual_fare"] as? String ?? nil
        r.ride_status = dict["ride_status"] as? Int ?? nil
        r.created_at = dict["created_at"] as? String ?? nil
        r.created_ago = dict["created_ago"] as? String ?? nil
        r.booking_detail_id = dict["booking_detail_id"] as? Int ?? nil
        r.waiting_price_per_min = dict["waiting_price_per_min"] as? Int ?? nil
        r.vehicle_tax = dict["vehicle_tax"] as? Int ?? nil
        r.vehicle_per_km_rate = dict["vehicle_per_km_rate"] as? Int ?? nil
        r.vehicle_per_min_rate = dict["vehicle_per_min_rate"] as? Int ?? nil
        r.min_vehicle_fare = dict["min_vehicle_fare"] as? Int ?? nil
        r.passenger_first_name = dict["passenger_first_name"] as? String ?? nil
        r.passenger_last_name = dict["passenger_last_name"] as? String ?? nil
        r.driver_first_name = dict["driver_first_name"] as? String ?? nil
        r.driver_last_name = dict["driver_last_name"] as? String ?? nil
        r.driver_status = dict["driver_status"] as? Int ?? nil
        r.driver_id = dict["driver_id"] as? Int ?? nil
        r.peak_factor_rate = dict["peak_factor_rate"] as? String ?? nil
        r.driver_waiting_time = dict["driver_waiting_time"] as? String ?? nil
        r.ride_pick_up_time = dict["ride_pick_up_time"] as? String ?? nil
        r.ride_start_time = dict["ride_start_time"] as? String ?? nil
        r.ride_end_time = dict["ride_end_time"] as? String ?? nil
        r.total_minutes_to_reach_pick_up_point = dict["total_minutes_to_reach_pick_up_point"] as? String ?? nil
        r.total_ride_minutes = dict["total_ride_minutes"] as? String ?? nil
        r.initial_distance_rate = dict["initial_distance_rate"] as? String ?? nil
        r.initial_time_rate = dict["initial_time_rate"] as? String ?? nil
        r.total_calculated_distance = dict["total_calculated_distance"] as? String ?? nil
        r.p2p_before_pick_up_distance = dict["p2p_before_pick_up_distance"] as? String ?? nil
        r.p2p_after_pick_up_distance = dict["p2p_after_pick_up_distance"] as? String ?? nil
        r.is_passenger_rating_given = dict["is_passenger_rating_given"] as? String ?? nil
        r.is_driver_rating_given = dict["is_driver_rating_given"] as? Int ?? nil
        r.passenger_image = dict["passenger_image"] as? String ?? nil
        r.passenger_mobile_no = dict["passenger_mobile_no"] as? String ?? nil
        r.passenger_rating = dict["passenger_rating"] as? String ?? nil
        r.driver_image = dict["driver_image"] as? String ?? nil
        r.driver_mobile_no = dict["driver_mobile_no"] as? String ?? nil
        r.driver_rating = dict["driver_rating"] as? String ?? nil
        r.vehicle_name = dict["vehicle_name"] as? String ?? nil
        r.vehicle_registration_number = dict["vehicle_registration_number"] as? String ?? nil
        r.driver_rating_from_passenger = dict["driver_rating_from_passenger"] as? String ?? nil
        r.driver_comment_from_passenger = dict["driver_comment_from_passenger"] as? String ?? nil
        r.passenger_rating_from_driver = dict["passenger_rating_from_driver"] as? String ?? nil
        r.passenger_comment_from_driver = dict["passenger_comment_from_driver"] as? String ?? nil
        r.otp = dict["otp"] as? String ?? nil
        return r
    }
    
    
    class func getBookinDict(r:BookingInfo)->[String:Any]{
        var dict = [String:Any]()
        
        dict["id"] =  r.id
        dict["booking_unique_id"] = r.booking_unique_id
        dict["passenger_id"] =  r.passenger_id
        dict["franchise_id"] = r.franchise_id
        dict["vehicle_type_id"] = r.vehicle_type_id
        dict["booking_type"] = r.booking_type
        dict["pick_up_area"] = r.pick_up_area
        dict["pick_up_latitude"] = r.pick_up_latitude
        dict["pick_up_longitude"] =  r.pick_up_longitude
        dict["pick_up_date"] = r.pick_up_date
        dict["pick_up_time"] = r.pick_up_time
        dict["drop_off_area"] = r.drop_off_area
        dict["drop_off_latitude"] = r.drop_off_latitude
        dict["drop_off_longitude"] = r.drop_off_longitude
        dict["total_distance"] = r.total_distance
        dict["payment_type"] = r.payment_type
        dict["estimated_fare"] = r.estimated_fare
        dict["actual_fare"] = r.actual_fare
        dict["ride_status"] = r.ride_status
        dict["created_at"] = r.created_at
        dict["created_ago"] = r.created_ago
        dict["booking_detail_id"] =  r.booking_detail_id
        dict["waiting_price_per_min"] = r.waiting_price_per_min
        dict["vehicle_tax"] = r.vehicle_tax
        dict["vehicle_per_km_rate"] = r.vehicle_per_km_rate
        dict["vehicle_per_min_rate"] = r.vehicle_per_min_rate
        dict["min_vehicle_fare"] = r.min_vehicle_fare
        dict["passenger_first_name"] = r.passenger_first_name
        dict["passenger_last_name"] = r.passenger_last_name
        dict["driver_first_name"] = r.driver_first_name
        dict["driver_last_name"] = r.driver_last_name
        dict["driver_status"] = r.driver_status
        dict["driver_id"] = r.driver_id
        dict["peak_factor_rate"] = r.peak_factor_rate
        dict["driver_waiting_time"] = r.driver_waiting_time
        dict["ride_pick_up_time"] = r.ride_pick_up_time
        dict["ride_start_time"] = r.ride_start_time
        dict["ride_end_time"] = r.ride_end_time
        dict["total_minutes_to_reach_pick_up_point"] = r.total_minutes_to_reach_pick_up_point
        dict["total_ride_minutes"] = r.total_ride_minutes
        dict["initial_distance_rate"] = r.initial_distance_rate
        dict["initial_time_rate"] = r.initial_time_rate
        dict["total_calculated_distance"] = r.total_calculated_distance
        dict["p2p_before_pick_up_distance"] = r.p2p_before_pick_up_distance
        dict["p2p_after_pick_up_distance"] = r.p2p_after_pick_up_distance
        dict["is_passenger_rating_given"] = r.is_passenger_rating_given
        dict["is_driver_rating_given"] = r.is_driver_rating_given
        dict["passenger_image"] = r.passenger_image
        dict["passenger_mobile_no"] =  r.passenger_mobile_no
        dict["passenger_rating"] = r.passenger_rating
        dict["driver_image"] = r.driver_image
        dict["driver_mobile_no"] = r.driver_mobile_no
        dict["driver_rating"] = r.driver_rating
        dict["vehicle_name"] = r.vehicle_name
        dict["vehicle_registration_number"] = r.vehicle_registration_number
        dict["driver_rating_from_passenger"] = r.driver_rating_from_passenger
        dict["driver_comment_from_passenger"] =  r.driver_comment_from_passenger
        dict["passenger_rating_from_driver"] = r.passenger_rating_from_driver
        dict["passenger_comment_from_driver"] = r.passenger_comment_from_driver
        dict["otp"] =  r.otp
        return dict
    }
    
    
    }
