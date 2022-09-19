//
//  SettingViewController.swift
//  TOWY Driver
//
//  Created by apple on 11/25/20.
//  Copyright © TOWY. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var btnLogout:UIButton!
    @IBOutlet weak var btnNo:UIButton!
    @IBOutlet weak var switchOnOff:UISwitch!
    
    @IBOutlet weak var tblHeight:NSLayoutConstraint!
    
    
    
    enum Setting:String{
        case UPDATE_PIN = "Update PIN"
        case BOOKING_TYPE = "Booking type"
        case MAPS = "Maps"
        case LANGUAGE = "Language"
        case VIBRATE = "Vibrate booking offer"
        case SIGNOUT = "Sign out"
    }
    
    var datasource = ["Update PIN","Booking type","Maps","Language"]
//    var datasource = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        btnLogout.setGradient(Radius: 8)
        
        tblView.register(UINib.init(nibName: "MenuTableViewCell", bundle: .main), forCellReuseIdentifier: "MenuTableViewCell")
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(hideBackView))
        backView.addGestureRecognizer(tapGes)
        tblHeight.constant = CGFloat(datasource.count * 62)
        
        if UserDefaults.standard.bool(forKey: Constants.IS_HAPTIC_FEEDBACK){
            switchOnOff.isOn = true
        }else{
            switchOnOff.isOn = false
        }
        
        
    }
    
    
    
    
    
    @objc func hideBackView(){
        self.backView.isHidden = true
        
    }
    
    @IBAction func logoutTapped(_ sender:UIButton){
        self.backView.isHidden = false
        
    }
    
    @IBAction func noTapped(_ sender:UIButton){
        self.backView.isHidden = true
        
    }
    
    @IBAction func yesTapped(_ sender:UIButton){
        logoutUser()
        
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK :- API CALLS
    
    
    func logoutUser(){
        LogoutManager.manager.LogoutUser { data, err in
            if err == nil{
                UtilityManager.manager.clearUserData()
                self.moveToLogin()
            }else{
                UtilityManager.manager.showAlert(self, message: err ?? "error login", title: Constants.APP_NAME)
            }
        }
    }
    
    func moveToLogin(){
        self.backView.isHidden = true
        UserDefaults.standard.set(false, forKey: Constants.IS_LOGIN)
        let story = UtilityManager.manager.getAuthStoryboard()
        let vc = story.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
    @IBAction func switchHaptic(_ sender:UISwitch){
        
        if sender.isOn{
            UserDefaults.standard.set(true, forKey: Constants.IS_HAPTIC_FEEDBACK)
            if #available(iOS 13.0, *) {
                UtilityManager.manager.addHapticFeedback(.rigid)
            } else {
                // Fallback on earlier versions
            }
        }else{
            UserDefaults.standard.set(false, forKey: Constants.IS_HAPTIC_FEEDBACK)
        }
        sender.isOn.toggle()
    }
    
    
}


extension SettingViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        return cell.setData(datasource[indexPath.row], contentType: .SETTINGS)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
//        case 1:
//            UtilityManager.manager.navigateToVc(from: self, identifier: "BookingTypeViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
        case 2 :
            UtilityManager.manager.navigateToVc(from: self, identifier: "MapsViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
//        case 3 :
//            UtilityManager.manager.navigateToVc(from: self, identifier: "LanguagesViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
        default:
            print("")
        }
    }
}
