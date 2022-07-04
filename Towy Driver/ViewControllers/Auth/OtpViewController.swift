//
//  OtpViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit
import SVPinView


class OtpViewController: UIViewController {

    @IBOutlet weak var pinView:SVPinView!
    @IBOutlet weak var lblPhoneNumber:UILabel!
    
    
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lblPhoneNumber.text = "We sent a code to " + phoneNumber
        
        pinView.style = .box
        pinView.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        
        pinView.becomeFirstResponderAtIndex = 0
        pinView.frame = self.view.frame
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
    
        UtilityManager.manager.gotoVC(from: self, identifier: "PasswordViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
}
