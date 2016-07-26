//
//  UserController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class UserController {
    
    let cloudKitManager: CloudKitManager
    
    private let userKey = "storedUsers"
    
    var user: User?
    
    init() {
        
        cloudKitManager = CloudKitManager()
    }
    
    static let sharedController = UserController()
    var defaultContainer: CKContainer?
    
    var currentUser: User? {
        guard let userRecord = NSUserDefaults.standardUserDefaults().objectForKey(userKey) as? CKRecord else { return nil }
        return User(record: userRecord)
    }
    
    
    func fetchNewRecords(type: String, completion: (() -> Void)?) {
        //        let predicate: NSPredicate
        
        cloudKitManager.fetchRecordsWithType(type, recordFetchedBlock: { (record) in
            switch type {
            case "User":
                let _ = User(record: record)
            default:
                return
            }
        }) { (records, error) in
            if let error = error {
                NSLog("Error fetching new records from CloudKit: \(error)")
            }
            completion?()
        }
    }
    
    func pushChangesToCloudKit(records: [CKRecord], completion: ((success: Bool, error: NSError?) -> Void)? = nil) {
        cloudKitManager.saveRecords(records, perRecordCompletion: nil) { (records, error) in
            if let completion = completion {
                if error == nil {
                    completion(success: true, error: error)
                }
            }
        }
    }
    
    func createUser(user: User) {
         NSUserDefaults.standardUserDefaults().setObject(user.recordCopy, forKey: userKey)
        if let cloudKitRecord = user.recordCopy {
            cloudKitManager.saveRecord(cloudKitRecord) { (record, error) in
                if let error = error {
                    NSLog("Error saving cloudkit record for new content \(user): \(error)")
                    return
                }
            }
        }
    }
    
    func getAllUsers() -> [User] {
        
        let user1 = User(userName: "JustinSmith", firstName: "Justin", lastName: "Smith")
        let user2 = User(userName: "MasonEarl", firstName: "Mason", lastName: "Earl")
        let user3 = User(userName: "TylerRobinson", firstName: "Tyler", lastName: "Robinson")

        return [user1, user2, user3]
    }
    
    // Function that gets all users  
    //  - Pull user records from cloudkit 
    //  - In here, use moc data to see if its working properly 
    // SearchController
    
    //    func addUserToConversation() {
    //
    //
    //    }
    
    
}



