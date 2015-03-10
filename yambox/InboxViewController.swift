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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("InboxViewController")
        println(User.currentUser().userData)
        
        welcomeLabel.text = User.currentUser().name
    }

    

}
