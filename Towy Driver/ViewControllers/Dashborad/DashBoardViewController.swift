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

class DashBoardViewController: UIViewController, MenuDelegate, GMSMapViewDelegate {
    
    
    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var mainMapView:UIView!
//    @IBOutlet weak var viewDistance:UIImageView!
//    @IBOutlet weak var radiusSlider:UISlider!
    @IBOutlet weak var lblCustomerName:UILabel!
    @IBOutlet weak var viewTbl:UIView!

    @IBOutlet weak var tblReasons:UITableView!
    @IBOutlet weak var btnChat:UIButton!
    @IBOutlet weak var viewMeetAt:UIView!
    @IBOutlet weak var viewStartService:UIView!
    @IBOutlet weak var viewRequest:UIView!

    
//    @IBOutlet weak var viewTimerBottomConstraint:NSLayoutConstraint!
    @IBOutlet weak var viewMeetAtBottomConstraint:NSLayoutConstraint!
//    @IBOutlet weak var viewRequestBottom:NSLayoutConstraint!
//    @IBOutlet weak var viewRedTrailing:NSLayoutConstraint!
    @IBOutlet weak var btnReachNearBy:UIButton!
    @IBOutlet weak var btnStatus:UIButton!
    @IBOutlet weak var lblWaitingTime:UILabel!
    @IBOutlet weak var btnStartService:UIButton!
    @IBOutlet weak var btnEndService:UIButton!
    
    
    @IBOutlet weak var btnCancelRideOnReach:UIButton!
    
    
    var dataSource = [Precaution]()
    
    var apiTimer:Timer?
    var WT:Timer!
    var timer:Timer? = Timer()
    var totalTime = 10
    var time = 0
    var driverMarker = GMSMarker()
    var booking : BookingInfo? = nil
    var locationManager = CLLocationManager()
    var mapView:GMSMapView = GMSMapView()
    var waitingTime:Int? = 0
    var isServing = false
    var newBookingInfo:BookingInfo? = nil
    
//    var socket: SocketIOClient? = nil
    
    var isConnectedToSocket = false
    
    let socket = SocketIOManager.sharedInstance.socket
//    let manager = SocketManager(socketURL: URL(string: Constants.SOCKET_ROOT)!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewRequestBottom.constant = -500
        
        if socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
        }
    
        socket!.on("driver-change-booking-driver-status") { (data, ack) in
            guard let dataInfo = data.first else { return }
        }
        
        tblReasons.delegate = self
        tblReasons.dataSource = self
        tblReasons.register(UINib.init(nibName: "TextWithCheckboxTableViewCell", bundle: .main), forCellReuseIdentifier: "TextWithCheckboxTableViewCell")
        
        checkDriverStatus()
        
        
        viewStartService.CurveViewsTop(corner: 30)
        btnChat.isHidden = true
        
