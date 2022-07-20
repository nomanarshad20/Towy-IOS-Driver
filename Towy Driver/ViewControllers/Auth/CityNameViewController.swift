//
//  CityNameViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 07/07/2022.
//

import UIKit

class CityNameViewController: UIViewController {

    @IBOutlet weak var btnNext:UIButton!
    @IBOutlet weak var txtCitytName:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCitytName.delegate = self
        btnNext.disable()
        txtCitytName.setPadding(12)
    }
    

    @IBAction func btnNext(_ sender: Any) {
        
        
       
        if txtCitytName.text == ""{
            UtilityManager.manager.showAlert(self, message: "Please enter city name.", title: Constants.APP_NAME)
            return
        }
      
       
            let vc = storyboard?.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    

}

extension CityNameViewController:UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtCitytName.text != ""{
            btnNext.enable()
        }else{
            btnNext.disable()
        }
     
        
        if textField.text == ""{
            textField.layer.borderWidth = 0
        }
        
    }
    
}
