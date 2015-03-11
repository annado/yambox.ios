//
//  InboxViewController.swift
//  yambox
//
//  Created by Anna Do on 3/10/15.
//  Copyright (c) 2015 Anna Do. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBAction func logOut(sender: UIButton) {
        User.currentUser().logout()
    }
    
    lazy var yammerClient : YammerClient = YammerClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("InboxViewController")
//        println(User.currentUser().userData)
        
        welcomeLabel.text = User.currentUser().name
        
        yammerClient.getInboxMessages({ (messages :AnyObject!) -> Void in
            println("Messages: \(messages)")
            }, failure: { (error: NSError!) -> Void in
            println("Failed: \(error)")
        })
    }

    func handleMessages(AnyObject!) {
        
    }

}
