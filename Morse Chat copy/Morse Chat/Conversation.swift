//
//  Conversation.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Conversation {
    
    private let groupNameKey = "GroupName"
    private let usersKey = "Users"
    private let messagesKey = "Messages"
    
    let reference: CKReference?
    var users: [CKReference]
    var convoName: String?
    var messages: [CKReference]?
    
     init(convoName: String?, users: [CKReference], messages: [CKReference]?) {
        self.convoName = convoName
        self.users = users
        self.reference = nil
    }
    
    init(record: CKRecord) {
        self.convoName = record.objectForKey(groupNameKey) as? String ?? ""
        self.users = record.objectForKey(usersKey) as! [CKReference]
        self.messages = record.objectForKey(messagesKey) as? [CKReference] ?? []
        self.reference = CKReference(record: record, action: .DeleteSelf)
    }

    
        func toAnyObject() -> AnyObject {
            
            if let groupName = convoName {
                return [groupNameKey:groupName,
                        usersKey:users]
            } else {
                return [usersKey:users]
            }
            
//                    if let groupName = convoName {
//                        if let messages = messages {
//                            return [groupNameKey:groupName,
//                                    usersKey:users,
//                                    messagesKey:messages]
//                        } else {
//                            return [groupNameKey: groupName,
//                                    usersKey: users,
//                                    messagesKey: []]
//                                }
//                        } else {
//                        if let messages = messages {
//                            return [groupNameKey:"",
//                                    usersKey:users,
//                                    messagesKey:messages]
//                        } else {
//                            return [groupNameKey: "",
//                                    usersKey:users,
//                                    messagesKey: []]
//                        }
//            
//                    }
            
        
    }
}





