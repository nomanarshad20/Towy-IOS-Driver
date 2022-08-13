//
//  MenuTableViewCell.swift
//  Oyla Captain
//
//  Created by apple on 11/24/20.
//  Copyright © 2020 Cyber Advance Solutions. All rights reserved.
//

import UIKit

enum CellType {
    case SIDE_MENU
    case HELP
    case HELP_DETAILS
    case REFERRAL
    case MESSAGE
    case SETTINGS
    case MAPS
    case LANGUAGES
    case LATERJOBS
    case NONE
    case PRECUATION
    case CANCEL_REASON
}

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menu:UILabel!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var ImgRoundCheck: UIImageView!
    @IBOutlet weak var lblreadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK:- Function
    func setData(_ data:Any,contentType:CellType)->MenuTableViewCell?{
        switch contentType {
        case .HELP:
            let ds = data as! MenuModel
            self.icon.image = UIImage.init(named: ds.image)
            self.menu.font =  UIFont.systemFont(ofSize: 17)
            self.menu.text = ds.title
            return self
        case .HELP_DETAILS:
            let ds = data as! HelpDataModel
            self.icon.image = UIImage.init(named: ds.image)
            self.menu.font =  UIFont.systemFont(ofSize: 17)
            self.menu.text = ds.title
            return self
        case .SIDE_MENU:
            let ds = data as! MenuModel
            self.menu.text = ds.title
            self.icon.image = UIImage.init(named: ds.image)
            return self
        case .REFERRAL:
            let ds = data as! String
            self.menu.font =  UIFont.systemFont(ofSize: 17)
            self.menu.text = ds
            self.lblreadingConstraint.constant = -25
            self.ImgRoundCheck.isHidden = true
            self.accessoryType = .disclosureIndicator
            return self
        case .MESSAGE:
            let ds = data as! String
            self.menu.font =  UIFont.systemFont(ofSize: 17)
            self.menu.text = ds
            self.lblreadingConstraint.constant = -25
            self.accessoryType = .disclosureIndicator
            return self
        case .LATERJOBS:
            let ds = data as! String
            self.menu.font =  UIFont.systemFont(ofSize: 17)
            self.menu.text = ds
            self.lblreadingConstraint.constant = -25
            self.accessoryType = .none
            return self
        case .MAPS:
            let ds = data as! [String:Bool]
            self.menu.font = UIFont.systemFont(ofSize: 17)
            self.menu.text = ds.keys.first
            self.lblreadingConstraint.constant = -25
            self.ImgRoundCheck.isHidden = false
            if ds[ds.keys.first!] ?? false {
                self.ImgRoundCheck.image = UIImage.init(named: "yes")
            }else{
                self.ImgRoundCheck.image = UIImage.init(named: "no")
            }
            return self
        case .LANGUAGES:
            let ds = data as! [String:Bool]
            self.menu.font = UIFont.systemFont(ofSize: 17)
            self.menu.text = ds.keys.first
            self.lblreadingConstraint.constant = -25
            self.ImgRoundCheck.isHidden = false
            if ds[ds.keys.first!]!{
                self.ImgRoundCheck.image = UIImage.init(named: "yes")
            }else{
                self.ImgRoundCheck.image = UIImage.init(named: "no")
            }
            return self
        case .SETTINGS:
            let ds = data as! String
            self.menu.font =  UIFont.systemFont(ofSize: 17)
            self.menu.text = ds
            self.lblreadingConstraint.constant = -25
            self.accessoryType = .disclosureIndicator
            return self
        default:
            print("")
        }
        return self
    }
    
    
}
