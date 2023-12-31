//
//  DashBoardViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 02/08/2022.
//

import UIKit
import SideMenu
import GoogleMaps
import SocketIO
import CoreLocation
import Toast_Swift
import Alamofire
import SwiftyJSON

class DashBoardViewController: UIViewController, MenuDelegate, GMSMapViewDelegate {
    
    
    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var mainMapView:UIView!
//    @IBOutlet weak var viewDistance:UIImageView!
//    @IBOutlet weak var radiusSlider:UISlider!
    @IBOutlet weak var lblCustomerName:UILabel!
    @IBOutlet weak var viewTbl:UIView!

    @IBOutlet weak var btnServiceDetail:UIButton!
    @IBOutlet weak var btnPassengerRating:UIButton!
    
    @IBOutlet weak var tblReasons:UITableView!
    @IBOutlet weak var btnChat:UIButton!
    @IBOutlet weak var viewMeetAt:UIView!
    @IBOutlet weak var viewStartService:UIView!
    @IBOutlet weak var viewRequest:UIView!

    
    @IBOutlet weak var viewNameBottomConstraint:NSLayoutConstraint!
    @IBOutlet weak var viewMeetAtBottomConstraint:NSLayoutConstraint!
    @IBOutlet weak var timerTopConstraint:NSLayoutConstraint!
//    @IBOutlet weak var viewRedTrailing:NSLayoutConstraint!
    @IBOutlet weak var btnReachNearBy:UIButton!
    @IBOutlet weak var btnStatus:UIButton!
    @IBOutlet weak var lblWaitingTime:UILabel!
    @IBOutlet weak var lblPassengerName:UILabel!

    @IBOutlet weak var btnStartService:UIButton!
    @IBOutlet weak var btnNavigation:UIButton!

    @IBOutlet weak var btnEndService:UIButton!
    @IBOutlet weak var btnCancelRideOnReach:UIButton!

    var isToDropOff:Bool? = nil
    var dataSource = [Precaution]()
    var isMapLoaded = false
    var apiTimer:Timer?
    var WT:Timer!
    var timer:Timer? = Timer()
    var totalTime = 10
    var time = 0
    var driverMarker = GMSMarker()
    
    var socketEvent = "driver-change-booking-driver-status"
    
    
    var booking : BookingInfo? = nil{
        didSet{
            UtilityManager.manager.saveModelInUserDefaults(key: Constants.CURRENT_RIDE, data: BookingInfo.getBookinDict(r: booking ?? BookingInfo.init()))
        }
    }
    var locationManager = CLLocationManager()
    var mapView:GMSMapView = GMSMapView()
    var waitingTime:Int? = 0
    var isServing = false
    var zoomLevel:Float = 17
    var isService = false{
        didSet{
            if isService{
                socketEvent = "driver-change-service-driver-status"}
        }
    }

//    var socket: SocketIOClient? = nil
    
    var isConnectedToSocket = false
    
    let socket = SocketIOManager.sharedInstance.socket
//    let manager = SocketManager(socketURL: URL(string: Constants.SOCKET_ROOT)!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        btnChat.isHidden = true
        self.btnNavigation.isHidden = true
        btnEndService.setTitle("Finish Towing", for: .normal)
        
