//
//  PatientCell.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/25/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class PatientCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
