//
//  HomeViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, GeneralCellDelegate, UIGestureRecognizerDelegate, LMDropdownViewDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet var firstTableView: UITableView!
    @IBOutlet var secondTableView: UITableView!
    @IBOutlet var thirdTableView: UITableView!
    @IBOutlet weak var singleLine: UIView!
    var patientTableView: UITableView!
    
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    var menuButton: UIBarButtonItem!
    var userButton: UIBarButtonItem!
    var dropDownMenu: LMDropdownView!
    
    var sicks: [Sick] = []
    var patients:[Patient]!
    var patient: Patient!

    
    // FIRST PAGE DATA
    private let CellIdentifier = "GeneralCell"
    var patientInjection: [Patient_Injection]!
    var injections: Array<AnyObject> = []
    
    // second
    var injectionSortedByTime:Array<AnyObject> = []
    
    //third
    var injectionSchedule: Array<AnyObject> = []
    
    private let SecondCellIdentifier = "ReportCell"
    private let ThirdCellIdentifier = "ThirdCell"
    private let PatientCellIdentifier = "PatientCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sổ tiêm chủng"
        
        self.patients = Patient.MR_findAll() as! [Patient]
        self.patient = self.patients[0]
        self.patientInjection = Patient_Injection.MR_findAllWithPredicate(NSPredicate(format: "patientID = \(self.patient.id)")) as! [Patient_Injection]
        self.reloadData(self.patient)
        
        self.menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.userButton = UIBarButtonItem(title: self.patients[0].name, style: UIBarButtonItemStyle.Plain, target: self, action: "showDropDownMenu")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.navigationItem.leftBarButtonItems = [self.menuButton, self.userButton]
        self.navigationController?.navigationBar.translucent = false
        self.sicks = Sick.MR_findAll() as! [Sick]
        self.configScrollView()
        
        //
        self.firstTableView.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        self.secondTableView.registerNib(UINib(nibName: SecondCellIdentifier, bundle: nil), forCellReuseIdentifier: SecondCellIdentifier)
        self.thirdTableView.registerNib(UINib(nibName: ThirdCellIdentifier, bundle: nil), forCellReuseIdentifier: ThirdCellIdentifier)
        self.patientTableView = UITableView(frame: CGRectMake(0.0, 0.0, SCREEN_SIZE.width, CGFloat(self.patients.count * 44)))
        self.patientTableView.delegate = self
        self.patientTableView.dataSource = self
        self.patientTableView.registerNib(UINib(nibName: PatientCellIdentifier, bundle: nil), forCellReuseIdentifier: PatientCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.swipeView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadPatient", name: "reloadpatient", object: nil)
    }
    
    func reloadPatient() {
        self.patients = Patient.MR_findAll() as! [Patient]
        self.reloadData(self.patient)
    }
    
    func reloadData(patient: Patient) {
        self.patientInjection = Patient_Injection.MR_findAllWithPredicate(NSPredicate(format: "patientID = \(patient.id)")) as! [Patient_Injection]
        self.injections = self.configInjection(self.patientInjection)
        self.injectionSortedByTime = self.configInjectionSortByTime(self.patientInjection)
        self.injectionSchedule = self.configInjectionSchedule()
    }
    
    // MARK: DROPDOWN MENU
    func showDropDownMenu() {
        if (self.dropDownMenu == nil) {
            self.dropDownMenu = LMDropdownView()
            self.dropDownMenu.delegate = self
            // Customize Dropdown style
            self.dropDownMenu.closedScale = 0.85
            self.dropDownMenu.blurRadius = 5
            self.dropDownMenu.blackMaskAlpha = 0.5
            self.dropDownMenu.animationDuration = 0.5
            self.dropDownMenu.animationBounceHeight = 20
            self.dropDownMenu.contentBackgroundColor =  UIColor.greenColor()
        }
        
        // Show/hide dropdown view
        if (self.dropDownMenu.isOpen) {
            self.dropDownMenu.hide()
        }
        else {
            self.dropDownMenu.showFromNavigationController(self.navigationController, withContentView: self.patientTableView)
        }
    }
    
    func dropdownViewDidHide(dropdownView: LMDropdownView!) {
        
    }
    
    func dropdownViewDidShow(dropdownView: LMDropdownView!) {
        
    }
    
    func dropdownViewWillHide(dropdownView: LMDropdownView!) {
        
    }
    
    func dropdownViewWillShow(dropdownView: LMDropdownView!) {
        
    }
    
    func swipe(gesture: UISwipeGestureRecognizer) {
        let loc = gesture.locationInView(self.view)
        
        if loc.x <= 40 {
            self.revealViewController().setFrontViewPosition(FrontViewPosition.Right, animated: true)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func configInjectionSchedule() -> Array<AnyObject> {
        let _tmpInjectionSchedule = Injection_Schedule.MR_findAllSortedBy("month", ascending: true) as! [Injection_Schedule]
        var tmpInjectionSchedule: Array<Injection_Schedule> = []
        for obj in _tmpInjectionSchedule {
            for _obj in self.patientInjection {
                if obj.sickID == _obj.sickID {
                    tmpInjectionSchedule.append(obj)
                    break
                }
            }
        }
        
        var tmpDic: Array<AnyObject> = Array<AnyObject>()
        var tmpMonth: Array<NSNumber> = []
        
        for obj in tmpInjectionSchedule {
            var mark: Bool = false
            for eachMonth in tmpMonth {
                if obj.month == eachMonth {
                    mark = true
                    break
                }
            }
            if !mark {
                tmpMonth.append(obj.month)
            }
        }
        
        for eachMonth in tmpMonth {
            var schedule: Array<Injection_Schedule> = []
            for obj in tmpInjectionSchedule {
                if obj.month == eachMonth {
                    schedule.append(obj)
                }
            }
            tmpDic.append(schedule)
        }
        
        return tmpDic
    }
    
    func configInjectionSortByTime(injection: [Patient_Injection]!) ->Array<AnyObject> {
        var tmpDic: Array<AnyObject> = Array<AnyObject>()
        var tmpInjection: Array<AnyObject> = []
        
        var tmpArrID: Array<Int> = []
        
        for obj in injection {
            var mark: Bool = false
            for eachID in tmpArrID {
                if obj.injectDay.month + obj.injectDay.year == eachID {
                    mark = true
                    break
                }
            }
            if !mark {
                tmpArrID.append(obj.injectDay.month + obj.injectDay.year)
            }
        }
        
        for sickID in tmpArrID {
            var injec: Array<Patient_Injection> = []
            for obj in injection {
                if obj.injectDay.month + obj.injectDay.year == sickID {
                    injec.append(obj)
                }
            }
            tmpInjection.append(injec)
        }
        
        return tmpInjection
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
    
    func configScrollView() {
        self.scrollview.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 154)
        let scrollViewWidth:CGFloat = self.scrollview.frame.width
        let scrollViewHeight:CGFloat = self.scrollview.frame.height
        
        self.firstTableView.frame = CGRectMake(0, 0, scrollViewWidth, scrollViewHeight)
        self.secondTableView.frame = CGRectMake(scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)
        self.thirdTableView.frame = CGRectMake(scrollViewWidth * 2, 0, scrollViewWidth, scrollViewHeight)
        
        self.scrollview.addSubview(self.firstTableView)
        self.scrollview.addSubview(self.secondTableView)
        self.scrollview.addSubview(self.thirdTableView)
        
        //4
        self.scrollview.contentSize = CGSizeMake(self.scrollview.frame.width * 3, self.scrollview.frame.height)
        self.scrollview.delegate = self
    }
    
    func moveToNextPage (){
        
        // Move to next page
        var pageWidth:CGFloat = CGRectGetWidth(self.scrollview.frame)
        let maxWidth:CGFloat = pageWidth * 3
        var contentOffset:CGFloat = self.scrollview.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
        } else {

            self.scrollview.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollview.frame)), animated: true)
            var tmpFrame: CGRect = self.singleLine.frame
            tmpFrame.origin.x += SCREEN_SIZE.width/3
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.singleLine.frame = tmpFrame
            })
        }
    }
    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        var pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
