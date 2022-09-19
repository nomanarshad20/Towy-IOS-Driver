//
//  WaitForApprovalViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class WaitForApprovalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set(0, forKey: Constants.REGISTRATION_STATUS)

    }
    

    @IBAction func nextTapped(_ sender:UIButton){
//        UtilityManager.manager.gotoVC(from: self, identifier: "WaitForApprovalViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }

    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

}
