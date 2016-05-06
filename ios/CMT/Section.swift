//
//  Section.swift
//  CMT
//
//  Created by ew on 2016/4/23.
//  Copyright © 2016年 Hong. All rights reserved.
//

import Foundation


//Differentiating current semester and previous semesters with sections in SemesterTableView
struct Section {
    var header: String
    var item: [String]
    
    init(sectionTitle: String, sectionContent: [String]){
        header = sectionTitle
        item = sectionContent
    }
    
    
}