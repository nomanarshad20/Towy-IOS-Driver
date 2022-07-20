//
//  InspectionTableViewCell.swift
//  Towy Driver
//
//  Created by Macbook Pro on 14/07/2022.
//

import UIKit

class InspectionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDistance:UILabel!
    @IBOutlet weak var lblAddressName:UILabel!
    @IBOutlet weak var lblLocation:UILabel!
    @IBOutlet weak var lblRate:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        lblRate.layer.cornerRadius = lblRate.frame.height/2
        lblRate.layer.borderWidth = 2
        lblRate.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
