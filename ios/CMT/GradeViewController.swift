////
////  GradeViewController.swift
////  CMT
////
////  Created by ew on 2016/4/25.
////  Copyright © 2016年 Hong. All rights reserved.
////
//
//import UIKit
//
//class GradeViewController: UIViewController {
//
//    var courseGrades = [Grade]()
//    var gradeItemField = UITextView()
//    var gradeField = UITextView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationItem.title = "Grade"
//        self.addGradeTable()
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    func addGradeTable() {
//        
//        
//        for courseGrade in courseGrades {
//            
//        gradeField.text = "\(courseGrade.grade_item!) - \(courseGrade.grade!)/\(courseGrade.range!)(\(courseGrade.percentage!)%)"
//        gradeField.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
//        self.view.addSubview(self.gradeField)
//            
//        }
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
// 
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
