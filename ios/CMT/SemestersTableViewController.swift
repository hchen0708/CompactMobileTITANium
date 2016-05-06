//
//  SemestersTableViewController.swift
//  CMT
//
//  Created by ew on 2016/4/15.
//  Copyright © 2016年 Hong. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess
import SwiftyJSON

class SemestersTableViewController: UITableViewController {
    let keychain = Keychain(service: "com.Hong-test.CMT")
    var semesters = [Semester]()
    var courses = [Course]()
    var currentSemester = [Semester]()
    var previousSemester = [Semester]()
    var sectionArray = [Section]()

    
    
    let coursesURL = "http://118.163.1.108/api/courses/?format=json"
    let sectionCategories = ["current semester", "previous semester"]
    var currentSemesterSlug: [String] = []
    var previousSemesterSlug: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Semester List"
        
        //Differentiating semester into sections through verifying the active booleanfield
        for semester in semesters{
            if semester.active == true {
                currentSemester.append(semester)
                currentSemesterSlug.append(semester.slug!)
            } else {
                previousSemester.append(semester)
                previousSemesterSlug.append(semester.slug!)
            }
        }
    
        let currentS = Section(sectionTitle: sectionCategories[0], sectionContent: currentSemesterSlug)
        let previousS = Section(sectionTitle: sectionCategories[1], sectionContent: previousSemesterSlug)
        
        //Combining two senester sections into array
        sectionArray.append(currentS)
        sectionArray.append(previousS)

        let token = self.keychain["token"]
        let url = NSURL(string: self.coursesURL)
        let mutableURLRequest = NSMutableURLRequest(URL: url!)
        mutableURLRequest.setValue("JWT \(token!)", forHTTPHeaderField: "Authorization")
        mutableURLRequest.HTTPMethod = "GET"
        
        let manager = Alamofire.Manager.sharedInstance
        let getCourseRequest = manager.request(mutableURLRequest)
        getCourseRequest.responseJSON { (coursesReceived) in
            let jsonData = JSON(coursesReceived.result.value!)
            for (_, subJSON) in jsonData {
                let course = Course(title: subJSON["title"].string!, id: subJSON["id"].int!, slug: subJSON["slug"].string!, course_description: subJSON["course_description"].string!,  semester_slug: subJSON["semester_slug"].string!)
                    course.course_code = subJSON["course_code"].string!
                    course.lecturer = subJSON["lecturer"].string!
                    self.courses.append(course)
            
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
        return sectionCategories.count
    }
    
    //Setting header for different sections
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionCategories[section]
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sectionArray[section].item.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("semesterCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = sectionArray[indexPath.section].item[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Helvetica nenu ", size: 20)
        return cell
        
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
        
        // Get the new view controller using segue.destinationViewController
        // Pass the selected object to the new view controller
        if segue.identifier == "showCourse" {
            let vc = segue.destinationViewController as! CourseTableViewController
            
            //Modifying selected indexPath.row
            for course in courses{
                let indexPath = self.tableView.indexPathForSelectedRow!
                if indexPath.section == 0 {
                    if course.semester_slug == self.semesters[semesters.count - 1].slug{
                        vc.courses.append(course)
                    }
                } else {
                    if course.semester_slug == self.semesters[indexPath.row].slug{
                        vc.courses.append(course)
                    }
                }
            }
        }
    }

}