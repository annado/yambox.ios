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
        // filter=unarchived%3Binbox_unseen&threaded=extended&exclude_own_messages_from_unseen=true
        // older_than=10594043&last_seen_message_id=35190767
        
        let path : String = "/api/v1/messages/inbox.json"
        var params : NSDictionary = ["limit": 10,
            "filter":"unarchived;inbox_unseen",
            "threaded":"extended",
            "exclude_own_messages_from_unseen":"true"
        ];
        
        httpClient.getPath(path, parameters: params, success: {(responseObject: AnyObject!) -> Void in
            var messages : NSMutableArray = responseObject["messages"] as NSMutableArray
//            messages.sortUsingComparator({ (a : AnyObject!, b : AnyObject!) -> NSComparisonResult in
//                
//            })
//            responseObject["messages"] = messages
            success(responseObject)
        }, failure: failure)
    }
    
    func markAsRead(threadId : NSString, messageId: NSString, success: (AnyObject!) -> Void, failure: (NSError!) -> Void) {
        let path : String = "api/v1/messages/last_seen_in_thread.json"
        
        var params : NSDictionary = ["thread_id" : threadId,
            "message_id" : messageId]
        
        httpClient.getPath(path, parameters: params, success: success, failure: failure)
        
    }
    
}