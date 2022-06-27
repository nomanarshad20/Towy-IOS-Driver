//
//  WelcomeViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func nextTapped(_ sender:UIButton){
        UtilityManager.manager.gotoVC(from: self, identifier: "MobileNumberViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
    @IBAction func loginTapped(_ sender:UIButton){
        UtilityManager.manager.gotoVC(from: self, identifier: "MobileNumberViewController", storyBoard: UtilityManager.manager.getAuthStoryboard()) 
    }
    
}
