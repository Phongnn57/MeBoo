//
//  MenuController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class MenuController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    private let CellIdentifier = "MenuCell"
    private let titles = [["Sổ y bạ các loại"], ["Trạm y tế", "Nhà thuốc"], ["Quản lí thành viên"], ["Thông tin ứng dụng", "Cài đặt hệ thống", "Thoát"]]
    private let imageView = [["home"], ["medical_station", "medical_station"], ["manage_member"], ["app_info", "setup", "logout"]]
    private let sectionTitle = ["Các loại sổ y bạ", "Tìm kiếm...", "Quản lí", "Hệ thống"]
    var presentedIndexpath: NSIndexPath = NSIndexPath()
    var sections: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatar.sd_setImageWithURL(NSURL(string: UserObject.sharedUser.photoURL))
        self.tableview.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.avatar.sd_setImageWithURL(NSURL(string: UserObject.sharedUser.photoURL))
        self.name.text = UserObject.sharedUser.name
        self.email.text = UserObject.sharedUser.email
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return (self.sections.objectAtIndex(section) as! [AnyObject]).count + 1
        }
        return (self.sections.objectAtIndex(section) as! [AnyObject]).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MenuCell
        
        cell.titleLB.text = self.titles[indexPath.section][indexPath.row]
        cell.imageview.image = UIImage(named: self.imageView[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MenuCell
        cell.selected = false
        
        if indexPath.section == 3 && indexPath.row == 2 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: true)
                }) { (finished: Bool) -> Void in
                    let loginViewController = LoginViewController()
                    DELEGATE.changeRootViewController(loginViewController)
            }
            return
        }
        
        if indexPath == self.presentedIndexpath {
            self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: true)
            return
        }
        
        var viewController: UIViewController!
        viewController = (self.sections[indexPath.section] as! [AnyObject])[indexPath.row] as! UIViewController
        
        if viewController != nil {
            self.revealViewController().pushFrontViewController(viewController, animated: true)
            self.presentedIndexpath = indexPath
        }
    }
    
    // MARK: EXIT BUTTON
    
    @IBAction func doLogoutAction(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: true)
            }) { (finished: Bool) -> Void in
            Patient.MR_truncateAll()
            Patient_Sick.MR_truncateAll()
            Patient_Injection.MR_truncateAll()
            
            let loginViewController = LoginViewController()
            DELEGATE.changeRootViewController(loginViewController)
        }
    }
}
