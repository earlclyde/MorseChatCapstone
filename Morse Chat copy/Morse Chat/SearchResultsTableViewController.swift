//
//  SearchResultsTableViewController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/26/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class SearchResultsTableViewController: UITableViewController {
    
   
    
            // Add a results array property that contains a list of SearchableRecords
    var resultsArray: [SearchableRecord] = []
            // Implement the UITableViewDatasource functions to display the search results.
    
    
    override func viewDidLoad() {
                  super.viewDidLoad()
        
            //self.clearsSelectionOnViewWillAppear = false
    }
    
            // MARK: TableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                  return resultsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultsCell", forIndexPath: indexPath)
        guard let result = resultsArray[indexPath.row] as? User else { return UITableViewCell()}
        cell.textLabel?.text = result.firstName
        return cell
    }
    
}
