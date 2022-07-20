//
//  LocationManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 21/12/2020.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import CoreLocation

//class LocationManager: NSObject, CLLocationManagerDelegate{
//
//    static let shared =  LocationManager()
//    private let privateQueue = DispatchQueue.init(label: "somePrivateQueue")
//    private var latestLocation: CLLocation!{
//        didSet{
//            privateQueue.resume()
//        }
//    }
//
//    func getUserLocation(queue: DispatchQueue, callback: @escaping (CLLocation?) -> Void) {
//        if latestLocation == nil{
//            privateQueue.suspend()
//        }
//
//        privateQueue.async{
//
//            queue.async{
//
//              callback(self.latestLocation)
//              
//            }
//        }
//
//    }
//
//    func fetchCountry(from currentLocation: CLLocation, completion:@escaping (CLLocation?) -> Void){
//    
//    }
//    
//    @objc func locationManager(_ manager: CLLocationManager,
//           didUpdateLocations locations: [CLLocation]){
//         latestLocation = locations.last! //API states that it is guaranteed to always have a value
//    }
//
//}
