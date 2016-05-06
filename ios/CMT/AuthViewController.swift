//
//  ViewController.swift
//  CMT
//
//  Created by ew on 2016/4/5.
//  Copyright © 2016年 Hong. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess
import SwiftyJSON

class AuthViewController: UIViewController, UITextFieldDelegate{
    let keychain = Keychain(service: "com.Hong-test.CMT")
    let authTokenUrl = "http://118.163.1.108/api-token-auth/"
    let coursesURL = "http://118.163.1.108/api/courses/?format=json"
    let semestersURL = "http://118.163.1.108/api/semesters/?format=json"
    
    var courses = [Course]()
    var semesters = [Semester]()
    
    let messageText = UITextView()
    var usernameField = UITextField()
    var passwordField = UITextField()
    let loginBtn = UIButton(type: UIButtonType.System)
    
    let prefs = NSUserDefaults.standardUserDefaults()
    let rememberAccountTxt = UITextView()
    let rememberAccount = UISwitch()
    let initUN: String = ""
    let initPW: String = ""
    let initSwitch: String = ""
    
    let bkColor = UIColor.init(red: CGFloat(15) / 255.0, green: CGFloat(60) / 255.0, blue: CGFloat(115) / 255.0, alpha: CGFloat(1))
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = bkColor
        
        //Check NSUserDefault is empty or not
        if prefs.stringForKey("RMAccount") != nil{
            //Check for default user configuration
            if prefs.stringForKey("RMAccount")! == "1"{
                rememberAccount.setOn(true, animated: true)
                if let initUN = prefs.stringForKey("username"){
                    self.usernameField.text! = initUN
                }
                if let initPW = prefs.stringForKey("password"){
                    self.passwordField.text! = initPW
                }
            } else {
                rememberAccount.setOn(false, animated: false)
            }
        } else {
            //If first time log in, set initial User Configuration
            prefs.setValue(rememberAccount.on, forKey: "RMAccount")
            rememberAccount.setOn(false, animated: false)
        }
        
