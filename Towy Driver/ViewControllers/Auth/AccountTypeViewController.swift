//
//  AccountTypeViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class AccountTypeViewController: UIViewController {

    
    @IBOutlet weak var btnNext:UIButton!
    @IBOutlet weak var viewWorkShop:UIView!
    @IBOutlet weak var viewTowService:UIView!
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.disable()

    }
    

    @IBAction func btnNext(_ sender: Any) {
        
    
        UtilityManager.manager.gotoVC(from: self, identifier: "AboutVehicleViewController", storyBoard: UtilityManager.manager.getAuthStoryboard()) 
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }


    @IBAction func btnWorkshopTapped(_ sender:UIButton){
        btnNext.enable()
        viewWorkShop.layer.borderWidth = 2
        viewTowService.layer.borderWidth = 0
    }

    
    @IBAction func btnTowTapped(_ sender:UIButton){
        btnNext.enable()
        viewTowService.layer.borderWidth = 2
        viewWorkShop.layer.borderWidth = 0
    }
    
    
    

}
