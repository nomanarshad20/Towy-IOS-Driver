//
//  Help1ViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 08/11/2022.
//

import UIKit
import WebKit

class Help1ViewController: UIViewController {

    
    @IBOutlet weak var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        getHelpData()
    }
    
    func getHelpData(){
        HelpManager.manager.getHelpWebContent { result, message in
            print(result)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
