//
//  WebViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 17/11/2022.
//

import UIKit
import WebKit


class WebViewController: UIViewController {

    
    @IBOutlet weak var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = URL(string: Constants.HTTP_CONNECTION_ROOT + Constants.GET_HELP_DATA_WEB)
                      
           webView.load(URLRequest(url: url!))
        
        
    }
    

    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

}
