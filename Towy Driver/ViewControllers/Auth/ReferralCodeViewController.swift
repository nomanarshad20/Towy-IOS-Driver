//
//  ReferralCodeViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 06/07/2022.
//

import UIKit

class ReferralCodeViewController: UIViewController {

    @IBOutlet weak var btnNext:UIButton!
    
    @IBOutlet weak var txtReferralCode:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtReferralCode.delegate = self
//        btnNext.isUserInteractionEnabled = false
//        btnNext.backgroundColor = UIColor.init(named: Constants.AssetsColor.TextfieldBackGround.rawValue)
        txtReferralCode.setPadding(12)
    }
    

    @IBAction func btnNext(_ sender: Any) {
       
            let vc = storyboard?.instantiateViewController(withIdentifier: "CityNameViewController") as! CityNameViewController
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnSkip(_ sender: Any) {
       
        let vc = storyboard?.instantiateViewController(withIdentifier: "CityNameViewController") as! CityNameViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    

}

extension ReferralCodeViewController:UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text == ""{
            textField.layer.borderWidth = 0
        }
        
    }
    
}
