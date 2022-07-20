//
//  PushnotificationSender.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 13/07/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation
import UIKit

class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title,  "badge":"1",
                                                             "sound":"default",
                                                             "body" : body],
                                           "data" : ["title" : title,  "badge":"1",
                                                     "sound":"default",
                                                     "body" : body,"message" : body,"driver_id" : "\(UtilityManager.manager.getId())","notification_type":"20"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(Constants.FIREBASE_PUSH_NOTIFICATION_SERVER_KEY)", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
