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

    @IBAction func doLoginWithGoogle(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let swRevealController: SWRevealViewController = storyBoard.instantiateInitialViewController() as! SWRevealViewController
        DELEGATE.startApp()
    }
    
    @IBAction func doLoginWithFacebook(sender: AnyObject) {
//        if(FBSDKAccessToken.currentAccessToken() != nil){
//            print("Logged in")
            //            FBSDKAccessToken.currentAccessToken().userID
            //            self.loginViaSocial(SocialTypes.Facebook, userId: FBSDKAccessToken.currentAccessToken().userID, accessToken: FBSDKAccessToken.currentAccessToken().tokenString)
//        }else{
//            let login = FBSDKLoginManager()
//            login.logInWithReadPermissions(["email", "public_profile"]) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
//                if (error == nil && !result.isCancelled && result.grantedPermissions.contains("email")) {
//                    //                    self.loginViaSocial(SocialTypes.Facebook, userId: result.token.userID, accessToken: result.token.tokenString)
//                    
//                }
//            }
            
//        }
    }
    
}
