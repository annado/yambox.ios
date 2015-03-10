//
//  AppViewController.swift
//  yambox
//
//  Created by Anna Do on 3/5/15.
//  Copyright (c) 2015 Anna Do. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didCompleteLogin:",
            name: YMYammerSDKLoginDidCompleteNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didFailLogin:", name: YMYammerSDKLoginDidFailNotification, object: nil)
    }
    
    @IBAction func didTapSignInWithYammer() {
        YMLoginController.sharedInstance().startLogin();
    }
    
    
    func didCompleteLogin(note: NSNotification) {
        println("Completed login with authToken")
        let userInfo : [NSObject : AnyObject] = note.userInfo!
        let authToken : NSString = userInfo[YMYammerSDKAuthTokenUserInfoKey] as NSString
        let userData : NSDictionary = userInfo[YammerSDKUserUserInfoKey] as NSDictionary
        
//        println(userData)
        
        User.currentUser().login(userData)
    }
    
    func didFailLogin(note: NSNotification) {
//        var error:NSError = note.userInfo[YMYammerSDKErrorUserInfoKey];
        println("login failed")
        println(note)
    }

}
