//
//  PortalData.swift
//  TOWY Driver
//
//  Created by apple on 11/26/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation

class PortalData:Codable{
    
    var image:String
    var title:String
    var des:String
    
    init(image:String,title:String,description:String) {
        self.image = image
        self.title = title
        self.des = description
    }
    
    
    
    class func getData(dict:[String:Any])->[PortalData]{
        var data = [PortalData]()
        data.append(PortalData.init(image: "starCircle", title: dict["ratingsAvg"] as? String ?? "", description: "Captain Rating"))
        data.append(PortalData.init(image: "Clock", title: dict["totalLoginHours"] as? String ?? "_", description: "Available Hour"))
        data.append(PortalData.init(image: "tickCircle", title: dict["acceptRidesPercent"] as? String ?? "_", description: "Acceptance"))
        data.append(PortalData.init(image: "doubleTick", title: "Ride Completion", description: "\(dict["percentage"] as? Double ?? 0) %"))
        return data
        
    }
    
}

