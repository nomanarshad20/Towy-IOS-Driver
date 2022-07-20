//
//  LocationModel.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 02/08/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


class LocationModel: NSObject, NSCoding {
    
    var booking_id: Int
    var driver_status:Int
    var lat:Double
    var lng:Double
    var speed: Int
    var time: Int
    
    
    
     init(booking_id: Int, driver_status: Int, lat: Double, lng: Double, speed: Int, time: Int) {
        self.booking_id = booking_id
        self.driver_status = driver_status
        self.lat = lat
        self.lng = lng
        self.speed = speed
        self.time = time
    }

    required convenience init(coder aDecoder: NSCoder) {
        let booking_id = aDecoder.decodeInteger(forKey: "booking_id")
        let driver_status = aDecoder.decodeInteger(forKey: "driver_status")
        let lat = aDecoder.decodeDouble(forKey: "lat")
        let lng = aDecoder.decodeDouble(forKey: "lng")
        let speed = aDecoder.decodeInteger(forKey: "speed")
        let time = aDecoder.decodeInteger(forKey: "time")
        self.init(booking_id: booking_id, driver_status: driver_status, lat: lat, lng: lng, speed: speed, time: time)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(booking_id, forKey: "booking_id")
        aCoder.encode(driver_status, forKey: "driver_status")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
        aCoder.encode(speed, forKey: "speed")
        aCoder.encode(time, forKey: "time")
    }
    
    
    
    
    
    
    
}
