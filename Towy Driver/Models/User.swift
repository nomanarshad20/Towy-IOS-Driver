//
//  User.swift
//  TOWY Driver
//
//  Created by apple on 11/18/20.
//  Copyright © 2022 TOWY. All rights reserved.
//



import Foundation

class User:Codable{
    var id : Int?
    var user_id : Int?
    var user_type : Int?
    var email : String?
    var first_name : String?
    var last_name : String?
    var FullName : String?
    var countryName : String?
    var password : String?
    var mobileNumber : String?
    var nic : String?
    var countryCode : String?
    var isLocal : Bool?
    var isModelValid : Bool?
    var is_varified : Int?
    var driver_vehicletype_id : String?
    var franchise_id : Int?
    var referralCode : String?
    var city : String?
    var fcm_token : String?
    var login : String?
    var referrer : String?
    
    
    init() {
        self.id = nil
        self.user_id = nil
        self.user_type = nil
        self.email = nil
        self.first_name = nil
        self.last_name = nil
        self.FullName = nil
        self.countryName = nil
        self.password = nil
        self.mobileNumber = nil
        self.nic = nil
        self.countryCode = nil
        self.isLocal = false
        self.is_varified = nil
        self.driver_vehicletype_id = nil
        self.franchise_id = nil
        self.city = nil
        self.fcm_token = nil
        self.login = nil
        self.referrer = nil
    }
    
    init(id:Int,userId:Int,type:Int,email:String,first_name:String,last_name:String,fullName:String,countryName:String,password:String,mobileNumber:String,nic:String,countryCode:String,isLocal:Bool,isVerified:Int,driver_vehicletype_id:String?,franchise_id:Int?,referrer: String?,city:String?,fcm_token:String?,login:String?) {
        self.id = id
        self.user_id = userId
        self.user_type = type
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.FullName = fullName
        self.countryName = countryName
        self.password = password
        self.mobileNumber = mobileNumber
        self.nic = nic
        self.countryCode = countryCode
        self.isLocal = isLocal
        self.is_varified = isVerified
        self.driver_vehicletype_id = driver_vehicletype_id
        self.franchise_id = franchise_id
        self.city = city
        self.fcm_token = fcm_token
        self.login = login
        self.referrer = referrer
    }
    
    
    
    init(dictionary:[String:Any]) {
        self.id = dictionary["id"] as? Int ?? nil
        self.user_id = dictionary["user_id"] as? Int ?? nil
        self.user_type = dictionary["user_type"] as? Int ?? nil
        self.email = dictionary["email"] as? String ?? nil
        self.first_name = dictionary["first_name"] as? String ?? nil
        self.last_name = dictionary["last_name"] as? String ?? nil
        self.FullName = dictionary["FullName"] as? String ?? nil
        self.countryName = dictionary["countryName"] as? String ?? nil
        self.password = dictionary["password"] as? String ?? nil
        self.mobileNumber = dictionary["mobileNumber"] as? String ?? nil
        self.nic = dictionary["nic"] as? String ?? nil
        self.countryCode = dictionary["countryCode"] as? String ?? nil
        self.isLocal = dictionary["isLocal"] as? Bool ?? false
        self.is_varified = dictionary["is_varified"]  as? Int ?? nil
        self.driver_vehicletype_id = dictionary["driver_vehicletype_id"] as? String ?? nil
        self.franchise_id = dictionary["franchise_id"] as? Int ?? nil
        self.referralCode = dictionary["referralCode"] as? String ?? nil
        self.city = dictionary["city"] as? String ?? nil
        self.fcm_token = dictionary["fcm_token"] as? String ?? nil
        self.referrer = dictionary["referrer"] as? String ?? nil
        self.login = dictionary["login"] as? String ?? nil


    }
    
    class func getDictFromUser(user:User)->[String:Any]{
        var dictionary = [String:Any]()
         dictionary["id"]  = user.id
         dictionary["user_id"] = user.user_id
         dictionary["user_type"] = user.user_type
         dictionary["email"] = user.email
         dictionary["first_name"] = user.first_name
         dictionary["last_name"] = user.last_name
         dictionary["FullName"] = user.FullName
         dictionary["countryName"] = user.countryName
         dictionary["password"] = user.password
         dictionary["mobileNumber"] = user.mobileNumber
         dictionary["nic"] = user.nic
         dictionary["countryCode"] = user.countryCode
         dictionary["isLocal"] = user.isLocal
         dictionary["is_varified"] = user.is_varified
         dictionary["driver_vehicletype_id"] = user.driver_vehicletype_id
         dictionary["franchise_id"] = user.franchise_id
         dictionary["referrer"] = user.referrer
         dictionary["city"] = user.city
        dictionary["fcm_token"] = user.fcm_token
        dictionary["login"] = user.login


        
            return dictionary
    }
 
    deinit {
        
    }
    
    
}
