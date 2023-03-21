//
//  SenderTableViewCell.swift
//  Towy Driver
//
//  Created by Macbook Pro on 12/07/2021.
//  Copyright © TOWY. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
}
