//
//  MedicalStationCell.swift
//  MeBoo
//
//  Created by Nam Phong on 7/21/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class MedicalStationCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellWithData(phamarcy: Clinic) {
        self.name.text = phamarcy.name ?? ""
        self.address.text = phamarcy.address ?? ""
        self.name.sizeToFit()
    }
}
