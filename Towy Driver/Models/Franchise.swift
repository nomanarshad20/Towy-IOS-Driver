//
//  Franchise.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 21/01/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation

class Franchise:Codable{
    
    var id : Int?
    var referral_id : String?
    var first_name : String?
    var countryName: String?
    var email : String?
    var franchise_latitude : String?
    var franchise_longitude : String?
    
     init(id: Int? = nil, referral_id: String? = nil, first_name: String? = nil, countryName: String? = nil, email: String? = nil, franchise_latitude: String? = nil, franchise_longitude: String? = nil) {
        self.id = id
        self.referral_id = referral_id
        self.first_name = first_name
        self.countryName = countryName
        self.email = email
        self.franchise_latitude = franchise_latitude
        self.franchise_longitude = franchise_longitude
    }
    
    init(dict:[String:Any]) {
        self.id = dict["id"] as? Int ?? nil
        self.referral_id = dict["referral_id"] as? String ?? nil
        self.first_name = dict["first_name"] as? String ?? nil
        self.countryName = dict["countryName"] as? String ?? nil
        self.email = dict["email"] as? String ?? nil
        self.franchise_latitude = dict["franchise_latitude"] as? String ?? nil
        self.franchise_longitude = dict["franchise_longitude"] as? String ?? nil
    }   
  
    class func getFranchiseArr(dict:[[String:Any]])->[Franchise]{
        var d = [Franchise]()
        for i in dict{
            d.append(Franchise.init(dict: i))
        }
        return d
    }
    
}
