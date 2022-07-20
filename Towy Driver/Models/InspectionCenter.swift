//
//  InspectionCenter.swift
//  Towy Driver
//
//  Created by Macbook Pro on 14/07/2022.
//

import Foundation


struct InspectionCenter{
    
    var id:String
    var location:String
    var distance:String
    var addressName:String
    var rate:String
    
    
    mutating func getCenters()->[InspectionCenter]{
        return [InspectionCenter.init(id: "1", location: "Gulberg ||| Lahore", distance: "2.3 mi", addressName: "Itfaq Tranding center", rate: "30$"),InspectionCenter.init(id: "2", location: "DHA Phase 5 Lahore", distance: "5.9 mi", addressName: "Ali Tranding center", rate: "30$")]
    }
    
}