//        booking = NewRide.init(vehicle_amount: 2, amount: 300, driver_id: 2, pickup_longitude: "71.34342", temp_id: 23, passenger_id: 213, vehicle_type: "2", oyla_pay: "jb", dropoff_latitude: "31.343", user_id: "12", distance_kilomiters: 2.33, pickup_latitude: "31.34343", estimate_minutes: "10", dropoff_longitude: "71.3434", booking_id: 223, driver_status: 2, ride_complete_time: 23, estimated_amount: 23, final_amount: 2300, oyla_wallet_pay: 0, descriptions: "kjdbjsdkbfjks", booking_unique_id: "dsfdsf", booking_changes: 0, payment_type: "CASH", pre_book: false, peak_factor_rate: "1.2", passenger_name: "Mursha_PAK", passenger_ratings: 4.5, passenger_profile_pic: "jjk", status: 1, passenger_mobile_no: 034566666666, is_skip_dropoff: 1, distance_radius: 30)
        //    let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
        //    let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
        //    viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x, y: radiusSlider.frame.origin.y)
      
        
        NotificationCenter.default.addObserver(self, selector: #selector(ratingCompleted), name:NSNotification.Name( Constants.NotificationObservers.DRIVER_RATED_THE_CUSTOMER.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rideDataReceived(notify:)), name:NSNotification.Name( Constants.NotificationObservers.RIDE_ACCEPTED.rawValue), object: nil)
        
       
//        UtilityManager.manager.saveDriverStatus(status: 1)
       
        setupUserCurrentLocation()
        //        isAddViewed = false
        Constants.DEFAULT_LAT = 31.458158
        Constants.DEFAULT_LONG = 74.350235
        if Constants.DEFAULT_LAT != nil && Constants.DEFAULT_LONG != nil{
            self.loadGoogleMapLayer()
            setCarMarker()
        }
        
//        self.updateStatusUI()
//        apiTimer = Timer.scheduledTimer(timeInterval: Constants.LOCATION_TIMER_DURATION_ONLINE, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
//            self.showDummyRequest()
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
//        let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
//        viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x+15.5 , y: radiusSlider.frame.origin.y+15.5)
        //        UtilityManager.manager.showAlertView(title: "Hey", message: "ldjfbdsjk", VC: self)
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
    
    func setupSocketEvents() {
        
        socket!.on(clientEvent: .connect) {data, ack in
            self.isConnectedToSocket = true

        }
        
        
        socket!.on(clientEvent: .ping, callback: { data,ack in
        print("ping")
        
        })
        
        socket!.on(clientEvent: .pong, callback: {data,ack in
        print("pong")
        
        })
        
        
        socket!.on("driver-change-booking-driver-status") { (data, ack) in
            guard let dataInfo = data.first else { return }
            //               if let response: SocketPosition = try? SocketParser.convert(data: dataInfo) {
            //                   let position = CGPoint.init(x: response.x, y: response.y)
            //                   self.delegate?.didReceive(point: position)
            //               }
        }
        
        socket!.on("point-to-point-tracking") { (data, ack) in
            guard let dataInfo = data.first else { return }
            //               if let response: SocketPosition = try? SocketParser.convert(data: dataInfo) {
            //                   let position = CGPoint.init(x: response.x, y: response.y)
            //                   self.delegate?.didReceive(point: position)
            //               }
        }
        
    }
    
    
    
    
    
    
    func emitLocation(location: CLLocation) {
        
        let locationDict = ["latitude":location.coordinate.latitude,"longitude":location.coordinate.longitude,"area_name":"area_name","city":"city","bearing":90,"booking_id":0,"user_id":UtilityManager.manager.getId()] as [String : Any]
        
        if socket?.status == .notConnected || socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
            emitLocation(location: location)
        }
        
//        socket?.emit("point-to-point-tracking", locationDict)
        socket?.emit("point-to-point-tracking", locationDict, completion: {
            print("data added")
        })
        self.view.makeToast("Location Updated", duration: 1.0, position: .bottom)

    }
    
    func emitReachNearBy(){
        
        let locationDict  = ["booking_id":self.booking?.id,"driver_status":1,"user_id":UtilityManager.manager.getId()]
        
//        socket?.emit("point-to-point-tracking", locationDict)
        socket?.emit("driver-change-booking-driver-status", locationDict, completion: {
            print("data added")
        })
        self.view.makeToast("reached pickup", duration: 1.0, position: .bottom)
        
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
        let info = notify.object as! BookingInfo
        setupRide(info: info)
        
    }
   
    
    func setupRide(info:BookingInfo){
        self.newBookingInfo = info
//        setupUserCurrentLocation()
        UtilityManager.manager.saveModelInUserDefaults(key: Constants.CURRENT_RIDE, data: BookingInfo.getBookinDict(r: info))
        if info.pick_up_latitude != nil && info.pick_up_longitude != nil{
            self.locationManager.startUpdatingHeading()
            self.locationManager.startUpdatingLocation()
//            UtilityManager.manager.saveDriverStatus(status: 2)
//            GetDriverStatus()
//            UtilityManager.manager.setPoliLineStatus(isDrawn: false)
//            self.isToDropOff = false
//            self.viewRideActions.isHidden = false
//            updateStatusUI()
            HIDE_CUSTOM_LOADER()
            checkDriverStatus()
//            observeDriverLocation()
        }
        
    }
    
    
    func checkDriverStatus(){
//        driver
        DriverStatusManager.manager.getCurrnetStatus { b,u,err  in
            if err == nil{
                if b != nil{
                    self.booking = b!
                    UtilityManager.manager.saveDriverStatus(status: 2)
                }
                if u != nil{
                    UtilityManager.manager.saveDriverStatus(status: u?.availability_status ?? 0)
                }
                self.updateStatusUI()
            }else{
                UtilityManager.manager.showAlert(self, message: err ?? "error getting statue", title: Constants.APP_NAME)
            }
        }
    }
    
    func checkRideStatus(){
        
    }
    
    
    func loadGoogleMapLayer()
    {
        
        let camera = GMSCameraPosition.camera(withLatitude:Constants.DEFAULT_LAT, longitude: Constants.DEFAULT_LONG, zoom: 14.0)
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), camera: camera)
        mapView.delegate = self
        self.mapView.isMyLocationEnabled = false
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        
        //        self.lblMarker?.isHidden = true
        //        self.bearing = "\(camera.bearing)"
        self.mainMapView.addSubview(mapView)
        setupUserCurrentLocation()
        
    }
    
    func setupUserCurrentLocation()
    {
        checkLocationPermission()
        locationManagerInitilize()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        
    }
    
    
    func checkLocationPermission(){
        var status:CLAuthorizationStatus!
        if #available(iOS 14.0, *) {
            status = CLLocationManager().authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            return
            
        case .denied, .restricted:
            
            UtilityManager.manager.showAlertWithAction(self, message: Constants.LOCATION_PERMISSION, title: Constants.APP_NAME, buttons: ["Enable","Cancel"]) { index in
                if index == 0{
                    if let BUNDLE_IDENTIFIER = Bundle.main.bundleIdentifier,
                       let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(BUNDLE_IDENTIFIER)") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location permission is granted")
            
        default:
            print("unknow staus")
        }
    }
    
    
    func locationManagerInitilize(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.allowsBackgroundLocationUpdates = false
            locationManager.showsBackgroundLocationIndicator = true
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            if #available(iOS 14.0, *) {
                locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "Tracking")
            } else {
                // Fallback on earlier versions
            }
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
//                self.viewfinishRide.isHidden = true
//                self.viewStartRide.isHidden = true
//                self.viewReasons.isHidden = true
                self.updateStatusUI()
                self.mapView.clear()
                self.setCarMarker()
