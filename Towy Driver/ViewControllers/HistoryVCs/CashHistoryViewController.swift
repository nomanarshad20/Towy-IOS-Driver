//
//  CashHistoryViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 29/06/2021.
//  Copyright © 2021 Cyber Advance Solutions. All rights reserved.
//

import UIKit
import CarbonKit

class CashHistoryViewController: UIViewController {

    
    @IBOutlet weak var tblView:UITableView!
    
    var datasource = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tblView.dataSource = self
        tblView.delegate = self
        tblView.estimatedRowHeight = 400
        tblView.register(UINib.init(nibName: "TransactionHistoryTableViewCell", bundle: .main), forCellReuseIdentifier: "TransactionHistoryTableViewCell")
    }
    

    func loadData(){
        
        tblView.reloadData()
        
    }
    
    
}



extension CashHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryTableViewCell", for: indexPath) as! TransactionHistoryTableViewCell
        let ds = datasource[indexPath.row]
        cell.lblDate.text =  UtilityManager.manager.getDateOfJoining(date: ds.updated_at)

        cell.lblAmount.text = Constants.Currency + ": \(ds.amount ?? 0)"
        cell.lblDescription.text = ds.description
        cell.lblBookingId.text = "\(Constants.APP_NAME)-\(ds.id ?? 0)"
        cell.lblDate.text = UtilityManager.manager.getDateOfJoining(date: ds.created_at)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cel = cell as! TransactionHistoryTableViewCell
        
        let ds = datasource[indexPath.row]
        cel.lblDate.text =  UtilityManager.manager.getDateOfJoining(date: ds.updated_at)

        cel.lblAmount.text = Constants.Currency + ": \(ds.amount ?? 0)"
        cel.lblDescription.text = ds.description
        cel.lblBookingId.text = "\(Constants.APP_NAME)-\(ds.id ?? 0)"
        cel.lblDate.text = UtilityManager.manager.getDateOfJoining(date: ds.created_at)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
    
   
}


    
