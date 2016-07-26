//
//  ConversationController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//
import CloudKit


class ConversationController: NSObject {
    
    static func createConversation(conversation:Conversation, completion:(success: Bool) -> Void) {
    let record = CKRecord(recordType: "Conversation")
        record.setValuesForKeysWithDictionary(conversation.toAnyObject() as! [String: AnyObject])
        
        let container = CKContainer.defaultContainer()
        container.publicCloudDatabase.saveRecord(record) { (conversation, error) in
            if error == nil {
                completion(success: true)
            } else {
                print("Error: \(error?.localizedDescription)")
                completion(success: false)
            }
        }
    }
}
