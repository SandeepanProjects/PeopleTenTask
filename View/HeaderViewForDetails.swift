//
//  HeaderViewForDetails.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 16/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import UIKit

class HeaderViewForDetails: UITableViewCell {

    @IBOutlet weak var restrauntName: UILabel!
    
    @IBOutlet weak var categoryType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
