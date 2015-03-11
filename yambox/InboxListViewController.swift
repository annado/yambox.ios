//
//  InboxListViewController.swift
//  yambox
//
//  Created by Anna Do on 3/11/15.
//  Copyright (c) 2015 Anna Do. All rights reserved.
//

import UIKit

class InboxListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var yammerClient : YammerClient = YammerClient()
    lazy var refreshControl : UIRefreshControl = UIRefreshControl()
    lazy var messages : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inbox"
        
        // setup tableView
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addRefreshControl()
        loadMessages()

        
        var logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
        self.navigationItem.rightBarButtonItem = logoutButton

    }

    // MARK: UIRefreshControl
    func addRefreshControl() {
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh() {
        loadMessages()
    }
    
    // MARK: Inbox Request
    func loadMessages() {
        refreshControl.beginRefreshing()
        
        yammerClient.getInboxMessages({
            (responseObject :AnyObject!) -> Void in
                self.messages = responseObject["messages"] as NSMutableArray
//              println("Messages: \(self.messages)")
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }, failure: { (error: NSError!) -> Void in
                println("Failed: \(error)")
                self.refreshControl.endRefreshing()
        })
    }
    
    func handleMessages(responseObject : AnyObject!) {
        
    }
    
    // MARK: UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.messages[indexPath.row]["content_excerpt"] as NSString
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func logout() {
        User.currentUser().logout()
    }

}
