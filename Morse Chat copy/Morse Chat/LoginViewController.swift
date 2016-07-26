//
//  LoginViewController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import Foundation
import CloudKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var morseImageView: UIImageView!
    
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var allowAccessLabel: UILabel!
    @IBOutlet weak var allowCloudAccessButton: UIButton!
   
    override func viewDidLoad() {
       super.viewDidLoad()
        
        usernameButton.setImage(UIImage(named: "usernameButton.png"), forState: .Normal)
    }
}


