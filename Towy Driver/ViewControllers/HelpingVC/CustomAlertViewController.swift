//
//  CustomAlertViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 3/08/2022.
//  Copyright © 2022 All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {

    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblMsg:UILabel!
    
    
    var txt = ""
    var msg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMsg.text = msg
        lblTitle.text = txt
        
    }
    

    @IBAction func backTapped(_ sender:UIButton){
        
        UtilityManager.manager.moveBack(self, false)
        
    }

}
