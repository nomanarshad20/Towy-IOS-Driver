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
    @IBOutlet weak var imgCountry: UIImageView!
//    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var btnNext:UIButton!
    
    
    var phoneCode = ""
    var countryName = ""
    var region = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        btnNext.setGradient(Radius: 5)
        
        cpv.showPhoneCodeInView = false
        cpv.showCountryCodeInView = false
        cpv.flagImageView.isHidden = true
        cpv.delegate = self
        cpv.dataSource = self

        imgCountry.image = cpv.flagImageView.image
//        lblCountry.text = cpv.selectedCountry.name
        phoneCode = cpv.selectedCountry.phoneCode
        countryName = cpv.selectedCountry.name
        region = cpv.selectedCountry.code
//        cpv.isUserInteractionEnabled = true
        
        guard let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider else {return}

        print("gggggggg",carrier.carrierName)
        
        guard let countryST = carrier.isoCountryCode else{return}
        print("ddddd",countryST)
        if let country =  cpv.getCountryByCode(countryST.uppercased()){
            imgCountry.image = country.flag
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
        
        if phoneCode == "+92"{
            UserDefaults.standard.setValue(true, forKey: Constants.IS_LOCAL)
        }else{
            UserDefaults.standard.setValue(false, forKey: Constants.IS_LOCAL)
        }
        UtilityManager.manager.gotoVC(from: self, identifier: "OtpViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
}

extension MobileNumberViewController:CountryPickerViewDelegate,CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
//        lblCountry.text = country.name
        imgCountry.image = country.flag
        self.countryName = country.name
        self.phoneCode = country.phoneCode
        self.region = country.code
    }
    
    
}