//        var currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth) +  1
//        var tmpFrame: CGRect = self.singleLine.frame
//        if Int(currentPage) == 0 {
//            tmpFrame.origin.x = 0
//        } else if Int(currentPage) == 1 {
//            tmpFrame.origin.x = SCREEN_SIZE.width/3
//        } else {
//            tmpFrame.origin.x = SCREEN_SIZE.width/3 * 2
//        }
//        
//        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            self.singleLine.frame = tmpFrame
//        })
//    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        var pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
//        var currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth) +  1
//        var tmpFrame: CGRect = self.singleLine.frame
//        if Int(currentPage) == 0 {
//            tmpFrame.origin.x = 0
//        } else if Int(currentPage) == 1 {
//            tmpFrame.origin.x = SCREEN_SIZE.width/3
//        } else {
//            tmpFrame.origin.x = SCREEN_SIZE.width/3 * 2
//        }
//        
//        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            self.singleLine.frame = tmpFrame
//        })
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView.isEqual(self.secondTableView) {
            return self.injectionSortedByTime.count
        } else if tableView.isEqual(self.thirdTableView) {
            return self.injectionSchedule.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(self.firstTableView) {
            return self.injections.count
        } else if tableView.isEqual(self.secondTableView) {
            let injections: Array<Patient_Injection> = self.injectionSortedByTime[section] as! Array<Patient_Injection>
            return injections.count
        } else if tableView.isEqual(self.thirdTableView) {
            let schedules: Array<Injection_Schedule> = self.injectionSchedule[section] as! Array<Injection_Schedule>
            return schedules.count
        } else if tableView.isEqual(self.patientTableView) {
            return self.patients.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.isEqual(self.firstTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! GeneralCell
            
            cell.delefate = self
            let injection: Array<Patient_Injection> = self.injections[indexPath.row] as! Array<Patient_Injection>
            cell.configCellWithSick(injection)
            
            let sickID = injection[0].sickID
            let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(sickID)")) as! Sick
            
            cell.sickName.text = sick.sickName
            
            return cell
        } else if tableView.isEqual(self.secondTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(SecondCellIdentifier) as! ReportCell
            
            let injections: Array<Patient_Injection> = self.injectionSortedByTime[indexPath.section] as! Array<Patient_Injection>
            let injection = injections[indexPath.row]
            cell.configCellWithPatientInjection(injection)
            
            return cell
        } else if tableView.isEqual(self.thirdTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(ThirdCellIdentifier) as! ThirdCell
            let schedules: Array<Injection_Schedule> = self.injectionSchedule[indexPath.section] as! Array<Injection_Schedule>
            let schedule = schedules[indexPath.row]
            let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(schedule.sickID)")) as! Sick
            cell.name.text = sick.sickName
            cell.count.text = "Mũi thứ " + "\(schedule.number)"
            
            return cell
        } else if tableView.isEqual(self.patientTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(PatientCellIdentifier) as! PatientCell
            cell.name.text = self.patients[indexPath.row].name
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.isEqual(self.thirdTableView) {
            
            let schedules: Array<Injection_Schedule> = self.injectionSchedule[indexPath.section] as! Array<Injection_Schedule>
            let schedule = schedules[indexPath.row]
            let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(schedule.sickID)")) as! Sick
            
            let infoSick = EnbacAlertPopup(title: sick.sickName, longText: sick.descrip, cancelButtonTitle: nil, doneButtonTitle: "Đóng")
            infoSick.openPopup()
        } else if tableView.isEqual(self.patientTableView) {
            self.patient = self.patients[indexPath.row]
            self.reloadData(self.patient)
            self.firstTableView.reloadData()
            self.secondTableView.reloadData()
            self.thirdTableView.reloadData()
            self.dropDownMenu.hide()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.isEqual(self.secondTableView) || tableView.isEqual(self.thirdTableView) {
            return 44
        }
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.isEqual(self.secondTableView) {
            let injections: Array<Patient_Injection> = self.injectionSortedByTime[indexPath.section] as! Array<Patient_Injection>
            let injection = injections[indexPath.row]
            let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(injection.sickID)")) as! Sick
            return ReportCell.calculateCellHeigh(sick.sickName)
        } else if tableView.isEqual(self.thirdTableView) {
            let schedules: Array<Injection_Schedule> = self.injectionSchedule[indexPath.section] as! Array<Injection_Schedule>
            let schedule = schedules[0]
            let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(schedule.sickID)")) as! Sick
            return ThirdCell.calculateCellHeigh(sick.sickName)
        } else if tableView.isEqual(self.patientTableView) {
            return 44
        }
        return 60
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.isEqual(self.secondTableView) {
            let injections: Array<Patient_Injection> = self.injectionSortedByTime[section] as! Array<Patient_Injection>
            let injection = injections[0]
            return "Tháng \(injection.injectDay.month) - \(injection.injectDay.year)"
        } else if tableView.isEqual(self.thirdTableView) {
            let schedules: Array<Injection_Schedule> = self.injectionSchedule[section] as! Array<Injection_Schedule>
            let schedule = schedules[0]
            let sick = Sick.MR_findFirstWithPredicate(NSPredicate(format: "id = \(schedule.sickID)")) as! Sick
            if schedule.month.integerValue <= 0 {
                return "Sơ sinh"
            }
            return "\(schedule.month) tháng"
        }
        return nil
    }
    
    // delegate
    func didSelectButtonAtCellAndIndex(cell: GeneralCell, btnIndex: Int) {
        let indexPath: NSIndexPath = self.firstTableView.indexPathForCell(cell)!
        let injections: Array<Patient_Injection> = self.injections[indexPath.row] as! Array<Patient_Injection>
        let patientInjection = injections[btnIndex]
        
        let infoPopup = EnbacAlertPopup(title: "Thông tin mũi tiêm", injectionCount: patientInjection.number.integerValue, injectionName: cell.sickName.text, injectionDay: patientInjection.injectDay.toString(), injectionStatus: patientInjection.isDone.integerValue == 0 ?  "Chưa hoàn thành" : "Hoàn thành", note: patientInjection.note, cancelButtonTitle: "Xong", doneButtonTitle: "Chỉnh sửa")
        infoPopup.openPopup()
    }
    
    
    // MARK: BUTTON ACTION
    
    @IBAction func moveToFirstTable(sender: AnyObject) {
    }

    @IBAction func moveToSecondTable(sender: AnyObject) {
    }
    
    @IBAction func moveToThirdTable(sender: AnyObject) {
    }
    
}