        //Tap background to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AuthViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.addLoginForm()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Disable screen rotation
    override func shouldAutorotate() -> Bool {
        return false
    }
    //Disable screen rotation
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func addLoginForm() {
        let offset = CGFloat(20)
        let width = self.view.frame.width - (2 * offset)
        let height = CGFloat(50)
        
        self.messageText.frame = CGRectMake(offset, 50 + 100, width, height+15)
        self.messageText.text = "Compact Mobile TITANium @ CSUF"
        self.messageText.textAlignment = .Center
        self.messageText.textColor = .whiteColor()
        self.messageText.font = UIFont(name: "Helvetica-Bold", size: 25)
        self.messageText.backgroundColor = bkColor

        self.messageText.userInteractionEnabled = false
        
        self.usernameField.frame = CGRectMake(offset, 150 + 100, width, height)
        self.usernameField.textColor = .whiteColor()
        self.usernameField.textAlignment = .Center
        self.usernameField.attributedPlaceholder = NSAttributedString(string: "Enter your User ID", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        self.usernameField.layer.cornerRadius = 10
        self.usernameField.layer.borderWidth = 2
        self.usernameField.layer.borderColor = UIColor.grayColor().CGColor
        self.usernameField.delegate = self
        self.usernameField.returnKeyType = .Next
        
        //Determine if auto fill-in user account info is active
        if self.usernameField.text?.characters.count == 0 {
            self.usernameField.becomeFirstResponder()
        }
        self.usernameField.autocorrectionType = .No
        
        self.passwordField.frame = CGRectMake(offset, 210 + 100, width, height)
        self.passwordField.textColor = .whiteColor()
        self.passwordField.textAlignment = .Center
        self.passwordField.attributedPlaceholder = NSAttributedString(string: "Enter your Password", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        self.passwordField.secureTextEntry = true
        self.passwordField.delegate = self
        self.passwordField.layer.cornerRadius = 10
        self.passwordField.layer.borderWidth = 2
        self.passwordField.layer.borderColor = UIColor.grayColor().CGColor
        
        self.rememberAccount.frame = CGRectMake(300, 270 + 100, width, height)
        self.rememberAccountTxt.frame = CGRectMake(200, 270 + 100, width, height)
        self.rememberAccountTxt.text = "Remember me"
        self.rememberAccountTxt.textColor = .whiteColor()
        self.rememberAccountTxt.backgroundColor = bkColor
        
        self.loginBtn.frame = CGRectMake(self.view.frame.width/2.0 - width/6.0, 310 + 100, width / 3.0, height)
        self.loginBtn.setTitle("Log In", forState: .Normal)
        self.loginBtn.addTarget(self, action: #selector(AuthViewController.doLogin(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginBtn.layer.borderColor = UIColor.grayColor().CGColor
        self.loginBtn.layer.borderWidth = 2
        self.loginBtn.layer.cornerRadius = 10

        
        self.view.addSubview(self.messageText)
        self.view.addSubview(self.usernameField)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.rememberAccountTxt)
        self.view.addSubview(self.rememberAccount)
        self.view.addSubview(self.loginBtn)
    }
    
    //Extensions on counting characters//
    //Configuring software keyboard as input field//
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.usernameField) {
            self.passwordField.becomeFirstResponder()
        } else if (textField == self.passwordField){
            self.doLogin(self.loginBtn)
        }
        return false
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    //Validate user account to login
    func validateLoginForm() -> Bool {
        let unCount = self.usernameField.text!.characters.count
        let pwCount = self.passwordField.text!.characters.count
        
            //Perform only if account is not auto-filled
            if  prefs.stringForKey("RMAccount")! == "0" {
                if (unCount > 0) && (pwCount > 0) {
                    prefs.setValue(self.rememberAccount.on, forKey: "RMAccount")
                    return true
                }  else if unCount == 0 && pwCount == 0{
                    self.messageText.text = "Username and password are required."
                    self.messageText.textColor = .redColor()
                    self.usernameField.becomeFirstResponder()
                    return false
                } else if unCount == 0{
                    self.messageText.text = "Username is required."
                    self.messageText.textColor = .redColor()
                    self.usernameField.becomeFirstResponder()
                    return false
                } else if pwCount == 0{
                    self.messageText.text = "Password is required."
                    self.messageText.textColor = .redColor()
                    self.passwordField.becomeFirstResponder()
                    return false
                } else {
                    return false
                }
            } else {
                //Auto fill-in user account info
                self.usernameField.text! = prefs.stringForKey("username")!
                self.passwordField.text! = prefs.stringForKey("password")!
                //Able reset remember account preference
                prefs.setValue(self.rememberAccount.on, forKey: "RMAccount")
                return true
            }
    }
    
    func doLogin(sender: AnyObject) {
        self.messageText.text = "Loading..."
        if self.validateLoginForm() {
            self.doAuth(self.usernameField.text!, password: self.passwordField.text!)
            
            //Save current user account info and preference to NSUserDefault
            prefs.setValue(self.usernameField.text!, forKey: "username")
            prefs.setValue(self.passwordField.text!, forKey: "password")
            prefs.setValue(rememberAccount.on, forKey: "RMAccout")
        }
    }
    
    func doAuth(username: String, password: AnyObject) {
        let params = ["username": username, "password": password]
        
        //Requesting for token through sending user info
        let authToken = Alamofire.request(.POST, self.authTokenUrl, parameters: params)
        authToken.responseJSON { (response) in
            let data = response.result.value!
            let errormsg = response.result.error
            if errormsg != nil {
                print(errormsg!)
            }
            let statusCode = response.response!.statusCode
            switch statusCode{
            case 200...299:
                self.messageText.text = "Auth success!"
                let jsonData = JSON(data)
                let token = jsonData["token"].string!
                let user = jsonData["user"].string!
                let active = jsonData["active"].bool!
                
                if active {
                    self.keychain["token"] = token
                    self.keychain["user"] = user
                } else {
                    self.keychain["token"] = nil
                }
                self.getSemester()
            case 400...499:
                print("Server responded no")
            case 500...599:
                print("Server Error")
            default:
                print("There was an error with your request")
            }
            
        }
    }

    func getSemester() {
        self.messageText.text = "Getting..."
        let token = self.keychain["token"]
        
        //Getting only semester info by using authenticated token
        if token != nil {
            let url = NSURL(string: self.semestersURL)
            let mutableURLRequest = NSMutableURLRequest(URL: url!)
            mutableURLRequest.setValue("JWT \(token!)", forHTTPHeaderField: "Authorization")
            mutableURLRequest.HTTPMethod = "GET"
            let manager = Alamofire.Manager.sharedInstance
            let getSemesterRequest = manager.request(mutableURLRequest)
            getSemesterRequest.responseJSON { (semesterReceived) in
                let sCode = semesterReceived.response!.statusCode
                //                print(sCode)
                switch sCode {
                case 200...299:
                    let jsonData = JSON(semesterReceived.result.value!)
                    for (_, subJSON) in jsonData {
                        let semester = Semester(id: subJSON["id"].int!, section: subJSON["section"].string!, year: subJSON["year"].int!, active: subJSON["active"].bool!)
                        self.semesters.append(semester)
                        semester.slug = subJSON["slug"].string!
                    }
                case 400...499:
                    self.messageText.text = "Error..."
                case 500...599:
                    self.messageText.text = "Server error..."
                default:
                    print("No Semester Available")
                }
                self.messageText.text = "Loaded!"
                self.performSegueWithIdentifier("showCurrentSemester", sender: self)
            }
            
        } else {
            print("No token")
        }
    }

    //Passing semester data to next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCurrentSemester" {
            for semester in semesters{
                if semester.active == true{
                    let nvc = segue.destinationViewController as! MainNavigationController
                    
                    //Passing data on top of Navigation controller to the destination view controller
                    let vc = nvc.topViewController as! SemestersTableViewController
                    vc.semesters = []
                    vc.semesters.append(semester)
                    vc.semesters = self.semesters
                }
            }
        }
    }
    
}

