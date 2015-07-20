//
//  UIImageExtension.swift
//  Enbac
//
//  Created by Ngo Ngoc Chien on 7/10/15.
//  Copyright © 2015 Hoang Duy Nam. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    
    class func fromColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect);
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image
    }
}