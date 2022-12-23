//
//  Service.swift
//  Towy Driver
//
//  Created by Macbook Pro on 03/11/2022.
//

import Foundation

class Service{
    
    
    var name:String?
    var id:Int?
    var image:String?
    var description:String?
    var isProviding:Bool?
    var quantity:Int?
    var base_fare:String?
    
     init(name: String? = nil, id: Int? = nil, image: String? = nil, description: String? = nil,isProviding:Bool? = true,quantity:Int? = 1,base_fare:String? = "0") {
        self.name = name
        self.id = id
        self.image = image
        self.description = description
         self.quantity = quantity
         self.base_fare = base_fare
    }
    
    init(dict:[String:Any]) {
        self.id = dict["id"] as? Int ?? nil
        self.name = dict["name"] as? String ?? nil
        self.image = dict["image"] as? String ?? nil
        self.description = dict["description"] as? String ?? nil
        self.isProviding = dict["isProviding"] as? Bool ?? true
        self.quantity = dict["quantity"] as? Int ?? 1
        self.base_fare = dict["base_fare"] as? String ?? "0.0"

        
    }
  
    class func getServiceArr(dict:[[String:Any]])->[Service]{
        var d = [Service]()
        let savedServices = UtilityManager.manager.getServices() as? [[String:Any]] ?? []
        var keysArr = [Int]()
        for s in savedServices{
            keysArr.append(s["service_id"] as! Int)
        }
        for i in dict{
            let service = Service.init(dict: i)
            if keysArr.contains(service.id!){
                d.append(service)}
        }
        return d
    }
    
    func serviceDict(service:Service)->[String:Any]{
        var d = [String:Any]()
        d["id"] =  service.id
        d["name"] =  service.name
        d["image"] =  service.image
        d["description"] =  service.description
        d["isProviding"] =  service.isProviding
        d["quantity"] =  service.quantity
        d["base_fare"] =  service.base_fare
        return d

    }
    
    
    func getServiceDict(services:[Service])->[[String:Any]]{
        
        var dict = [[String:Any]]()
        
        for i in services{
            dict.append(self.serviceDict(service: i))
        }
        
        return dict
        
        
    }
    
    
}

