//
//  CityNameViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 07/07/2022.
//

import UIKit

class CityNameViewController: UIViewController {

    @IBOutlet weak var btnNext:UIButton!
    @IBOutlet weak var txtCitytName:UITextField!
    
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        if user.mobileNumber == nil{
//            user = User.init(dictionary: UtilityManager.manager.getModelFromUserDefalts(key: Constants.APP_USER)!) 
//        }
        
        txtCitytName.delegate = self
        btnNext.disable()
        txtCitytName.setPadding(12)
    }
    

    @IBAction func btnNext(_ sender: Any) {
        
        
       
        if txtCitytName.text == ""{
            UtilityManager.manager.showAlert(self, message: "Please enter city name.", title: Constants.APP_NAME)
            return
        }
        registerUser()
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

    
    func registerUser(){
        
        let params = ["user_type":"2",
                      "fcm_token":UtilityManager.manager.getFcmToken(),"password":user.password,
                      "password_confirmation":user.password,
                      "city":user.city ?? txtCitytName.text!,
                      "first_name":user.first_name,
                      "last_name":user.last_name,
                      "login":user.mobileNumber ?? user.email,
                      "referrer":user.referralCode]
//        ["user_type":"2",
//                      "fcm_token":"jgdfjhsdhfjsgjfhsdf4b3bb 435","password":"123456789a",
//                      "password_confirmation":"123456789a",
//                      "city":"Lahore",
//                      "first_name":"mnbfdsn",
//                      "last_name":"sdfbskdjf",
//                      "login":"034564645475985"]
        SignUpManager.manager.signup(params: params as [String : Any]) { result, message in
            if message == nil{
                
                 self.user.city = self.txtCitytName.text!
                 
                 let st = UtilityManager.manager.getAuthStoryboard()
                 let vc = st.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                 vc.user = self.user
                UtilityManager.manager.saveModelInUserDefaults(key: Constants.APP_USER, data: User.getDictFromUser(user: self.user))
                self.navigationController?.pushViewController(vc, animated: true)

            }else{
                UtilityManager.manager.showAlert(self, message: message!, title: "Oops")
            }
        }
    }

}

extension CityNameViewController:UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtCitytName.text != ""{
            btnNext.enable()
        }else{
            btnNext.disable()
        }
     
        
        if textField.text == ""{
            textField.layer.borderWidth = 0
        }
        
    }
    
}
