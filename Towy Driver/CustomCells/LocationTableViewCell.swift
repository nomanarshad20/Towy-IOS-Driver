//
//  LocationTableViewCell.swift
//  Oyla Captain
//
//  Created by Macbook Pro on 15/12/2020.
//  Copyright © 2020 Cyber Advance Solutions. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLocationHeading:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
