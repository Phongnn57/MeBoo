//
//  AppInfoViewController.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/8/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class AppInfoViewController: BaseViewController {
    var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.title = "Thông tin ứng dụng"
        
        self.contentView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, self.contentView.frame.height)
        self.scrollview.addSubview(self.contentView)
        self.scrollview.contentSize = self.contentView.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}