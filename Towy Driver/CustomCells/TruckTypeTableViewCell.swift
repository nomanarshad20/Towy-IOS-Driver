//
//  TruckTypeTableViewCell.swift
//  Towy Driver
//
//  Created by Macbook Pro on 22/06/2022.
//

import UIKit

class TruckTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var imgaeIcon:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
