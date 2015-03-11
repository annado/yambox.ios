//
//  AppViewController.swift
//  yambox
//
//  Created by Anna Do on 3/5/15.
//  Copyright (c) 2015 Anna Do. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didFailLogin:", name: YMYammerSDKLoginDidFailNotification, object: nil)
    }
    
    @IBAction func didTapSignInWithYammer() {
        User.currentUser().login()
    }
    
    
    func didFailLogin(note: NSNotification) {
//        var error:NSError = note.userInfo[YMYammerSDKErrorUserInfoKey];
        println(note)
        self.statusLabel.text = "Sign in failed."
    }

}
