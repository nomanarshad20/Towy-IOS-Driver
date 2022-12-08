//
//  NewRideRequestViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 09/12/2020.
//  Copyright © TOWY. All rights reserved.
//

import UIKit
import GoogleMaps
import MediaPlayer
import FirebaseAuth
import FirebaseDatabase
import NotificationBannerSwift
import Toast_Swift
import SocketIO


protocol RideRequestDelegate{
    func didAcceptRide()
    func didCancel()
    
}


class NewRideRequestViewController: UIViewController {
    
    
    @IBOutlet weak var viewSlider:UIView!
    @IBOutlet weak var viewDistance:UIImageView!
    @IBOutlet weak var radiusSlider:UISlider!
    @IBOutlet weak var lblSliderTitle:UILabel!
    @IBOutlet weak var btnReject:UIButton!
    
    @IBOutlet weak var viewTimerBottomConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var viewRequestBottom:NSLayoutConstraint!
    
    @IBOutlet weak var viewRedTrailing:NSLayoutConstraint!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblDistancePickup: UILabel!
    @IBOutlet weak var lblUserRating: UIButton!

    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var tblViewH:NSLayoutConstraint!

    
    var timer:Timer!
    var time:Double = 0.0001
    var timeSlider = 0
    var progress = 0
    var noti:NotificationModel? = nil
    var isAccepted = false
    var bookingInfo:NewRide!
    var screenW:Float = 0
    var ref:DatabaseReference!
    var isService = false
    
    var totalTime = 10
    
    var socketEvent = "accept-reject-ride"
    
    var datasource :[Service] = []

    
    var locManager = CLLocationManager()
    lazy var currentLocation: CLLocation? = nil
    
    var delegate:RideRequestDelegate!
    
    let socket = SocketIOManager.sharedInstance.socket
    
    var isConnectedToSocket = false
    let manager = SocketManager(socketURL: URL(string: Constants.SOCKET_ROOT)!, config: [.log(false), .compress])

    
    
    var serviceIds : [Int] = []{
        didSet{
            if serviceIds.count > 0{
//                btnContinue.isUserInteractionEnabled = true
//                btnContinue.backgroundColor = .black
            }else{
//                btnContinue.isUserInteractionEnabled = false
//                btnContinue.backgroundColor = .lightGray
            }
        }
    }
    
    
    override func viewDidLoad() {
        

        ref = Database.database().reference()
        
        
        if bookingInfo != nil{
            lblCustomerName.text = bookingInfo.passenger_name
            lblUserRating.setTitle("\(bookingInfo.passenger_ratings ?? 0.0)", for: .normal)
        }
        
        if socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
        }
        
        setupSocketEvents()
       
        viewRedTrailing.constant = self.view.frame.width
        viewRequestBottom.constant = -500
        radiusSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        if noti?.newRide?.services?.count ?? 0 > 0{
            isService = true
            tblView.register(UINib.init(nibName: "TruckTypeTableViewCell", bundle: .main), forCellReuseIdentifier: "TruckTypeTableViewCell")
            if noti?.newRide?.services?.count ?? 0 <= 3{
                tblViewH.constant = 200
            }
            tblView.delegate = self
            tblView.dataSource = self
            datasource = (noti?.newRide?.services!)!
            socketEvent = "accept-reject-service-ride"
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.stop()
        let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
        let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
        viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x+15.5 , y: radiusSlider.frame.origin.y+15.5)
        //        UtilityManager.manager.showAlertView(title: "Hey", message: "ldjfbdsjk", VC: self)
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.showDummyRequest()
        })
        
        
    }
    
//    func setupSocket() {
//        self.socket = manager.defaultSocket
//    }
    
//    func stop() {
//        socket?.removeAllHandlers()
//        isConnectedToSocket = false
//    }
//
    
    func setupSocketEvents() {

            self.socket!.on("\(UtilityManager.manager.getId())-finalRideStatus") { (data, ack) in
                guard let dataInfo = data.first as? [String:Any] else { return }
                
                if dataInfo["data"] as? [String:Any] != nil{
                    self.dismiss(animated: true) {
                        if self.isService{
                            NotificationCenter.default.post(name: NSNotification.Name("ride_Accepted"), object: self.noti?.newRide)

                        }else{
                            NotificationCenter.default.post(name: NSNotification.Name("ride_Accepted"), object: self.noti?.booking)

                        }

                    }
                }else{
                    self.dismiss(animated: true) {}
                }
               
            }

        }
