//
//  TempTableViewCell.swift
//  MemoryGame
//
//  Created by Lior Cohen on 08/06/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class TempTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
