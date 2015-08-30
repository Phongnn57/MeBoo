//
//  AddMemberViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

protocol AddMemberViewControllerDelegate {
    func didFinishCreatePatient(patient: Patient)
}

class AddMemberViewController: BaseViewController, UITextFieldDelegate, SHMultipleSelectDelegate, UIPickerViewDataSource, UIPickerViewDelegate, EnbacAlertPopupDelegate {
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var nameTF: SingleLineTextField!
    @IBOutlet weak var dobTF: SingleLineTextField!
    @IBOutlet weak var bloodTypeTF: SingleLineTextField!
    @IBOutlet weak var boyBtn: UIButton!
    @IBOutlet weak var girlBtn: UIButton!
    @IBOutlet weak var relationShip: SingleLineTextField!
    @IBOutlet weak var height: SingleLineTextField!
    @IBOutlet weak var weight: SingleLineTextField!
    @IBOutlet weak var avatar: UIImageView!
    
    var gender: Int = 0
    var isEdit: Bool = false
    var sicks: [Sick]!
    var selectedSicks:[Int]!
    var delegate: AddMemberViewControllerDelegate?
    var editPatient: Patient!
    var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sicks = Sick.MR_findAll() as! [Sick]
        self.selectedSicks = []
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "endEditing"))
        self.showDatePickerPopup()
        self.configPickerView()
        
        
        if isEdit {
            self.titleLB.text = "Sửa thành viên"
            
            self.nameTF.updateText(self.editPatient.name)
            self.dobTF.updateText(self.editPatient.dob.toString())
            self.bloodTypeTF.updateText(self.editPatient.bloodType)
            self.relationShip.updateText(self.editPatient.relationshipWithUser)
            
        } else {
            self.titleLB.text = "Thêm thành viên"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func configPickerView() {
        var pickerView = UIPickerView()
        pickerView.frame = CGRectMake(0, 0, pickerView.frame.size.width, 200)
        pickerView.dataSource = self
        pickerView.delegate = self
        self.bloodTypeTF.inputView = pickerView
    }
    
    // MARK: Show Term of services
    func showTermOfServices() {
        let termPopup = EnbacAlertPopup(title: "Chính sách và điều khoản sử dụng", longText: TermStr, cancelButtonTitle: "Không đồng ý", doneButtonTitle: "Đồng ý")
        termPopup.extraTag = 1
        termPopup.delegate = self
        termPopup.openPopup()
    }
    
    func alertPopupDidSelectCancelButton(alertView: UIView, extraTag: Int) {
        
    }
    
    func alertPopupDidSelectDoneButton(alertView: UIView, extraTag: Int) {
        
    }
    
    // MARK: PICKER VIEW 
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BloodType.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return BloodType[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.bloodTypeTF.text = BloodType[row]
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }

    @IBAction func saveMemberAction(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        if self.nameTF.text.isEmpty {
            self.view.makeToast("Vui lòng nhập họ tên")
            return
        }
        if self.dobTF.text.isEmpty {
            self.view.makeToast("Vui lòng nhập ngày tháng năm sinh")
            return
        }
        if self.bloodTypeTF.text.isEmpty {
            self.view.makeToast("Vui lòng chọn nhóm máu")
            return
        }
        if self.relationShip.text.isEmpty {
            self.view.makeToast("Vui lòng nhập quan hệ với bạn")
            return
        }
        
        let multipleSelect = SHMultipleSelect()
        multipleSelect.delegate = self
        multipleSelect.rowsCount = self.sicks.count
        
        multipleSelect.show()

    }
    
    func createUser() {
        
        if !isEdit {
            let newPatient = Patient.MR_createEntity() as! Patient
            newPatient.name = self.nameTF.text
            newPatient.dob = self.dobTF.text.toDate(format: "dd-MM-yyyy")!
            newPatient.gender = self.gender
            newPatient.bloodType = self.bloodTypeTF.text
            newPatient.relationshipWithUser = self.relationShip.text
            newPatient.userId = UserObject.sharedUser.userID
            newPatient.lastUpdated = NSDate().seconds
            
            MRProgressOverlayView.showOverlayAddedTo(self.view, title: "Đang tạo...", mode: MRProgressOverlayViewMode.IndeterminateSmall, animated: true)
            PatientAPI.createPatientUser(newPatient.name, dob: newPatient.dob.toString(), gender: newPatient.gender.integerValue, userID: UserObject.sharedUser.userID, relationShip: newPatient.relationshipWithUser, bloodType: newPatient.bloodType, completion: { (patientID) -> Void in
                
                SickAPI.createSickUser(patientID.integerValue, sick: self.selectedSicks, completion: { () -> Void in
                    
                    MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
                    
                    newPatient.id = patientID
                    NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                    
                    for sickID in self.selectedSicks {
                        let newPatientSick = Patient_Sick.MR_createEntity() as! Patient_Sick
                        newPatientSick.patientID = patientID
                        newPatientSick.sickID = sickID
                        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                        
                        if let injectionSchedule: [Injection_Schedule] = Injection_Schedule.MR_findAllWithPredicate(NSPredicate(format: "sickID = \(sickID)")) as? [Injection_Schedule] {
                            
                            for _injectionSchedule in injectionSchedule {
                                
                                let injecSche: Injection_Schedule = _injectionSchedule as Injection_Schedule
                                
                                let patientInjection = Patient_Injection.MR_createEntity() as! Patient_Injection
                                patientInjection.isDone = 0
                                patientInjection.patientID = newPatient.id
                                patientInjection.sickID = sickID
                                patientInjection.injectDay = newPatient.dob.addMonths(injecSche.month.integerValue)
                                patientInjection.number = injecSche.number
                                let date = NSDate()
                                patientInjection.lastUpdated = date.seconds
                                
                                NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                            }
                        }
                    }
                    
                    self.delegate?.didFinishCreatePatient(newPatient)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    }, failure: { (error) -> Void in
                        self.view.makeToast("Có lỗi xảy ra! Vui lòng thử lại")
                        MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
                })
                
                }) { (error) -> Void in
                    self.view.makeToast("Có lỗi xảy ra! Vui lòng thử lại")
                    MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
            }

        } else {
            PatientAPI.updatePatientUser(self.editPatient.id.integerValue, name: self.editPatient.name, relationShip: self.editPatient.relationshipWithUser, bloodType: self.editPatient.bloodType, lastUpdated: Int(NSDate().timeIntervalSince1970), completion: { () -> Void in
                
                NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                self.delegate?.didFinishCreatePatient(self.editPatient)
                self.dismissViewControllerAnimated(true, completion: nil)
            }, failure: { (error) -> Void in
                self.view.makeToast("Có lỗi xảy ra! Vui lòng thử lại")
            })
        }
        
    }

    
    // MARK: TEXTFIELD DELEGATE
    func showDatePickerPopup() {
        let datePicker = UIDatePicker()
        datePicker.frame = CGRectMake(0, 0, datePicker.frame.size.width, 200)
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: "datePickerDidChange:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.dobTF.inputView = datePicker
    }
    
    @IBAction func selectBoy(sender: AnyObject) {
        boyBtn.setBackgroundImage(UIImage(named: "selected"), forState: .Normal)
        girlBtn.setBackgroundImage(UIImage(named: "unselected"), forState: .Normal)
        self.avatar.image = UIImage(named: "boy")
        self.gender = 0
    }
    
    @IBAction func selectGirl(sender: AnyObject) {
        girlBtn.setBackgroundImage(UIImage(named: "selected"), forState: .Normal)
        boyBtn.setBackgroundImage(UIImage(named: "unselected"), forState: .Normal)
        self.avatar.image = UIImage(named: "girl")
        self.gender = 1
    }
    
    // MARK: SHMULTIPLE SELECT
    func multipleSelectView(multipleSelectView: SHMultipleSelect!, clickedBtnAtIndex clickedBtnIndex: Int, withSelectedIndexPaths selectedIndexPaths: [AnyObject]!) {
        if clickedBtnIndex == 1 {
            if selectedIndexPaths != nil {
                for indexpath in selectedIndexPaths {
                    if let _indexPath: NSIndexPath = indexpath as? NSIndexPath {
                        self.selectedSicks.append(self.sicks[_indexPath.row].id.integerValue)
                    }
                }
                self.createUser()
            }
            
        } else {
            print("0")
        }
    }
    
    func multipleSelectView(multipleSelectView: SHMultipleSelect!, setSelectedForRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }
    
    func multipleSelectView(multipleSelectView: SHMultipleSelect!, titleForRowAtIndexPath indexPath: NSIndexPath!) -> String! {
        return self.sicks[indexPath.row].sickName
    }
    
    // mark: datepicker action
    func datePickerDidChange(datePicker: UIDatePicker) {
        
        let date = datePicker.date
        let year = date.year
        let month = date.month
        let day = date.days
        
        let str = "\(day)-\(month)-\(year)"
        
        self.dobTF.text = str
    }

}
