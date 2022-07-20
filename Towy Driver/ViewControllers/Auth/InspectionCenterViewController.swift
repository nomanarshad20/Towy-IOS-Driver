//
//  InspectionCenterViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 14/07/2022.
//

import UIKit

class InspectionCenterViewController: UIViewController {
        
        @IBOutlet weak var tblView:UITableView!
        
    
    
    var datasource = [InspectionCenter]()
    
        override func viewDidLoad() {
            super.viewDidLoad()

            
            datasource = [InspectionCenter.init(id: "1", location: "Gulberg ||| Lahore", distance: "2.3", addressName: "Itfaq Tranding center", rate: "30$"),InspectionCenter.init(id: "2", location: "DHA Phase 5 Lahore", distance: "5.9", addressName: "Ali Tranding center", rate: "30$")]
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(UINib.init(nibName: "InspectionTableViewCell", bundle: .main), forCellReuseIdentifier: "InspectionTableViewCell")
            
        }
        
        @IBAction func nextTapped(_ sender:UIButton){
            UtilityManager.manager.gotoVC(from: self, identifier: "DocumentsViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
        }

        @IBAction func backTapped(_ sender:UIButton){
            UtilityManager.manager.moveBack(self)
        }

    }

    extension InspectionCenterViewController:UITableViewDataSource,UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return datasource.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InspectionTableViewCell", for: indexPath) as! InspectionTableViewCell
            let ds = datasource[indexPath.row]
            cell.lblAddressName.text = ds.addressName
            cell.lblDistance.text = ds.distance + " mi"
            cell.lblLocation.text = ds.location
            cell.lblRate.text = "   " + ds.rate + " per Inspection   "
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 165
        }
        
        
    }
