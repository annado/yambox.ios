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

        println("LoginViewController did load")
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didCompleteLogin:",
            name: YMYammerSDKLoginDidCompleteNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didFailLogin:", name: YMYammerSDKLoginDidFailNotification, object: nil)
        updateUI()
    }

    func updateUI() {
        var authToken = YMLoginController.sharedInstance().storedAuthToken()

        println("TOKEN?");
        println(authToken);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignInWithYammer() {
        println("Sign in with Yammer tapped")
        YMLoginController.sharedInstance().startLogin();
    }
    
    
    func didCompleteLogin(note: NSNotification) {
        println("Completed login with authToken")
        let userInfo : [NSObject : AnyObject] = note.userInfo!
        let authToken : NSString = userInfo[YMYammerSDKAuthTokenUserInfoKey] as NSString
        println(authToken)
//        [self handleSuccessWithToken:authToken];
    }
    
    func didFailLogin(note: NSNotification) {
//        var error:NSError = note.userInfo[YMYammerSDKErrorUserInfoKey];
        println("login failed")
        println(note)
    }

}
