//
//  Grades.swift
//  CMT
//
//  Created by ew on 2016/4/25.
//  Copyright © 2016年 Hong. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Grade:NSObject{
    var url:String?
    var id:Int
    
    var user:Int
    var grade:Float?
    var range:Float?
    var percentage:Float?
    
    var course: Int?
    var course_title: String?
    var grade_item: String?
    var feedback:String?
    
    
    init(user:Int, grade_item: String, id: Int) {
        self.user = user
        self.grade_item = grade_item
        self.id = id
    }
    
}
