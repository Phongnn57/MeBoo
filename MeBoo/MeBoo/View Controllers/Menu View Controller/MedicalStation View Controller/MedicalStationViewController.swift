//
//  MedicalStationViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class MedicalStationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
