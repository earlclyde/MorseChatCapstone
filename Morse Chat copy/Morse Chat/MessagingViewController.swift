//
//  MessagingViewController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import CloudKit
import Foundation

class MessagingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var keyboardView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.whiteColor()
        self.setNavBar()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let toMessageCell = tableView.dequeueReusableCellWithIdentifier("toMessageCell", forIndexPath: indexPath) as! ToMessageTableViewCell
            return toMessageCell
        } else {
            let fromMessageCell = tableView.dequeueReusableCellWithIdentifier("fromMessageCell", forIndexPath: indexPath) as! FromMessageTableViewCell
            return fromMessageCell
        }
    }
    
    override var inputAccessoryView: UIView {
        return keyboardView
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    @IBAction func sendMessageTapped(sender: AnyObject) {
        
        if let messageText = messageTextView.text where messageTextView.text != nil || messageTextView.text != "" {
            //TODO: Get the user from NSUserDefaults to create the initial user in the messsage
            //Query cloudkit for all other users to determine who else to add to the conversation Hint: (Fetch records on the UserController)
            
            let message = Message(senderUID: (UserController.sharedController.currentUser?.userID)!, messageText: messageText)
            MessageController.postMessage(message) { (success) in
                if success {
                    print("Worked!")
                    print(message.senderUID)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.messageTextView.text = ""
                    })
                } else {
                    print("Not this time buddy!")
                }
            }
        }
    }
}
 // Need to add functions to check if the user is logged in fetchUserID...
 // Just getting user info from iCloud. 
 // Figure out how to get User Data from iCloud and assign the user to the login.  




