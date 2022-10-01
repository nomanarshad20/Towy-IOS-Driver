//
//  PasswordResetViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 05/09/2022.
//

import UIKit

class PasswordResetViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtLogin:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var txtRePassword:UITextField!
    
    @IBOutlet weak var imgOneLatter:UIImageView!
    @IBOutlet weak var lblOneLatter:UILabel!
    
    @IBOutlet weak var imgEightChr:UIImageView!
    @IBOutlet weak var lblEightChr:UILabel!
    
    @IBOutlet weak var imgOneDigit:UIImageView!
    @IBOutlet weak var lblOneDigit:UILabel!
    
    @IBOutlet weak var btnShowPassword:UIButton!
    @IBOutlet weak var btnForgot:UIButton!
    
    @IBOutlet weak var btnNext:UIButton!
    
    
    var login = ""
    var isEmail = false
    
    
    var isStrongPassword = false{
        didSet{
            if isStrongPassword{
                btnNext.isUserInteractionEnabled = true
            btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            }else{
                btnNext.isUserInteractionEnabled = false
            btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
            }
        }
    }
    
    var hasOneLatter = false{
        didSet{
            if hasOneLatter{
                if hasOneDigit && hasEightChr{
                    isStrongPassword = true
                }else{
                    isStrongPassword = false
                }
                imgOneLatter.image = UIImage.init(systemName: "checkmark.circle.fill")
                imgOneLatter.tintColor = UtilityManager.manager.getAppGreenColor()
                lblOneLatter.textColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            }else{
                imgOneLatter.image = UIImage.init(systemName: "multiply.circle.fill")
                imgOneLatter.tintColor = UtilityManager.manager.getAppRedColor()
                lblOneLatter.textColor = UIColor.lightGray
            }
        }
    }
    
    var hasOneDigit = false{
        didSet{
            if hasOneDigit{
                if hasOneLatter && hasEightChr{
                    isStrongPassword = true
                }else{
                    isStrongPassword = false
                }
                imgOneDigit.image = UIImage.init(systemName: "checkmark.circle.fill")
                imgOneDigit.tintColor = UtilityManager.manager.getAppGreenColor()
                lblOneDigit.textColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            }else{
                imgOneDigit.image = UIImage.init(systemName: "multiply.circle.fill")
                imgOneDigit.tintColor = UtilityManager.manager.getAppRedColor()
                lblOneDigit.textColor = UIColor.lightGray
            }
        }
    }
    
    var hasEightChr = false{
        didSet{
            if hasEightChr{
                if hasOneDigit && hasOneLatter{
                    isStrongPassword = true
                }else{
                    isStrongPassword = false
                }
                imgEightChr.image = UIImage.init(systemName: "checkmark.circle.fill")
                imgEightChr.tintColor = UtilityManager.manager.getAppGreenColor()
                lblEightChr.textColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            }else{
                imgEightChr.image = UIImage.init(systemName: "multiply.circle.fill")
                imgEightChr.tintColor = UtilityManager.manager.getAppRedColor()
                lblEightChr.textColor = UIColor.lightGray
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtLogin.text = login
        
        self.txtLogin.isUserInteractionEnabled = false
        isStrongPassword = false
        hasOneLatter = false
        hasOneDigit = false
        hasEightChr = false
        
        txtPassword.delegate = self
        txtPassword.setPadding(12)
        txtRePassword.delegate = self
        txtRePassword.setPadding(12)
        txtLogin.delegate = self
        txtLogin.setPadding(12)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func updatePassword(_ sender:UIButton){
        
        
        if txtPassword.text != "" && txtRePassword.text != ""{
            if txtPassword.text != txtRePassword.text{
                UtilityManager.manager.showAlert(self, message: "Password do not match.", title: Constants.APP_NAME)
            }else{
                // api to reset
                PasswordManager.manager.updatePassword(params: [
                    "login":txtLogin.text!,"password":txtPassword.text!,"password_confirmation":txtRePassword.text!]) { result, message in
                        if result{
//                           login user
                            UserDefaults.standard.set(false, forKey: Constants.IS_PASSWORD_FORGOT)
                            UserDefaults.standard.set(false, forKey: Constants.IS_LOGIN)
                            UserDefaults.standard.set(nil, forKey: "authVerificationID")
                            UtilityManager.manager.showAlertWithAction(self, message: "Password updated login to continue.", title: Constants.APP_NAME, buttons: ["Login"]) { index in
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                           
                           
                        }else{
                            UtilityManager.manager.showAlert(self, message: message ?? "Error updating password", title: Constants.APP_NAME)
                            UserDefaults.standard.set(false, forKey: Constants.IS_PASSWORD_FORGOT)

                        }
                    }

            }
        }
        
        
        // api on sccess move to dashboard
        
    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
        
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == txtPassword{
            
            if string == " "{
                return false
            }
            
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                if hasNumber(password: updatedText){
                    hasOneDigit = true
                }else{
                    hasOneDigit = false
                }
                
                if hasPatitalLatter(password: updatedText){
                    hasOneLatter = true
                }else{
                    hasOneLatter = false
                }
                
                if hasPatitalLattersSmall(password: updatedText){
                    hasOneLatter = true
                }else{
                    hasOneLatter = false
                }
                
                if updatedText.count >= 8{
                    hasEightChr = true
                }else{
                    hasEightChr = false
                }
            }
            return true
        }
        else{
            return true
        }
        
    }
 
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.black.cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0{
            textField.layer.borderColor = UIColor.clear.cgColor
        }
        if textField.text == ""{
//            btnNext.disable()
        }else{
//            btnNext.enable()
        }
        return true
    }

    func hasPatitalLatter(password:String) -> Bool {

          let capitalLetterRegEx  = ".*[A-Z]+.*"
           let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
           let capitalresult = texttest.evaluate(with: password)
           print("\(capitalresult)")
           return capitalresult
       }
    
    func hasPatitalLattersSmall(password:String) -> Bool {

          let capitalLetterRegEx  = ".*[a-z]+.*"
           let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
           let capitalresult = texttest.evaluate(with: password)
           print("\(capitalresult)")
           return capitalresult
       }
       
       
       func hasNumber(password:String) -> Bool {

           let numberRegEx  = ".*[0-9]+.*"
              let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
           let numberresult = texttest1.evaluate(with: password)
              return numberresult
       }
    
}

