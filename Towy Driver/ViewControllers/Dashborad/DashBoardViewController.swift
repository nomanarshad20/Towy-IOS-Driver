//
//  DashBoardViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 02/08/2022.
//

import UIKit
import SideMenu
import GoogleMaps

class DashBoardViewController: UIViewController, MenuDelegate, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    
   
    
    
    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var mainMapView:UIView!
    @IBOutlet weak var viewDistance:UIImageView!
    @IBOutlet weak var radiusSlider:UISlider!
    @IBOutlet weak var lblSliderTitle:UILabel!
    @IBOutlet weak var btnReject:UIButton!
    @IBOutlet weak var btnChat:UIButton!
    @IBOutlet weak var viewSlider:UIView!
    @IBOutlet weak var viewTimerBottomConstraint:NSLayoutConstraint!
    @IBOutlet weak var viewMeetAtBottomConstraint:NSLayoutConstraint!
    @IBOutlet weak var viewRequestBottom:NSLayoutConstraint!
    @IBOutlet weak var viewRedTrailing:NSLayoutConstraint!
    @IBOutlet weak var btnReachNearBy:UIButton!
    
    var timer = Timer()
    var totalTime = 10
    var time = 0
    var driverMarker = GMSMarker()
    var booking = NewRide()
    var locationManager = CLLocationManager()
    var mapView:GMSMapView = GMSMapView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnChat.isHidden = true
        booking = NewRide.init(vehicle_amount: 2, amount: 300, driver_id: 2, pickup_longitude: "71.34342", temp_id: 23, passenger_id: 213, vehicle_type: "2", oyla_pay: "jb", dropoff_latitude: "31.343", user_id: "12", distance_kilomiters: 2.33, pickup_latitude: "31.34343", estimate_minutes: "10", dropoff_longitude: "71.3434", booking_id: 223, driver_status: 2, ride_complete_time: 23, estimated_amount: 23, final_amount: 2300, oyla_wallet_pay: 0, descriptions: "kjdbjsdkbfjks", booking_unique_id: "dsfdsf", booking_changes: 0, payment_type: "CASH", pre_book: false, peak_factor_rate: "1.2", passenger_name: "Mursha_PAK", passenger_ratings: 4.5, passenger_profile_pic: "jjk", status: 1, passenger_mobile_no: 034566666666, is_skip_dropoff: 1, distance_radius: 30)
        //    let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
        //    let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
        //    viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x, y: radiusSlider.frame.origin.y)
        viewRedTrailing.constant = self.view.frame.width
        viewRequestBottom.constant = -500
        radiusSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        setupUserCurrentLocation()
//        isAddViewed = false
        Constants.DEFAULT_LAT = 31.458158
        Constants.DEFAULT_LONG = 74.350235
        if Constants.DEFAULT_LAT != nil && Constants.DEFAULT_LONG != nil{
            self.loadGoogleMapLayer()
            setCarMarker()
        }
    
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.showDummyRequest()
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
        let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
        viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x+15.5 , y: radiusSlider.frame.origin.y+15.5)
//        UtilityManager.manager.showAlertView(title: "Hey", message: "ldjfbdsjk", VC: self)
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                print("start")
                //            case .moved:
                // handle drag moved
                //              print("")
            case .ended:
                // handle drag ended
                if slider.value >= 90{
                    viewMeetAtBottomConstraint.constant = -25
                    self.viewTimerBottomConstraint.constant = -100
                    slider.setValue(97, animated: true)
                    let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
                    let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
                    viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x+15.5 , y: radiusSlider.frame.origin.y+15.5)
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                        self.view.layoutSubviews()
                        self.view.layoutIfNeeded()
                    } completion: { _ in
                        self.timer.invalidate()
                        self.time = 0
                        self.viewRedTrailing.constant = self.view.frame.width
                        self.btnReachNearBy.isHidden = false
                        self.btnChat.isHidden = false
                        self.viewSlider.isHidden = true
                        self.btnReject.isHidden = true
                    }
                }else{
                    
                    slider.setValue(2, animated: true)
                    self.viewTimerBottomConstraint.constant = -30
                    let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
                    let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
                    UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear) {
                        self.viewDistance.center = CGPoint(x: thumbRect.origin.x + self.radiusSlider.frame.origin.x+15.5 , y: self.radiusSlider.frame.origin.y+15.5)
                        self.view.layoutSubviews()
                        self.view.layoutIfNeeded()
                    } completion: { _ in
                        print("rested")
                    }
                    
                }
            default:
                break
            }
        }
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
    
    
    @IBAction func reachNearByTapped(_ sender:UIButton){
        
        UtilityManager.manager.showAlertViewWithButtons(title: "Confirm your arrival", message: "Make Shure you have reach the location  ", buttons: ["Confirm"]) { index in
            print("button pressed")
        }
        
        
    }
    
    @IBAction func chatBtnTapped(_ sender:UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.booking = self.booking
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func rejectTapped(_ sender:UIButton){
        
        viewRequestBottom.constant = -500
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.timer.invalidate()
            self.time = 0
            self.viewRedTrailing.constant = self.view.frame.width
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
    
    func showDummyRequest(){
        viewRequestBottom.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateViewTimer), userInfo: nil, repeats: true)
            
        }
        
    }
    
    @objc func updateViewTimer() {
        if time < totalTime{
            time += 1
            viewRedTrailing.constant = self.view.frame.width - self.view.frame.width/CGFloat(totalTime) * CGFloat(time)
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                self.view.layoutSubviews()
                self.view.layoutIfNeeded()
            } completion: { _ in
                
            }
        }else{
            self.viewRequestBottom.constant = -500
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.view.layoutSubviews()
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.timer.invalidate()
                self.time = 0
                self.viewRedTrailing.constant = self.view.frame.width
            }
            
        }
        
        
    }
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
        let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
        viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x+15.5 , y: radiusSlider.frame.origin.y+15.5)
        
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
//        case .CAPTAIL_PORTAL :
//            self.backView.isHidden = true
//            UtilityManager.manager.navigateToVc(from: self, identifier: "DriverPortalViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
        case .TRANSACTIONS :
            self.backView.isHidden = true
            UtilityManager.manager.navigateToVc(from: self, identifier: "HistoryViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
        default:
            print("")
        }
    }
    
    func hide() {
        self.backView.isHidden = true
    }
    
}
