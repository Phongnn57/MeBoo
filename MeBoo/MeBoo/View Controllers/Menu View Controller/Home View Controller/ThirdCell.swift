//
//  ThirdCell.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/11/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class ThirdCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func calculateCellHeigh(str: String) -> CGFloat {
        var lb = UILabel(frame: CGRectMake(0, 0, SCREEN_SIZE.width - 132, 200))
        lb.numberOfLines = 0
        lb.font = UIFont.systemFontOfSize(17)
        lb.text = str
        lb.sizeToFit()
        
        return lb.frame.size.height + 20
    }
}
