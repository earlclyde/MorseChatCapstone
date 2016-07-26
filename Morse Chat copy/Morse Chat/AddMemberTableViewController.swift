//
//  AddMemberTableViewController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import CloudKit
import Foundation

class AddMemberTableViewController: UITableViewController {
    
    @IBOutlet var bigMemberView: UIView!
    let darkView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let searchResultsCell = tableView.dequeueReusableCellWithIdentifier("searchResultsCell", forIndexPath: indexPath)
       
        return searchResultsCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 52
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        bigMemberView.center.x = view.center.x
        bigMemberView.center.y = view.center.y - 40
        darkView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        darkView.backgroundColor = UIColor.blackColor()
        darkView.alpha = 0.5
        
        self.view.addSubview(darkView)
        self.view.addSubview(bigMemberView)
        
    }
    
    @IBAction func dismissButtonTapped(sender: AnyObject) {
        bigMemberView.removeFromSuperview()
        darkView.removeFromSuperview()
    }
    
    @IBAction func addContactButtonTapped(sender: AnyObject) {
    }
    
}
