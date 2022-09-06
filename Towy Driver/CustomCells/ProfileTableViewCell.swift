//
//  ProfileTableViewCell.swift
//  Oyla Captain
//
//  Created by Macbook Pro on 17/03/2021.
//  Copyright © 2021 Cyber Advance Solutions. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblMainOption:UILabel!
    @IBOutlet weak var lblDetails:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
