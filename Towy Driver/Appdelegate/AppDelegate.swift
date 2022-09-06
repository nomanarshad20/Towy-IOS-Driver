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
import FirebaseCoreInternal
import NotificationBannerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey(Constants.GOOGLE_APIKEY)
        GMSPlacesClient.provideAPIKey(Constants.GOOGLE_APIKEY)
        GoogleApi.shared.initialiseWithKey(Constants.GOOGLE_APIKEY)
        Messaging.messaging().delegate = self

        registerForRemoteNotification()
        
        
        
        return true
    }


    func registerForRemoteNotification() {
            if #available(iOS 10.0, *) {
                let center  = UNUserNotificationCenter.current()

                center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                    if error == nil{
                        DispatchQueue.main.async(execute: {
                            UIApplication.shared.registerForRemoteNotifications()
                        })
                    }
                }

            }
            else {
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    
    func cancelRide(params:[String:Any]){
        RideManager.manager.sendNotificationToUser(params: params) { (dict, err) in
            if err == nil{
                print("a ride was cancelled. ")
            }
        }
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        SocketIOManager.sharedInstance.closeConnection()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0
        SocketIOManager.sharedInstance.establishConnection()
    }

    
}


extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        UtilityManager.manager.saveFCMToken(token: fcmToken ?? "")
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if UserDefaults.standard.bool(forKey: Constants.IS_LOGIN){
            if let _ = userInfo["aps"] as? [String: AnyObject],
               let noti = NotificationModel.getNotificationType(dict: userInfo) {
                if UtilityManager.manager.getDriverStatus() > 0 {
                    showPopup(noti: noti)
                }
            }
        }
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler:
            @escaping (UIBackgroundFetchResult) -> Void
    ) {

        
        
        
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber += 1
        if UserDefaults.standard.bool(forKey: Constants.IS_LOGIN){
            if let _ = userInfo["aps"] as? [String: AnyObject],
               let noti = NotificationModel.getNotificationType(dict: userInfo) {
                if UtilityManager.manager.getDriverStatus() > 0 {
                    showPopup(noti: noti)
                }
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
//        center.removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        let userInfo = notification.request.content.userInfo
        let state : UIApplication.State = UIApplication.shared.applicationState
               if (state == .inactive || state == .background) {
                if #available(iOS 14.0, *) {
                    completionHandler([.alert,.badge,.banner,.sound,.list])
                } else {
                    completionHandler([.alert,.badge,.sound])
                }
               } else {
                if let _ = userInfo["aps"] as? [String: AnyObject],
                   let noti = NotificationModel.getNotificationType(dict: userInfo) {
                    if UtilityManager.manager.getDriverStatus() > 0 {
                        completionHandler([.sound])
                        showPopup(noti: noti)
                    }
                }else{
                    
                }
            }
        }
    
    
    func showPopup(noti:NotificationModel){
        
        switch noti.type {
        case .NEW_RIDE_REQUEST:
            if UserDefaults.standard.bool(forKey: Constants.IS_HAPTIC_FEEDBACK){
                if #available(iOS 13.0, *) {
                    UtilityManager.manager.addHapticFeedback(.rigid)
                } else {
                    if #available(iOS 13.0, *) {
                        UtilityManager.manager.addHapticFeedback(.soft)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            
            if !Constants.IS_RIDE_POPUP_VISIBLE{
                navigateToVC(identifier: "NewRideRequestViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
            }else{
                let params = ["temp_id":noti.newRide?.temp_id ?? "","user_id":UtilityManager.manager.getId(),"driver_action":2,"pre_book":false] as [String : Any]
                cancelRide(params: params)
            }
            
        case .SCHEDULE_RIDE:
            if UserDefaults.standard.bool(forKey: Constants.IS_HAPTIC_FEEDBACK){
                if #available(iOS 13.0, *) {
                    UtilityManager.manager.addHapticFeedback(.rigid)
                } else {
                    // Fallback on earlier versions
                }
            }
            guard let ride = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE)else{return}
            if UtilityManager.manager.getDriverStatus() == 2 && ride["driver_status"] as? Int ?? 1 >= 2{
                navigateToVC(identifier: "NewRideRequestViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
            }
        case .RIDE_LOCATION_CHANGED:
            navigateToVC(identifier: "RideCancelledByUserViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
        case .RIDE_CANCELED:
            navigateToVC(identifier: "RideCancelledByUserViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
        case .LOGOUT_USER:
            navigateToVC(identifier: "RideCancelledByUserViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
        case .OFFLINE_PARTNER:
            NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.OFFLINE_USER.rawValue), object: noti)
        case .RIDE_CANCEL_ON_RECEIVE:
                NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_USER_ON_RECEIVE.rawValue), object: noti)
            
        case .MESSAGE_RECEIVE:
            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
            let banner = FloatingNotificationBanner(title: "New Message", subtitle: noti.message?.message,rightView: rightView, style: .success)
            banner.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            banner.clipsToBounds = true
            banner.autoDismiss = true
            banner.haptic = .medium
            banner.dismissOnSwipeUp = true
            self.addBadge()
            banner.onTap = {
                self.moveToChat()
            }
            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        case .BOUNS :
            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
            let banner = FloatingNotificationBanner(title: "Got Bouns", subtitle: noti.message?.message,rightView: rightView, style: .success)
            banner.backgroundColor = UIColor.systemGreen
            banner.clipsToBounds = true
            banner.autoDismiss = true
            banner.haptic = .medium
            banner.dismissOnSwipeUp = true
            banner.onTap = {
                
            }
            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        case .WARNING :
            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
            let banner = FloatingNotificationBanner(title: "Warning", subtitle: noti.message?.message,rightView: rightView, style: .success)
            banner.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            banner.clipsToBounds = true
            banner.autoDismiss = true
            banner.haptic = .medium
            banner.dismissOnSwipeUp = true
            banner.onTap = {
                
            }
            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        case .LOCATION_ERROR_NOTIFICATION :
            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
            let banner = FloatingNotificationBanner(title: "Location Error", subtitle: noti.message?.message,rightView: rightView, style: .success)
            banner.backgroundColor = UIColor.systemRed
            banner.clipsToBounds = true
            banner.autoDismiss = true
            banner.haptic = .medium
            banner.dismissOnSwipeUp = true
            banner.onTap = {
                
            }
            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        default:
            print("")
        }
        
    }
    
//    func showBanners(
//        _ banners: [FloatingNotificationBanner],
//        in notificationBannerQueue: NotificationBannerQueue
//    ) {
//        banners.forEach { banner in
//              banner.show(
//                bannerPosition: .top,
//                 queue: notificationBannerQueue,
//                 cornerRadius: 8,
//                shadowColor: UIColor(red: 0.431, green: 0.459, blue: 0.494, alpha: 1),
//                  shadowBlurRadius: 16,
//                shadowEdgeInsets: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
//           )
//        }
//    }

    
    @objc func moveToChat(){
        let st = UtilityManager.manager.getDashboardStoryboard()
        let vc = st.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        guard let b = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE)else{return}
        vc.booking = BookingInfo.getRideInfo(dict: b)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
            if let topVc = UIApplication.getTopMostViewController(){
                if topVc.restorationIdentifier ?? "fsfsdf" !=  vc.restorationIdentifier ?? "sfsddfsfsdf"{
                    topVc.present(vc, animated: true, completion: nil)
                }
            }
    }
     
    func addBadge(){
        let st = UtilityManager.manager.getDashboardStoryboard()
        let vc = st.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        if let topVc = UIApplication.getTopMostViewController(){
            if topVc.restorationIdentifier ?? "fsfsdf" !=  vc.restorationIdentifier ?? "sfsddfsfsdf"{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationObservers.CHECK_BANNER.rawValue), object: nil, userInfo: nil)
            }else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationObservers.RESET_BANNER.rawValue), object: nil, userInfo: nil)
            }
        }
    }
    
    
    func navigateToVC(identifier:String,storyBoard:UIStoryboard,noti:NotificationModel) {
        
        DispatchQueue.main.async {
            
            switch identifier {
            
            case "NewRideRequestViewController":
                
                let vc = storyBoard.instantiateViewController(withIdentifier: identifier) as! NewRideRequestViewController
                vc.noti = noti
                vc.modalPresentationStyle = .overCurrentContext
                Constants.IS_RIDE_POPUP_VISIBLE = true
                if let topVc = UIApplication.getTopMostViewController(){
                    if topVc.restorationIdentifier ?? "fsfsdf" ==  "SideMenuViewController"{
                        topVc.dismiss(animated: true) {
                            if let topVc = UIApplication.getTopMostViewController(){
                                topVc.present(vc, animated: true, completion: nil)
                            }
                        }
                    }else{
                        topVc.present(vc, animated: true, completion: nil)
                    }
                }
                
            case "RideCancelledByUserViewController":
                HIDE_CUSTOM_LOADER()
                let vc = storyBoard.instantiateViewController(withIdentifier: identifier) as! RideCancelledByUserViewController
                vc.noti = noti
                
                
                if let topVc = UIApplication.getTopMostViewController(){
                    if topVc.restorationIdentifier ?? "fsfsdf" ==  "SideMenuViewController"{
                        topVc.dismiss(animated: true) {
                            if let topVc = UIApplication.getTopMostViewController(){
                                topVc.present(vc, animated: true, completion: nil)
                            }
                        }
                    }else{
                        
                        if let window = self.window, let rootViewController = window.rootViewController {
                            var currentController = rootViewController
                            while let presentedController = currentController.presentedViewController {
                                currentController = presentedController
                            }
                            
                            vc.modalPresentationStyle = .overCurrentContext
                            currentController.present(vc, animated: true, completion: nil)
                        }
                    }
                }
                
                
                
            default:
                print("")
            }
        }
        
    }
    
    func DismissVCOne() {
        self.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    
}
