//
//  AllLoaders.swift
//  Towy Driver
//
//  Created by Macbook Pro on 19/06/2022.
//


import UIKit
import NVActivityIndicatorView


private var activityRestorationIdentifier: String {
    return "NVActivityIndicatorViewContainer"
}

public func ShowLoaderWithMessage(message:String) {
    startActivityAnimating(size: CGSize(width:56, height:56), message: message, type: NVActivityIndicatorType.ballScale, color: #colorLiteral(red: 0.9764705882, green: 0.7176470588, blue: 0, alpha: 1), padding: 2,isFromOnView: false)
}


//MARK:- ShowLoader
//Mark:-

// MARK: - INTERNET CHECK

//func IS_INTERNET_AVAILABLE() -> Bool{
//    return AIReachabilityManager.sharedManager.isInternetAvailableForAllNetworks()
//}
//func SHOW_INTERNET_ALERT(){
//    HIDE_CUSTOM_LOADER()
//    HIDE_NETWORK_ACTIVITY_INDICATOR()
    
  //  displayAlertWithTitle(APP_NAME, andMessage: "Please check your internet connection and try again.", buttons: ["Dismiss"], completion: nil)
//}
public func SHOW_CUSTOM_LOADER() {
    startActivityAnimating(size: CGSize(width:56, height:56), message: nil, type: NVActivityIndicatorType.ballScale, color:#colorLiteral(red: 0.9764705882, green: 0.7176470588, blue: 0, alpha: 1), padding: 2,isFromOnView: false)
}

public func SHOW_CUSTOM_LOADER_MSG(message: String) {
    startActivityAnimating(size: CGSize(width:56, height:56), message: message, type: .ballRotateChase, color: UIColor.black.withAlphaComponent(0.60), padding: 2, isFromOnView: false)
}

//MARK:- Hide Loader
//MARK:-


public func HIDE_CUSTOM_LOADER() {
    stopActivityAnimating(isFromOnView: false)
}


//MARK:- ShowLoaderOnView
//Mark:-


public func ShowLoaderOnView() {
    startActivityAnimating(size: CGSize(width:56, height:56), message: nil, type: NVActivityIndicatorType.ballScale, color: UIColor.yellow, padding: 2,isFromOnView: true)
}


//MARK:- HideLoaderOnView
//MARK:-


public func HideLoaderOnView() {
    stopActivityAnimating(isFromOnView: true)
}

private func startActivityAnimating(size: CGSize? = nil, message: String? = nil, type: NVActivityIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil, isFromOnView:Bool) {
    let activityContainer: UIView = UIView(frame: CGRect(x:0, y:0,width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
    activityContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    activityContainer.restorationIdentifier = activityRestorationIdentifier
    
    activityContainer.isUserInteractionEnabled = false
    let actualSize = size ?? CGSize(width:56,height:56)
    
    let activityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x:0, y:0, width:actualSize.width, height:actualSize.height),
        type: type!,
        color: color!,
        padding: padding!)
    
    activityIndicatorView.center = activityContainer.center
    activityIndicatorView.startAnimating()
    activityContainer.addSubview(activityIndicatorView)
    
    
    if message != nil {
        let width = activityContainer.frame.size.width / 2
        if let message = message , !message.isEmpty {
            let label = UILabel(frame: CGRect(x:0, y:0,width:width, height:30))
            label.center = CGPoint(
                x:activityIndicatorView.center.x, y:
                activityIndicatorView.center.y + actualSize.height)
            label.textAlignment = .center
            label.text = message
            //label.font = UIFont.appFont_Karla_Regular_WithSize(16.0)
            label.textColor = activityIndicatorView.color
            activityContainer.addSubview(label)
        }
    }
    UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
    if isFromOnView == true {
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(activityContainer)
    }
    else {
        UIApplication.shared.keyWindow?.addSubview(activityContainer)
    }
}

/**
 Stop animation and remove from view hierarchy.
 */

private func stopActivityAnimating(isFromOnView:Bool) {
    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
    if isFromOnView == true {
        for item in (UIApplication.shared.keyWindow?.rootViewController?.view.subviews)!
            where item.restorationIdentifier == activityRestorationIdentifier {
                item.removeFromSuperview()
        }
    }else{
        for item in (UIApplication.shared.keyWindow?.subviews)!
                  where item.restorationIdentifier == activityRestorationIdentifier {
                      item.removeFromSuperview()
              }
        
    }
//    else {
//        if IS_INTERNET_AVAILABLE()
//        {
      
//        }else{
//            SHOW_INTERNET_ALERT()
//        }
//
//    }
}
