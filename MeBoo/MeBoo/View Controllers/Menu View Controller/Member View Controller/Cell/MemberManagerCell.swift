//
//  MemberManagerCell.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class MemberManagerCell: SWTableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var dobLB: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellWithPatient(patient: Patient) {
        self.nameLB.text = patient.name
        self.dobLB.text = patient.dob.toString()
        if patient.gender == 0 {
            self.imageview.image = UIImage(named: "girl")
        } else {
            self.imageview.image = UIImage(named: "boy")
        }
    }
}