        if socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
        }
    
       
        addSocketListerForRide()
        addSocketListnerForLocation()
       
        
        
        
        tblReasons.delegate = self
        tblReasons.dataSource = self
        tblReasons.register(UINib.init(nibName: "TextWithCheckboxTableViewCell", bundle: .main), forCellReuseIdentifier: "TextWithCheckboxTableViewCell")
        
        
        viewStartService.CurveViewsTop(corner: 30)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ratingCompleted), name:NSNotification.Name( Constants.NotificationObservers.DRIVER_RATED_THE_CUSTOMER.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rideDataReceived(notify:)), name:NSNotification.Name( Constants.NotificationObservers.RIDE_ACCEPTED.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.rideCancelByUser), name:NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_USER.rawValue) , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rideCancelByDriver), name:NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_DRIVER.rawValue) , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.appBecomeActive), name:NSNotification.Name(Constants.NotificationObservers.APP_BECOME_ACTIVE.rawValue) , object: nil)

        checkLocationPermission()

        checkDriverStatus()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let mode = UIDevice.PowerModeState(isLowPowerModeEnabled: ProcessInfo.processInfo.isLowPowerModeEnabled)
        if mode == .lowPower{
            openLocationSettingsForLowPower()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
       func checkLocationPermission(){
           if CLLocationManager.locationServicesEnabled() {
               switch CLLocationManager.authorizationStatus() {
               case .notDetermined, .restricted,.denied :
                   self.openLocationSettings()
               case .authorizedWhenInUse:
                   self.openLocationSettings()
               case .authorizedAlways:
                   self.setupUserCurrentLocation()
                   self.loadGoogleMapLayer()
               @unknown default:
                   openLocationSettings()
               }
           } else {
               print("Location services are not enabled")
           }
       }
    
    
   
    
    
    
    func openLocationSettings(){
        UtilityManager.manager.showAlertWithAction(self, message: "Please enable location services to 'Always' to use app.", title: "Allow Location services", buttons: ["Go to Settings"]) { index in
            if let bundleId = Bundle.main.bundleIdentifier,
               let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    func openLocationSettingsForLowPower(){
       
        UtilityManager.manager.showAlert(self, message: "Please turn off Low power mode for better performance.", title: "Low Power Mode")
    }
    
    func stopTimerLocation(){
        if apiTimer != nil{
            apiTimer?.invalidate()
            apiTimer = nil
        }
    }
    
    func stopTimer(){
        if timer != nil{
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    //SOCKET
    
    
//    func setupSocket() {
//        self.socket = manager.defaultSocket
//    }
    
//    func stop() {
//        socket?.removeAllHandlers()
//        isConnectedToSocket = false
//    }
    
    func addSocketListerForRide() {
        socket!.on("\(UtilityManager.manager.getId())-driverStatus") { (data, ack) in
            self.view.makeToast("ride status updated", duration: 1.0, position: .bottom)
            guard let dataInfo = data.first as? [String:Any] else { return }
            
             if dataInfo["data"] as? [String:Any] != nil{
                 self.booking = BookingInfo.getRideInfo(dict: dataInfo["data"] as! [String:Any])
                 
                 UtilityManager.manager.saveDriverStatus(status: 2)
                 DispatchQueue.main.async(execute: {
                     self.updateStatusUI()
                 })
             }else{
                 if dataInfo["message"] as? String != nil{
                     UtilityManager.manager.showAlert(self, message: dataInfo["message"] as? String ?? "error getting booking record", title: Constants.APP_NAME)
                 }
             }
            
            
        }
        
        
            
    }
    
    
    func addSocketListnerForLocation(){
        socket!.on("\(UtilityManager.manager.getId())-driverCoordinate") { (data, ack) in
            self.view.makeToast("Location Updated", duration: 1.0, position: .bottom)
            guard let dataInfo = data.first else { return }
        }
    }
    
    
    
    
    func emitLocation(location: CLLocation) {
        
        let locationDict = ["latitude":location.coordinate.latitude,"longitude":location.coordinate.longitude,"area_name":"area_name","city":"city","bearing":90,"booking_id":self.booking?.id ?? 0,"user_id":UtilityManager.manager.getId()] as [String : Any]
        
        if socket?.status == .notConnected || socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
            emitLocation(location: location)
            return
        }
        
//        socket?.emit("point-to-point-tracking", locationDict)
        socket?.emit("point-to-point-tracking", locationDict, completion: {
            print("data added")
        })
       

    }
    
    func emitRideStatus(status:Int,finalDistance:Double? = nil,initialDistance:Double? = nil){
        
        if Constants.DEFAULT_LAT != nil && Constants.DEFAULT_LONG != nil{
            var rideDict:[String:Any]  = ["booking_id":self.booking?.id ?? 0,"driver_status":status,"user_id":UtilityManager.manager.getId(),"lat":Constants.DEFAULT_LAT!,"lng":Constants.DEFAULT_LONG!]
            
            if status == 3{
                if isService{
                    rideDict = ["booking_id":self.booking?.id ?? 0,"driver_status":status,"user_id":UtilityManager.manager.getId(),"lat":Constants.DEFAULT_LAT!,"lng":Constants.DEFAULT_LONG!]
                }else{
                    rideDict = ["booking_id":self.booking?.id ?? 0,"driver_status":status,"user_id":UtilityManager.manager.getId(),"total_distance":finalDistance ?? 0.0,"mobile_final_distance":finalDistance ?? 0.0,"mobile_initial_distance":initialDistance ?? 0.0,"lat":Constants.DEFAULT_LAT!,"lng":Constants.DEFAULT_LONG!]
                }
                
            }
            
            SHOW_CUSTOM_LOADER()
            
            socket?.emit(socketEvent, rideDict, completion: {
                HIDE_CUSTOM_LOADER()
            })
            
        }else{
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
        
    }
    
    
    func observeDriverLocation(){
       stopTimerLocation()
        if apiTimer == nil{
            switch UtilityManager.manager.getDriverStatus() {
            case 0:
                apiTimer = Timer.scheduledTimer(timeInterval: Constants.LOCATION_TIMER_DURATION_ONLINE, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
            case 1:
                apiTimer = Timer.scheduledTimer(timeInterval: Constants.LOCATION_TIMER_DURATION_ONLINE, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
            case 2:
                apiTimer = Timer.scheduledTimer(timeInterval: Constants.LOCATION_TIMER_DURATION_ONRIDE, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
            default:
                apiTimer = Timer.scheduledTimer(timeInterval: Constants.LOCATION_TIMER_DURATION_ONLINE, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
            }
            
        }
    }
    
    
    @objc func appBecomeActive(){
        checkDriverStatus()
        viewWillAppear(false)
    }
    
    @objc func appEnterBackGround(){
        if  apiTimer != nil {
            apiTimer?.invalidate()
            apiTimer = nil
        }
    }
    
    @objc func rideCancelByUser(notify:Notification){
        UtilityManager.manager.saveModelInUserDefaults(key: Constants.CURRENT_RIDE, data: nil)
//        self.backViewForPopup.isHidden = true
        self.viewRequest.isHidden = true
        self.viewMeetAt.isHidden = true
        self.mapView.clear()
        setCarMarker()
        checkDriverStatus()
        
        if apiTimer != nil{
            self.apiTimer?.invalidate()
            apiTimer = nil
        }
        
    }
    
    @objc func rideCancelByDriver(){
        
        DriverStatusManager.manager.UpdateStatus(status: 1) { [self] res, message in
            HIDE_CUSTOM_LOADER()
            if message == nil{
                UtilityManager.manager.saveDriverStatus(status: res ?? 1)
                updateStatusUI()
            }
        }
    }
    
    
    @objc func updateLocation(){
        
        if self.checkNetwork(){
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    @objc func ratingCompleted(){
        
        UtilityManager.manager.saveDriverStatus(status: 1)
        self.updateStatusUI()
        
    }
    
    @objc func rideDataReceived(notify:Notification){
        HIDE_CUSTOM_LOADER()
        if let info = notify.object as? BookingInfo{
            UserDefaults.standard.set(info.id, forKey: "booking_id")
            self.btnServiceDetail.isHidden = true
            setupRide(info: info)
        }else{
            let info = notify.object as? NewRide
            UserDefaults.standard.set(info?.booking_id, forKey: "booking_id")
            setupRide(info: BookingInfo().getBookingFromNewRide(r: info!))
        }
        
        
    }
   
    
    func setupRide(info:BookingInfo){
        self.booking = info
        lblPassengerName.text = booking?.passenger_first_name ?? "Towy User"
        btnPassengerRating.setTitle( "   " + (booking?.passenger_rating ?? "0.0") + "   ", for: .normal)
        HIDE_CUSTOM_LOADER()
        UtilityManager.manager.saveDriverStatus(status: 2)
        updateStatusUI()
        viewMeetAt.isHidden = false
        self.viewMeetAtBottomConstraint.constant = -20
        self.btnReachNearBy.isHidden = false
        self.btnChat.isHidden = false
        self.btnNavigation.isHidden = false
//                viewRequestBottom.constant = 0
        viewRequest.isHidden = false
        
        self.drawPolyline(CurrentCoordinate: CLLocationCoordinate2D(latitude: Constants.DEFAULT_LAT, longitude: Constants.DEFAULT_LONG), destinationcordinate: CLLocationCoordinate2D.init(latitude: Double(self.booking!.pick_up_latitude!) ?? 0.0, longitude: Double(self.booking!.pick_up_longitude!) ?? 0.0))
        
        setDestination(coordinates: CLLocationCoordinate2D.init(latitude: Double(self.booking!.pick_up_latitude!) ?? 0.0, longitude: Double(self.booking!.pick_up_longitude!) ?? 0.0))
        AppDelegate().setupGetificationInHome(manager: locationManager)
    }
    
    
    func checkDriverStatus(){
//        driver
        DriverStatusManager.manager.getCurrnetStatus { [self] b,u,err  in
            if err == nil{
                if b != nil{
                    self.booking = b!
                    lblPassengerName.text = booking?.passenger_first_name ?? "Towy User"
                    btnPassengerRating.setTitle( "   " + (booking?.passenger_rating ?? "0.0") + "   ", for: .normal)
                    if booking?.services != nil{
                        btnServiceDetail.isHidden = false
                        isService = true
                    }else{
                        btnServiceDetail.isHidden = true
                    }
                    UtilityManager.manager.saveDriverStatus(status: 2)
                }
                if u != nil{
                    UtilityManager.manager.saveDriverStatus(status: u?.availability_status ?? 0)
                }
                self.updateStatusUI()
            }else{
                if err == "Unauthenticated."{
                    UtilityManager.manager.clearUserData()
                    self.moveToLogin()
                }else{
                    UtilityManager.manager.showAlert(self, message: err ?? "error getting statue", title: Constants.APP_NAME)

                }
            }
        }
    }
    
    
    func loadGoogleMapLayer(){
        
        if Constants.DEFAULT_LONG != nil{
            if !isMapLoaded{
                let camera = GMSCameraPosition.camera(withLatitude:Constants.DEFAULT_LAT, longitude: Constants.DEFAULT_LONG, zoom: 14.0)
                
                let screenRect = UIScreen.main.bounds
                let screenWidth = screenRect.size.width
                let screenHeight = screenRect.size.height
                mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), camera: camera)
                mapView.delegate = self
                self.mapView.isMyLocationEnabled = false
                mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
                self.mainMapView.addSubview(mapView)
                isMapLoaded = true
            }
            self.setCarMarker()
        }
//        else{
//            checkLocationPermission()
//        }
        
       
        
    }
    
    func setupUserCurrentLocation()
    {
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.allowsBackgroundLocationUpdates = false
            locationManager.showsBackgroundLocationIndicator = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
        
        
        
    }
    
    func setCarMarker(){
        let coordinates = CLLocationCoordinate2D(latitude: Constants.DEFAULT_LAT, longitude: Constants.DEFAULT_LONG)
        
        DispatchQueue.main.async {
            CATransaction.begin()
            self.driverMarker.position = coordinates
            
            //            let image = UIImage(named:UtilityManager.manager.getVehicleImageName())!.withRenderingMode(.alwaysOriginal)
            let image = UIImage(named:"carRed")
            let markerView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            markerView.image = image
            self.driverMarker.iconView = markerView
            self.driverMarker.icon = image
            self.driverMarker.map = self.mapView
            self.driverMarker.appearAnimation = .pop
            CATransaction.setAnimationDuration(0.01)
            CATransaction.commit()
        }
        
    }
    
    
    func setDestination(coordinates:CLLocationCoordinate2D){
        
        
        
        DispatchQueue.main.async {
            CATransaction.begin()
            let destination = GMSMarker()
            destination.position = coordinates
            let image = UIImage(systemName: "square.fill")
            let markerView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            markerView.tintColor = .black
            markerView.image = image
            destination.iconView = markerView
            destination.icon = image
            destination.map = self.mapView
            destination.appearAnimation = .pop
            CATransaction.setAnimationDuration(0.01)
            CATransaction.commit()
        }
        
    }
    
    
    func cancelBooking(params:[String:Any]){
        SHOW_CUSTOM_LOADER()
        print("params",params)
        RideManager.manager.cancelBooking(params: params) { (data, err) in
            HIDE_CUSTOM_LOADER()
            if err == nil {
                print("data",data)
                UtilityManager.manager.setPoliLineStatus(isDrawn: false)
                UtilityManager.manager.saveModelInUserDefaults(key: Constants.CURRENT_RIDE, data: nil)
                UtilityManager.manager.saveDriverStatus(status: 1)
//                self.backViewForPopup.isHidden = true
                self.viewRequest.isHidden = true
                self.viewStartService.isHidden = true
                self.viewMeetAt.isHidden = true
                self.mapView.clear()
                self.setCarMarker()
                self.btnNavigation.isHidden = true
                self.btnChat.isHidden = true
                self.updateStatusUI()
//                self.GetDriverStatus()
            }else{
                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: err ?? "some thing went wrong")
            }
        }
    }
   
    
    
    @IBAction func servicesDetailsTapped(_ sender:UIButton){

        let vc = storyboard?.instantiateViewController(withIdentifier: "ServicesListViewController") as! ServicesListViewController
        vc.datasource = Service.getServiceArr(dict: booking?.services ?? [])
        vc.isDetails = true
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    @IBAction func cancelCancellingRide(_ sender:UIButton){
        self.viewTbl.isHidden = true
    }
    
    @IBAction func gotoNavigation(_ sender:UIButton){
        openGoogleMap()
    }
    
    
    @IBAction func reachNearByTapped(_ sender:UIButton){
        
        
        
        UtilityManager.manager.showAlertViewWithButtons(title: "Confirm your arrival", message: "Make Shure you have reach the location  ", buttons: ["Confirm","No"]) { [self] index in
            //API CALL
            if index == 0{
                
                if socket?.status == .connected{
                    self.emitRideStatus(status: 1)
                }else{
                    SocketIOManager.sharedInstance.establishConnection()
                    self.emitRideStatus(status: 1)
                }
                
                
                // this should be socket listen node
                
                UtilityManager.manager.saveWaitingStartTime(time: Date.init())
            }
            
        }
        
        
    }
    
    @IBAction func startServiceTapped(_ sender:UIButton){
       
        
        if socket?.status == .connected{
            self.emitRideStatus(status: 2)
        }else{
            SocketIOManager.sharedInstance.establishConnection()
            self.emitRideStatus(status: 2)
        }
        
    }
    
    @IBAction func endServiceBtnTapped(_ sender:UIButton){
       
        // Handle service here
        
     moveToPayable()
        
    }
    
    
    func emitStartService(_ sender:UIButton){
        
        
        
    }
    
    @IBAction func cancelServiceBtnTapped(_ sender:UIButton){
        
        UtilityManager.manager.showAlertViewWithButtons(title: "Are you sure?", message: "Cancelling before safe time could cause you a penalty", buttons: ["Confirm","Don't Cancel"]) { [self] index in
            //API CALL
            if index == 0{
                RideManager.manager.getCancelReasons { result, message in
                    if result != nil{
                        self.dataSource = result!
                        self.viewTbl.isHidden = false
                        self.tblReasons.reloadData()
                    }
                }
            }
            
        }
    }
    
    
    
    @IBAction func chatBtnTapped(_ sender:UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.booking = self.booking
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func changeStatus(_ sender:UIButton){
        
        if UtilityManager.manager.getDriverStatus() == 2{
            
            return
        }
        
        var status = 0
        
        if UtilityManager.manager.getDriverStatus() == 1{
            status = 0
        }else{
            status = 1
        }
        
        SHOW_CUSTOM_LOADER()
        DriverStatusManager.manager.UpdateStatus(status: status) { [self] res, message in
            HIDE_CUSTOM_LOADER()
            if message == nil{
                UtilityManager.manager.saveDriverStatus(status: res ?? 0)
                updateStatusUI()
            }
        }
        
    }
    
    
    @IBAction func menuTapped(_ sender:UIButton){
        self.backView.isHidden = false
        let sideMenuVc = storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        sideMenuVc.presentationStyle = .menuSlideIn
        let vc = sideMenuVc.viewControllers.first as! SideMenuViewController
        sideMenuVc.menuWidth = self.view.frame.width - 50
        vc.delegate = self
        
        self.present(sideMenuVc, animated: true, completion: {
        })
        
        
        
    }
    
    
    
    func openGoogleMap() {
        
        guard var latDouble = Constants.DEFAULT_LAT else{return}
        guard var longDouble = Constants.DEFAULT_LONG else{return}
        
        if isToDropOff != nil{
            if isToDropOff!{
                guard let lat = self.booking?.drop_off_latitude else {return }
                latDouble =  Double(lat) ?? 0.0
                guard let long = self.booking?.drop_off_longitude else {return }
                longDouble =  Double(long) ?? 0.0
            }else{
                guard let lat = self.booking?.pick_up_latitude else {return }
                latDouble =  Double(lat) ?? 0.0
                guard let long = self.booking?.pick_up_longitude else {return }
                longDouble =  Double(long) ?? 0.0
            }
        }
        
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.allowsBackgroundLocationUpdates = true
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            
            //            "http://maps.apple.com/?saddr=35.6813023,139.7640529&daddr=35.4657901,139.6201192"
            //        "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving"
            
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }else{
                
                if let urlDestination = URL.init(string: "http://maps.apple.com/?saddr=&daddr=\(latDouble),\(longDouble)") {
                    UIApplication.shared.open(urlDestination)
                }
            }
        }
        
    }
    
    func startWaitingTimer(){
        getStartTime()
        if WT != nil {
            WT.invalidate()
            WT = nil
            WT = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateWaitingTime), userInfo: nil, repeats: true)
        }else{
            WT = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateWaitingTime), userInfo: nil, repeats: true)
        }
    }
    func getStartTime(){
        self.waitingTime = Int(UtilityManager.manager.getTimerValue())
    }
    
    func updateStatusUI(){
        
        //        online,offline,onRide
        switch UtilityManager.manager.getDriverStatus(){
        case 0:
            UserDefaults.standard.removeObject(forKey: "booking_id")
            isToDropOff = nil
            self.btnStatus.setImage(UIImage.init(named: "offline"), for: .normal)
            self.viewStartService.isHidden = true
            self.btnChat.isHidden = true
            self.btnNavigation.isHidden = true
//            self.viewRequestBottom.constant = -500
            self.viewMeetAtBottomConstraint.constant = -100
//            self.viewTimerBottomConstraint.constant = -100
            stopTimerLocation()
            AppDelegate().stopMonitoringInHome()
            SocketIOManager.sharedInstance.closeConnection()
            
        case 1:
            UserDefaults.standard.removeObject(forKey: "booking_id")
            self.btnStatus.setImage(UIImage.init(named: "online"), for: .normal)
            self.viewStartService.isHidden = true
            self.btnChat.isHidden = true
            self.btnNavigation.isHidden = true
            self.viewMeetAtBottomConstraint.constant = -100
            self.observeDriverLocation()
            AppDelegate().stopMonitoringInHome()
            

        case 2:

            self.btnStatus.setImage(UIImage.init(named: "onRide"), for: .normal)
            getRideStatus()
//            self.observeDriverLocation()
//        case 3:
//            DriverStatusManager.manager.UpdateStatus(status: 1) { [self] res, message in
//                HIDE_CUSTOM_LOADER()
//                if message == nil{
//                    UtilityManager.manager.saveDriverStatus(status: res ?? 0)
//                    updateStatusUI()
//                }
//            }
        default:
            self.btnStatus.setImage(UIImage.init(named: "offline"), for: .normal)
        }
    }
    
    
    func getRideStatus(){
        if booking != nil{
            UserDefaults.standard.set(booking!.id, forKey: "booking_id")
            lblCustomerName.text = booking?.passenger_first_name ?? "Towy User"
            switch booking?.driver_status{
            case Constants.RideDriverStatus.ON_THE_WAY.rawValue:
                //UISETP

                isToDropOff = false
                viewMeetAt.isHidden = false
                self.viewMeetAtBottomConstraint.constant = -20
                self.btnReachNearBy.isHidden = false
                self.btnChat.isHidden = false
                self.btnNavigation.isHidden = false
                //                viewRequestBottom.constant = 0
                viewRequest.isHidden = false
                
                setDestination(coordinates: CLLocationCoordinate2D.init(latitude: Double(self.booking!.pick_up_latitude!) ?? 0.0, longitude: Double(self.booking!.pick_up_longitude!) ?? 0.0))
                if Constants.DEFAULT_LAT != nil{
                    self.drawPolyline(CurrentCoordinate: CLLocationCoordinate2D(latitude: Constants.DEFAULT_LAT, longitude: Constants.DEFAULT_LONG), destinationcordinate: CLLocationCoordinate2D.init(latitude: Double(self.booking!.pick_up_latitude!) ?? 0.0, longitude: Double(self.booking!.pick_up_longitude!) ?? 0.0))}
                HIDE_CUSTOM_LOADER()
                
            case Constants.RideDriverStatus.REACH_PICKUP.rawValue:
                
                btnNavigation.isHidden = true
                
                DispatchQueue.main.async { [self] in
                    self.startWaitingTimer()
                    //                    viewRequestBottom.constant = -500
                    viewRequest.isHidden = true
                    btnEndService.isHidden = true
                    btnStartService.isHidden = false
                    viewStartService.isHidden = false
                    viewMeetAt.isHidden = true
                    self.btnChat.isHidden = false
                    self.btnNavigation.isHidden = false
                    self.viewNameBottomConstraint.constant = 27
                    timerTopConstraint.constant = 25
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                        self.view.layoutSubviews()
                        self.view.layoutIfNeeded()
                    } completion:{_ in
                        
                    }
                    if isService{
                        btnStartService.setTitle("Start Service", for: .normal)
                    }
                    
                }
                
                
                HIDE_CUSTOM_LOADER()
                
                
            case Constants.RideDriverStatus.START.rawValue:
                //UISETP
                print("")
                if isService{
                    timerTopConstraint.constant = -40
                    viewStartService.isHidden = false
                    self.btnChat.isHidden = true
                    self.btnNavigation.isHidden = true
                    btnEndService.isHidden = false
                    btnStartService.isHidden = true
                    lblWaitingTime.isHidden = true
                    btnEndService.setTitle("Finish Service", for: .normal)
                    self.viewNameBottomConstraint.constant = -50
                    if WT != nil{
                        WT.invalidate()
                        WT = nil
                    }
                    
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                        self.view.layoutSubviews()
                        self.view.layoutIfNeeded()
                    } completion: { b in
                        
                    }
            }else{
                isToDropOff = true
                DispatchQueue.main.async { [self] in
                    setDestination(coordinates: CLLocationCoordinate2D.init(latitude: Double(self.booking!.drop_off_latitude!) ?? 0.0, longitude: Double(self.booking!.drop_off_longitude!) ?? 0.0))
                    self.drawPolyline(CurrentCoordinate: CLLocationCoordinate2D(latitude: Constants.DEFAULT_LAT, longitude: Constants.DEFAULT_LONG), destinationcordinate: CLLocationCoordinate2D.init(latitude: Double(self.booking!.drop_off_latitude!) ?? 0.0, longitude: Double(self.booking!.drop_off_longitude!) ?? 0.0))
                    timerTopConstraint.constant = -40
                    viewStartService.isHidden = false
                    self.btnChat.isHidden = false
                    self.btnNavigation.isHidden = false
                    btnEndService.isHidden = false
                    btnStartService.isHidden = true
                    lblWaitingTime.isHidden = true
                    self.viewNameBottomConstraint.constant = -50
                    if WT != nil{
                        WT.invalidate()
                        WT = nil
                    }
                    
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                        self.view.layoutSubviews()
                        self.view.layoutIfNeeded()
                    } completion: { b in
                        
                    }
                    
                    
                }
            }
                
                
                HIDE_CUSTOM_LOADER()
                
            case Constants.RideDriverStatus.COMPLETED.rawValue:
                //UISETP
                AppDelegate().stopMonitoringInHome()
                if self.booking?.is_driver_rating_given  ?? 0 == 0{
                    let vc = storyboard?.instantiateViewController(withIdentifier: "PayableViewController") as! PayableViewController
                    vc.booking = self.booking
                    vc.modalPresentationStyle = .fullScreen
                    vc.delegate = self
                    self.present(vc, animated: true)
                }
                HIDE_CUSTOM_LOADER()
            case Constants.RideDriverStatus.FARE_COLLECTED.rawValue:
                //UISETP
                AppDelegate().stopMonitoringInHome()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RateAndReviewViewController") as! RateAndReviewViewController
                vc.booking = self.booking
                vc.delegate = self
                HIDE_CUSTOM_LOADER()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("")
            }
        }else{
            HIDE_CUSTOM_LOADER()
        }
       
    }
    
    
    @objc func updateWaitingTime(){
        waitingTime! += 1
        lblWaitingTime.isHidden = false
        lblWaitingTime.text = "Waiting Time : " + timeString(time: TimeInterval(waitingTime!))
    }
    
    
    func moveToPayable(){
        
        var afterStart:Double =  0
        var beforeStart:Double =  0
        var watingTime:Double =  0
        var totalDistance:Double = 0
        
        var locations = RideManager.manager.getPreviousLocations(sorted: true)
        if locations != []{
            locations = UtilityManager.manager.removeDuplicateElements(posts: locations)
            for i in 0..<locations.count-1{
                let obj = locations[i]
                let obj1 = locations[i+1]
//                let start:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: obj.lat, longitude: obj.lng)
//                let end:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: obj1.lat, longitude: obj1.lng)
                let distance = UtilityManager.manager.p2pDistance(from: obj, to: obj1)
                switch obj.driver_status {
                case 0:
                    totalDistance += distance
                    beforeStart += distance
                case 1:
                    totalDistance += distance
                    watingTime += distance
                case 2:
                    totalDistance += distance
                    afterStart += distance
                default:
                    print("")
                }
            }
        }
        
        if UtilityManager.manager.getFareFromUSD() != nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PayableViewController") as! PayableViewController
            vc.delegate = self
            vc.fare = UtilityManager.manager.getFareFromUSD() ?? 0.0
            vc.distance = UtilityManager.manager.getDistnaceFromUSD() ?? 0.0
            vc.totaldistance = totalDistance
            vc.time = UtilityManager.manager.getTimeFromUSD() ?? "00:00"
            vc.des = UtilityManager.manager.getDescriptionFromUSD() ?? ""
            vc.bookingId = UtilityManager.manager.getBookingIdFromUSD() ?? ""
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else{
            
//            let b = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE)
            if let booking_Id =  self.booking?.id {
                
                
//                let params = ["booking_id":"\(booking_Id)","driver_status":3,"ride_locations": [
//                    "coordinates": [],
//                    "total_distance_after_started": afterStart,
//                    "total_distance_before_reached": beforeStart,
//                    "total_distance_during_wait": watingTime,
//                    "total_distance_traveled": totalDistance
//                ]] as [String : Any]
//                
//                let data =  ["total_distance":totalDistance,"mobile_final_distance":totalDistance,"mobile_initial_distance":beforeStart]
//                
                
                
                if socket?.status == .connected{
                    self.emitRideStatus(status: 3,finalDistance: totalDistance,initialDistance: beforeStart)
                }else{
                    SocketIOManager.sharedInstance.establishConnection()
                    self.emitRideStatus(status: 3,finalDistance: totalDistance,initialDistance: beforeStart)

                }
                
                
                //                ,"total_distance_after_started":afterStart,"total_distance_before_reached":beforeStart,"total_distance_during_wait":watingTime,"total_distance_traveled":totalDistance
//                RideManager.manager.getFinalFare(params:params) { (data, err) in
//                    if err == nil{
//                        if self.apiTimer != nil{
//                            self.apiTimer?.invalidate()
//                            self.apiTimer = nil
//                        }
//                        let bookingInfo = data?["bookingInfo"] as? [String:Any]
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PayableViewController") as! PayableViewController
//                        vc.delegate = self
//                        let amountData = data?["amountData"] as? [String:Any]
//                        vc.fare = amountData?["rideFinalAmount"] as? Double ?? 0.0
//                        vc.distance = amountData?["rideFinalDistance"] as? Double ?? 0.0
//                        vc.time = amountData?["rideFinalTime"] as? String ?? "00:00"
//                        vc.des = amountData?["rideDescription"] as? String ?? ""
//                        vc.bookingId = bookingInfo?["booking_unique_id"] as? String ?? ""
//                        UtilityManager.manager.saveBookingIdInUSD(fare:bookingInfo?["booking_unique_id"] as? String ?? "")
//                        UtilityManager.manager.saveDescriptionInUSD(fare:amountData?["rideDescription"] as? String ?? "")
//                        UtilityManager.manager.saveFareInUSD(fare:amountData?["rideFinalAmount"] as? Double ?? 0.0)
//                        UtilityManager.manager.saveDistanceInUSD(fare:amountData?["rideFinalDistance"] as? Double ?? 0.0)
//                        UtilityManager.manager.saveTimeInUSD(fare:amountData?["rideFinalTime"] as? String ?? "00:00")
//                        vc.totaldistance = totalDistance
//                        vc.modalPresentationStyle = .fullScreen
//                        self.present(vc, animated: true, completion: nil)
//                    }else{
//                        UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: err ?? "something went wrong.")
//                    }
//                }
            }
        }
        
    }
    
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        if hours == 0 && minutes < 10 {
            
            self.lblWaitingTime.textColor = UIColor.red
            self.btnCancelRideOnReach.layer.borderColor = UIColor.red.cgColor
            self.btnCancelRideOnReach.setTitleColor(UIColor.red, for: .normal)
            
        }else{
            
            self.lblWaitingTime.textColor = UIColor.systemGreen
            self.btnCancelRideOnReach.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)?.cgColor
            self.btnCancelRideOnReach.setTitleColor(UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue), for: .normal)
        }
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func showDummyRequest(){

//        viewRequestBottom.constant = 0
//        viewTimerBottomConstraint.constant = -25
//        btnReachNearBy.isHidden = true
//        btnReject.isHidden = false
//        viewSlider.isHidden = false
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
//            self.view.layoutSubviews()
//            self.view.layoutIfNeeded()
//        } completion: { _ in
//            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateViewTimer), userInfo: nil, repeats: true)
//
//        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewRideRequestViewController") as! NewRideRequestViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    func menuTapped(TappedMenu: Menu) {
        self.backView.isHidden = true
        switch TappedMenu {
            //        case .REWARD:
            //            self.backView.isHidden = true
            //            UtilityManager.manager.navigateToVc(from: self, identifier: "RewardsViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
        case .HELP:
            self.backView.isHidden = true
            UtilityManager.manager.navigateToVc(from: self, identifier: "HelpViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
        case .SETTINGS :
            self.backView.isHidden = true
            UtilityManager.manager.navigateToVc(from: self, identifier: "SettingViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
            //        case .MESSAGE :
            //            self.backView.isHidden = true
            //            UtilityManager.manager.navigateToVc(from: self, identifier: "MessagesViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
            //        case .REFERRAL :
            //            self.backView.isHidden = true
            //            UtilityManager.manager.navigateToVc(from: self, identifier: "ReferralViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
        case .CAPTAIL_PORTAL :
            self.backView.isHidden = true
            UtilityManager.manager.navigateToVc(from: self, identifier: "DriverPortalViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
        case .LOGOUT :
            self.backView.isHidden = true
            if UtilityManager.manager.getDriverStatus() == 2{
                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: "You Can't logout while connected with customer.")
            }else{
                logoutUser()
            }
            
            
        default:
            print("")
        }
    }
    
    func hide() {
        self.backView.isHidden = true
    }
    
    
    func logoutUser(){
        LogoutManager.manager.LogoutUser { data, err in
            if err == nil{
                UtilityManager.manager.clearUserData()
                self.moveToLogin()
            }else{
                UtilityManager.manager.showAlert(self, message: err ?? "error login", title: Constants.APP_NAME)
            }
        }
    }
    
    func moveToLogin(){
        self.backView.isHidden = true
        UserDefaults.standard.set(false, forKey: Constants.IS_LOGIN)
        let story = UtilityManager.manager.getAuthStoryboard()
        let vc = story.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func drawPolyline(CurrentCoordinate : CLLocationCoordinate2D, destinationcordinate :CLLocationCoordinate2D)
    {
        self.mapView.clear()
        let str = String(format:"https://maps.googleapis.com/maps/api/directions/json?origin=\(CurrentCoordinate.latitude),\(CurrentCoordinate.longitude)&destination=\(destinationcordinate.latitude),\(destinationcordinate.longitude)&key=\(Constants.GOOGLE_APIKEY)")
        Alamofire.request(str).responseJSON { (responseObject) -> Void in
            let resJson = JSON(responseObject.result.value!)
            
            let routes : NSArray = resJson["routes"].rawValue as! NSArray
            if(resJson["status"].rawString()! == "ZERO_RESULTS"){}
            else if(resJson["status"].rawString()! == "NOT_FOUND"){}
            else if routes.count == 0{}
            else{
                let routes : NSArray = resJson["routes"].rawValue as! NSArray
                
                let pathv : NSArray = routes.value(forKey: "overview_polyline") as! NSArray
                let paths : NSArray = pathv.value(forKey: "points") as! NSArray
                let newPath = GMSPath.init(fromEncodedPath: paths[0] as! String)
                
                let polyLine = GMSPolyline(path: newPath)
                
                polyLine.strokeWidth = 4
                polyLine.strokeColor =  .black
                let ThemeOrange = GMSStrokeStyle.solidColor(UIColor.black)
                let OrangeToBlue = GMSStrokeStyle.gradient(from:  UIColor.black, to:  UIColor.black)
                polyLine.spans = [GMSStyleSpan(style: ThemeOrange),
                                  GMSStyleSpan(style: ThemeOrange),
                                  GMSStyleSpan(style: OrangeToBlue)]
                polyLine.map = self.mapView
                self.setCarMarker()
                let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: CurrentCoordinate, coordinate: destinationcordinate))
                DispatchQueue.main.async {
                    self.mapView.moveCamera(cameraUpdate)
                    let currentZoom = self.mapView.camera.zoom
                    self.mapView.animate(toZoom: currentZoom - 1.4)
                }
                
                
            }
        }
    }
    
    
}

