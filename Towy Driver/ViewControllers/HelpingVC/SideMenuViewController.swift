//
//  SideMenuViewController.swift
//  Oyla Captain
//
//  Created by apple on 11/12/20.
//  Copyright © 2020 Cyber Advance Solutions. All rights reserved.

import UIKit
import Kingfisher

protocol MenuDelegate {
    func menuTapped(TappedMenu:Menu)
    func hide()
}

enum Menu:String {
    case CAPTAIL_PORTAL = "Partner Portal"
//    case TRANSACTIONS = "Transaction History"
//    case MESSAGE = "Message"
//    case MY_HOME = "Home"
//    case REFERRAL = "Referral"
    case HELP = "Help"
    case SETTINGS = "Settings"
    case LOGOUT = "Logout"
//    case REWARD = "Reward"
}


class SideMenuViewController: UIViewController {

    @IBOutlet weak var imgProfile:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblVehicleNumber:UILabel!
    @IBOutlet weak var lblRating:UILabel!
    @IBOutlet weak var lblreferral:UILabel!
    @IBOutlet weak var tblView:UITableView!
    
//    MenuModel.init(title: "Transaction History", image: "transaction"),
//    ,MenuModel.init(title: "Message", image: "message")
//    ,MenuModel.init(title: "Referral", image: "referral")
//    ,MenuModel.init(title: "Saved Locations", image: "home_location")
    
    var delegate:MenuDelegate!
    var datasource = [MenuModel.init(title: "Partner Portal", image: "captain"),MenuModel.init(title: "Help", image: "help"),MenuModel.init(title: "Settings", image: "setting"),MenuModel.init(title: "Logout", image: "home_location")]
//    var datasource = [MenuModel.init(title: "Settings", image: "setting"),MenuModel.init(title: "Partner Portal", image: "captain")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       tblView.register(UINib.init(nibName: "MenuTableViewCell", bundle: .main), forCellReuseIdentifier: "MenuTableViewCell")
         setUserProfile()
    }
   
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
       
       }
      
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate.hide()
    }
    
    
    //MARK :- IBACTION

   
    @IBAction func backTapped(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func rewardTapped(_ sender:UIButton){
//        UtilityManager.manager.navigateToVc(from: self, identifier: "LeadgerViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
//        self.dismiss(animated: true) { [self] in
//            delegate.menuTapped(TappedMenu: Menu.REWARD)
//        }
    }
    
    //MARK :- FUNCTIONS
    
    func setUserProfile(){
        lblName.text = UtilityManager.manager.getUserName()
        if let vehicleNumber = UtilityManager.manager.getVehicleNumber(){
            lblVehicleNumber.text = vehicleNumber
        }else{
            lblVehicleNumber.text = "missing"
        }
        if let rating = UtilityManager.manager.getDriverRating(){
            lblRating.text = "★ " + rating
        }else{
            lblRating.text = "★ 0.0"
        }
        if let id = UtilityManager.manager.getDriverReferralId(){
            lblreferral.text = id
        }else{
            lblreferral.text = ""
        }
        
        if let imageUrl = UtilityManager.manager.getUserImageUrl(){
            let u = URL.init(string: Constants.HTTP_CONNECTION_IMG+imageUrl)
            imgProfile.kf.setImage(with: u, placeholder: UIImage.init(named: "profile-1"), options: .none, progressBlock: nil) { (i, e, c, U) in
                if i != nil{
                    self.imgProfile.image = i
                }
            }
        }
    }

}

extension SideMenuViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as!  MenuTableViewCell
        if indexPath.row == 0 || indexPath.row == 2{
            cell.accessoryType = .none}else{cell.accessoryType = .disclosureIndicator}
        return cell.setData(datasource[indexPath.row], contentType: .HELP)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let lbl = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.lightGray
        let info = Bundle.main.infoDictionary
        guard let currentVersion = info?["CFBundleShortVersionString"] as? String else{
            return nil}
        lbl.text = "App Version " + currentVersion
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.movoToVC(index: indexPath)
            }
        }
    }
    
    
    func movoToVC(index:IndexPath){
        
        guard let menu = Menu.init(rawValue: datasource[index.row].title)else{return}
        delegate.menuTapped(TappedMenu: menu)
    }
    
}



extension SideMenuViewController{
    
    func convermationPopUp(title:String,yesTitle:String,noTitle:String,completionHandler:@escaping (_ result : Bool )-> Void){
        
    let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: yesTitle, style: .default, handler: { (action) in
            
            print("action")
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: noTitle, style: .default, handler: { (action) in
            
             completionHandler(false)
        }))

    self.present(alert, animated: true)
      
    }
}
