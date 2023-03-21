//
//  ReferralCodeViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 06/07/2022.
//

import UIKit

class ReferralCodeViewController: UIViewController {

    @IBOutlet weak var btnNext:UIButton!
    
    @IBOutlet weak var txtReferralCode:UITextField!
    
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        if user.mobileNumber == nil{
//            user = UtilityManager.manager.getModelFromUserDefalts(key: Constants.APP_USER)
//        }
        
        txtReferralCode.delegate = self
//        btnNext.isUserInteractionEnabled = false
//        btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
        txtReferralCode.setPadding(12)
    }
    

    @IBAction func btnNext(_ sender: Any) {
       
        
        
        if txtReferralCode.text == ""{
            UtilityManager.manager.showAlert(self, message: "Please enter Referral Code to verify.", title: "Oops")
            return
        }
        
        gotoCityVC()
        
    }
    
    
    @IBAction func btnSkip(_ sender: Any) {
       
       gotoCityVC()
        
    }
    
    func gotoCityVC(){
        
//        UserDefaults.standard.set(5, forKey: Constants.REGISTRATION_STATUS)

        
        user.referral_code = self.txtReferralCode.text ?? ""
        
        let st = UtilityManager.manager.getAuthStoryboard()
        let vc = st.instantiateViewController(withIdentifier: "CityNameViewController") as! CityNameViewController
        vc.user = self.user
        UtilityManager.manager.saveModelInUserDefaults(key: Constants.APP_USER, data: User.getDictFromUser(user: user))
        if self.navigationController != nil{
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.present(vc , animated: true, completion: nil)
            }

    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    

}

extension ReferralCodeViewController:UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text == ""{
            textField.layer.borderWidth = 0
        }
        
    }
    
}
