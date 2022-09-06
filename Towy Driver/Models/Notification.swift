//
//  Notification.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 08/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
class NotificationModel{
    
    var message:Message?
    var newRide:NewRide?
    var booking:BookingInfo?
    var rideCancel:String?
    var rideDropOffChange:NewRide?
    var type:Constants.NotificationType
//    var temp_id:String?
//    var passenger_id:String?
//    var booking_id:Int?
//    var pickup_longitude:String?
//    var distance_kilomiters:String?
//    var estimate_minutes:String?
//    var vehicle_amount:String?
//    var oyla_pay:String?
//    var notificationContent:[AnyHashable:Any]?
//    var distance:Double?
//    var vehicle_type:String?
//    var pickup_latitude:String?
//    var dropoff_latitude:String?
//    var dropoff_longitude:String?
//    var driver_status:Int?
//    var milisecWait:Double?
//    var rideStatus:Int?
//    var rideprogress:Int?
    
    init() {
        self.newRide = nil
        self.rideDropOffChange = nil
        self.rideCancel = nil
        self.type = .NONE
        self.message = nil
        self.booking = nil
//        self.temp_id = nil
//        self.passenger_id = nil
//        self.booking_id = nil
//        self.pickup_longitude = nil
//        self.distance_kilomiters = nil
//        self.estimate_minutes = nil
//        self.vehicle_amount = nil
//        self.oyla_pay = nil
//        self.notificationContent = nil
//        self.distance = nil
//        self.vehicle_type = nil
//        self.pickup_latitude = nil
//        self.dropoff_latitude = nil
//        self.dropoff_longitude = nil
//        self.driver_status = nil
//        self.milisecWait = nil
//        self.rideStatus = nil
//        self.rideprogress = nil
    }
    
    
    
    
    init(newRide: NewRide? = nil,booking:BookingInfo? = nil, rideCancel: String? = nil, rideDropOffChange: NewRide? = nil, type: Constants.NotificationType,message:Message?) {
        self.newRide = newRide
        self.rideCancel = rideCancel
        self.rideDropOffChange = rideDropOffChange
        self.type = type
        self.message = message
        self.booking = booking
    }
    
