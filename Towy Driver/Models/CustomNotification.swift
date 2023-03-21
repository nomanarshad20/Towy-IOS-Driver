//
//  CustomNotification.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 22/09/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation

class CustomNotification{
    
    var id : Int?
    var created_at : String?
    var user_id : Int?
    var message : String?
    var is_read : Int?
    var title : String?
    
    internal init(id: Int, created_at: String, user_id: Int, message: String, is_read: Int, title: String) {
        self.id = id
        self.created_at = created_at
        self.user_id = user_id
        self.message = message
        self.is_read = is_read
        self.title = title
    }
    
    init(data:[String:Any]) {
        self.id = data["id"] as? Int ?? nil
        self.created_at = data["created_at"] as? String ?? nil
        self.user_id = data["user_id"] as? Int ?? nil
        self.message = data["message"] as? String ?? nil
        self.is_read = data["is_read"] as? Int ?? nil
        self.title = data["title"] as? String ?? nil
    }
    
    
    class func getNotificationFromData(data:[String:Any])-> [CustomNotification]{
        var arr = [CustomNotification]()
        guard let notiArray = data["notifications"] as? [[String:Any]] else{return []}
        for i in notiArray{
            arr.append(CustomNotification.init(data: i))
        }
        return arr
    }
    
}

