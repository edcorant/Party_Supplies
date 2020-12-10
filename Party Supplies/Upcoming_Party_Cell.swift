//
//  Upcoming_Party_Cell.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 12/7/20.
//

import UIKit

class Upcoming_Party_Cell: UITableViewCell {
    
    @IBOutlet weak var supply_circle: UIButton!
    @IBOutlet weak var supply_name: UILabel!
    
    var user_is_bringing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
