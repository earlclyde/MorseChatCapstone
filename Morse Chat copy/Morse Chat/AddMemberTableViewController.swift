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

class AddMemberTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController: UISearchController?
    
    var users: [User] = []
    
    //MARK: Outlets
    
    @IBOutlet var bigMemberView: UIView!
    let darkView = UIView()
    
    // MARK: Actions 
    
    @IBAction func dismissButtonTapped(sender: AnyObject) {
        bigMemberView.removeFromSuperview()
        darkView.removeFromSuperview()
    }
    
    @IBAction func addMemberButtonTapped(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setNavBar()
        setUpSearchController()
//        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
        // Update users property with results of the get users function in the user controller
        users = UserController.sharedController.getAllUsers()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.firstName + user.lastName
        
        return cell
        
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        bigMemberView.center.x = view.center.x
//        bigMemberView.center.y = view.center.y - 40
//        darkView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
//        darkView.backgroundColor = UIColor.blackColor()
//        darkView.alpha = 0.5
//        
//        self.view.addSubview(darkView)
//        self.view.addSubview(bigMemberView)
//        
//    }
    
    // MARK: SearchResultsController: Don't forget to conform to protocol!
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SearchResultsTableViewController")
       
        searchController = UISearchController(searchResultsController: resultsController)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = true
        definesPresentationContext = true
        tableView.tableHeaderView = searchController!.searchBar
    }
    
    // MARK: UISearchResultsDelegate
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let resultsViewController = searchController.searchResultsController as? SearchResultsTableViewController,
            let searchTerm = searchController.searchBar.text?.lowercaseString {
            print(users[0].firstName, users[1].firstName, users[2].firstName)
            print(searchTerm)
            resultsViewController.resultsArray = users.filter({$0.matchesSearchTerm(searchTerm)})
            resultsViewController.tableView.reloadData()
        }
    }
}
        
//        if let resultsViewController = searchController?.searchResultsController as? SearchResultsTableViewController,
//        let searchTerm = searchController!.searchBar.text?.lowercaseString where
//            resultsViewController.resultsArray = users.filter({$0.matchesSearchTerm(searchTerm)}) {
//        resultsViewController.tableView.reloadData()
//        
//    }



    // MARK: Navigation - Segue
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "" {
//            let newChatViewController = segue.destinationViewController as? AddMemberTableViewController
//            newChatViewController?.delegate = self
//        }
//    }




