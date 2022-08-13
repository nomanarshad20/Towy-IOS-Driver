//
//  DocumentAddViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 23/06/2022.
//

import UIKit


protocol docAddedDelegate{
    func didAddDoc(docType:DocType,image:UIImage)
    func registrationinfoAdded(params:[String:Any],docType:DocType,image:UIImage)
}

class DocumentAddViewController: UIViewController {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDes:UILabel!
    @IBOutlet weak var lblExtra:UILabel!
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var btnInspetion:UIButton!
    @IBOutlet weak var btnTakePhoto:UIButton!
    
    
    var ttl = ""
    var des = ""
    var img = UIImage()
    var document:DocType!
    var delegate:docAddedDelegate!
    
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblDes.text = des
        self.lblTitle.text = ttl
        btnInspetion.isHidden = true
        setupDate()
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        if document == .VEHICLE_INSPECTION{
            UtilityManager.manager.gotoVC(from: self, identifier: "", storyBoard: UtilityManager.manager.getAuthStoryboard())
        }else{
            showCamera()
        }
        
    }
    
    @IBAction func inspectionDone(_ sender: Any) {
        
    }
    
    func setupDate(){
        
        switch document{
        case .VEHICLE_INSPECTION:
            btnTakePhoto.setTitle("Find an inspection center", for: .normal)
            btnInspetion.disable()
            btnInspetion.isHidden = false
            lblTitle.text = "Vehicle inspection"
            lblDes.text = "Your city requires an inspection to make sure your vehicle is in working order. After the inspection, submit the completed inspection form. Inspections completed for other ridesharing companies are accepted."
            imgView.image = UIImage.init(named: "imagePlaceHolder")
        case .VEHICLE_INSURANCE:
            lblTitle.text = "Take a photo of your Vehicle Insurance"
            lblDes.text = "Make sure your name, VIN, insurance company,and expiration date are clear and readable. If the effective date has not passed, please wait to upload this document until that date. If your name is not listed on your insurance card, upload a copy of the Declaration Page instead that shows your name on the policy. You can submit an additional photo if the information is on multiple pages"
            imgView.image = UIImage.init(named: "imagePlaceHolder")
        case .BG_CHECK:
            lblTitle.text = "Take a photo of your CNIC Front Side"
            lblDes.text = "ACKNOWLEDGMENT AND AUTHORIZATION FOR BACKGROUND CHECK I acknowledge and agree that I have read and understand the Background Check Disclosure and further acknowledge that I have read, understand and agree with the statements contained in the additional disclosures."
            imgView.image = UIImage.init(named: "imagePlaceHolder")
        case .PROFILE_PHOTO:
            lblTitle.text = "Take your profile photo"
            lblDes.text = "Your profile photo helps people recognize you. Please note that once you submit your profile photo it cannot be changed."
            lblExtra.text = "\n1. Face the camera directly with your eyes and mouth clearly visible\n\n2. Make sure the photo is well lit, free of glare, and in focus \n\n3. No photos of a photo, filters, or alterations"
            imgView.image = UIImage.init(named: "imagePlaceHolder")
        case .LICENSE:
            lblTitle.text = "Take a photo of your Driving License Front Side"
            lblDes.text = "Make sure your US Driver's License is not expired and avoid using your flash to prevent glare.\nTry rotating your phone horizontally to fit all 4 corners into the picture and ensure your information is clear and visible."
            imgView.image = UIImage.init(named: "imagePlaceHolder")
        case .REGISTRATION_BOOK:
            lblTitle.text = "Take a photo of your Vehicle Registration"
            lblDes.text = "Make sure your vehicle's make, model, year, license plate, VIN, and expiration are clear and visible."
            imgView.image = UIImage.init(named: "imagePlaceHolder")

        default:
            print("2")
        }
    }
    
    
}


extension DocumentAddViewController:ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        //        if let cellImage = self.tblViewProduct.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? NewProductPhotoCell {
        self.imgView.image = image
       
        imagePicker.dismiss()
        delegate.didAddDoc(docType: self.document, image: image)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            UtilityManager.manager.moveBack(self)
        })
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
