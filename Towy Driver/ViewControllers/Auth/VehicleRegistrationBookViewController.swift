//
//  VehicleRegistrationBookViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class VehicleRegistrationBookViewController: UIViewController {

@IBOutlet weak var lblTitle:UILabel!
@IBOutlet weak var lblDes:UILabel!
@IBOutlet weak var imgView:UIImageView!


var ttl = ""
var des = ""
var img = UIImage()
var document:DocType!

override func viewDidLoad() {
    super.viewDidLoad()

    self.lblDes.text = des
    self.lblTitle.text = ttl
    setupDate()
}

@IBAction func backTapped(_ sender:UIButton){
    UtilityManager.manager.moveBack(self)
}


    @IBAction func btnNext(_ sender: Any) {
        
    
        UtilityManager.manager.gotoVC(from: self, identifier: "WaitForApprovalViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
func setupDate(){
    
        lblTitle.text = "Vehicle Registration Book"
    lblDes.text = "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book."
        imgView.image = UIImage.init(named: "registration")
    }


}
