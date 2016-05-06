//
//  Courses.swift
//  CMT
//
//  Created by ew on 2016/4/21.
//  Copyright © 2016年 Hong. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Course:NSObject{
    var title: String? = "default title"
    var id: Int
    var slug: String?
    var course_description: String?
    var course_code: String?
    
    var semester_slug: String?
    var lecturer: String?
    
    
    init(title: String, id:Int, slug: String, course_description: String, semester_slug:String){
        self.title = title
        self.id = id
        self.slug = slug
        self.course_description = course_description
        self.semester_slug = semester_slug
    }
    
}
