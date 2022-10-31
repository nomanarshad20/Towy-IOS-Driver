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
    var isExiting = false
    let socket = SocketIOManager.sharedInstance.socket
    var locationManager = CLLocationManager()
    var location:CLLocationCoordinate2D? = nil
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey(Constants.GOOGLE_APIKEY)
        GMSPlacesClient.provideAPIKey(Constants.GOOGLE_APIKEY)
        GoogleApi.shared.initialiseWithKey(Constants.GOOGLE_APIKEY)
        Messaging.messaging().delegate = self

        registerForRemoteNotification()
//        window!.overrideUserInterfaceStyle = .light
        
        locationManagerInitilize()
        LocationManager.shared.requestLocationAuthorization()
        
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return UIInterfaceOrientationMask.portrait
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
        SocketIOManager.sharedInstance.closeConnection()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.APP_BECOME_ACTIVE.rawValue), object: nil)
       
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


extension AppDelegate:CLLocationManagerDelegate{
    
    
    
    func locationManagerInitilize(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.allowsBackgroundLocationUpdates = false
            locationManager.showsBackgroundLocationIndicator = true
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            if #available(iOS 14.0, *) {
                locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "Tracking")
            }
           
        }else{
            handleEventForFailApiCall(apiName: "enable location services.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let currentLocation:CLLocation = manager.location else{
            self.locationManager.stopUpdatingLocation()
            return}
        Constants.DEFAULT_LAT = currentLocation.coordinate.latitude
        Constants.DEFAULT_LONG = currentLocation.coordinate.longitude
        self.location = currentLocation.coordinate
        emitLocation(location: currentLocation)
        DriverLocationManager.manager.updateLocalLocation(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude, bearing: "0.0")
        self.locationManager.stopUpdatingLocation()
        
    }
    
    
    func locationManager(
        _ manager: CLLocationManager,
        didExitRegion region: CLRegion
    ) {

        
        locationManagerInitilize()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        if socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
        }
        
        
        if !isExiting{
            isExiting = true
                setupGetificationInHome(manager: locationManager)
            }
        }
        
        
    
    
    
//    func locationManager(
//        _ manager: CLLocationManager,
//        didExitRegion region: CLRegion
//    ) {
//
//        if socket?.status == .disconnected{
//            SocketIOManager.sharedInstance.establishConnection()
//        }
//
//        if region is CLCircularRegion {
//
//            if region.identifier == "InHome1"{
//                if !isFinishingHome{
//                    isFinishingHome = true
//                    isStartingHome = false
//                    self.finishHomeTimer()
//                    UserDefaults.standard.set(true, forKey: "InHomeTimerFinished")
//
//                    if DataManager.sharedInstance.getHours() <= 0{
//                    if region is CLCircularRegion {
//                        handleEvent(for: region)
//                    }
//
//                    }
////                    if region is CLCircularRegion {
////                        handleEvent(for: region)
////                    }
//                }
//            }else{
//
//                var hasInRegion = 0
//                if DataManager.sharedInstance.getInHomeHours() > 0{
//                    for i in manager.monitoredRegions{
//                        if i.identifier == "InHome1" ||  i.identifier == "InHome2"{
//                            hasInRegion += 1
//                        }
//                    }
//                    //finishing Home and no region monitoring is available
//                    if hasInRegion < 2{
//                        UserDefaults.standard.set(false, forKey: "hasInRegionMonitoring")
//                        isFinishingHome = true
//                        isStartingHome = false
//
//                        self.finishHomeTimer()
//                        UserDefaults.standard.set(true, forKey: "InHomeTimerFinished")
//
//                    }
//                }
//
//                if !isStarting{
//                    self.starttimer()
//                    if region is CLCircularRegion {
//                        UserDefaults.standard.set("", forKey: "inRegionTime")
//                        handleEvent(for: region)
//                    }
//                }
//            }
//
//
////            NotificationCenter.default.post(name: Notification.Name("AppBecomeActive"), object: nil)
////            self.starttimer()
////            handleEvent(for: region)
//        }
//    }
    
    
    func setupGetificationInHome(manager:CLLocationManager){
        
        stopMonitoringInHome()
        
        let state : UIApplication.State = UIApplication.shared.applicationState
        if  UtilityManager.manager.getDriverStatus() == 2{
            
            let coordinate = CLLocationCoordinate2D.init(latitude: location?.latitude ?? Constants.DEFAULT_LAT, longitude: location?.longitude ?? Constants.DEFAULT_LONG)
            let radius = Constants.radius
            let identifier = "InHome1"
            let note = "Stay safe"
            let eventType: Geotification.EventType = .onExit
            let geotificationExit = Geotification(
                coordinate: coordinate,
                radius: radius,
                identifier: identifier,
                note: note,
                eventType: eventType)
            
            geotificationExit.clampRadius(maxRadius:
                                            locationManager.maximumRegionMonitoringDistance)
            startMonitoring(geotification: geotificationExit)
            isExiting = false
        }else{
            isExiting = false
        }
    }
    
    
    func startMonitoring(geotification: Geotification) {
        
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
           handleEventForFailApiCall(apiName: "No region monitoring is available.")
            return
        }
        
        let fenceRegion = geotification.region
        locationManager.startMonitoring(for: fenceRegion)
    }
    
