//
//  UINavButton.swift
//  CMT
//
//  Created by ew on 2016/4/21.
//  Copyright © 2016年 Hong. All rights reserved.
//

import Foundation
import UIKit


public class UINavButton: UIButton{
    init(title:String?) {
        let diameter = CGFloat(50)
        let xOffset = CGFloat(5)
        let yOffset = CGFloat(20)
        let newFrame = CGRectMake(xOffset, yOffset, diameter, diameter/2.0)
        super.init(frame: newFrame)
        
        self.setTitle(title, forState: UIControlState.Normal)
        self.layer.masksToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
