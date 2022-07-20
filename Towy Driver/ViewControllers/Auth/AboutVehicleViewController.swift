//
//  AboutVehicleViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 08/07/2022.
//

import UIKit

class AboutVehicleViewController: UIViewController {

    @IBOutlet weak var btnNext:UIButton!
    @IBOutlet weak var yesHaveVehicle:UIView!
    @IBOutlet weak var needVehicle:UIView!
    
    @IBOutlet weak var lblYesTitle:UILabel!
    @IBOutlet weak var lblNoTitle:UILabel!
    @IBOutlet weak var lblYesDes:UILabel!
    @IBOutlet weak var lblNoDes:UILabel!
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.disable()

    }
    

    @IBAction func btnNext(_ sender: Any) {
        
    
        UtilityManager.manager.gotoVC(from: self, identifier: "SSNViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }


    @IBAction func btnYesHave(_ sender:UIButton){
        btnNext.enable()
        yesHaveVehicle.backgroundColor = UIColor.black
        needVehicle.backgroundColor = UIColor.white
        lblYesDes.textColor = UIColor.white
        lblYesTitle.textColor = UIColor.white
        lblNoDes.textColor = UIColor.black
        lblNoTitle.textColor = UIColor.black
    }

    
    @IBAction func needVehicle(_ sender:UIButton){
        btnNext.enable()
        yesHaveVehicle.backgroundColor = UIColor.white
        needVehicle.backgroundColor = UIColor.black
        lblYesDes.textColor = UIColor.black
        lblYesTitle.textColor = UIColor.black
        lblNoDes.textColor = UIColor.white
        lblNoTitle.textColor = UIColor.white
    }
    
    
    

}
