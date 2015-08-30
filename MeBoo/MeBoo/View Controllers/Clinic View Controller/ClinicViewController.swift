//
//  ClinicViewController.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/25/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class ClinicViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var mapBtn: UIBarButtonItem!
    var menuButton: UIBarButtonItem!
    
    var clinics: [Clinic]!
    private let CellIdentifier = "MedicalStationCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clinics = Clinic.MR_findAll() as! [Clinic]
        self.tableview.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        self.mapBtn = UIBarButtonItem(title: "Bản đồ", style: UIBarButtonItemStyle.Plain, target: self, action: "moveToMapView")
        self.navigationItem.rightBarButtonItem = self.mapBtn
        self.menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.leftBarButtonItem = self.menuButton
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TABLEVIEW METHODS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clinics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MedicalStationCell
        cell.configCellWithData(self.clinics[indexPath.row])

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    // MARK:
    func moveToMapView() {
        let mapViewController = MapViewController()
        mapViewController.clinics = self.clinics
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
}