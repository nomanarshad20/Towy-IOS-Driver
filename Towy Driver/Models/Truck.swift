//
//  Truck.swift
//  Towy Driver
//
//  Created by Macbook Pro on 29/07/2022.
//

import Foundation


struct Truck{
   
    
    
    var id:Int?
    var name:String?
    var image:String?
    
    
     init(id: Int? = nil, name: String? = nil, image: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    
    func getTrucksFromArray(data:[[String:Any]])->[Truck]{
        
        var trucks = [Truck]()
        
        for i in data{
            trucks.append(Truck.init(id: i["id"] as? Int ?? nil, name: i["name"] as? String ?? nil, image: i["image"] as? String ?? nil))
        }
       return trucks
    }
    
    
}
