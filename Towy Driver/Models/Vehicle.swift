//
//  Vehicle.swift
//  TOWY Driver
//
//  Created by apple on 11/19/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import  UIKit

class Vehicle : Codable{
    
    var user_id:Int?
    var vehicle_name:String
    var vehicle_number:String
    var vehicle_model:String
    var vehicle_model_year:String
    var driver_vehicletype_id:String?
    
    
    init(dict:[String:Any]) {
        self.user_id = dict["user_id"] as? Int ?? 0
        self.vehicle_name = dict["vehicle_name"] as? String ?? ""
        self.vehicle_number = dict["vehicle_number"] as? String ?? ""
        self.vehicle_model = dict["vehicle_model"] as? String ?? ""
        self.vehicle_model_year = dict["vehicle_model_year"] as? String ?? ""
        self.driver_vehicletype_id = dict["driver_vehicletype_id"] as? String ?? "1"

    }
    
}
