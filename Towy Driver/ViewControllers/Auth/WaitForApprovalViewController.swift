//
//  WaitForApprovalViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit

class WaitForApprovalViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var txtMessage:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtMessage.delegate = self
        
        UserDefaults.standard.set(0, forKey: Constants.REGISTRATION_STATUS)

    }
    

    @IBAction func resendRequest(_ sender:UIButton){
        if txtMessage.text != "" && txtMessage.text != "write message ...."{
            DocumentManager.manager.resendRequest(message: txtMessage.text!) { result, message in
                if result ?? false{
                    self.txtMessage.text = "write message ...."
                    UtilityManager.manager.showAlert(self, message: "your request is submitted please wait for our team response.", title: Constants.APP_NAME)
                }else{
                    UtilityManager.manager.showAlert(self, message: message ?? "error sending request.", title: Constants.APP_NAME)
                }
            }

        }else{
            UtilityManager.manager.showAlert(self, message: "please enter message to send.", title: Constants.APP_NAME)
        }
    }
    
    
    @IBAction func nextTapped(_ sender:UIButton){
//        UtilityManager.manager.gotoVC(from: self, identifier: "WaitForApprovalViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }

    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtMessage.text == "write message ...."{
            txtMessage.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtMessage.text == ""{
            txtMessage.text = "write message ...."
        }
    }
    
}


