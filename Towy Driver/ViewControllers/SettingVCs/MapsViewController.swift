//
//  MapsViewController.swift
//  Oyla Captain
//
//  Created by apple on 11/25/20.
//  Copyright © 2020 Cyber Advance Solutions. All rights reserved.
//

import UIKit

class MapsViewController: UIViewController {

   @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var tblHeight:NSLayoutConstraint!

     var isSelected = -1
     
    
     
    var datasource = ["Google Map":true]
         
         override func viewDidLoad() {
             super.viewDidLoad()

             tblView.register(UINib.init(nibName: "MenuTableViewCell", bundle: .main), forCellReuseIdentifier: "MenuTableViewCell")
             tblHeight.constant = CGFloat(datasource.count * 62)
         }
         

         @IBAction func backTapped(_ sender:UIButton){
              UtilityManager.manager.moveBack(self)
             
         }

     }

     extension MapsViewController:UITableViewDataSource,UITableViewDelegate{
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return datasource.count
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
            return cell.setData(datasource, contentType: .MAPS)!
         }
         
         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 62
         }
         
         
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             let keys = Array(datasource.keys)
             let selectedKey = keys[indexPath.row]
             for (k,_) in datasource{
                 if k == selectedKey{
                     datasource.updateValue(true, forKey:k)
                 }else{
                     datasource.updateValue(false, forKey:k)
                 }
             }
             tableView.reloadData()
         }
     }
