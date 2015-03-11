//
//  User.swift
//  yambox
//
//  Created by Anna Do on 3/10/15.
//  Copyright (c) 2015 Anna Do. All rights reserved.
//

import Foundation

private var _currentUser = User()
let UserLoggedInNotification = "UserLoggedInNotification"
let kUserDataKey = "kUserDataKey"

class User : NSObject {
    
    var name : NSString = ""
    var userData : NSDictionary = [:]
    var loggedIn : Bool = false
    
    class func currentUser() -> User {
        if (!_currentUser.isLoggedIn()) {
            _currentUser.retrieveSavedUser()
        }
        
        return _currentUser
    }
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "loginSuccess:",
            name: YMYammerSDKLoginDidCompleteNotification,
            object: nil)
    }
    
    func initUser(data : NSDictionary) {
        name = data["full_name"] as NSString
        userData = data
        loggedIn = true
    }
    
    
    func isLoggedIn() -> Bool {
        return loggedIn;
    }
  
    func login() {
        YMLoginController.sharedInstance().startLogin();
    }
    
    func loginSuccess(note: NSNotification) {
        let userInfo : [NSObject : AnyObject] = note.userInfo!
        let authToken : NSString = userInfo[YMYammerSDKAuthTokenUserInfoKey] as NSString
        let data : NSDictionary = userInfo[YammerSDKUserUserInfoKey] as NSDictionary
        
        initUser(data)
        saveUser()
        loginNotification()
    }
    
    func saveUser() {
        if let data : NSData = NSJSONSerialization.dataWithJSONObject(userData, options: NSJSONWritingOptions.PrettyPrinted, error: nil) {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(data, forKey: kUserDataKey)
        }
    }
    
    func retrieveSavedUser() {
        if let data : NSData = NSUserDefaults.standardUserDefaults().dataForKey(kUserDataKey) {
            var userData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            _currentUser.initUser(userData)
        }
    }
    
    func clearSavedUser() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(kUserDataKey)
    }
    
    func logout() {
        YMLoginController.sharedInstance().clearAuthToken()
        userData = [:]
        _currentUser = User()
        
        clearSavedUser()
        logoutNotification()
    }
    
    func loginNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName(UserLoggedInNotification, object: nil)
    }
    
    func logoutNotification() {
        loginNotification()
    }
}
