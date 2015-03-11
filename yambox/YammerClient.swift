//
//  YammerClient.swift
//  yambox
//
//  Created by Anna Do on 3/10/15.
//  Copyright (c) 2015 Anna Do. All rights reserved.
//

import Foundation

class YammerClient {
    
    var httpClient : YMHTTPClient
    
    init() {
        let url = NSURL(string: YAMMER_API_BASE_URL)
        if (User.currentUser().isLoggedIn()) {
            let token : NSString = YMLoginController.sharedInstance().storedAuthToken()
            httpClient = YMHTTPClient(baseURL: url, authToken: token)
        } else {
            httpClient = YMHTTPClient(baseURL: url)
        }
    }
    
    func getInboxMessages(success: (AnyObject!) -> Void, failure: (NSError!) -> Void) {
        var params : NSDictionary = ["limit": 30];
        httpClient.getPath("/api/v1/messages/inbox.json", parameters: params, success: success, failure: failure)
    }
}