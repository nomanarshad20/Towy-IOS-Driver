//
//  PayableViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 04/01/2021.
//  Copyright © TOWY. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth
import FirebaseDatabase
import SwiftyJSON


protocol RideCompletionDelegate {
    func didFinishRide()
    func didCancel()
}

class PayableViewController: UIViewController {
    
//    @IBOutlet weak var viewActualAmount: UIView!
    @IBOutlet weak var lblTripFare: UILabel!
    @IBOutlet weak var lblPromotion: UILabel!
    @IBOutlet weak var lblOutstanding: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var lblTotalAmountHeader: UILabel!

    @IBOutlet weak var lblDistance:UILabel!
//    @IBOutlet weak var lblBookingId:UILabel!
//    @IBOutlet weak var lblDescription:UILabel!
    
    var delegate:RideCompletionDelegate!
    var fare = 0.0
    var distance = 0.0
    var time = "00:00"
    var tt = 0.43747489
    var des = ""
    var bookingId = ""
    var ref:DatabaseReference!
    var messages = [Message]()
    var messagesJson:String? = ""
    var booking:BookingInfo!
    var totaldistance = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        ref = Database.database().reference()
//
//        viewActualAmount.layer.cornerRadius = 6
//        viewActualAmount.layer.borderWidth = 1
//        viewActualAmount.layer.borderColor = UIColor.black.cgColor
//
//        viewAmountReceived.layer.cornerRadius = 6
//        viewAmountReceived.layer.borderWidth = 1
//        viewAmountReceived.layer.borderColor = UIColor.black.cgColor
//
//        viewDescription.layer.cornerRadius = 6
//        viewDescription.layer.borderWidth = 1
//        viewDescription.layer.borderColor = UIColor.black.cgColor
//
//
//        txtdescription.layer.cornerRadius = 4
//        txtdescription.layer.borderColor = UIColor.darkGray.cgColor
//        txtdescription.layer.borderWidth = 1
//
//        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 30))
//        txtdescription.leftViewMode = .always
//        txtdescription.leftView = leftView
//        txtdescription.addSubview(leftView)
        
        btnSave.layer.cornerRadius = 4

        checkDriverStatus()
        getdata()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        UtilityManager.manager.showAlertView(title: "Distance Traveled", message: "Total Distance: \(totaldistance)")
    }
    
    func setupIbOutlets(){
        self.fare = Double(booking.actual_fare ?? "0.0") ?? 0.0
        self.bookingId = "\(booking.id!)"
        self.lblDistance.text = (booking.total_calculated_distance ?? "0") + " \(Constants.DISTANCE_UNIT)"
        
        
        
        //        self.btnSave.isHidden = true
       
//        if UtilityManager.manager.getUserType() == 0{
//            txtExtraAmount.isHidden = true
//        }else{
//            txtExtraAmount.isHidden = false
//        }
        
//        txtExtraAmount.delegate = self
//        txtAmountReceived.delegate = self
//
        
        let time = getTotalTime()
        
        if  time > 60{
            let h = time / 60
            let min = time % 60
            lblTime.text = "\(h)" + "H" + "\(min)" + "min"
        }else{
            lblTime.text = "\(time) min"

        }
        
        //        lblDistance.text = "\(distance.rounded(toPlaces: 1)) "
        lblTotalAmountHeader.text = "\(fare.rounded())"
        lblTripFare.text = "\(fare.rounded())"
        
//        lblTotalAmount.text = "\(fare.rounded())"
//        lblBookingId.text = bookingId
//        lblDescription.text = des
        
//        if fare == 0.0 {
//            txtAmountReceived.text = "0"
//            txtAmountReceived.isUserInteractionEnabled = false
//        }
        
    }
    
    func getTotalTime()->Int{
        let pickupMinutes = Double(booking.total_minutes_to_reach_pick_up_point ?? "0.0") ?? 0.0
        let waitingTime = Double(booking.driver_waiting_time ?? "0.0") ?? 0.0
        let servingTime = Double(booking.total_ride_minutes ?? "0.0") ?? 0.0
        return Int(pickupMinutes+waitingTime+servingTime)
    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
        //        delegate.didCancel()
        //        self.dismiss(animated: true, completion: nil)
        UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: Constants.CANT_GET_BACK)
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        finishRide()
//        if checkVaidation(){
//            UtilityManager.manager.showAlertWithAction(self, message: Constants.WANT_TO_FINISH_RIDE, title: Constants.APP_NAME, buttons: ["Finish","Cancel"]) { [self] (index) in
//
//
//                if index == 0{
//                    finishRide()
//                }
//            }
//        }
    }
    
    
    func checkDriverStatus(){

        SHOW_CUSTOM_LOADER()
        DriverStatusManager.manager.getCurrnetStatus { b,u,err  in
            HIDE_CUSTOM_LOADER()
            if err == nil{
                if b != nil{
                    self.booking = b!
                    self.setupIbOutlets()
                }
            }else{
                UtilityManager.manager.showAlert(self, message: err ?? "error getting statue", title: Constants.APP_NAME)
            }
        }
    }
    
    
    func finishRide(){
        
        self.dismiss(animated: true) {
            SHOW_CUSTOM_LOADER()
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                HIDE_CUSTOM_LOADER()
                self.delegate.didFinishRide()
            })
        }
        
        