//                self.GetDriverStatus()
            }else{
                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: err ?? "some thing went wrong")
            }
        }
    }
    
    @IBAction func reachNearByTapped(_ sender:UIButton){
        
        
        
        UtilityManager.manager.showAlertViewWithButtons(title: "Confirm your arrival", message: "Make Shure you have reach the location  ", buttons: ["Confirm","No"]) { [self] index in
            //API CALL
            if index == 0{
                
                if socket?.status == .connected{
                    self.emitReachNearBy()
                }else{
                    SocketIOManager.sharedInstance.establishConnection()
                    self.emitReachNearBy()
                }
                
                
                // this should be socket listen node
                
                UtilityManager.manager.saveWaitingStartTime(time: Date.init())
                self.startWaitingTimer()
                viewRequest.isHidden = true
                btnEndService.isHidden = true
                viewStartService.isHidden = false
                viewMeetAt.isHidden = true
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                    self.view.layoutSubviews()
                    self.view.layoutIfNeeded()
                } completion: { _ in
    //                viewRequestBottom.constant = -500
                }
            }
            
        }
        
        
    }
    
    @IBAction func startServiceTapped(_ sender:UIButton){
        btnEndService.isHidden = false
        btnStartService.isHidden = true
        lblWaitingTime.isHidden = true
        btnChat.isHidden = true
        if WT != nil{
            WT.invalidate()
            WT = nil
        }
    }
    
    @IBAction func endServiceBtnTapped(_ sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "RateAndReviewViewController") as! RateAndReviewViewController
        //        vc.booking = self.booking
        self.navigationController?.pushViewController(vc, animated: true)
        
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
            self.btnStatus.setImage(UIImage.init(named: "offline"), for: .normal)
            self.viewStartService.isHidden = true
            self.btnChat.isHidden = true
//            self.viewRequestBottom.constant = -500
            self.viewMeetAtBottomConstraint.constant = -100
