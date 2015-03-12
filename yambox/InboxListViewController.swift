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
        self.tableView.registerClass(MGSwipeTableCell.self, forCellReuseIdentifier: "cell")
        
        addRefreshControl()
        loadMessages()

        
        var logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
        self.navigationItem.rightBarButtonItem = logoutButton

    }
    
    func logout() {
        User.currentUser().logout()
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
        let kCellIdentifier : String = "cell"
        var cell : MGSwipeTableCell = self.tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as MGSwipeTableCell

        cell.textLabel?.text = self.messages[indexPath.row]["content_excerpt"] as NSString

        var swipeExpansionSettings = MGSwipeExpansionSettings()
        swipeExpansionSettings.threshold = 1
        swipeExpansionSettings.fillOnTrigger = true
        swipeExpansionSettings.buttonIndex = 0

        cell.leftButtons = [MGSwipeButton(title: "Mark as Read", backgroundColor: UIColor(red: 0.443, green: 0.737, blue: 0.471, alpha: 1.0), callback: { (tableCell : MGSwipeTableCell!) -> Bool in
            println("Mark as Read!")
            return true
        })]

        cell.leftSwipeSettings.transition = MGSwipeTransition.TransitionBorder
        cell.leftExpansion = swipeExpansionSettings

        cell.rightButtons = [MGSwipeButton(title: "Snooze", backgroundColor: UIColor(red:1.000, green:0.875, blue:0.275, alpha:1.0), callback: { (tableCell : MGSwipeTableCell!) -> Bool in
            println("Snooze!")
            return true
        })]
        cell.rightSwipeSettings.transition = MGSwipeTransition.TransitionBorder
        cell.rightExpansion = swipeExpansionSettings

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
