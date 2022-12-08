//
//  CustomSplashViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class CustomSplashViewController: UIViewController {
    
    @IBOutlet weak var viewLogo:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        UserDefaults.standard.set(false,forKey: Constants.IS_LOGIN)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            // HERE
            self.viewLogo.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5) // Scale your image
            
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                
                self.viewLogo.transform = CGAffineTransform.identity // undo in 1 seconds
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    
                    
                    self.getRegistrationStatus(status: UserDefaults.standard.integer(forKey: Constants.REGISTRATION_STATUS))
                    
//                    if UserDefaults.standard.bool(forKey: Constants.IS_LOGIN){
//                        let story = UtilityManager.manager.getMainStoryboard()
//                        let vc = story.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
//                        //                    let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
//
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CityNameViewController") as! CityNameViewController
//                    vc.user = User()
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    }else{
//                        let story = UtilityManager.manager.getAuthStoryboard()
//                        let vc = story.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
//                        self.navigationController?.pushViewController(vc, animated: true)
//
////                        let story = UtilityManager.manager.getAuthStoryboard()
////                        let vc = story.instantiateViewController(withIdentifier: "TruckTypeViewController") as! TruckTypeViewController
////                        self.navigationController?.pushViewController(vc, animated: true)
//
//                    }
                    
                    
                })
            })
        }
    }
    
    
    
    func getRegistrationStatus(status:Int? = 0){
            switch status {
            case 1:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "SSNViewController") as! SSNViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:
                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
                if UserDefaults.standard.integer(forKey: Constants.IS_VERIFIED) == 1{
                    let story = UtilityManager.manager.getMainStoryboard()
                    let vc = story.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
                    UserDefaults.standard.set(true, forKey: Constants.IS_LOGIN)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let story = UtilityManager.manager.getAuthStoryboard()
                    let vc = story.instantiateViewController(withIdentifier: "WaitForApprovalViewController") as! WaitForApprovalViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            default:
                
//                UserDefaults.standard.set(status, forKey: Constants.REGISTRATION_STATUS)
//                let story = UtilityManager.manager.getAuthStoryboard()
//                let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
//                self.navigationController?.pushViewController(vc, animated: true)
                
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        
     }
    
}

