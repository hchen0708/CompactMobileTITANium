//
//  ProjectViewController.swift
//  CMT
//
//  Created by ew on 2016/4/6.
//  Copyright © 2016年 Hong. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var courses = [Course]()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleText = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 100))
        titleText.text = "Courses - \(self.courses.count)"
        titleText.textAlignment = .Center
        
        self.view.addSubview(titleText)
        
        if self.courses.count > 0 {
            for i in courses {
                print(i.title)
            }
        }
        
        self.tableView.frame = CGRectMake(0, self.view.frame.height/4.0, self.view.frame.width, self.view.frame.height*3/4.0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel!.text = "\(indexPath.row + 1) - \(self.courses[indexPath.row].title)"
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.courses.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
