//
//  CourseActivityViewController.swift
//  CMT
//
//  Created by ew on 2016/4/26.
//  Copyright © 2016年 Hong. All rights reserved.
//

import UIKit

class CourseActivityViewController: UIViewController {
    var courseActivities = [CourseActivity]()
    var contentView = UITextView()
    var activityTitle = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addActivityContentView()
        
        // Do any additional setup after loading the view.
    }
    func addActivityContentView() {
        let offset = CGFloat(20)
        let title = self.courseActivities[0].title
        
        //Modifying font style and size
        let fontSize_px = 20
        let fontFamily = "HelveticaNeue-Light"
        let content = self.courseActivities[0].content
        let mod = "<div style=\"font-size:\(fontSize_px); font-family:\(fontFamily)\">\(content!)</div>"
        self.courseActivities[0].content = mod
        let mod_content = self.courseActivities[0].content
        
        //Modifying course content to HTML tag readable
        let attributedData = (mod_content?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)!
        let attributedOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        let attributedContent = try! NSAttributedString(data: attributedData, options: attributedOptions, documentAttributes: nil)

        self.activityTitle.frame = CGRectMake(offset, 0, self.view.frame.width - 2 * offset, self.view.frame.height-20)
        self.activityTitle.text = title
        self.activityTitle.textAlignment = .Center
        self.activityTitle.font = UIFont(name: "Helvetica", size: 25)
        self.activityTitle.userInteractionEnabled = false
        
        self.contentView.frame = CGRectMake(offset, 100, self.view.frame.width - 2 * offset, self.view.frame.height-20)
        self.contentView.attributedText = attributedContent
        self.contentView.userInteractionEnabled = false
        
        self.view.addSubview(activityTitle)
        self.view.addSubview(contentView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
