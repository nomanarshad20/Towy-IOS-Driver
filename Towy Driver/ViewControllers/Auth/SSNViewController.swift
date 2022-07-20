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

        txtSSN.delegate = self
        btnNext.disable()
        
    }
    
    
    
    @IBAction func btnNext(_ sender: Any) {
        
    
        UtilityManager.manager.gotoVC(from: self, identifier: "DocumentsViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
    @IBAction func btnNbackTappedext(_ sender: Any) {
        
    
        UtilityManager.manager.moveBack(self)
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