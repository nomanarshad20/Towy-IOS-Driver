//
//  SSNViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 08/07/2022.
//

import UIKit
import SkyFloatingLabelTextField


class SSNViewController: UIViewController {

    @IBOutlet weak var txtSSN:SkyFloatingLabelTextField!
    @IBOutlet weak var btnNext:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UserDefaults.standard.set(3, forKey: Constants.REGISTRATION_STATUS)

        
        txtSSN.delegate = self
        btnNext.disable()
        
    }
    
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        if txtSSN.text?.count == 11{
            SHOW_CUSTOM_LOADER()
            SignUpManager.manager.sendSSN(ssn: txtSSN.text!) { result, message in
                HIDE_CUSTOM_LOADER()
                if message == nil{
                    UtilityManager.manager.gotoVC(from: self, identifier: "DocumentsViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
                }else{
                    UtilityManager.manager.showAlert(self, message: message ?? "error saving SSN.", title: Constants.APP_NAME)

                }
            }
            
           
        }else{
            UtilityManager.manager.showAlert(self, message: "Please enter SSN.", title: Constants.APP_NAME)
        }
    }
      
    
    @IBAction func btnNbackTappedext(_ sender: Any) {
        
    
        UtilityManager.manager.moveBack(self)
    }
    
    
    @IBAction func helpTapped(_ sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}



extension SSNViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
       
            if (textField.text?.count == 3) || (textField.text?.count == 6) {
                if !(string == "") {
                    textField.text = (textField.text)! + "-"
                }
            }
            return !(textField.text!.count > 10 && (string.count ) > range.length)
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count == 11{
            btnNext.enable()
        }else{
            btnNext.disable()
        }
    }
    
    }
