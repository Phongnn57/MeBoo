//
//  MedicalStationViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class MedicalStationViewController: BaseViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate{

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let CellIdentifier = "MedicalStationCell"
    var menuButton: UIBarButtonItem!
    var pharmacies: [Clinic]!
    var filteredTableData: [Clinic]!
    var searchBar: UISearchBar!
    var offset = 0
    var number: Int = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.leftBarButtonItem = self.menuButton
        self.title = "Trạm y tế"
        self.tableview.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        self.pharmacies = [Clinic]()
        self.filteredTableData = [Clinic]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        MRProgressOverlayView.showOverlayAddedTo(self.view, title: "Đang tải", mode: MRProgressOverlayViewMode.IndeterminateSmall, animated: true)
        PharmacyAPI.getPharmacies(self.number, offset: self.offset, completion: { (clinics) -> Void in
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
            
            self.pharmacies = clinics
            self.tableview.reloadData()
            self.createSearchBar()
            
            self.offset = self.number
            self.number += 40
            
        }) { (error) -> Void in
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
        }
    }
    
    func loadMoreData() {
        self.activityIndicator.startAnimating()
        PharmacyAPI.getPharmacies(self.number, offset: self.offset, completion: { (clinics) -> Void in
            self.activityIndicator.stopAnimating()
            
            if clinics != nil {
                for clinic in clinics {
                    self.pharmacies.append(clinic)
                }
            }
            
            self.tableview.reloadData()
            self.createSearchBar()
            
            self.offset = self.number
            self.number += 40
            self.view.userInteractionEnabled = true
            }) { (error) -> Void in
                self.view.userInteractionEnabled = true
                self.activityIndicator.stopAnimating()
        }
    }
    
    //Mark: SEARCH METHODS
    func createSearchBar() {
        self.searchBar = UISearchBar(frame: CGRectMake(0, 0, SCREEN_SIZE.width, 44))
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Tìm kiếm"
        self.tableview.tableHeaderView = self.searchBar
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredTableData = self.pharmacies
        } else {
            self.filteredTableData.removeAll()
            let searchPredicate = NSPredicate(format: "address CONTAINS[cd] %@", self.searchBar.text!)
            let arr = NSArray(array: self.pharmacies)
            let tmpArr = arr.filteredArrayUsingPredicate(searchPredicate)
            self.filteredTableData = tmpArr as! [Clinic]
        }
        self.tableview.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            searchBar.resignFirstResponder()
            return false
        }
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.searchBar.showsCancelButton = true
        return true
    }

    
    // MARK: EMPTY SET
    
    func offsetForEmptyDataSet(scrollView: UIScrollView!) -> CGPoint {
        return CGPointMake(0, -64)
    }
    
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
        return self.pharmacies.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MedicalStationCell
        cell.configCellWithData(self.pharmacies[indexPath.row])
        
        if indexPath.row == self.pharmacies.count - 1 {
            self.view.userInteractionEnabled = false
            self.loadMoreData()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}
