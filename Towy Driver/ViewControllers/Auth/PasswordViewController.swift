//
//  PasswordViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class PasswordViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var txtPassword:UITextField!
    
    @IBOutlet weak var imgOneLatter:UIImageView!
    @IBOutlet weak var lblOneLatter:UILabel!
    
    @IBOutlet weak var imgEightChr:UIImageView!
    @IBOutlet weak var lblEightChr:UILabel!
    
    @IBOutlet weak var imgOneDigit:UIImageView!
    @IBOutlet weak var lblOneDigit:UILabel!
    
    @IBOutlet weak var btnShowPassword:UIButton!
    @IBOutlet weak var btnForgot:UIButton!

    @IBOutlet weak var btnNext:UIButton!
    
    
    @IBOutlet weak var lblTopTitle:UILabel!

    
    
    var isPasswordVisible = false
    var user = User()
    var isLogin = false
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

        if isLogin{
            lblTopTitle.text = "Enter your account password"
            btnForgot.isHidden = false
        }
        
//        if user.mobileNumber == nil{
//            user = UtilityManager.manager.getModelFromUserDefalts(key: Constants.APP_USER)
//        }
        
        print(user)
        
        isStrongPassword = false
        hasOneLatter = false
        hasOneDigit = false
        hasEightChr = false
        
        txtPassword.delegate = self
        txtPassword.setPadding(12)
        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnShowpass(_ sender: Any) {
        if isPasswordVisible{
            btnShowPassword.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)
            txtPassword.isSecureTextEntry = true
        }else{
            btnShowPassword.setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
            txtPassword.isSecureTextEntry = false
        }
        isPasswordVisible.toggle()
    }

    @IBAction func btnNext(_ sender: Any) {
        
        
        if !isLogin{
        
        self.user.password = self.txtPassword.text!
        
        let st = UtilityManager.manager.getAuthStoryboard()
        let vc = st.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
        vc.user = self.user
        UtilityManager.manager.saveModelInUserDefaults(key: Constants.APP_USER, data: User.getDictFromUser(user: user))
//        UserDefaults.standard.set(3, forKey: Constants.REGISTRATION_STATUS)
        if self.navigationController != nil{
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.present(vc , animated: true, completion: nil)
            }
        
        }else{
            
            self.signInUser()
            
        }
    }
    
    
    
    @IBAction func forgotTapped(_ sender:UIButton){
    
        UserDefaults.standard.set(true, forKey: Constants.IS_PASSWORD_FORGOT)
        UtilityManager.manager.moveBack(self)
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
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
       
    
    
    
    func signInUser(){
        
        let params = ["user_type":"2",
                      "fcm_token":UtilityManager.manager.getFcmToken(),
                      "password":txtPassword.text!,
                      "login":user.mobile_no ?? user.email]
        SHOW_CUSTOM_LOADER()
        LoginManager.manager.Login(param: params as [String : Any], completionHandler: { status, message in
            HIDE_CUSTOM_LOADER()
            if message == nil{
                if self.isLogin{
                    self.getRegistrationStatus(status: status)
                }else{
                    
                    UtilityManager.manager.gotoVC(from: self, identifier: "SSNViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
                }
            }else{
                UtilityManager.manager.showAlert(self, message: message!, title: "Oops")
            }
        })
        
    }
    
    
    
    func getRegistrationStatus(status:Int? = 0){
            switch status {
            case 1:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "SSNViewController") as! SSNViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                if UserDefaults.standard.integer(forKey: Constants.IS_VERIFIED) == 1{
                    let story = UtilityManager.manager.getMainStoryboard()
                    let vc = story.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
                    UserDefaults.standard.set(true, forKey: Constants.IS_LOGIN)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let story = UtilityManager.manager.getAuthStoryboard()
                    let vc = story.instantiateViewController(withIdentifier: "WaitForApprovalViewController") as! WaitForApprovalViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            default:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        
     }
    
    }
