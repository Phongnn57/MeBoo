//
//  AddMemberViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class AddMemberViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var nameTF: SingleLineTextField!
    @IBOutlet weak var dobTF: SingleLineTextField!
    @IBOutlet weak var bloodTypeTF: UITextField!
    @IBOutlet weak var boyBtn: UIButton!
    @IBOutlet weak var girlBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "endEditing"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }

    @IBAction func saveMemberAction(sender: AnyObject) {
        print(nameTF.frame)
        print(dobTF.frame)
    }
    
    // MARK: TEXTFIELD DELEGATE
    func configDOBTextfield() {
        
    }
    
    
    @IBAction func selectBoy(sender: AnyObject) {
        boyBtn.setBackgroundImage(UIImage(named: "selected"), forState: .Normal)
        girlBtn.setBackgroundImage(UIImage(named: "unselected"), forState: .Normal)
    }
    
    @IBAction func selectGirl(sender: AnyObject) {
        girlBtn.setBackgroundImage(UIImage(named: "selected"), forState: .Normal)
        boyBtn.setBackgroundImage(UIImage(named: "unselected"), forState: .Normal)
    }
    
}
