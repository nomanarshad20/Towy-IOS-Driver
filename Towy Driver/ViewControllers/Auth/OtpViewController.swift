//
//  OtpViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class OtpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
    
        UtilityManager.manager.gotoVC(from: self, identifier: "PasswordViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
}
