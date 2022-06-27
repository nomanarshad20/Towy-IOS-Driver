//
//  DocumentsViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 20/06/2022.
//

import UIKit


class DocumentsViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    


    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }


    @IBAction func btnNext(_ sender: Any) {
        UtilityManager.manager.gotoVC(from: self, identifier: "VehicleRegistrationBookViewController", storyBoard: UtilityManager.manager.getAuthStoryboard()) 
    }
    
    @IBAction func ID_F(_ sender:UIButton){
        addDocument(document: .ID_CARD_FRONT)
    }
    @IBAction func ID_B(_ sender:UIButton){
        addDocument(document: .ID_CARD_BACK)
    }
    @IBAction func LICENSE_F(_ sender:UIButton){
        addDocument(document: .LICENSE_F)
    }
    @IBAction func LICENSE_B(_ sender:UIButton){
        addDocument(document: .LICENSE_B)
    }
    @IBAction func ProfilePhoto(_ sender:UIButton){
        addDocument(document: .PROFILE_PHOTO)
    }
    
    
    func addDocument(document:DocType){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DocumentAddViewController") as! DocumentAddViewController
        vc.document = document
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
