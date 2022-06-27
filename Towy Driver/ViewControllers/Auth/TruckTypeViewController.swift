//
//  TruckTypeViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class TruckTypeViewController: UIViewController {

    
    @IBOutlet weak var tblView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib.init(nibName: "TruckTypeTableViewCell", bundle: .main), forCellReuseIdentifier: "TruckTypeTableViewCell")
        
    }
    
    @IBAction func nextTapped(_ sender:UIButton){
        UtilityManager.manager.gotoVC(from: self, identifier: "DocumentsViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }

    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

}

extension TruckTypeViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckTypeTableViewCell", for: indexPath) as! TruckTypeTableViewCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
