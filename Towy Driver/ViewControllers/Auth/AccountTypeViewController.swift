//
//  AccountTypeViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class AccountTypeViewController: UIViewController {

    
    @IBOutlet weak var btnNext:UIButton!
    @IBOutlet weak var viewWorkShop:UIView!
    @IBOutlet weak var viewTowService:UIView!
    
    
    var user = User()
   
    var isDriver = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set(1, forKey: Constants.REGISTRATION_STATUS)

        
//        if user.mobileNumber == nil{
//            user = User.init(dictionary: UtilityManager.manager.getModelFromUserDefalts(key: Constants.APP_USER)!)
//        }
        
        btnNext.disable()

    }
    

    @IBAction func btnNext(_ sender: Any) {
        
        SHOW_CUSTOM_LOADER()
        
        SignUpManager.manager.setUserType(type: isDriver) { [self] result, message in
            if result ?? false{
                if isDriver == "2"{
                    UtilityManager.manager.gotoVC(from: self, identifier: "TruckTypeViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())

                }else{
                    
                    //To left for Workshop
                    UtilityManager.manager.gotoVC(from: self, identifier: "ServicesViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())

                }
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "error setting User Type", title: Constants.APP_NAME)
            }
        }
        

        
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }


    @IBAction func btnWorkshopTapped(_ sender:UIButton){
        isDriver = "3"
        btnNext.enable()
        viewWorkShop.layer.borderWidth = 2
        viewTowService.layer.borderWidth = 0
    }

    
    @IBAction func btnTowTapped(_ sender:UIButton){
        isDriver = "2"
        btnNext.enable()
        viewTowService.layer.borderWidth = 2
        viewWorkShop.layer.borderWidth = 0

        
    }
    
    
    
    
    

}