    class func getNotificationType(dict:[AnyHashable:Any])->NotificationModel?{
        let n = NotificationModel()
        switch dict["notification_type"] as? String{
        case "11":
            let data = dict["data"] as? String ?? ""
            let str = self.convertStringToDictionary(text: data)
            n.booking = BookingInfo.getRideInfo(dict: str ?? [:])
            n.type = .NEW_RIDE_REQUEST
            return n
        case "3":
            let data = dict["data"] as? String ?? ""
            let str = self.convertStringToDictionary(text: data)
            n.rideDropOffChange = NewRide.getRideInfo(dict: str?["booking_location_changed"] as? [String:Any] ?? [:])
            n.type = .RIDE_LOCATION_CHANGED
            return n
        case "4":
            n.type = .RIDE_CANCELED
            return n
        case "7":
            let data = dict["data"] as? String ?? ""
            let str = self.convertStringToDictionary(text: data)
            n.newRide = NewRide.getRideInfo(dict: str?["bookingInfo"] as? [String:Any] ?? [:])
            n.type = .SCHEDULE_RIDE
            return n
        case "8":
            n.type = .LOGOUT_USER
            return n
//        case "11":
//            n.type = .OFFLINE_PARTNER
//            return n
        case "10":
            n.type = .RIDE_CANCEL_ON_RECEIVE
            return n
        case "20":
            
            let dataDict = dict["aps"] as? [String:Any]
            let data = dataDict?["alert"] as? [String:Any]
            n.type = .MESSAGE_RECEIVE
            n.message = Message.init(booking_id: nil, receiver_id: data?["title"] as? String, sender_id: nil, message: data?["body"] as? String, messageTime: nil, type: "1")
            return n
        case "21":
            
            let dataDict = dict["aps"] as? [String:Any]
            let data = dataDict?["alert"] as? [String:Any]
            n.type = .WARNING
            n.message = Message.init(booking_id: nil, receiver_id: data?["title"] as? String, sender_id: nil, message: data?["body"] as? String, messageTime: nil, type: "1")
            return n
        case "22":
            
            let dataDict = dict["aps"] as? [String:Any]
            let data = dataDict?["alert"] as? [String:Any]
            n.type = .BOUNS
            n.message = Message.init(booking_id: nil, receiver_id: data?["title"] as? String, sender_id: nil, message: data?["body"] as? String, messageTime: nil, type: "1")
            return n
        case "23":
            
            let dataDict = dict["aps"] as? [String:Any]
            let data = dataDict?["alert"] as? [String:Any]
            n.type = .LOCATION_ERROR_NOTIFICATION
            n.message = Message.init(booking_id: nil, receiver_id: data?["title"] as? String, sender_id: nil, message: data?["body"] as? String, messageTime: nil, type: "1")
            return n
        default:
            return NotificationModel.init()
        }
    }
    
    
//    init(temp_id:String?,passenger_id:String?,booking_id:Int?,pickup_longitude:String?,distance_kilomiters:String?,estimate_minutes:String?,vehicle_amount:String?,oyla_pay:String?,notificationContent:[AnyHashable:Any]?,distance:Double?,vehicle_type:String?,pickup_latitude:String?,dropoff_latitude:String?,dropoff_longitude:String?,milisecWait:Double?,driver_status:Int?,rideStatus:Int?,rideprogress:Int?) {
//        self.temp_id = temp_id
//        self.passenger_id = passenger_id
//        self.booking_id = booking_id
//        self.pickup_longitude = pickup_longitude
//        self.distance_kilomiters = distance_kilomiters
//        self.estimate_minutes = estimate_minutes
//        self.vehicle_amount = vehicle_amount
//        self.oyla_pay = oyla_pay
//        self.notificationContent = notificationContent
//        self.distance = distance
//        self.vehicle_type = vehicle_type
//        self.pickup_latitude = pickup_latitude
//        self.dropoff_latitude = dropoff_latitude
//        self.dropoff_longitude = dropoff_longitude
//        self.driver_status = driver_status
//        self.milisecWait = milisecWait
//        self.rideStatus = rideStatus
//        self.rideprogress = rideprogress
//    }
//    init(dict:[String:Any]) {
//        self.temp_id = dict["temp_id"] as? String ?? nil
//        self.passenger_id = dict["passenger_id"] as? String ?? nil
//        self.booking_id = dict["booking_id"] as? Int ?? nil
//        self.pickup_longitude = dict["pickup_longitude"] as? String ?? nil
//        self.distance_kilomiters = dict["distance_kilomiters"] as? String ?? nil
//        self.estimate_minutes = dict["estimate_minutes"] as? String ?? nil
//        self.vehicle_amount = dict["vehicle_amount"] as? String ?? nil
//        self.oyla_pay = dict["oyla_pay"] as? String ?? nil
//        self.notificationContent = dict["aps"] as? [AnyHashable:Any] ?? nil
//        self.distance =  dict["distance"] as? Double ?? nil
//        self.vehicle_type =  dict["vehicle_type"] as? String ?? nil
//        self.pickup_latitude =  dict["pickup_latitude"] as? String ?? nil
//        self.dropoff_latitude =  dict["dropoff_latitude"] as? String ?? nil
//        self.dropoff_longitude =  dict["dropoff_longitude"] as? String ?? nil
//        self.driver_status =  dict["driver_status"] as? Int ?? nil
//        self.milisecWait =  dict["milisecWait"] as? Double ?? nil
//        self.rideStatus =  dict["rideStatus"] as? Int ?? nil
//        self.rideprogress =  dict["rideprogress"] as? Int ?? nil
//
//    }
    
//    class func getNotificationFromDict(dict:[AnyHashable:Any])-> Notification?{
//        let noti = Notification()
//        noti.temp_id = dict["temp_id"] as? String ?? nil
//        noti.passenger_id = dict["passenger_id"] as? String ?? nil
//        noti.booking_id = dict["booking_id"] as? Int ?? nil
//        noti.pickup_longitude = dict["pickup_longitude"] as? String ?? nil
//        noti.distance_kilomiters = dict["distance_kilomiters"] as? String ?? nil
//        noti.estimate_minutes = dict["estimate_minutes"] as? String ?? nil
//        noti.vehicle_amount = dict["vehicle_amount"] as? String ?? nil
//        noti.oyla_pay = dict["oyla_pay"] as? String ?? nil
//        noti.notificationContent = dict["aps"] as? [AnyHashable:Any] ?? nil
//        noti.distance =  dict["distance"] as? Double ?? nil
//        noti.vehicle_type =  dict["vehicle_type"] as? String ?? nil
//        noti.pickup_latitude =  dict["pickup_latitude"] as? String ?? nil
//        noti.dropoff_latitude =  dict["dropoff_latitude"] as? String ?? nil
//        noti.dropoff_longitude =  dict["dropoff_longitude"] as? String ?? nil
//        noti.driver_status =  dict["driver_status"] as? Int ?? nil
//        noti.milisecWait =  dict["milisecWait"] as? Double ?? nil
//        noti.rideStatus =  dict["rideStatus"] as? Int ?? nil
//        noti.rideprogress =  dict["rideprogress"] as? Int ?? nil
//        return noti
//    }
    
    class func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    
}

