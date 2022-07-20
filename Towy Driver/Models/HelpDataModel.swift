//
//  HelpDataModel.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 31/03/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


import Foundation

class HelpDataModel:Codable{
    
    var title:String!
    var image:String!
    var id:String?
    
    init(title:String,image:String,id:String?){
        self.title = title
        self.image = image
        self.id = id
    }
}


