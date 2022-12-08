//
//  VehicleRegistrationBookViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit
import Kingfisher

class VehicleRegistrationBookViewController: UIViewController {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDes:UILabel!
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtModel:UITextField!
    @IBOutlet weak var txtNumber:UITextField!
    @IBOutlet weak var txtYear:UITextField!
    @IBOutlet weak var btnNext:UIButton!
    
    
    
    var ttl = ""
    var des = ""
    var img = UIImage()
    var document:DocType!
    var delegate:docAddedDelegate!
    var hasImage = false
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnNext.disable()
        self.lblDes.text = des
        self.lblTitle.text = ttl
        setupDate()
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
    @IBAction func btnImageTapped(_ sender:UIButton){
        self.showCamera()
    }
    
    
    @IBAction func btnNextTapped(_ sender: Any) {
      
        delegate.registrationinfoAdded(params: ["name":txtName.text!,"model":txtModel.text!,"registration_number":txtNumber.text!,"model_year":txtYear.text!], docType: .REGISTRATION_BOOK, image: self.imgView.image!)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            UtilityManager.manager.moveBack(self)
        })
        
       
            

    }
    
    func setupDate(){
        
        lblTitle.text = "Vehicle Registration Book"
        lblDes.text = "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book."
//        imgView.image = UIImage.init(named: "camera.fill")
        
        txtName.setPadding(12)
        txtYear.setPadding(12)
        txtNumber.setPadding(12)
        txtModel.setPadding(12)
        txtName.delegate = self
        txtYear.delegate = self
        txtModel.delegate = self
        txtNumber.delegate = self
    }
    
    
    func checkValidations()->Bool{
            if  txtName.text == ""{
                UtilityManager.manager.showAlert(self, message: "Truck name is missing!", title: Constants.APP_NAME)
                return false
            }
            if txtModel.text == ""{
                UtilityManager.manager.showAlert(self, message: "Truck Model is missing!", title: Constants.APP_NAME)
                return false
            }
        if txtNumber.text == ""{
            UtilityManager.manager.showAlert(self, message: "Truck Number is missing!", title: Constants.APP_NAME)
            return false
        }
        if txtYear.text == ""{
            UtilityManager.manager.showAlert(self, message: "Truck Year is missing!", title: Constants.APP_NAME)
            return false
        }
        if !hasImage{
            UtilityManager.manager.showAlert(self, message: "Registraion Book image is missing!", title: Constants.APP_NAME)
            return false
        }
        
       
           
        return true
    }
    
    
    
    
}



extension VehicleRegistrationBookViewController:ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        //        if let cellImage = self.tblViewProduct.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? NewProductPhotoCell {
        self.imgView.image = image
        hasImage = true
        if txtName.text != "" && txtModel.text != "" && txtYear.text != "" && txtNumber.text != "" && hasImage{
            btnNext.enable()
        }
        imagePicker.dismiss()
    }
    
    func cancelButtonDidClick(on imageView: ImagePicker) {
        imagePicker.dismiss()
        
    }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    
    func showCamera(){
        UtilityManager.manager.showAlertWithAction(self, message: "Choose Image Media", title: "Choose Media", buttons: ["Camera","Photo Gallery"], completion: { index in
            
            if index == 1 {
                self.chooseGallery()
            }else {
                self.chooseCamera()
            }
        })
    }
    
    func chooseCamera(){
        print("chooseCamera ==>")
        imagePicker.cameraAsscessRequest()
    }
    
    func chooseGallery(){
        print("chooseGallery ==>")
        imagePicker.photoGalleryAsscessRequest()
    }
}



extension VehicleRegistrationBookViewController:UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtName.text != "" && txtModel.text != "" && txtYear.text != "" && txtNumber.text != "" && hasImage{
            self.btnNext.enable()
        }else{
            btnNext.disable()
        }
     
        
        if textField.text == ""{
            textField.layer.borderWidth = 0
        }
        
    }
    
}