//
//
//        socket?.on(clientEvent: .ping, callback: { data,ack in
//        print("ping")
//
//        })
//
//        socket?.on(clientEvent: .pong, callback: {data,ack in
//        print("pong")
//
//        })
        
    
    
    func showDummyRequest(){

        viewRequestBottom.constant = 0
        viewTimerBottomConstraint.constant = -25
        btnReject.isHidden = false
        viewSlider.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateViewTimer), userInfo: nil, repeats: true)

        }

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
                    //                API CALL to accept ride
                    self.timer.invalidate()
                    isAccepted = true
                    InformPassenger(actionStatus: 1)
//                    UtilityManager.manager.saveDriverStatus(status: 2)
//                    self.updateStatusUI()
//                    viewMeetAtBottomConstraint.constant = -25
                    self.viewTimerBottomConstraint.constant = -100
                    slider.setValue(97, animated: true)
                    let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
                    let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
                    viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x+15.5 , y: radiusSlider.frame.origin.y+15.5)
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                        self.view.layoutSubviews()
                        self.view.layoutIfNeeded()
                    } completion: { _ in
                        
                        self.stopTimer()
                        self.timeSlider = 0
                        self.viewRedTrailing.constant = self.view.frame.width
                        self.viewTimerBottomConstraint.constant = -100
//                        self.btnReachNearBy.isHidden = false
//                        self.btnChat.isHidden = false
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
    
    @objc func updateViewTimer() {
        if timeSlider < totalTime{
            timeSlider += 1
            viewRedTrailing.constant = self.view.frame.width - self.view.frame.width/CGFloat(totalTime) * CGFloat(timeSlider)
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
                self.stopTimer()
                self.timeSlider = 0
                self.viewRedTrailing.constant = self.view.frame.width
                self.InformPassenger(actionStatus: 2)
                self.isAccepted = false
                NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_DRIVER.rawValue), object: nil)
                Constants.IS_RIDE_POPUP_VISIBLE = false
                self.dismiss(animated: true)
                
            }
            
        }
        
        
    }
    
    func stopTimer(){
        if timer != nil{
            timer?.invalidate()
            timer = nil
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
      
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Constants.IS_RIDE_POPUP_VISIBLE = false
    }
    
    
    @objc func rideCancelByUserOnReceive(){
        if UtilityManager.manager.player?.isPlaying ?? false{
            UtilityManager.manager.player?.stop()
        }
        self.dismiss(animated: true, completion: {
            UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: "Ride was cancelled before start")
        })
    }
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        let trackRect =  radiusSlider.trackRect(forBounds: radiusSlider.bounds)
        let thumbRect = radiusSlider.thumbRect(forBounds: radiusSlider.bounds, trackRect: trackRect, value: radiusSlider.value)
        viewDistance.center = CGPoint(x: thumbRect.origin.x + radiusSlider.frame.origin.x+15.5 , y: radiusSlider.frame.origin.y+15.5)
        
    }
    
    @IBAction func rejectTapped(_ sender:UIButton){
        
        isAccepted = false
        let params = ["user_id":UtilityManager.manager.getId(),"driver_action":0,"booking_id":noti?.booking?.id ?? self.noti?.newRide?.booking_id ?? ""] as [String : Any]
        self.setupNewRide(params: params)

        
//        viewRequestBottom.constant = -500
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
//            self.view.layoutSubviews()
//            self.view.layoutIfNeeded()
//        } completion: { [self] _ in
//            self.stopTimer()
//            self.timeSlider = 0
//            self.viewRedTrailing.constant = self.view.frame.width
//        }
//
        
    }

    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.timer.invalidate()
            AppDelegate().DismissVCOne()
        }
    }
    
    
    
    @IBAction func acceptTapped(_ sender: Any) {
        self.timer.invalidate()
        isAccepted = true
        InformPassenger(actionStatus: 1)
    }
    
    func InformPassenger(actionStatus:Int){
        
        var params = [String:Any]()
        
//        if UtilityManager.manager.player?.isPlaying ?? false{
//            UtilityManager.manager.player?.stop()
//        }
        
//        "booking_id":"114","driver_action":1,"user_id":27
        
//        ["temp_id":noti?.newRide?.temp_id ?? "","user_id":UtilityManager.manager.getId(),"driver_action":actionStatus,"pre_book":false]
        
        if noti?.type == .some(.NEW_RIDE_REQUEST) || noti?.type == .SERVICE_REQUEST{
            params = ["user_id":UtilityManager.manager.getId(),"driver_action":actionStatus,"booking_id":noti?.booking?.id ??  noti?.newRide?.booking_id ?? ""] as [String : Any]
            setupNewRide(params: params)
        }else{
            params = ["user_id":UtilityManager.manager.getId(),"driver_action":actionStatus,"pre_book":true,"booking_id":noti?.newRide?.booking_id ?? ""] as [String : Any]
            schedualRide(params: params)
        }
        
        
        
    }
    
    func setupNewRide(params:[String:Any]){
        
        
        if !isAccepted{
            DispatchQueue.main.async { [self] in
//                Constants.IS_RIDE_POPUP_VISIBLE = false
                if self.isConnectedToSocket{
                    self.socket?.emit(socketEvent, params)
                    self.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_DRIVER.rawValue), object: params)
                    })
                }else{
                    SocketIOManager.sharedInstance.establishConnection()
                    self.socket?.emit(socketEvent, params)
                    self.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_DRIVER.rawValue), object: params)
                    })
                }
                

            }
        }else{
            
//            RideManager.manager.sendNotificationToUser(params: params) { (dict, err) in
//                HIDE_CUSTOM_LOADER()
//                if err == nil && dict != nil{
                    let fcm = UtilityManager.manager.getFcmToken()
                    
            self.ref.child("\(self.noti?.booking?.id ??  noti?.newRide?.booking_id ?? 13312313123)").child("fcm").child("fcm2").setValue(fcm) { [self] err, reffer in
                        
                        if socket?.status == .connected{
                            socket?.emit(socketEvent, params)
                            
                        }else{
                            //                if socket?.status == .disconnected{
                            SocketIOManager.sharedInstance.establishConnection()
                            socket?.emit(socketEvent, params)
                        }
                        
                    }
                    
//                }else{
//                    self.dismiss(animated: false, completion: nil)
//                }
            }
        }
