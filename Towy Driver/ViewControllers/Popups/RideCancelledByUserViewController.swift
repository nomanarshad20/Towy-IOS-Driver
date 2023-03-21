//
//  RideCancelledByUserViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 17/12/2020.
//  Copyright © TOWY. All rights reserved.
//

import UIKit

class RideCancelledByUserViewController: UIViewController {

    @IBOutlet weak var lblMessage:UILabel!
    @IBOutlet weak var viewRideCancel:UIView!
    @IBOutlet weak var viewDestinationChanged:UIView!
    @IBOutlet weak var lblOldDes:UILabel!
    @IBOutlet weak var lblNewDes:UILabel!
    @IBOutlet weak var btnGotIt:UIButton!
    @IBOutlet weak var btnBack:UIButton?
    
    var noti:NotificationModel!
    var isCancel = true
    
    
    var oldDes:String? = nil{
        didSet{
            lblOldDes.text = "Previous:\(oldDes!)"
        }
    }
    var newDes:String? = nil{
        didSet{
            lblNewDes.text = "New : \(newDes!)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if noti.type == .LOGOUT_USER{
            lblMessage.text = Constants.LOGOUT_BY_NOTIFICAION
            self.viewRideCancel.isHidden = false
            self.viewDestinationChanged.isHidden = true
            self.btnBack?.setTitle(Constants.BTN_LOGIN_AGAIN, for: .normal)
        }else if noti.rideDropOffChange == nil{
            UtilityManager.manager.saveDriverStatus(status: 1)
            NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_USER.rawValue), object: nil)
            lblMessage.text = Constants.RIDE_CANCELLED_BY_PASSENGER
            self.viewRideCancel.isHidden = false
            self.viewDestinationChanged.isHidden = true
        }else{
            self.viewRideCancel.isHidden = true
            self.btnGotIt.isHidden = true
            self.viewDestinationChanged.isHidden = false
            
        }
        
        if noti.rideDropOffChange?.dropoff_latitude != nil && noti.rideDropOffChange?.dropoff_longitude != nil{
            UtilityManager.manager.getAddressFromLatLong(latitude: Double(noti.rideDropOffChange?.dropoff_latitude ?? "0") ?? 0, longitude: Double(noti.rideDropOffChange?.dropoff_longitude ?? "0") ?? 0) { (adress) in
                self.btnGotIt.isHidden = false
                self.newDes = adress
            }
        }else{
            
        }
        
        let b = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE)
        if  b?["dropoff_latitude"]  != nil && b?["dropoff_longitude"] != nil{
            UtilityManager.manager.getAddressFromLatLong(latitude: Double( b?["dropoff_latitude"] as? String ?? "0") ?? 0, longitude: Double( b?["dropoff_longitude"] as? String ?? "0") ?? 0) { (adress) in
                self.btnGotIt.isHidden = false
                self.oldDes = adress
            }
        }
    }
    

    @IBAction func backTapped(_ sender:UIButton){
        
        if noti.type == .LOGOUT_USER{
            logoutUser()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    @IBAction func gotItTapped(_ sender:UIButton){
        UtilityManager.manager.muteTune()
        NotificationCenter.default.post(name: NSNotification.Name("ride_Destination_changed"), object: noti)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func logoutUser(){
        UtilityManager.manager.clearUserData()
        self.moveToLogin()
        
    }
    
    func moveToLogin(){
        UserDefaults.standard.set(false, forKey: Constants.IS_LOGIN)
        let story = UtilityManager.manager.getMainStoryboard()
        let vc = story.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
