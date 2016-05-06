
//
//  Semesters.swift
//  CMT
//
//  Created by ew on 2016/4/14.
//  Copyright © 2016年 Hong. All rights reserved.
//

import Foundation
import SwiftyJSON

class Semester:NSObject{
    var id: Int
    var section: String?
    var year: Int
    var slug: String?
    var active: Bool
    
    
    init(id:Int, section: String, year:Int, active:Bool){
        self.id = id
        self.section = section
        self.year = year
        self.active = active
    }
    
}
