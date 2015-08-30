//
//  PersonalSettingViewController.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/8/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class PersonalSettingViewController: BaseViewController {

    @IBOutlet weak var email: SingleLineTextField!
    @IBOutlet weak var phone: SingleLineTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
