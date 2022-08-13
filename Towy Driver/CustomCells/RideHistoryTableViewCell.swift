//
//  RideHistoryTableViewCell.swift
//  Oyla Captain
//
//  Created by Macbook Pro on 19/03/2021.
//  Copyright © 2021 Cyber Advance Solutions. All rights reserved.
//

import UIKit

class RideHistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblPickup:UILabel!
    @IBOutlet weak var lblDropoff:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
