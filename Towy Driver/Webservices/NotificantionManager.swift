//
//  NotificantionManager.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 22/09/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NotificantionManager {
    
    static var manager = NotificantionManager()
    
    func getNotifications(completionHandler:@escaping (_ result : [CustomNotification]?, _ message:String?)-> Void)
    {
        let header:[String:String] =  UtilityManager.manager.getAuthHeader()
        
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_NOTIFICATIONS_HISTORY
        webServiceManager.manager.postData(url: baseUrl, param: nil, headers: header) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].dictionaryObject
            {
                let notifications = CustomNotification.getNotificationFromData(data: data)
                completionHandler(notifications,nil)
            }else{
                completionHandler(nil,err)
            }
        }
    }
    
    
}
