//
//  Upcoming_Party_Item.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 12/7/20.
//

import UIKit

class Upcoming_Party_Item: UITableViewCell {
    
    @IBOutlet weak var party_name: UILabel!
    @IBOutlet weak var party_address: UILabel!
    @IBOutlet weak var party_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
