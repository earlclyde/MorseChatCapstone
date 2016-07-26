//
//  ProfileTableViewController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import Foundation
import CloudKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var displayName: UITextField!

    override func viewDidLoad() {
        if let firstName = UserController.sharedController.currentUser?.firstName,
            lastName = UserController.sharedController.currentUser?.lastName {
            self.displayName.text = (firstName + " " + lastName)
        }
        self.setNavBar()
    }
    

}
