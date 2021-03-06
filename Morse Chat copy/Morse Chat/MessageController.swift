//
//  MessageController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class MessageController: NSObject {
    // var messages: [CKRecord]()
    
    // create cloudkitManager instance
    let cloudKitManager: CloudKitManager
    
    override init() {
        
        cloudKitManager = CloudKitManager()
    }
    
    static func postMessage(message: Message, completion:(success: Bool) -> Void) {
        let record = CKRecord(recordType: "Message")
        record.setValuesForKeysWithDictionary(message.toAnyObject() as! [String: AnyObject])
        
        let container = CKContainer.defaultContainer()
        container.publicCloudDatabase.saveRecord(record) { (message, error) in
            if error == nil {
                completion(success: true)
            } else {
                print(error?.localizedDescription)
                completion(success: false)
                // handle error
            }
        }
    }
    func fetchNewRecords(type: String, completion: ((records: [CKRecord]?) -> Void)?){
        cloudKitManager.fetchRecordsWithType(type, recordFetchedBlock: { (record) in
        }) { (records, error) in
            if let error = error {
                NSLog("Error fetching new records from CloudKit: \(error)")
            }
            if let completion = completion {
                completion(records: records)
            }
        }
    }
    
    func fetchConversationMessages(completion:(messages: [Message]) -> Void) {
        fetchNewRecords(Message.typeKey) { (records) in
            if let records = records {
                let messages = records.flatMap { Message(record: $0) }
                completion(messages: messages)
            } else {
                completion(messages: [])
            }
        }
    }
    
    
//    func loadMessages() {
//        let pred = NSPredicate(value: true)
//        let sort = NSSortDescriptor(key: "Time", ascending: false)
//        let query = CKQuery(recordType: "Messages", predicate: pred)
//        query.sortDescriptors = [sort]
//        
//        let operation = CKQueryOperation(query: query)
//        operation.desiredKeys = ["messageText"]
//        operation.resultsLimit = 50
//        
//        var newMessages = [Message]()
//        
//        operation.recordFetchedBlock = { (record) in
//            let message = Message()
//            message.recordID = record.recordID
//            message.messageText = record["messageText"] as! String
//            newMessages.append(message)
//            
//        }
    
//    func syncedRecords(type: String) -> [CloudKitManagedObject] {
////        let fetchRequest = NSFetchRequest(entityName: type)
//        let predicate = NSPredicate(format: "recordIDData != nil")
//        let ckSubscription = CKSubscription(recordType: type, predicate: predicate, options: .FiresOnce)
//        
//    }
//    
////    func syncedRecords(type: String) -> [CloudKitManagedObject] {
////        let fetchRequest = NSFetchRequest(entityName: type)
////        fetchRequest.predicate = NSPredicate(format: "recordIDData != nil")
////        
////        let moc = Stack.sharedStack.managedObjectContext
////        let results = (try? moc.executeFetchRequest(fetchRequest)) as? [CloudKitManagedObject] ?? []
////        return results
////    }
//    
//    func unsyncedRecords() {
//        
//    }
}



