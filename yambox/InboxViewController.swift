//
//  InboxViewController.swift
//  yambox
//
//  Created by Anna Do on 3/10/15.
//  Copyright (c) 2015 Anna Do. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    lazy var listViewController : InboxListViewController = InboxListViewController(nibName: "InboxListViewController", bundle: nil)
//    lazy var navController : UINavigationController = {
//        return UINavigationController(rootViewController: self.listViewController)
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // init NavigationBar
//        setupNavigationController()
//        self.addChildViewController(navController)
//        UIView *menuView = menuNavController.view;
//        self.navigationBar.addSubview(menuNavController.view)
        
        // init InboxListViewController
        self.addChildViewController(self.listViewController)
        self.listView = self.listViewController.view;
        var frame :CGRect = self.listView.frame;
        frame.origin.y = 50;
//        frame.size.height = 262;
        self.listView.frame = frame;
//        self.view.addSubview(self.listView)
    }
    
    func setupNavigationController() {
        var logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
//        menuNavController
    }
    
    func logout() {
        User.currentUser().logout()
    }

}
