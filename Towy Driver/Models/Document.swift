//
//  Document.swift
//  Towy Driver
//
//  Created by Macbook Pro on 23/06/2022.
//

import Foundation
import UIKit


enum DocType: String {
    case ID_CARD_FRONT =  "idFront"
    case ID_CARD_BACK = "idBack"
    case PROFILE_PHOTO = "profilePhoto"
    case LICENSE_F = "licenseF"
    case LICENSE_B = "licenseB"
    case REGISTRATION_BOOK = "registraionBook"
}

struct Document{
    
    var type:DocType!
    var title:String!
    var description:String!
    var img:UIImage
    
}
