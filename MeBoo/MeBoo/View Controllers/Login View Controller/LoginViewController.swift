//
//  LoginViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/19/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var loginGoogle: UIButton!
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var verticalSpaceConstraint: NSLayoutConstraint!
    
    var email: String = ""
    var name: String = ""
    var gender: Int = 2
    var photoURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { () -> Void in
            self.verticalSpaceConstraint.constant = 80
            self.logoView.layoutIfNeeded()
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.loginFacebook.alpha = 1
                    self.loginGoogle.alpha = 1
                })
        }
    }
    
    func finishedLoggin() {
        DELEGATE.startApp()
    }

    @IBAction func doLoginWithGoogle(sender: AnyObject) {
//        let alert = EnbacAlertPopup(title: "Thông tin mũi tiêm", injectionCount: 2, injectionName: "Viêm gan B", injectionDay: "22-2-2105", injectionStatus: "Chưa đến", note: "Hâhhahahahahahahahah hahahahahahahahahahahahahahahahaha", cancelButtonTitle: "Đóng", doneButtonTitle: "Chỉnh sửa")
//        alert.openPopup()
        
        
        
        let alert = EnbacAlertPopup(title: "Thong bao", longText: TermStr, cancelButtonTitle: "Huy bo", doneButtonTitle: "Dong y")
        alert.openPopup()

    }
    
    @IBAction func doLoginWithFacebook(sender: AnyObject) {
        
        if(FBSDKAccessToken.currentAccessToken() != nil){
            self.getUserProfile({ () -> Void in
                self.startConnectServer()
            })
        }else{
            let login = FBSDKLoginManager()
            login.logInWithReadPermissions(["email", "public_profile"]) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
                if (error == nil && !result.isCancelled && result.grantedPermissions.contains("email")) {
                    self.getUserProfile({ () -> Void in
                        self.startConnectServer()
                    })
                }
            }
        }
    }
    
    func getUserProfile(completion:()->Void) {

        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
            if (error == nil){
                if let _email = result["email"] as? String {
                    self.email = _email
                }
                if let _gender = result["gender"] as? String {
                    if _gender == "male" {
                        self.gender = 0
                    } else if _gender == "female" {
                        self.gender = 1
                    }
                }
                if let _name = result["name"] as? String {
                    self.name = _name
                }
                
                if let _picture = result["picture"] as? Dictionary<String, AnyObject> {
                    if let _data = _picture["data"] as? Dictionary<String, AnyObject> {
                        if let _photoURL = _data["url"] as? String {
                            self.photoURL = _photoURL
                        }
                    }
                }
                completion()
            }
        })
    }
    
    func startConnectServer() {
        MRProgressOverlayView.showOverlayAddedTo(self.view, title: "Đang đăng nhập", mode: MRProgressOverlayViewMode.IndeterminateSmall, animated: true)
        UserAPI.getUserWithLoginType(AppConstant.LoginType.Login_Facebook, loginID: FBSDKAccessToken.currentAccessToken().userID, completion: { (existUser) -> Void in
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
            if existUser {
                
                Patient.MR_truncateAll()
                Patient_Sick.MR_truncateAll()
                Patient_Injection.MR_truncateAll()
                MRProgressOverlayView.showOverlayAddedTo(self.view, title: "Đang khởi tạo dữ liệu", mode: MRProgressOverlayViewMode.IndeterminateSmall, animated: true)
                UserAPI.callSuperAPI(UserObject.sharedUser.userID, completion: { () -> Void in
                    MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
                    self.finishedLoggin()
                    }, failure: { (error) -> Void in
                        MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
                })
                
            } else {
                
                UserAPI.createUser(AppConstant.LoginType.Login_Facebook, loginID: FBSDKAccessToken.currentAccessToken().userID, gender: self.gender, accessToken: FBSDKAccessToken.currentAccessToken().tokenString, photoURL: self.photoURL, name: self.name, email: self.email, completion: { () -> Void in
                    MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
                    
                    let addPatient = AddMemberViewController()
                    self.presentViewController(addPatient, animated: true, completion: nil)
                    
                    }, failure: { (error) -> Void in
                        self.view.makeToast(error)
                        MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
                })
            }
            
            }) { (error) -> Void in
                MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
        }
    }
}
