//
//  CloudKitManagedObject.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/19/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc protocol CloudKitManagedObject {
    
    // Things that are required. Any cloudKit managed object that we want to be saved to coreData needs to have this.
    // RecordName identifies objects in cloudKit and locally.
    // RecordType: the name of the type in cloudKit
    // CloudKit record: Your representation of what the object should look like in cloudKit form.
    
    var timestamp: NSDate { get set }
    var recordIDData: NSData? { get set }
    var recordName: String { get set }
    var recordType: String { get }
    
    var cloudKitRecord: CKRecord? { get } // CoreData version of dictionaryCopy
    
    init?(record: CKRecord, context: NSManagedObjectContext)
    
}
// For working with cloudKit and managed objects. Think core data when you hear managed objects.

extension CloudKitManagedObject {
    
    var isSynced: Bool {
        return recordIDData != nil
    }
    
    var cloudKitRecordID: CKRecordID? {
        guard let recordIDData = recordIDData,
            recordID = NSKeyedUnarchiver.unarchiveObjectWithData(recordIDData) as? CKRecordID else {
                return nil
        }
        return recordID
    }
    
    var cloudKitReference: CKReference? {
        guard let recordID = cloudKitRecordID else {
            return nil
        }
        return CKReference(recordID: recordID, action: .None)
    }
    
    func update(record: CKRecord) {
        self.recordIDData = NSKeyedArchiver.archivedDataWithRootObject(record.recordID)
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Unable to save Managed Object Context in \(#function) \nError: \(error)")
        }
    }
    
    func nameForManagedObject() -> String {
        return NSUUID().UUIDString
    }
    
}

