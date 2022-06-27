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
                     UtilityManager.manager.gotoVC(from: self, identifier: "WelcomeViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
                 })
           })
        }
    }
    
        
}
