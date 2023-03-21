//
//  CaptainProtalCollectionViewCell.swift
//  TOWY Driver
//
//  Created by CAS Solution on 11/11/2020.
//

import UIKit

class CaptainProtalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewMain:UIView?
    @IBOutlet weak var lblTitle:UILabel?
    @IBOutlet weak var lblSubTitle:UILabel?
    @IBOutlet weak var imgTitle:UIImageView?

    var obj:PortalData? = nil {
        didSet{
            self.lblTitle?.text = obj?.title
            self.lblSubTitle?.text = obj?.des
            self.imgTitle?.image = UIImage(named: obj?.image ?? "" )
        }
    }
  

}
