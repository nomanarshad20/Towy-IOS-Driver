//
//  DocumentsViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit


class DocumentsViewController: UIViewController {
    
    
    @IBOutlet weak var imgBGCheck:UIImageView!
    @IBOutlet weak var imgDrivingLicense:UIImageView!
    @IBOutlet weak var imgRegistration:UIImageView!
    @IBOutlet weak var imgInsurance:UIImageView!
    @IBOutlet weak var imgInspection:UIImageView!
    @IBOutlet weak var imgProfile:UIImageView!
    
    
    var isImage = false
    var isInsurance = false
    var isRegistration = false
    var isLicense = false
    var isInspection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgBGCheck.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        
    }
    
    
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        //Api Call for mark complete documents and got to  waiting for approval
        if checkValidation(){
            SHOW_CUSTOM_LOADER()
            DocumentManager.manager.userDocumentsCompleted { result, message in
                if result ?? false{
                    UtilityManager.manager.gotoVC(from: self, identifier: "WaitForApprovalViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
                }else{
                    UtilityManager.manager.showAlert(self, message: message ?? "error syncing data.", title: Constants.APP_NAME)
                }
            }
        }
    }
    
    @IBAction func BG_CheckTapped(_ sender:UIButton){
        //        addDocument(document: .BG_CHECK)
    }
    @IBAction func LICENSETapped(_ sender:UIButton){
        addDocument(document: .LICENSE)
    }
    @IBAction func ProfilePhotoTapped(_ sender:UIButton){
        addDocument(document: .PROFILE_PHOTO)
    }
    @IBAction func inspectionTapped(_ sender:UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "InspectionCenterViewController") as! InspectionCenterViewController
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func registrationTapped(_ sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleRegistrationBookViewController") as! VehicleRegistrationBookViewController
        vc.document = .REGISTRATION_BOOK
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func insuranceTapped(_ sender:UIButton){
        addDocument(document: .VEHICLE_INSURANCE)
    }
    
    
    
    
    
    
    
    func addDocument(document:DocType){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DocumentAddViewController") as! DocumentAddViewController
        vc.document = document
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func updateUI(docType: DocType){
        switch docType {
        case .BG_CHECK:
            imgBGCheck.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .PROFILE_PHOTO:
            isImage = true
            imgProfile.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .LICENSE:
            isLicense = true
            imgDrivingLicense.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .REGISTRATION_BOOK:
            isRegistration = true
            imgRegistration.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .VEHICLE_INSURANCE:
            isInsurance = true
            imgInsurance.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .VEHICLE_INSPECTION:
            isInspection = true
            imgInspection.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        }
    }
    
    func checkValidation()->Bool{
        
        if !isImage{
            UtilityManager.manager.showAlert(self, message: "Please select profile Image.", title: "Profile image")
            return false
        }
        if !isRegistration{
            UtilityManager.manager.showAlert(self, message: "Please enter registration informations.", title: "Registration informations")
            return false
        }
        if !isInsurance{
            UtilityManager.manager.showAlert(self, message: "Please enter insurance informations.", title: "Insurance informations")
            return false
        }
        if !isLicense{
            UtilityManager.manager.showAlert(self, message: "Please enter License informations.", title: "License informations")
            return false
        }
        if !isInspection{
            UtilityManager.manager.showAlert(self, message: "Please enter Inspection informations.", title: "Inspection informations")
            return false
        }
        
        return true
        
    }
    
}


extension DocumentsViewController:docAddedDelegate{
    
    
    func didAddDoc(docType: DocType,image:UIImage) {
        switch docType {
        case .BG_CHECK:
            imgBGCheck.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .PROFILE_PHOTO:
            uploadImage(docType: docType, imageParams: ["image":image])
        case .LICENSE:
            uploadImage(docType: docType, imageParams: ["drivers_license":image])
        case .REGISTRATION_BOOK:
            uploadImage(docType: docType, imageParams: ["cnic_front_side":image])
        case .VEHICLE_INSURANCE:
            uploadImage(docType: docType, imageParams: ["vehicle_insurance":image])
        case .VEHICLE_INSPECTION:
            uploadImage(docType: docType, imageParams: ["vehicle_inspection":image])
        }
        
    }
    
    func registrationinfoAdded(params: [String : Any], docType: DocType, image: UIImage) {
        uploadVehicleInfo(params: params, docType: docType, imageParams: ["registration_book":image])
    }
    
    
    
    func uploadImage(params:[String:Any]? = nil,docType: DocType,imageParams:[String:UIImage]){
        SHOW_CUSTOM_LOADER()
        DocumentManager.manager.uploadUserDocuments(params: nil, imagesArray: imageParams) { result, message in
            HIDE_CUSTOM_LOADER()
            if result{
                self.updateUI(docType: docType)
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "error saving image.", title: "Oops")
            }
        }
    }
    
    
    func uploadVehicleInfo(params:[String:Any]? = nil,docType: DocType,imageParams:[String:UIImage]){
        SHOW_CUSTOM_LOADER()
        DocumentManager.manager.uploadVehicleInfo(params: params!, imagesArray: imageParams) { result, message in
            HIDE_CUSTOM_LOADER()
            if result{
                self.updateUI(docType: docType)
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "error saving image.", title: "Oops")
            }
        }
    }
    
}
