//
//  ViewController.swift
//  CMT
//
//  Created by ew on 2016/4/6.
//  Copyright © 2016年 Hong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.someFunc("Justin", age: nil, completionHandler: isComplete)
        self.newFunc(newCompletionH)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func someFunc(name:String, age:Int?, completionHandler:(isDone:Bool) -> Void) -> String {
        print("hello there \(name)")
        
        
        completionHandler(isDone: true)
        return "hello there \(name)"
        
        
    }
    
    func isComplete(done:Bool) -> Void {
        print(done)
    }

    func newFunc(completionHandler:() -> Void) {
        completionHandler()
    }
    
    func newCompletionH() -> Void {
        print("new one has ran")
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
