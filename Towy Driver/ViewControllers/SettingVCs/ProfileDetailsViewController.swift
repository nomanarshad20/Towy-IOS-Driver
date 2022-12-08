//
//  ProfileDetailsViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 17/03/2021.
//  Copyright © TOWY. All rights reserved.
//

import UIKit

class ProfileDetailsViewController: UIViewController {

    
    @IBOutlet weak var tblSettings:UITableView!
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var btnServices:UIButton!
    @IBOutlet weak var stackServices:UIStackView!
//    @IBOutlet weak var tblsSettingHeightConstraint:NSLayoutConstraint!
    
    
    var detailsDatasource = [[String]]()
    var mainDatasource = [[String]]()
    var manager = UtilityManager.manager
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if UtilityManager.manager.getUserType() == 2{
            btnServices.isHidden = true
            stackServices.isHidden = true
        }
        
        detailsDatasource = [["\(manager.getId())","\(manager.getDriverStatus())","\(manager.getFranchiseName())","\(manager.getSSN() ?? "_")","\(manager.getDateOfJoining() ?? "_")"],["\(manager.getVehicleNumber()!)","\(manager.getVehicleModelYear()!)","_"]]
        
        
        mainDatasource = [["Captain ID","Status","Franchise Name","SSN","Date of Joining"],["Model","Year"]]
        
        
        tblSettings.register(UINib.init(nibName: "ProfileTableViewCell", bundle: .main), forCellReuseIdentifier: "ProfileTableViewCell")
        tblSettings.estimatedRowHeight = 200
//        tblsSettingHeightConstraint.constant = CGFloat((mainDatasource[0].count + mainDatasource[1].count) * 52 )
        
        lblName.text = UtilityManager.manager.getUserName()
        
        
        
        if let imageUrl = UtilityManager.manager.getUserImageUrl(){
            let u = URL.init(string: Constants.HTTP_CONNECTION_ROOT_ASSETS+imageUrl)
            profileImage.kf.setImage(with: u, placeholder: UIImage.init(named: "profile-1"), options: .none, progressBlock: nil) { (i, e, c, U) in
                if i != nil{
                    self.profileImage.image = i
                }
            }
        }
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self, true)
    }

    
    @IBAction func historyTapped(_ sender:UIButton){
        UtilityManager.manager.navigateToVc(from: self, identifier: "HistoryViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
    }
    
    @IBAction func servicesTapped(_ sender:UIButton){
        UtilityManager.manager.navigateToVc(from: self, identifier: "ServicesListViewController", storyBoard: UtilityManager.manager.getDashboardStoryboard())
    }
    
    
    
}

extension ProfileDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 5
        }else{
           return 2
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.lblMainOption.text = mainDatasource[indexPath.section][indexPath.row]
        cell.lblDetails.text = detailsDatasource[indexPath.section][indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 80))
        let lbl = UILabel.init(frame: CGRect.init(x: v.frame.width / 2 - 50, y: 30, width: v.frame.width, height: 40))
        lbl.text = "Car Info"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        v.addSubview(lbl)
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0{
            return 80
        }else{
            return 0
        }
    }
    
}
