//
//  OtpViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit
import SVPinView
import FirebaseAuth

class OtpViewController: UIViewController {
    
    @IBOutlet weak var pinView:SVPinView!
    @IBOutlet weak var lblPhoneNumber:UILabel!
    @IBOutlet weak var btnResend:UIButton!
    @IBOutlet weak var btnNext:UIButton!
    
    
    
    var WT:Timer!
    var phoneNumber = ""
    var waitingTime = 30
    var user = User()
    var isEmail = false
    var isPasswordReset = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ratingCompleted), name:NSNotification.Name( Constants.NotificationObservers.DRIVER_RATED_THE_CUSTOMER.rawValue), object: nil)
        self.btnResend.setTitleColor( UIColor.gray, for: .normal)
        WT = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateWaitingTime), userInfo: nil, repeats: true)
        
        lblPhoneNumber.text = "Enter the OTP code sent to you at " + phoneNumber
        
        pinView.style = .box
        pinView.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        if isEmail{
            pinView.pinLength = 4
        }
        pinView.becomeFirstResponderAtIndex = 0
        pinView.frame = self.view.frame
        btnNext.isUserInteractionEnabled = false
        btnNext.backgroundColor =  UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
        pinView.didFinishCallback = { [self] pin in
            btnNext.isUserInteractionEnabled = true
            btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
        }
        pinView.didChangeCallback = { [self] pin in
            if pin.count != 6{
                btnNext.isUserInteractionEnabled = false
                btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: Constants.IS_PASSWORD_FORGOT){
           isPasswordReset = true
        }
    }
    
    
    @objc func updateWaitingTime(){
        if waitingTime == 0{
            if WT != nil{
                WT.invalidate()
                WT = nil
            }
            waitingTime = 30
            self.pinView.clearPin(completionHandler: nil)
            btnResend.isUserInteractionEnabled = true
            btnResend.setTitleColor(UIColor.white, for: .normal)
            btnResend.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            btnResend.setTitle("I didn't receive a code", for: .normal)
        }else{
            
            btnResend.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeTextColor.rawValue)
            btnResend.isUserInteractionEnabled = false
            waitingTime -= 1
            btnResend.isHidden = false
            btnResend.setTitle("I didn't receive a code( "+timeString(time: TimeInterval(waitingTime)) + " )", for: .normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        if hours == 0 && minutes < 10 {
            
            self.btnResend.setTitleColor( UIColor.gray, for: .normal)
            
        }
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
    
    @IBAction func resendOtp(_ sender: Any) {
        
        
        
        
        SHOW_CUSTOM_LOADER()
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(self.phoneNumber, uiDelegate: nil) { verificationID, error in
                HIDE_CUSTOM_LOADER()
                if let error = error {
                    UtilityManager.manager.showAlert(self, message: error.localizedDescription, title: "Oops")
                    return
                }else{
                    self.pinView.clearPin(completionHandler: nil)
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    self.WT = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateWaitingTime), userInfo: nil, repeats: true)
                }
                // Sign in using the verificationID and the code sent to the user
                // ...
            }

    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        if isEmail{
            SHOW_CUSTOM_LOADER()
            OTPManager.manager.codeVerifyApi(email:self.phoneNumber, pin: pinView.getPin()) { result, message in
                HIDE_CUSTOM_LOADER()
                if result{
                    print("llkfnkd")
                }else{
                    UtilityManager.manager.showAlert(self, message: message ?? "error verifying OTP" , title: "Oops")
                }
            }
        }else{
            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID,
                verificationCode: pinView.getPin())
            SHOW_CUSTOM_LOADER()
            Auth.auth().signIn(with: credential) { authResult, error in
                HIDE_CUSTOM_LOADER()
                if let error = error {
                    UtilityManager.manager.showAlert(self, message: error.localizedDescription , title: "Oops")
                    
                }else{
                    
                    if !self.isPasswordReset{
                        UserDefaults.standard.set(true, forKey: Constants.IS_LOGIN)
                        UserDefaults.standard.set(nil, forKey: "authVerificationID")
                        
                        self.user.mobile_no = self.phoneNumber
                        
                        let st = UtilityManager.manager.getAuthStoryboard()
                        let vc = st.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                        vc.user = self.user
                        UtilityManager.manager.saveModelInUserDefaults(key: Constants.APP_USER, data: User.getDictFromUser(user: self.user))
                        //                  UserDefaults.standard.set(2, forKey: Constants.REGISTRATION_STATUS)
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let st = UtilityManager.manager.getAuthStoryboard()
                        let vc = st.instantiateViewController(withIdentifier: "PasswordResetViewController") as! PasswordResetViewController
                        vc.login = self.phoneNumber
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                   
                }
                
                
            }
            
        }
        
        
        
    }
    
    
    @IBAction func loginWithPass(_ sender:UIButton){
        let st = UtilityManager.manager.getAuthStoryboard()
        let vc = st.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        vc.isLogin = true
        self.user.mobile_no =  self.phoneNumber
        vc.user = self.user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
        UserDefaults.standard.set(false, forKey: Constants.IS_PASSWORD_FORGOT)
        UtilityManager.manager.moveBack(self)
    }
    
}