//            self.viewTimerBottomConstraint.constant = -100
            stopTimerLocation()
            SocketIOManager.sharedInstance.closeConnection()
            
        case 1:
            self.btnStatus.setImage(UIImage.init(named: "online"), for: .normal)
            self.viewStartService.isHidden = true
            self.btnChat.isHidden = true
            self.viewMeetAtBottomConstraint.constant = -100
            self.observeDriverLocation()
            

        case 2:
            self.btnStatus.setImage(UIImage.init(named: "onRide"), for: .normal)
            getRideStatus()
            self.observeDriverLocation()
        case 3:
            DriverStatusManager.manager.UpdateStatus(status: 1) { [self] res, message in
                HIDE_CUSTOM_LOADER()
                if message == nil{
                    UtilityManager.manager.saveDriverStatus(status: res ?? 0)
                    updateStatusUI()
                }
            }
        default:
            self.btnStatus.setImage(UIImage.init(named: "offline"), for: .normal)
        }
    }
    
    
    func getRideStatus(){
        
        if booking != nil{
            lblCustomerName.text = booking?.passenger_first_name ?? "Customer Name"
            switch booking?.driver_status{
            case Constants.RideDriverStatus.ON_THE_WAY.rawValue:
                //UISETP
                viewMeetAt.isHidden = false
                self.viewMeetAtBottomConstraint.constant = -25
                self.btnReachNearBy.isHidden = false
                self.btnChat.isHidden = false
//                viewRequestBottom.constant = 0
                viewRequest.isHidden = false
                
            case Constants.RideDriverStatus.REACH_PICKUP.rawValue:
                

                DispatchQueue.main.async { [self] in
                    self.startWaitingTimer()
//                    viewRequestBottom.constant = -500
                    viewRequest.isHidden = true
                    btnEndService.isHidden = true
                    viewStartService.isHidden = false
                    viewMeetAt.isHidden = true
                    self.btnChat.isHidden = false

                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                                self.view.layoutSubviews()
                                self.view.layoutIfNeeded()
                    } completion:{_ in
                        
                    }
                }
                
                
                
            case Constants.RideDriverStatus.START.rawValue:
                //UISETP
                print("")
                self.btnChat.isHidden = false
            case Constants.RideDriverStatus.COMPLETED.rawValue:
                //UISETP
                print("")
            case Constants.RideDriverStatus.FARE_COLLECTED.rawValue:
                //UISETP
                print("")
            default:
                print("")
            }
        }
       
    }
    
    
    @objc func updateWaitingTime(){
        waitingTime! += 1
        lblWaitingTime.isHidden = false
        lblWaitingTime.text = "Waiting Time : " + timeString(time: TimeInterval(waitingTime!))
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
            //        case .HELP:
            //            self.backView.isHidden = true
            //            UtilityManager.manager.navigateToVc(from: self, identifier: "HelpViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
            //        case .SETTINGS :
            //            self.backView.isHidden = true
            //            UtilityManager.manager.navigateToVc(from: self, identifier: "SettingViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
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
            logoutUser()
            
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
    
}

extension DashBoardViewController:CLLocationManagerDelegate{
    // MARK: CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let currentLocation:CLLocation = manager.location else{
            self.locationManager.stopUpdatingLocation()
            return}
        emitLocation(location: currentLocation)
//        self.current_lat = currentLocation.coordinate.latitude
//        self.current_lang = currentLocation.coordinate.longitude
        //        if UtilityManager.manager.getDriverStatus() != 2{
        Constants.DEFAULT_LAT = currentLocation.coordinate.latitude
        Constants.DEFAULT_LONG = currentLocation.coordinate.longitude
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
        if let bookinginfo = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE){
//            print("BookingInfo",bookinginfo)
            let bookingModel = BookingInfo.getRideInfo(dict: bookinginfo)
            self.stopTimerLocation()
            
//            self.getMessages { b in

            self.cancelBooking(params: ["cancel_reason_id":self.dataSource[indexPath.row].id ?? 0,"booking_id":49,"other_reason":self.dataSource[indexPath.row].text ?? "chal oye","chat_messages": ""])
//            }
            
            
        }else{
            print("misssing booking info")
        }
    }
}
