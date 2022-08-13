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
                    let story = UtilityManager.manager.getMainStoryboard()
                    let vc = story.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
//                    let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController

//                    let vc = story.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                })
            })
        }
    }
    
    
    
    func getRegistrationStatus(status:Int? = 0){
            switch status {
            case 0:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "ReferralCodeViewController") as! ReferralCodeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "CityNameViewController") as! CityNameViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                let story = UtilityManager.manager.getAuthStoryboard()
                let vc = story.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        
     }
    
}

