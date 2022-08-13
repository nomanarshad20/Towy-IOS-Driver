//
//  TruckTypeViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class TruckTypeViewController: UIViewController {

    
    @IBOutlet weak var tblView:UITableView!
    
    var datasource = [Truck]()
    
    
    var truckId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib.init(nibName: "TruckTypeTableViewCell", bundle: .main), forCellReuseIdentifier: "TruckTypeTableViewCell")
        getTruckTypes()
    }
    
    @IBAction func nextTapped(_ sender:UIButton){
        UtilityManager.manager.gotoVC(from: self, identifier: "DocumentsViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }

    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

    func getTruckTypes(){
        SHOW_CUSTOM_LOADER()
        TruckManager.manager.getTruckTypes { result, message in
            HIDE_CUSTOM_LOADER()
            if message == nil{
                if result?.count ?? 0 > 0{
                    self.datasource = result!
                    self.tblView.reloadData()
                }
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "Error Getting Trucks Type Form Server.", title: Constants.APP_NAME)
            }
        }
        
    }
    
    
}

extension TruckTypeViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckTypeTableViewCell", for: indexPath) as! TruckTypeTableViewCell
        cell.lblName.text = datasource[indexPath.row].name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.truckId = "\(datasource[indexPath.row].id ?? 0)"
        UtilityManager.manager.showAlertWithAction(self, message: "You want to select: \n \(datasource[indexPath.row].name ?? "")", title: "Truck Type", buttons: ["Yes","NO"]) { index in
            if index == 0{
                self.setTruckType()
            }
        }
        
    }
   
    
    func setTruckType(){
        TruckManager.manager.saveTruckType(truckId: self.truckId) { result, message in
            if result ?? false{
                UtilityManager.manager.gotoVC(from: self, identifier: "SSNViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "error saving truck type.", title: "Oops")
            }
        }
    }
    
}
