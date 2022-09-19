//
//  RateAndReviewViewController.swift
//  TOWY Driver
//
//  Created by apple on 11/17/20.
//  Copyright © TOWY. All rights reserved.
//

import UIKit
import Cosmos



protocol RatingDelegate {
    func didRatePassenger()
    func didCancelRating()
}

class RateAndReviewViewController: UIViewController{
    
    
    @IBOutlet weak var ratingView:CosmosView!
    @IBOutlet weak var txtDescription:UITextView!
    @IBOutlet weak var btnSubmit:UIButton!
    
    var delegate:RatingDelegate!
    var booking:BookingInfo!
    var rating = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.didFinishTouchingCosmos = { rating in
            self.rating = "\(rating)"
        }
    }
    
    @IBAction func submittTapped(_ sender:UIButton){
        
        if rating != "" && booking != nil{
            SHOW_CUSTOM_LOADER()
            //"user_id":UtilityManager.manager.getId(),,"type": 2
            RatingManager.manager.RateAndReview(params:["passenger_id":booking.passenger_id ?? 0,"rating":rating,"message":txtDescription.text ?? "","booking_id":booking.id ?? 0]) { (bool, err) in
                if bool{
                    DispatchQueue.main.async {
                        self.delegate.didRatePassenger()
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: err ?? "something went wrong")
                }
            }
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.DRIVER_RATED_THE_CUSTOMER.rawValue), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated: true)
//            UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: Constants.RATE_FIRST)
        }
        
       
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        delegate.didCancelRating()
        self.navigationController?.popViewController(animated: true)
    }
    
}

