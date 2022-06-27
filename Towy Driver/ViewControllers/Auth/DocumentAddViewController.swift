//
//  DocumentAddViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 23/06/2022.
//

import UIKit

class DocumentAddViewController: UIViewController {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDes:UILabel!
    @IBOutlet weak var imgView:UIImageView!
    
    
    var ttl = ""
    var des = ""
    var img = UIImage()
    var document:DocType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblDes.text = des
        self.lblTitle.text = ttl
        setupDate()
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
    
       
    }
    
    func setupDate(){
        
        switch document{
        case .ID_CARD_FRONT:
            lblTitle.text = "Take a photo of your CNIC Front Side"
            lblDes.text = "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book.It's difficult to find examples of lorem ipsum in use before Letraset made it popular as a dummy text in the 1960s, although McClintock says he remembers coming across the lorem ipsum passage in a book of old metal type samples. So far he hasn't relocated where he once saw the passage, but the popularity of Cicero in the 15th century supports the theory that the filler text has been used for centuries."
            imgView.image = UIImage.init(named: "registration")
        case .ID_CARD_BACK:
            lblTitle.text = "Take a photo of your CNIC Back Side"
            lblDes.text = "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book.It's difficult to find examples of lorem ipsum in use before Letraset made it popular as a dummy text in the 1960s, although McClintock says he remembers coming across the lorem ipsum passage in a book of old metal type samples. So far he hasn't relocated where he once saw the passage, but the popularity of Cicero in the 15th century supports the theory that the filler text has been used for centuries."
            imgView.image = UIImage.init(named: "boy")
        case .PROFILE_PHOTO:
            lblTitle.text = "Take your photo"
            lblDes.text = "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book.It's difficult to find examples of lorem ipsum in use before Letraset made it popular as a dummy text in the 1960s, although McClintock says he remembers coming across the lorem ipsum passage in a book of old metal type samples. So far he hasn't relocated where he once saw the passage, but the popularity of Cicero in the 15th century supports the theory that the filler text has been used for centuries."
            imgView.image = UIImage.init(named: "boy")
        case .LICENSE_F:
            lblTitle.text = "Take a photo of your Driving License Front Side"
            lblDes.text = "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book.It's difficult to find examples of lorem ipsum in use before Letraset made it popular as a dummy text in the 1960s, although McClintock says he remembers coming across the lorem ipsum passage in a book of old metal type samples. So far he hasn't relocated where he once saw the passage, but the popularity of Cicero in the 15th century supports the theory that the filler text has been used for centuries."
            imgView.image = UIImage.init(named: "registration")
        case .LICENSE_B:
            lblTitle.text = "Take a photo of your Driving License Back Side"
            lblDes.text = "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book.It's difficult to find examples of lorem ipsum in use before Letraset made it popular as a dummy text in the 1960s, although McClintock says he remembers coming across the lorem ipsum passage in a book of old metal type samples. So far he hasn't relocated where he once saw the passage, but the popularity of Cicero in the 15th century supports the theory that the filler text has been used for centuries."
            imgView.image = UIImage.init(named: "registration")
        default:
            "print 2"
        
        }
    }
    

}
