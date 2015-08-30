//
//  ReportCell.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/8/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellWithPatientInjection(patientInjection: Patient_Injection) {
        let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(patientInjection.sickID)")) as! Sick
        self.name.text = sick.sickName
        self.time.text = patientInjection.injectDay.toString()
        self.count.text = "Mũi thứ " + "\(patientInjection.number)"
    }
    
    class func calculateCellHeigh(str: String) -> CGFloat {
        var lb = UILabel(frame: CGRectMake(0, 0, SCREEN_SIZE.width - 55, 200))
        lb.numberOfLines = 0
        lb.font = UIFont.systemFontOfSize(17)
        lb.text = str
        lb.sizeToFit()
        
        return lb.frame.size.height + 45
    }
}