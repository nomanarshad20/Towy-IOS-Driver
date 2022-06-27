//
//  AllExtensions.swift
//  Towy Driver
//
//  Created by Macbook Pro on 19/06/2022.
//


import UIKit
extension UIViewController {
    var storyboardId: String {
        return value(forKey: "storyboardIdentifier") as? String ?? "none"
    }
}
extension UIApplication {
   class func getTopViewController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate
        if let window = appDelegate!.window {
            return window?.topViewController()
        }
        return nil
    }
}
extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

extension UIView{
    
    func springAnimation(delay:Double = 0.5){
        let oldSize = self.bounds.size.width
        self.bounds.size.width = 0.0
        UIView.animate(withDuration: 1.0, delay: delay, usingSpringWithDamping: 0.3, initialSpringVelocity:0.2, options: [],animations: {
            self.bounds.size.width = oldSize
        }, completion: nil)
    }
    
}
