//
//  HistoryViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 19/03/2021.
//  Copyright © 2021 Cyber Advance Solutions. All rights reserved.
//

import UIKit
//import SwiftDate

class HistoryViewController: UIViewController {
    
    
    @IBOutlet weak var tblView:UITableView!
    
    
    var datasource = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SHOW_CUSTOM_LOADER()
        
        tblView.register(UINib.init(nibName: "RideHistoryTableViewCell", bundle: .main), forCellReuseIdentifier: "RideHistoryTableViewCell")
        
        for _ in 0...2{
            self.datasource.append(Trip.init())
        }
        
        HistoryManager.manager.getHistory(params: nil) { (data, err) in
            HIDE_CUSTOM_LOADER()
            if err == nil{
                let trips = data?["rides"] as? [[String:Any]]
                for i in trips! {
                    self.datasource.append(Trip.init(dict: i))
                }
                self.tblView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self, true)
    }
    
    
    
    
    
}

extension HistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideHistoryTableViewCell", for: indexPath) as! RideHistoryTableViewCell
        let ds = datasource[indexPath.row]
//        cell.lblDate.text =  UtilityManager.manager.getDateOfJoining(date: ds.updated_at)
//
//        cell.lblPrice.text = Constants.Currency + ": \(ds.passenger_cash_paid ?? 0)"
//        UtilityManager.manager.getAddressFromLatLong(latitude: Double(ds.pickup_latitude ?? "0.0") ?? 0.0, longitude: Double(ds.pickup_longitude ?? "0.0") ?? 0.0, completionHandler: { (adress) in
//            cell.lblPickup.text = adress
//        })
//        UtilityManager.manager.getAddressFromLatLong(latitude: Double(ds.dropoff_latitude ?? "0.0") ?? 0.0, longitude: Double(ds.dropoff_longitude ?? "0.0") ?? 0.0, completionHandler: { (adress) in
//            cell.lblDropoff.text = adress
//        })
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cel = cell as! RideHistoryTableViewCell
        
//        let ds = datasource[indexPath.row]
//        cel.lblDate.text =  UtilityManager.manager.getDateOfJoining(date: ds.updated_at)
//        
//        cel.lblPrice.text = Constants.Currency + ": \(ds.passenger_cash_paid ?? 0)"
//        UtilityManager.manager.getAddressFromLatLong(latitude: Double(ds.pickup_latitude ?? "0.0") ?? 0.0, longitude: Double(ds.pickup_longitude ?? "0.0") ?? 0.0, completionHandler: { (adress) in
//            cel.lblPickup.text = adress
//        })
//        UtilityManager.manager.getAddressFromLatLong(latitude: Double(ds.dropoff_latitude ?? "0.0") ?? 0.0, longitude: Double(ds.dropoff_longitude ?? "0.0") ?? 0.0, completionHandler: { (adress) in
//            cel.lblDropoff.text = adress
//        })
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let st = UtilityManager.manager.getDashboardStoryboard()
//        let vc = st.instantiateViewController(withIdentifier: "RideDetailsViewController") as! RideDetailsViewController
//        vc.trip = datasource[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