//            Constants.IS_RIDE_POPUP_VISIBLE = false
           
//                UtilityManager.manager.showAlert(self, message: "Oops socket is discunnected", title: Constants.APP_NAME)
//            }
        
//        }else{
//            SHOW_CUSTOM_LOADER()
//    }
    
    func schedualRide(params:[String:Any]){
        if !isAccepted{
            self.dismiss(animated: false, completion: nil)
        }else{
            RideManager.manager.sendNotificationToUser(params: params) { (dict, err) in
                UserDefaults.standard.set(false, forKey: Constants.HAS_ALREADY_RECEIVED)
                if err == nil{
                    UtilityManager.manager.saveModelInUserDefaults(key: Constants.SCHEDUAL_RIDE, data: NewRide.getBookingDict(r: self.noti?.newRide ?? NewRide.init()))
                    self.dismiss(animated: false, completion: nil)
                }else{
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    
    
    
    

    
    func checkPickup(driverLocation:CLLocationCoordinate2D){
        
        if noti?.booking?.pick_up_longitude != nil && noti?.booking?.pick_up_latitude != nil{
            
            let pickup = CLLocationCoordinate2D(latitude: Double((noti?.booking?.pick_up_latitude)!)!, longitude: Double((noti?.booking?.pick_up_longitude)!)!)
            
            let distance = UtilityManager.manager.getP2PForPickup(driverLocation: driverLocation, pickup: pickup)

            if Int(distance)  > Int(noti?.booking?.p2p_before_pick_up_distance ?? "3") ?? 3 {
                //                UtilityManager.manager.showAlertView(title: "Cancel", message: "passenger is far away.")
                print("distanccccccc",distance)
                if timer != nil && timer.isValid{
                    timer.invalidate()
                }
                InformPassenger(actionStatus: 5)
            }
            
        }
    }
    
}

extension NewRideRequestViewController:CLLocationManagerDelegate,GMSMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        self.currentLocation = manager.location!
        
        
    }
    
    
    func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
        let session = URLSession.shared
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(Constants.GOOGLE_APIKEY)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                
                print("error in JSONSerialization")
                return
                
            }
            print("responseForPolyLIne",jsonResult)
            
            
            guard let routes = jsonResult["routes"] as? [Any] else {
                return
            }
            guard routes.count > 0 else { return}
            guard let route = routes[0] as? [String: Any] else {
                return
            }
            
            guard let legs = route["legs"] as? [Any] else {
                return
            }
            guard legs.count > 0 else { return}
            
            guard let leg = legs[0] as? [String: Any] else {
                return
            }
            //distance
            //duration
            guard let steps = leg["steps"] as? [Any] else {
                return
            }
            let distance = leg["distance"] as? NSDictionary
            let duration = leg["duration"] as? NSDictionary
            print("Distancessss",distance!["text"]!)
            print("durationssss",duration!["text"]!)
            let valDistance = distance!["text"] as? String ?? ""
            if valDistance.contains("km"){
                let new = valDistance.replacingOccurrences(of: "km", with: "")
                DispatchQueue.main.async {
                    
//                    self.lblDistance.text = "\(new)"
                }
                
            }else{
                let new = valDistance.replacingOccurrences(of: "m", with: "")
                DispatchQueue.main.async {
                    
//                    self.lblDistance.text = "\(new)"
//                    self.lblKm.text = "M"
                }
            }
            
            
            if let dtn = duration!["text"] {
                var stringArray = (dtn as AnyObject).components(separatedBy: CharacterSet.decimalDigits.inverted)
                guard stringArray.count != 0 else {
                    return
                }
                
                stringArray = stringArray.filter({ $0 != ""})
                
                var mainMinutes = 0
                if stringArray.count > 1  && stringArray.count < 3{
                    let mint = Int(stringArray[0])! * 60
                    mainMinutes = mint + Int(stringArray[1])!
                }else{
                    mainMinutes = Int(stringArray[0])!
                }
                print("mainString",mainMinutes)
            } else {
                print("There was an error decoding the string")
            }
            
            for item in steps {
                guard let step = item as? [String: Any] else {
                    return
                }
                guard let polyline = step["polyline"] as? [String: Any] else {
                    return
                }
                guard let polyLineString = polyline["points"] as? String else {
                    return
                }
                
            }
        })
        
        task.resume()
    }
}


