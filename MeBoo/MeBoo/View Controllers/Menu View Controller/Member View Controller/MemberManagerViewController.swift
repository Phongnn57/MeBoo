//
//  MemberManagerViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class MemberManagerViewController: BaseViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate, AddMemberViewControllerDelegate {

    @IBOutlet weak var tableview: UITableView!
    var addMemberBtn: UIBarButtonItem!
    
    private let CellIdentifier = "MemberManagerCell"
    let menuItems = NSArray(objects: "fjdf", "dfgfd")
    var menuButton: UIBarButtonItem!
    var menuPopover: MLKMenuPopover!
    
    // data
    var patients: [Patient]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.patients = Patient.MR_findAllWithPredicate(NSPredicate(format: "userId = \(UserObject.sharedUser.userID)")) as! [Patient]
        
        self.menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.leftBarButtonItem = self.menuButton
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
        addMember.delegate = self
        self.presentViewController(addMember, animated: true) { () -> Void in
            
        }
    }
    
    // Mark: Add New Member delegate
    func didFinishCreatePatient(patient: Patient) {
        self.patients = Patient.MR_findAllWithPredicate(NSPredicate(format: "userId = \(UserObject.sharedUser.userID)")) as! [Patient]
        self.tableview.reloadData()
        NSNotificationCenter.defaultCenter().postNotificationName("reloadpatient", object: nil)
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
        return self.patients.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MemberManagerCell
        
        cell.delegate = self
        cell.rightUtilityButtons = self.rightButtons() as [AnyObject]
        cell.configCellWithPatient(self.patients[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
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
        let indexpath: NSIndexPath = self.tableview.indexPathForCell(cell)!
        if index == 0 {
            print("SELECT VACCINE")
        } else if index == 1 {
            let addMember = AddMemberViewController()
            addMember.delegate = self
            addMember.isEdit = true
            addMember.editPatient = self.patients[indexpath.row]
            self.presentViewController(addMember, animated: true) { () -> Void in
                
            }
        } else {
            print("DELETE")
            PatientAPI.deleteAPatient(self.patients[indexpath.row].id.integerValue, completion: { () -> Void in
                self.patients[indexpath.row].MR_deleteEntity()
                self.patients.removeAtIndex(indexpath.row)
                NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                self.tableview.deleteRowsAtIndexPaths([indexpath], withRowAnimation: .Fade)
                
            }, failure: { (error) -> Void in
                self.view.makeToast(error)
            })
        }
    }
    
    func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: SWTableViewCell!) -> Bool {
        return true
    }
}
