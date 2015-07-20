//
//  SkyDanceButton.swift
//  Sổ Y Bạ
//
//  Created by Nam Phong on 7/16/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import UIKit

class SkyDanceButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        var highlightedColor: UIColor = self.darkerColorForColor(self.backgroundColor!)
        self.setBackgroundImage(UIImage.fromColor(highlightedColor, size: CGSizeMake(1, 1)), forState: UIControlState.Highlighted)
        self.clipsToBounds = true;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.highlighted = true
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "dehighlight", userInfo: nil, repeats: false)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "dehighlight", userInfo: nil, repeats: false)
    }

    func dehighlight() {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.highlighted = false
        }
    }
    
    func darkerColorForColor(c: UIColor) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        if c.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: max(r-0.2, 0.0), green: max(g-0.2, 0.0), blue: max(b-0.2, 0.0), alpha: a)
        }
        return c
    }

}
