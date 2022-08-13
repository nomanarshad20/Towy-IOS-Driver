//
//  CustomAlertViewWithActionsViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 03/08/2022.
//

import UIKit

class CustomAlertViewWithActionsViewController: UIViewController {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblMsg:UILabel!
    @IBOutlet weak var btnAction:UIButton!
    
    
    var txt = ""
    var msg = ""
    var buttons = [String]()
    
    var onCompletion: ((_ success: Int) -> ())?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMsg.text = msg
        lblTitle.text = txt
        btnAction.setTitle(buttons.first, for: .normal)
       
    }
    

    @IBAction func backTapped(_ sender:UIButton){
        
        
        
        UtilityManager.manager.moveBack(self, false)
        
    }

    
    @IBAction func actionTapped(_ sender:UIButton){
        
        onCompletion!(1)
        UtilityManager.manager.moveBack(self, false)
        
    }
    
}