extension DashBoardViewController:CLLocationManagerDelegate{
    // MARK: CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        guard let currentLocation:CLLocation = manager.location else{
            self.locationManager.stopUpdatingLocation()
            return}
        Constants.DEFAULT_LAT = currentLocation.coordinate.latitude
        Constants.DEFAULT_LONG = currentLocation.coordinate.longitude
        emitLocation(location: currentLocation)
        if !isMapLoaded{
            loadGoogleMapLayer()
        }
//        self.current_lat = currentLocation.coordinate.latitude
//        self.current_lang = currentLocation.coordinate.longitude
        //        if UtilityManager.manager.getDriverStatus() != 2{
        
        //        }
        //        print( "LOCSTION",Constants.DEFAULT_LAT!,Constants.DEFAULT_LONG!)
//        getAddressFromLatLong(latitude: current_lat ?? Constants.DEFAULT_LAT, longitude: current_lang ?? Constants.DEFAULT_LONG)
        //        if UtilityManager.manager.getDriverStatus() == 2{
        //            self.resetCamera()}
        self.locationManager.stopUpdatingLocation()
        
    }
}



extension DashBoardViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextWithCheckboxTableViewCell", for: indexPath) as! TextWithCheckboxTableViewCell
        return cell.setData(data: dataSource[indexPath.row]) ?? UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cel = tableView.cellForRow(at: indexPath) as! TextWithCheckboxTableViewCell
        SHOW_CUSTOM_LOADER()
        self.viewTbl.isHidden = true
        cel.data = dataSource[indexPath.row]
        _ = cel.changeStatus()
//            print("BookingInfo",bookinginfo)
            self.stopTimerLocation()
            
//            self.getMessages { b in

            self.cancelBooking(params: ["cancel_reason_id":self.dataSource[indexPath.row].id ?? 0,"booking_id":booking?.id ?? 0,"other_reason":self.dataSource[indexPath.row].text ?? "chal oye","chat_messages": ""])
//            }
       
    }
}

extension DashBoardViewController:RatingDelegate{
    func didRatePassenger() {
        
        checkDriverStatus()
        self.mapView.clear()
        self.setCarMarker()
    }
    
    func didCancelRating() {
        print("rating cancelled.")
    }
}

extension DashBoardViewController:RideCompletionDelegate{
    
    
    func didFinishRide() {
        SHOW_CUSTOM_LOADER()
        self.emitRideStatus(status: 4)
        HIDE_CUSTOM_LOADER()
    }
    
    func didCancel() {
        print("cancel finishing ride")
    }
}
