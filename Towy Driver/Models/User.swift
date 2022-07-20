//
//  User.swift
//  TOWY Driver
//
//  Created by apple on 11/18/20.
//  Copyright © 2022 TOWY. All rights reserved.
//



import Foundation

class User:Codable{
    var id : Int!
    var user_id : Int!
    var type : Int!
    var email : String!
    var first_name : String!
    var last_name : String!
    var FullName : String!
    var countryName : String!
    var password : String!
    var mobile_no : String!
    var nic : String!
    var countryCode : String!
    var isLocal : Bool?
    var isModelValid : Bool?
    var is_varified : Int?
    var driver_vehicletype_id : String?
    var franchise_id : Int?
    var referralCode : String?
    
    
    init() {
        self.id = 0
        self.user_id = 0
        self.type = 0
        self.email = ""
        self.first_name = ""
        self.last_name = ""
        self.FullName = ""
        self.countryName = ""
        self.password = ""
        self.mobile_no = ""
        self.nic = ""
        self.countryCode = ""
        self.isLocal = false
        self.is_varified = 0
        self.driver_vehicletype_id = "1"
        self.franchise_id = nil
        self.referralCode = nil
    }
    
    init(id:Int,userId:Int,type:Int,email:String,firstName:String,lastName:String,fullName:String,countryName:String,password:String,mobileNumber:String,nic:String,countryCode:String,isLocal:Bool,isVerified:Int,driver_vehicletype_id:String?,franchise_id:Int?,referralCode: String?) {
        self.id = id
        self.user_id = userId
        self.type = type
        self.email = email
        self.first_name = firstName
        self.last_name = lastName
        self.FullName = fullName
        self.countryName = countryName
        self.password = password
        self.mobile_no = mobileNumber
        self.nic = nic
        self.countryCode = countryCode
        self.isLocal = isLocal
        self.is_varified = isVerified
        self.driver_vehicletype_id = driver_vehicletype_id
        self.franchise_id = franchise_id
        self.referralCode = referralCode
    }
    
    init(dictionary:NSDictionary) {
        self.id = dictionary["id"] as? Int ?? 0
        self.user_id = dictionary["user_id"] as? Int ?? 0
        self.type = dictionary["type"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.first_name = dictionary["first_name"] as? String ?? ""
        self.last_name = dictionary["last_name"] as? String ?? ""
        self.FullName = dictionary["FullName"] as? String ?? ""
        self.countryName = dictionary["countryName"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.mobile_no = dictionary["mobile_no"] as? String ?? ""
        self.nic = dictionary["nic"] as? String ?? ""
        self.countryCode = dictionary["countryCode"] as? String ?? ""
        self.isLocal = dictionary["isLocal"] as? Bool ?? false
        self.is_varified = dictionary["is_varified"]  as? Int ?? 0
        self.driver_vehicletype_id = dictionary["driver_vehicletype_id"] as? String ?? "1"
        self.franchise_id = dictionary["franchise_id"] as? Int ?? nil
        self.referralCode = dictionary["referralCode"] as? String ?? nil

    }
    
    class func getDictFromUser(user:User)->[String:Any]{
        var dictionary = [String:Any]()
         dictionary["id"]  = user.id
         dictionary["user_id"] = user.user_id
         dictionary["type"] = user.type
         dictionary["email"] = user.email
         dictionary["first_name"] = user.first_name
         dictionary["last_name"] = user.last_name
         dictionary["FullName"] = user.FullName
         dictionary["countryName"] = user.countryName
         dictionary["password"] = user.password
         dictionary["mobile_no"] = user.mobile_no
         dictionary["nic"] = user.nic
         dictionary["countryCode"] = user.countryCode
         dictionary["isLocal"] = user.isLocal
         dictionary["is_varified"] = user.is_varified
         dictionary["driver_vehicletype_id"] = user.driver_vehicletype_id
         dictionary["franchise_id"] = user.franchise_id
         dictionary["referralCode"] = user.referralCode
        
            return dictionary
    }
 
    deinit {
        
    }
    
    
}
