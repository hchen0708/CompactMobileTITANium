//
//  CourseActivities.swift
//  CMT
//
//  Created by ew on 2016/4/21.
//  Copyright © 2016年 Hong. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class CourseActivity:NSObject{
    var url:String?
    var id:Int
    var user:Int
    var user_name:String?
    var course_title: String?
    var title:String?
    var content:String?
    
    init(user:Int, title: String, id:Int){
        self.user = user
        self.title = title
        self.id = id
        }
    }