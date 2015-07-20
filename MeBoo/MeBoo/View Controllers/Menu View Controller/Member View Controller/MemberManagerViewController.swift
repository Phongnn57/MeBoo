//
//  MemberManagerViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class MemberManagerViewController: BaseViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate {

    @IBOutlet weak var tableview: UITableView!
    var addMemberBtn: UIBarButtonItem!
    
    private let CellIdentifier = "MemberManagerCell"
    let menuItems = NSArray(objects: "fjdf", "dfgfd")
    
    var menuPopover: MLKMenuPopover!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Quản lí thành viên"
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //
        self.tableview.tableFooterView = UIView()
        self.tableview.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.configBarButton()
    }
    
    // MARK: BAR BUTTON ITEM
    func configBarButton() {
        self.addMemberBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "moveToAddMemberView")
        self.navigationItem.rightBarButtonItem = self.addMemberBtn
    }
    
    func moveToAddMemberView() {
        let addMember = AddMemberViewController()
        self.presentViewController(addMember, animated: true) { () -> Void in
            
        }
    }
    
    // MARK: EMPTY SET
    
    func offsetForEmptyDataSet(scrollView: UIScrollView!) -> CGPoint {
        return CGPointMake(0, -64)
    }
//    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
//        return UIImage(named: "sample")
//    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "NO DATA FOUND"
        return NSAttributedString(string: text)
    }
    
    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldDisplay(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    
    // MARK: TABLEVIEW
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MemberManagerCell
        
        cell.delegate = self
        cell.rightUtilityButtons = self.rightButtons() as [AnyObject]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }

    func rightButtons() -> NSMutableArray {
        let rightUtilityButtons = NSMutableArray()
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(rgba: "#aaaaaa"), icon: UIImage(named: "select_vaccine"))
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(rgba: "#35a616"), icon: UIImage(named: "edit"))
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(rgba: "#ff0000"), icon: UIImage(named: "delete"))
        
        return rightUtilityButtons
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        if index == 0 {
            print("SELECT VACCINE")
        } else if index == 1 {
            print("EDIT")
        } else {
            print("DELETE")
        }
    }

}
