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
    
    init() {
        
        cloudKitManager = CloudKitManager()
    }
    
    static let sharedController = UserController()
    var defaultContainer: CKContainer?
    
    //TODO: Set your current user once the user has been created. Save into NSUserDefaults
    
    
    var currentUser: User?
    
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
        if let cloudKitRecord = user.recordCopy {
            cloudKitManager.saveRecord(cloudKitRecord) { (record, error) in
                if let error = error {
                    NSLog("Error saving cloudkit record for new content \(user): \(error)")
                    return
                }
            }
        }
    }
    
    //    func addUserToConversation() {
    //
    //
    //    }
    
    
}



