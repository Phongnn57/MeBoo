//
//  GeneralCell.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/8/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

protocol GeneralCellDelegate {
    func didSelectButtonAtCellAndIndex(cell: GeneralCell, btnIndex: Int)
}

class GeneralCell: UITableViewCell {

    @IBOutlet weak var sickName: UILabel!
    
    var delefate: GeneralCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellWithSick(injections: Array<Patient_Injection>) {
        
        for obj in self.subviews {
            if obj.isKindOfClass(UIButton) {
                obj.removeFromSuperview()
            }
        }
        
        for var i = 0; i < injections.count; i++ {
            let sickID = injections[i].sickID
            let sickCount = injections[i].number
            let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(sickID)")) as! Sick
            
            var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            button.frame = CGRectMake(96.0 + 32.0 * CGFloat(i), 14, 24, 24)
            
            let currentDay = NSDate()
            if injections[i].injectDay.isAfter(currentDay) {
                button.setImage(UIImage(named: "inject_incomming"), forState: .Normal)
            } else {
                button.setImage(UIImage(named: "inject_done"), forState: .Normal)
            }
            
            
            button.tag = i
            button.addTarget(self, action: "didSelectButton:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
        }
    }
    
    func didSelectButton(btn: UIButton) {
        self.delefate?.didSelectButtonAtCellAndIndex(self, btnIndex: btn.tag)
    }
}
