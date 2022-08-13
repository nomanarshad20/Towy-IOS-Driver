//
//  TransactionHistoryTableViewCell.swift
//  Oyla Captain
//
//  Created by Macbook Pro on 29/06/2021.
//  Copyright © 2021 Cyber Advance Solutions. All rights reserved.
//

import UIKit

class TransactionHistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblBookingId:UILabel!
    @IBOutlet weak var lblPaymentType:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var lblAmount:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