//    func handleEvent(for region: CLRegion) {
//
////        if UIApplication.shared.applicationState == .active {
////            guard let message = note(from: region.identifier) else { return }
////            BaseVC().ShowErrorAlert(message: message, AlertTitle: message)
////        } else {
//            guard let body = note(from: region.identifier) else { return }
//            let notificationContent = UNMutableNotificationContent()
//            notificationContent.body = body
//            notificationContent.sound = .default
//            notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//            let request = UNNotificationRequest(
//                identifier: "location_change",
//                content: notificationContent,
//                trigger: trigger)
//            UNUserNotificationCenter.current().add(request) { error in
//
//                if let error = error {
//                    print("Error: \(error)")
//                }
//            }
//        }
    
    
    func handleEventForFailApiCall(apiName:String) {
        
//        if UIApplication.shared.applicationState == .active {
//            guard let message = note(from: region.identifier) else { return }
//            BaseVC().ShowErrorAlert(message: message, AlertTitle: message)
//        } else {
             let body = "Service Name : \(apiName)"
            let notificationContent = UNMutableNotificationContent()
            notificationContent.body = body
        notificationContent.sound = .default
            notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(
                identifier: "API_Call_Failiure",
                content: notificationContent,
                trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }
    
    
    func note(from identifier: String) -> String? {
        var geotifications = Geotification.allGeotifications()
        
        if identifier == "InHome1" || identifier == "InHome2"{
            geotifications = Geotification.allGeotificationsInRegion()
        }
        
        let matched = geotifications.first { $0.identifier == identifier }
        return matched?.note
    }
    
    
    func stopMonitoringInHome() {
        //        UserDefaults.standard.removeObject(forKey: "savedItemsInHome")
        //        UserDefaults.standard.synchronize()
        for region in locationManager.monitoredRegions {
            guard
                let circularRegion = region as? CLCircularRegion
            else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
    
    
    func emitLocation(location: CLLocation) {
        
        let locationDict = ["latitude":Constants.DEFAULT_LAT!,"longitude":Constants.DEFAULT_LONG!,"area_name":"area_name","city":"city","bearing":90,"booking_id":UtilityManager.manager.getBookingId() ,"user_id":UtilityManager.manager.getId()] as [String : Any]
        
        if socket?.status == .notConnected || socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
            emitLocation(location: location)
            return
        }
        
//        socket?.emit("point-to-point-tracking", locationDict)
        socket?.emit("point-to-point-tracking", locationDict, completion: {
            self.handleEventForFailApiCall(apiName: "Location updated from background service.")
        })
       

    }
    
}



class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?

    public func requestLocationAuthorization() {
        self.locationManager.delegate = self
        let currentStatus = CLLocationManager.authorizationStatus()

        // Only ask authorization if it was never asked before
        guard currentStatus == .notDetermined else { return }

        // Starting on iOS 13.4.0, to get .authorizedAlways permission, you need to
        // first ask for WhenInUse permission, then ask for Always permission to
        // get to a second system alert
        if #available(iOS 13.4, *) {
            self.requestLocationAuthorizationCallback = { status in
                if status == .authorizedWhenInUse {
                    self.locationManager.requestAlwaysAuthorization()
                }
            }
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    // MARK: - CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        self.requestLocationAuthorizationCallback?(status)
    }
}