//        let b = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE)
//        if b != nil{
//            let params = ["user_id":UtilityManager.manager.getId(),"driver_status":Constants.RideStatus.RIDE_COMPLETED.rawValue,"passenger_id":b?["passenger_id"] as? Int ?? 0,"booking_id":b?["booking_id"] as? Int ?? 0,"add_extra_payment":txtExtraAmount.text ?? "0","final_payment":txtAmountReceived.text ?? fare,"chat_messages":messagesJson ?? ""] as [String : Any]
//            RideManager.manager.updateRideStatus(params: [:]) { (data, err) in
//                if err == nil {
//                    UserDefaults.standard.set(nil, forKey: Constants.RIDE_LOCATIONS)
//                    self.delegate.didFinishRide()
//                    self.dismiss(animated: true, completion: nil)
//                }else{
//                    UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: err ?? "something went wrong.")
//                }
//            }
//        }
    }
    
    func getdata(){
        let booking = booking
        if let booking_Id =  booking?.id as? Int {
            ref.child("\(booking_Id)").child("messages").observeSingleEvent(of: .value, with: { dataSnap in
                if dataSnap.exists(){
                    for child in dataSnap.children.allObjects{
                        let childSnap = child as? DataSnapshot
                        self.messages.append(Message.init(dict: (childSnap?.value as? [String:Any])!))
                    }
                    self.messagesJson = Message.getJsonFromMessages(messages: self.messages)
                    self.btnSave.isHidden = false
                }else{
                    self.btnSave.isHidden = false
                }
            })
        }else{
            btnSave.isHidden = false
        }
    }
    
    
    func showSaveBtn(){
        DispatchQueue.main.async {
            self.btnSave.isHidden = false
        }
    }
    
//    func checkVaidation()->Bool{
//        if fare > 0{
////            if txtAmountReceived.text == ""{
////                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: "Received amount can't be empty.")
////                return false
////            }
////            if Double(txtAmountReceived.text!) ?? 0.0 < fare.rounded(){
////                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: "Received amount can't be less than Total Amount.")
////                return false
////            }
////            if Double(txtAmountReceived.text!) ?? 0.0 >= fare.rounded() && Double(txtAmountReceived.text!) ?? 0.0 > fare.rounded() + 300.0{
////                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: "You can't Receive more than \(fare+300.0) \(Constants.Currency).")
////                return false
////            }
//
//
//            return true
//        }else{
//            return true
//        }
//    }
}

extension PayableViewController:UITextFieldDelegate{
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if textField == txtExtraAmount && textField.text != ""{
//            if let text = textField.text,
//               let textRange = Range(range, in: text) {
//                let updatedText = text.replacingCharacters(in:textRange,with:string)
//                if updatedText.count > 3{
//                    return false
//                }else{
//                    return true
//                }
//            }
//        }
        
        
//        if textField == txtAmountReceived && textField.text != ""{
//            if let text = textField.text,
//               let textRange = Range(range, in: text) {
//                let updatedText = text.replacingCharacters(in:textRange,with:string)
//                if updatedText.count > 5{
//                    return false
//                }else{
//                    return true
//                }
//            }
//        }
//        
//        return true
//    }
    
    
}
