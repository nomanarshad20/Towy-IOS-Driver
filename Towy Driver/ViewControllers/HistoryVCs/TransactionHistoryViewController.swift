//
//  TransactionHistoryViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 29/06/2021.
//  Copyright © 2021 Cyber Advance Solutions. All rights reserved.
//

import UIKit
import CarbonKit


class TransactionHistoryViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
    
}
