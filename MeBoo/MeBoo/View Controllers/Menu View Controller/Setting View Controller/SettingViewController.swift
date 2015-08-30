//
//  SettingViewController.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/8/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.title = "Cài đặt hệ thống"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
