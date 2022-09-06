//
//  TextWithCheckboxTableViewCell.swift
//  Oyla Captain
//
//  Created by apple on 11/12/20.
//  Copyright © 2020 Cyber Advance Solutions. All rights reserved.
//

import UIKit

class TextWithCheckboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var imgStatus:UIImageView!
    
    var cellType:CellType!
    var data:Precaution!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    
    func setData(data:Precaution)->TextWithCheckboxTableViewCell?{
            self.lblTitle.text = data.text
            self.imgStatus.image = UIImage.init(named: "unchecked")
//            self.lblTitle.font =  UIFont(name: "Montserrat-Medium", size: 15.0)!
            return self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func changeStatus()->Precaution{
        if data.status!{
            imgStatus.image = UIImage.init(named: "unchecked")
            data.status?.toggle()
        }else{
            imgStatus.image = UIImage.init(named: "checked")
            data.status?.toggle()
        }
        return data
    }
    
    
}
