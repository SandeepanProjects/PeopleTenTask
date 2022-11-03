//
//  DetailCell.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 16/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var formattedPhoneLbl: UILabel!
    
    @IBOutlet weak var twitterLbl: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
