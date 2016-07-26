//
//  ChatViewController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import Foundation
import CloudKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var memberView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let darkView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
//
//        UserController.sharedController.checkForUser { (success) in
//            if success {
//                print("Current: \(UserController.sharedController.currentUser?.firstName)")
//            } else {
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self.performSegueWithIdentifier("loginSegue", sender: self)
//                })
//            }
//        }
    }
    
    // MARK: Segmented Control
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        tableView.reloadData()
    }
    
    // MARK: TableView
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return 100
            
        } else {
            if indexPath.row == 0 {
                return 55
                
            } else if indexPath.row == 1 {
                return 55
                
            } else {
                //                (120(cell height) * # of friends) + 10
                let contactCellHeight = (self.view.bounds.height * 4)
                return contactCellHeight
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let convoCell = tableView.dequeueReusableCellWithIdentifier("conversationCell", forIndexPath: indexPath) as! ChatMessageCell
            return convoCell
            
        } else {
            if indexPath.row == 0 {
                let addContactCell = tableView.dequeueReusableCellWithIdentifier("addMember", forIndexPath: indexPath)
                return addContactCell
                
                //        Im going to have to set all notifications for current user in an array and use that count
                //               else if indexpath.row == 1...(notificationCount + 1)
                
            } else if indexPath.row == 1 {
                let notificationCell = tableView.dequeueReusableCellWithIdentifier("notificationCell", forIndexPath: indexPath)
                return notificationCell
                
            } else {
                let contactCell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath: indexPath) as! MemberTableViewCell
                return contactCell
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            performSegueWithIdentifier("messageSegue", sender: self)
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: Collection View
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCellWithReuseIdentifier("memberItem", forIndexPath: indexPath)
        return item
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let size = CGSize(width:(self.view.bounds.width / 2) - 10, height:120)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        memberView.center.x = view.center.x
        memberView.center.y = view.center.y - 40
        darkView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        darkView.backgroundColor = UIColor.blackColor()
        darkView.alpha = 0.5
        
        self.view.addSubview(darkView)
        self.view.addSubview(memberView)
        
    }
    
    // MARK: Member View
    
    @IBAction func contactDismissButtonTapped(sender: AnyObject) {
        memberView.removeFromSuperview()
        darkView.removeFromSuperview()
    }
    
    @IBAction func addToGroupButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("addToGroup", sender: self)
    }
    
    @IBAction func sendMessageButtonTapped(sender: AnyObject) {
        let currentUserRef = CKReference(recordID: UserController.sharedController.currentUser!.userID!, action: CKReferenceAction.None)
        let userMessageRef = CKReference(recordID: UserController.sharedController.currentUser!.userID!, action: CKReferenceAction.None)
        let conversation = Conversation.init(convoName: nil, users: [currentUserRef], messages: [userMessageRef])
        ConversationController.createConversation(conversation) { (success) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.memberView.removeFromSuperview()
                    self.darkView.removeFromSuperview()
                    self.performSegueWithIdentifier("messageSegue", sender: self)
                })
                print("Convo: \(conversation.users)")
            } else {
                print("Not this time")
            }
            
        }
    }
    
}

extension UIViewController {
    
    func setNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 82/255, green: 164/255, blue: 230/255, alpha: 1.0)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let iconImage = UIImage.init(named: "White Icon")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = iconImage
        self.navigationItem.titleView = imageView
    }
}

