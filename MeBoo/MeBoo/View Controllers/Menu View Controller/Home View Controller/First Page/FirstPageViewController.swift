//
//  FirstPageViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class FirstPageViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UIGestureRecognizerDelegate, GeneralCellDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    private let CellIdentifier = "GeneralCell"
    
    var patientInjection: [Patient_Injection]!
    var injections: Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableview.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        let patients = Patient.MR_findAll() as! [Patient]
        let patient = patients.first
        self.patientInjection = Patient_Injection.MR_findAllWithPredicate(NSPredicate(format: "patientID = \(patient!.id)")) as! [Patient_Injection]
        
        self.injections = self.configInjection(self.patientInjection)
        
        
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        swipeGesture.delegate = self
        self.view.addGestureRecognizer(swipeGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swiped(swipeRecognizer: UISwipeGestureRecognizer) {
        
        let loc = swipeRecognizer.locationInView(self.view)
        if loc.x <= 40 {
            print("SWIPE")
            self.revealViewController().setFrontViewPosition(FrontViewPosition.Right, animated: true)
            
        }
    }
   
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func configInjection(injection: [Patient_Injection]!) ->Array<AnyObject> {
        var tmpDic: Array<AnyObject> = Array<AnyObject>()
        var tmpInjection: Array<AnyObject> = []

        var tmpArrID: Array<NSNumber> = []
        
        for obj in injection {
            var mark: Bool = false
            for eachID in tmpArrID {
                if obj.sickID == eachID {
                    mark = true
                    break
                }
            }
            if !mark {
                tmpArrID.append(obj.sickID)
            }
        }
        
        for sickID in tmpArrID {
            var injec: Array<Patient_Injection> = []
            for obj in injection {
                if obj.sickID == sickID {
                    injec.append(obj)
                }
            }
            tmpInjection.append(injec)
        }
        
        return tmpInjection
    }

    // MARK: EMPTY SET
    /*
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
    */

    // MARK: TABLEVIEW
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.injections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! GeneralCell
        
        cell.delefate = self
        let injection: Array<Patient_Injection> = self.injections[indexPath.row] as! Array<Patient_Injection>
        cell.configCellWithSick(injection)
        
        let sickID = injection[0].sickID
        let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(sickID)")) as! Sick

        cell.sickName.text = sick.sickName
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // delegate
    func didSelectButtonAtCellAndIndex(cell: GeneralCell, btnIndex: Int) {
        let indexPath: NSIndexPath = self.tableview.indexPathForCell(cell)!
        let injections: Array<Patient_Injection> = self.injections[indexPath.row] as! Array<Patient_Injection>
        let patientInjection = injections[btnIndex]
        
        let infoPopup = EnbacAlertPopup(title: "TEST", injectionCount: patientInjection.number.integerValue, injectionName: "NAME", injectionDay: patientInjection.injectDay.toString(), injectionStatus: "Chưa hoàn thành", note: patientInjection.note, cancelButtonTitle: "Xong", doneButtonTitle: "Chỉnh sửa")
        infoPopup.openPopup()
    }

}
