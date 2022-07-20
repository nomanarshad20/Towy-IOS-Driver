//
//  Document.swift
//  Towy Driver
//
//  Created by Macbook Pro on 23/06/2022.
//

import Foundation
import UIKit


enum DocType: String {
    case BG_CHECK =  "bgCheck"
    case PROFILE_PHOTO = "profilePhoto"
    case LICENSE = "license"
    case REGISTRATION_BOOK = "registraionBook"
    case VEHICLE_INSURANCE = "vehicleInsurance"
    case VEHICLE_INSPECTION = "vehicleInspection"
}

struct Document{
    
    var type:DocType!
    var title:String!
    var description:String!
    var img:UIImage
    
}
