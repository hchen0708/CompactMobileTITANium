//
//  CourseTableViewController.swift
//  CMT
//
//  Created by ew on 2016/4/7.
//  Copyright © 2016年 Hong. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess
import SwiftyJSON

class CourseTableViewController: UITableViewController {
    let keychain = Keychain(service: "com.Hong-test.CMT")
    var courses = [Course]()
    var courseGrades = [Grade]()
    var courseActivities = [CourseActivity]()
    let coursesActivityURL = "http://118.163.1.108/api/course_activities/?format=json"
    let courseGradeURL = "http://118.163.1.108/api/course_grade/?format=json"

    //Define selected row for swiping gesture at a specific row
    var selectedRow:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Course List"
        
        let token = self.keychain["token"]
        let url = NSURL(string: self.coursesActivityURL)
        let mutableURLRequest = NSMutableURLRequest(URL: url!)
        mutableURLRequest.setValue("JWT \(token!)", forHTTPHeaderField: "Authorization")
        mutableURLRequest.HTTPMethod = "GET"
        
        
        //Grabing course activities
        let manager = Alamofire.Manager.sharedInstance
        let getCourseActivityRequest = manager.request(mutableURLRequest)
        getCourseActivityRequest.responseJSON { (activitiesReceived) in
            let jsonData = JSON(activitiesReceived.result.value!)
            for (_, subJSON) in jsonData {
                let courseActivity = CourseActivity(user: subJSON["user"].int!, title: subJSON["title"].string!, id: subJSON["id"].int!)
                courseActivity.course_title = subJSON["course_title"].string!
                courseActivity.content = subJSON["content"].string!
                self.courseActivities.append(courseActivity)
            }
        }
        
        //Grabing course grades
        let url2 = NSURL(string: self.courseGradeURL)
        let mutableURLRequest2 = NSMutableURLRequest(URL: url2!)
        mutableURLRequest2.setValue("JWT \(token!)", forHTTPHeaderField: "Authorization")
        mutableURLRequest2.HTTPMethod = "GET"
        
        let manager2 = Alamofire.Manager.sharedInstance
        let getCourseGradeRequest = manager2.request(mutableURLRequest2)
        getCourseGradeRequest.responseJSON { (gradesReceived) in
            let jsonData2 = JSON(gradesReceived.result.value!)
            for (_, subJSON) in jsonData2 {
                let courseGrade = Grade(user: subJSON["user"].int!, grade_item: subJSON["grade_item"].string!, id: subJSON["id"].int!)
                courseGrade.percentage = subJSON["percentage"].float!
                courseGrade.feedback = subJSON["feedback"].string!
                courseGrade.grade = subJSON["grade"].float!
                courseGrade.course = subJSON["course"].int!
                courseGrade.course_title = subJSON["course_title"].string!
                courseGrade.range = subJSON["range"].float!
                self.courseGrades.append(courseGrade)
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.courses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = "\(self.courses[indexPath.row].course_code!)"
        cell.detailTextLabel?.text = "\(self.courses[indexPath.row].title!)"
        cell.textLabel?.font = UIFont(name: "Helvetica nenu ", size: 20)
        return cell
    }
    
    //Define segue to swiping action
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let grades = UITableViewRowAction(style: .Normal, title: "Grades") { action, index in
            self.selectedRow = indexPath.row
            self.performSegueWithIdentifier("showGrades", sender: nil)
        }
        //Showing "grades" in swipe cell
        return [grades]
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        //Determining which segue is activating to pass data
        if segue.identifier == "showCourseActivity" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let vc = segue.destinationViewController as! CourseActivityTableViewController
            vc.courseActivities = []
            for courseActivity in courseActivities{
                if courseActivity.course_title == courses[indexPath.row].title{
                vc.courseActivities.append(courseActivity)
                }
            }
        }
        
        if segue.identifier == "showGrades" {
            let vc = segue.destinationViewController as! GradeTableViewController
            vc.courseGrades = []
            for courseGrade in courseGrades{
                if courseGrade.course_title == courses[self.selectedRow].title{
                    vc.courseGrades.append(courseGrade)
                }
            }
        }
    }
    

}
