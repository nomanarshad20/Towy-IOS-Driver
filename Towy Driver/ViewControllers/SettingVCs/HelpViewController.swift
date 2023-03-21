//
//  HelpViewController.swift
//  TOWY Driver
//
//  Created by apple on 11/24/20.
//  Copyright © TOWY. All rights reserved.
//

import UIKit



class HelpViewController: UIViewController {

    
    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var tblHeight:NSLayoutConstraint!
    
    enum Help:String{
        case TRIP = "Trip issue and help"
        case BONUS = "Bonus & Guarantees"
        case APP_ISSUES = "App issues"
        case EARNING = "Earnings & payments"
        case ACCOUNT = "Account & profile"
        case PERFORMANCE = "Performance"
        case SAFETY = "Personal safety"
        case OTHERS = "Others"
        
    }
    
    
    var dataSource = [HelpDataModel.init(title: Help.TRIP.rawValue, image:"carFront", id: "tripissue"),HelpDataModel.init(title: Help.BONUS.rawValue, image:"bonus", id: "bouns"),HelpDataModel.init(title: Help.APP_ISSUES.rawValue, image:"appIssue", id: "appissue"),HelpDataModel.init(title: Help.EARNING.rawValue, image:"earning", id: "earnings"),HelpDataModel.init(title: Help.ACCOUNT.rawValue, image:"account", id: "accounts"),HelpDataModel.init(title: Help.PERFORMANCE.rawValue, image: "starGray", id: "performance"),HelpDataModel.init(title: Help.SAFETY.rawValue, image: "others", id: "personalsaftey"),HelpDataModel.init(title: Help.OTHERS.rawValue, image: "others", id: "others")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tblView.register(UINib.init(nibName: "MenuTableViewCell", bundle: .main), forCellReuseIdentifier: "MenuTableViewCell")
        tblHeight.constant = CGFloat(dataSource.count * 50)
    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
         UtilityManager.manager.moveBack(self)
    }
}


extension HelpViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        return cell.setData(dataSource[indexPath.row], contentType: .HELP_DETAILS)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
//            let st = UtilityManager.manager.getDashboardStoryboard()
//            let vc = st.instantiateViewController(withIdentifier: "HelpDetailsViewController") as! HelpDetailsViewController
//            vc.params = ["page":dataSource[indexPath.row].id ?? "bouns","type":2,"user_id":UtilityManager.manager.getId()]
//        vc.ttl = dataSource[indexPath.row].title
//            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
