//
//  SocketManager.swift
//  Towy Driver
//
//  Created by Macbook Pro on 03/09/2022.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    
    
    
    static let sharedInstance =  SocketIOManager()
    
    var manager = SocketManager(socketURL: URL(string: Constants.SOCKET_ROOT)!, config: [.log(true), .compress])
    
    var socket : SocketIOClient!
    
    override init() {
        super.init()
        
        establishConnection()
        
        
//        socket.joinNamespace("point-to-point-tracking") // Create a socket for the /swift namespac
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected \(data)")
            
//            let id:String = getDataFromPreference(key: ID)
//            let identifier:String = getDataFromPreference(key: IDENTIFIER)
//            self.socket.emit(
//                "point-to-point-tracking", ["latitude":"31.66666666","longitude":"74.65656565","area_name":"area_name","city":"city","bearing":90,"booking_id":0,"user_id":27]
//            )
            
        }
        
//        socket.on("point-to-point-tracking") { dataArray, ack in
//            print("socket connected \(dataArray)")
//        }
        
    }
    
    func establishConnection() {
        self.socket = manager.defaultSocket
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
