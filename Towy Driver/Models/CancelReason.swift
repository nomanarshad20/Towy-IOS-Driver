//
//  CancelReason.swift
//  TOWY Driver
//
//  Created by apple on 11/12/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation

class CancelReason:Codable{
    var id:Int!
    var text:String!
    var status:Bool?
    
    init(id:Int,text:String,status:Bool) {
        self.id = id
        self.text = text
        self.status = status
    }
}
