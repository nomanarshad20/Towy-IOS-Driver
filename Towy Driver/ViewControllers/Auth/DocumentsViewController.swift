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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    


    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }


    @IBAction func btnNext(_ sender: Any) {
        UtilityManager.manager.gotoVC(from: self, identifier: "VehicleRegistrationBookViewController", storyBoard: UtilityManager.manager.getAuthStoryboard()) 
    }
    
    @IBAction func BG_CheckTapped(_ sender:UIButton){
        addDocument(document: .BG_CHECK)
    }
    @IBAction func LICENSETapped(_ sender:UIButton){
        addDocument(document: .LICENSE)
    }
    @IBAction func ProfilePhotoTapped(_ sender:UIButton){
        addDocument(document: .PROFILE_PHOTO)
    }
    @IBAction func inspectionTapped(_ sender:UIButton){
        addDocument(document: .VEHICLE_INSPECTION)
    }
    @IBAction func registrationTapped(_ sender:UIButton){
        addDocument(document: .REGISTRATION_BOOK)
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
    
}


extension DocumentsViewController:docAddedDelegate{
    
    func didAddDoc(docType: DocType) {
        switch docType {
        case .BG_CHECK:
            imgBGCheck.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .PROFILE_PHOTO:
            imgProfile.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .LICENSE:
            imgDrivingLicense.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .REGISTRATION_BOOK:
            imgRegistration.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .VEHICLE_INSURANCE:
            imgInsurance.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        case .VEHICLE_INSPECTION:
            imgInspection.tintColor = UIColor.init(named: Constants.AssetsColor.ThemeBlueColor.rawValue)
        }
    }
    
}
