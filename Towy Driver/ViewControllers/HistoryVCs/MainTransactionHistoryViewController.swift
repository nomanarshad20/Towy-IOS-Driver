//
//  MainTransactionHistoryViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 29/06/2021.
//  Copyright © TOWY. All rights reserved.
//

import UIKit
import CarbonKit


class MainTransactionHistoryViewController: UIViewController {

    
    
    let items = ["Cash", "Wallet", "Bouns"]
    
    var cashDatasource = [Transaction]()
    var walletDatasource = [Transaction]()
    var bounsDatasource = [Transaction]()
    var carbonTabSwipeNavigation:CarbonTabSwipeNavigation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTransactions()
        
        
    }

    
    func getTransactions(){
        SHOW_CUSTOM_LOADER()
        TransactionsManager.manager.getHistory { (transation, err) in
            HIDE_CUSTOM_LOADER()
            if err == nil{
                if let trans = transation?["BonusTransaction"]{
                    self.bounsDatasource = trans
                }
                if let trans = transation?["CashTransaction"]{
                    self.cashDatasource = trans
                }
                if let trans = transation?["WalletTransaction"]{
                    self.walletDatasource = trans
                }
                self.setupController()
            }else{
                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: err ?? "Error loading Transations")
            }
        }
        
        
    }
   
    
    func setupController(){
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.width/3, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.width/3, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.width/3, forSegmentAt: 2)
        carbonTabSwipeNavigation.currentTabIndex = 0
//        carbonTabSwipeNavigation.setSelectedColor(UIColor.YELLOW_THEME_COLOR)
//        carbonTabSwipeNavigation.setNormalColor(UIColor.Gray97)
//        carbonTabSwipeNavigation.setIndicatorColor(UIColor.YELLOW_THEME_COLOR)
    }
    
}

extension MainTransactionHistoryViewController:CarbonTabSwipeNavigationDelegate{
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "CashHistoryViewController") as! CashHistoryViewController
            vc.datasource = cashDatasource
            return vc
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "WalletHistoryViewController") as! WalletHistoryViewController
            vc.datasource = walletDatasource
            return vc
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "BounsHistoryViewController") as! BounsHistoryViewController
            vc.datasource = bounsDatasource
            return vc
        default:
            print("dfsd")
        }
        return UIViewController()
    }
    
}
