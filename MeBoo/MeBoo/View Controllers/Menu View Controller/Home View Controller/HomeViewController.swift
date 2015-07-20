//
//  HomeViewController.swift
//  MeBoo
//
//  Created by Nam Phong on 7/20/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var menuButton: UIBarButtonItem!
    var firstLoad = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sổ tiêm chủng"
        
        self.menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.leftBarButtonItem = self.menuButton
        
        self.configPaging()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        if self.firstLoad {
            self.firstLoad = false
            
        }
    }
    
    func configPaging() {
        let injectionNote = FirstPageViewController()
        injectionNote.title = "SỔ TIÊM"
        let reportPage = ReportPageViewController()
        reportPage.title = "BÁO CÁO"
        let injectionSchedule = FirstPageViewController()
        injectionSchedule.title = "LỊCH TIÊM"
        
        let viewControllers = [injectionNote, reportPage, injectionSchedule]
        
        let statusHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let navigationHeight = self.navigationController?.navigationBar.frame.size.height
        let containerViewController: YSLContainerViewController = YSLContainerViewController(controllers: viewControllers, topBarHeight: statusHeight + navigationHeight!, parentViewController: self)
        self.view.addSubview(containerViewController.view)
    }

}
