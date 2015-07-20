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
    private let CellIdentifier = "MenuCell"
    private let titles = ["Sổ y bạ các loại", "Quản lí thành viên", "Trạm y tế gần đây"]
    var presentedRow: Int = 0
    var sections: NSMutableArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MenuCell
        
        cell.titleLB.text = self.titles[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MenuCell
        cell.selected = false
        
        if indexPath.row == self.presentedRow {
            self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: true)
            return
        }
        
        var viewController: UIViewController!
        viewController = self.sections[indexPath.row] as! UIViewController
        
        if viewController != nil {
            self.revealViewController().pushFrontViewController(viewController, animated: true)
            self.presentedRow = indexPath.row
        }
    }
    
    // MARK: EXIT BUTTON
    
    @IBAction func doLogoutAction(sender: AnyObject) {
        
    }
}
