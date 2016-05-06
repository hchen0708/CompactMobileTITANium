//
//  MainNavigationController.swift
//  CMT
//
//  Created by ew on 2016/4/22.
//  Copyright © 2016年 Hong. All rights reserved.
//

import UIKit
import KeychainAccess

class MainNavigationController: UINavigationController {

    var semesters = [Semester]()
    var courses = [Course]()
    let bkColor = UIColor.init(red: CGFloat(15) / 255.0, green: CGFloat(60) / 255.0, blue: CGFloat(115) / 255.0, alpha: CGFloat(1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = self.navigationBar
        navBar.frame = CGRectMake(0, 0, self.view.frame.width, 10)
        navBar.barTintColor = bkColor
        //Set title text through text attributes
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //Set NavBar item color ("backbtn")
        navBar.tintColor = UIColor.whiteColor()

        self.view.addSubview(navBar)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        segue.destinationViewController as! SemestersTableViewController
    
//    }
    

}
