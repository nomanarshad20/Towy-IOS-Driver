//
//  RideDetailsViewController.swift
//  Oyla Captain
//
//  Created by Macbook Pro on 19/03/2021.
//  Copyright © 2021 Cyber Advance Solutions. All rights reserved.
//

import UIKit

class RideDetailsViewController: UIViewController {

    @IBOutlet weak var lblFare: UILabel!
//    @IBOutlet weak var lblCashCollected: UILabel!
    @IBOutlet weak var lblCashAddedToWallet: UILabel!
    @IBOutlet weak var extraAmount: UILabel!
    @IBOutlet weak var lblOylaShare: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
     @IBOutlet weak var lblTime: UILabel!
    
    var trip:Trip!
    
    var currency = "RS : "
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currency = Constants.Currency
        setupView()
    }

   
    func setupView(){
        self.lblFare.text = currency + " \(trip.estimated_fare ?? "0")"
//        self.lblCashCollected.text = currency + "\(trip.estimated_fare ?? "0")"
        self.lblCashAddedToWallet.text = currency + "\(trip.wallet_pay_amount ?? 0)"
        self.extraAmount.text = currency + "\(trip.extra_amount ?? 0)"
        self.lblOylaShare.text = currency + "\(trip.oyla_wallet_pay ?? "0")"
        self.lblPaymentType.text = "\(trip.payment_type ?? "0")"
        self.lblTax.text = currency + "0"
        self.lblDistance.text = "\(trip.total_distance ?? "0") : \(Constants.DISTANCE_UNIT)"

        
        self.lblTime.text = UtilityManager.manager.getDateOfJoining(date: trip.created_at)

        
    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self, true)
    }

}
