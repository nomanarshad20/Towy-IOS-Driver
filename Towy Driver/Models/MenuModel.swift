//
//  MenuModel.swift
//  TOWY Driver
//
//  Created by apple on 11/12/20.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation

class MenuModel:Codable{
    
    var title:String!
    var image:String!
    
    init(title:String,image:String){
        self.title = title
        self.image = image
    }
}


