//
//  MobileNumberViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit
import SkyFloatingLabelTextField
import PhoneNumberKit
import CoreTelephony
import CountryPickerView




class MobileNumberViewController: UIViewController {

    @IBOutlet weak var cpv: CountryPickerView!
    @IBOutlet weak var viewCountry:UIView!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var btnNext:UIButton!
    
    @IBOutlet weak var txtEmail:UITextField!
    @IBOutlet weak var txtPhone:UITextField!
    
    @IBOutlet weak var viewPhoneNumber:UIView!
    @IBOutlet weak var viewEmail:UIView!
    @IBOutlet weak var lblCountryCode:UILabel!
    
    
    
    @IBOutlet weak var viewTxtField:UIView!
    
    
    
    
    var phoneCode = ""
    var countryName = ""
    var region = ""
    
    var isEmail:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnNext.disable()
        txtEmail.setPadding(12)
        txtPhone.setPadding(12)
        
        viewPhoneNumber.isHidden = true
        
        viewTxtField.layer.borderWidth = 2
        viewTxtField.layer.borderColor = UIColor.black.cgColor
        
        
        cpv.showPhoneCodeInView = false
        cpv.showCountryCodeInView = false
        cpv.flagImageView.isHidden = true
        cpv.delegate = self
        cpv.dataSource = self

        txtEmail.delegate = self
        txtPhone.delegate = self
        
        imgCountry.image = cpv.flagImageView.image
        phoneCode = cpv.selectedCountry.phoneCode
        lblCountryCode.text = phoneCode
        countryName = cpv.selectedCountry.name
        region = cpv.selectedCountry.code
        
        guard let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider else {return}

        print("gggggggg",carrier.carrierName)
        
        guard let countryST = carrier.isoCountryCode else{return}
        print("ddddd",countryST)
        if let country =  cpv.getCountryByCode(countryST.uppercased()){
            imgCountry.image = country.flag
            lblCountryCode.text = phoneCode
//            lblCountry.text = country.name
            phoneCode = country.phoneCode
            countryName = country.name
            region = country.code
//            cpv.isUserInteractionEnabled = false
          
        }
       
    }
    
    @IBAction func showCountryList(_ sender:UIButton){
        
        cpv.showCountriesList(from: self)
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
       
        if checkValidation(){
            let vc = storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
            vc.phoneNumber = self.txtPhone.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
    func checkValidation()->Bool{
        if isEmail{
            if txtEmail.text == ""{
                UtilityManager.manager.showAlert(self, message: "Email is missing!", title: Constants.APP_NAME)
                return false
            }
            if !UtilityManager.manager.isValidEmail(txtEmail.text!){
                UtilityManager.manager.showAlert(self, message: "Email is invalid!", title: Constants.APP_NAME)
                return false
            }
        }else{
            if txtPhone.text == ""{
                UtilityManager.manager.showAlert(self, message: "Mobile is missing!", title: Constants.APP_NAME)
                return false
            }
            if !PhoneNumberKit().isValidPhoneNumber(txtPhone.text!, withRegion: self.region, ignoreType: false){
                UtilityManager.manager.showAlert(self, message: "Phone Number is invalid!", title: Constants.APP_NAME)
                return false
            }
        }
        return true
    }
    
    
}

extension MobileNumberViewController:CountryPickerViewDelegate,CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
//        lblCountry.text = country.name
        imgCountry.image = country.flag
        self.countryName = country.name
        self.phoneCode = country.phoneCode
        lblCountryCode.text = phoneCode
        self.region = country.code
    }
    
    
}


extension MobileNumberViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if string == " "{
            return false
        }
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if checkStringContainIntegrs(string: updatedText){
                isEmail = false
                viewPhoneNumber.isHidden = false
                viewEmail.isHidden = true
                txtPhone.text = updatedText
                txtPhone.becomeFirstResponder()
            }else{
                isEmail = true
                viewPhoneNumber.isHidden = true
                viewEmail.isHidden = false
                txtEmail.text = updatedText
                txtEmail.becomeFirstResponder()
            }
                   return false
        }
        return false
    }
 
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail{
        textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.black.cgColor
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0{
            textField.layer.borderColor = UIColor.clear.cgColor
        }
        if textField.text == ""{
            btnNext.disable()
        }else{
            btnNext.enable()
        }
        return true
    }
    
    
    func checkStringContainIntegrs(string:String)->Bool{
        if Int(string) != nil {
            return true
        }else{
            return false
        }
    }
    
    
}