class CenteredThumbSlider : UISlider {
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect
    {
        let unadjustedThumbrect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        let thumbOffsetToApplyOnEachSide:CGFloat = unadjustedThumbrect.size.width / 2.0
        let minOffsetToAdd = -thumbOffsetToApplyOnEachSide
        let maxOffsetToAdd = thumbOffsetToApplyOnEachSide
        let offsetForValue = minOffsetToAdd + (maxOffsetToAdd - minOffsetToAdd) * CGFloat(value / (self.maximumValue - self.minimumValue))
        var origin = unadjustedThumbrect.origin
        origin.x += offsetForValue
        return CGRect(origin: origin, size: unadjustedThumbrect.size)
    }
}




extension NewRideRequestViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckTypeTableViewCell", for: indexPath) as! TruckTypeTableViewCell
        let ds = datasource[indexPath.row]
        cell.lblName.text = ds.name
        cell.lblDescription.text = ds.name
        if serviceIds.contains(datasource[indexPath.row].id!){
            cell.backView.backgroundColor = .black
            cell.lblName.textColor = .white
            cell.lblDescription.textColor = .white
        }else{
            cell.backView.backgroundColor = .white
            cell.lblName.textColor = .black
            cell.lblDescription.textColor = .darkGray
        }
        cell.imgaeIcon.kf.setImage(with: URL.init(string: Constants.HTTP_CONNECTION_ROOT_ASSETS+(ds.image ?? "") ), placeholder: nil, options: nil, progressBlock: nil) { image, error, cacheType, imageURL in
            if image != nil{
                cell.imgaeIcon.image = image!
            }else{
                cell.imgaeIcon.image = UIImage.init(named: "Mask Group 110")
                
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cel = cell as! TruckTypeTableViewCell
        if serviceIds.contains(datasource[indexPath.row].id!){
            cel.backView.backgroundColor = .black
            cel.lblName.textColor = .white
            cel.lblDescription.textColor = .white
        }else{
            cel.backView.backgroundColor = .white
            cel.lblName.textColor = .black
            cel.lblDescription.textColor = .darkGray
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if serviceIds.contains(datasource[indexPath.row].id!){
//            if let itemToRemoveIndex = serviceIds.firstIndex(of: datasource[indexPath.row].id!) {
//                   serviceIds.remove(at: itemToRemoveIndex)
//               }
//        }else{
//            self.serviceIds.append(datasource[indexPath.row].id ?? 0)
//        }
//
//
//
//        tblView.reloadData()
//
//    }
   
    
    
    
    func setServices(){
        ServiceManager.manager.saveServices(serviceIds: self.serviceIds) { result, message in
            if result ?? false{
//                if self.isEdit{
//                    NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.NEW_SERVICE_ADDED.rawValue), object: nil, userInfo: nil)
//                    self.dismiss(animated: true)
//                }else{
//                    UtilityManager.manager.gotoVC(from: self, identifier: "SSNViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
//                }
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "error saving Services.", title: "Oops")
            }
        }
    }
    
}
