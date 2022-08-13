//
//  AppDelegate.swift
//  Towy Driver
//
//  Created by Macbook Pro on 19/06/2022.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import GoogleMaps
import GooglePlaces


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey(Constants.GOOGLE_APIKEY)
        GMSPlacesClient.provideAPIKey(Constants.GOOGLE_APIKEY)
        GoogleApi.shared.initialiseWithKey(Constants.GOOGLE_APIKEY)
        
        
        return true
    }


    
}


extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        UtilityManager.manager.saveFCMToken(token: fcmToken ?? "")
    }
}
