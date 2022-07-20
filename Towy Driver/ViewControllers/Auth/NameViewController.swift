//
//  NameViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 06/07/2022.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var btnNext:UIButton!
    
    @IBOutlet weak var txtFirstName:UITextField!
    @IBOutlet weak var txtLastName:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtLastName.delegate = self
        txtFirstName.delegate = self
        btnNext.isUserInteractionEnabled = false
        btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
        txtFirstName.setPadding(12)
        txtLastName.setPadding(12)
    }
    

    @IBAction func btnNext(_ sender: Any) {
        
        
       
        if txtFirstName.text == ""{
            UtilityManager.manager.showAlert(self, message: "Please enter first name.", title: Constants.APP_NAME)
            return
        }
        
        if txtLastName.text == ""{
            UtilityManager.manager.showAlert(self, message: "Please enter last name.", title: Constants.APP_NAME)
            return
        }
       
            let vc = storyboard?.instantiateViewController(withIdentifier: "ReferralCodeViewController") as! ReferralCodeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    

}

extension NameViewController:UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtLastName.text != "" && txtFirstName.text != ""{
            btnNext.enable()
        }else{
            btnNext.disable()
        }
     
        
        if textField.text == ""{
            textField.layer.borderWidth = 0
        }
        
    }
    
}
