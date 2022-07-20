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
    @IBOutlet weak var btnResend:UIButton!
    @IBOutlet weak var btnNext:UIButton!
    
    
    
    var WT:Timer!
    var phoneNumber = ""
    var waitingTime = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnResend.setTitleColor( UIColor.gray, for: .normal)
        WT = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateWaitingTime), userInfo: nil, repeats: true)
        
        lblPhoneNumber.text = "Enter the 4-digit code sent to you at " + phoneNumber
        
        pinView.style = .box
        pinView.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        
        pinView.becomeFirstResponderAtIndex = 0
        pinView.frame = self.view.frame
        btnNext.isUserInteractionEnabled = false
        btnNext.backgroundColor =  UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
        pinView.didFinishCallback = { [self] pin in
            btnNext.isUserInteractionEnabled = true
            btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
        }
        pinView.didChangeCallback = { [self] pin in
            if pin.count != 4{
                btnNext.isUserInteractionEnabled = false
                btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func updateWaitingTime(){
        if waitingTime == 0{
            if WT != nil{
            WT.invalidate()
                WT = nil
            }
            waitingTime = 30
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
        
        
        
        WT = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateWaitingTime), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
    
        UtilityManager.manager.gotoVC(from: self, identifier: "PasswordViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
}
