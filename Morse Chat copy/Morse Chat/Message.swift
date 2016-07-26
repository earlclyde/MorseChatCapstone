//
//  Message.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Message {
    
    private let textKey = "MessageText"
    private let userPhotoKey = "UserPhoto"
    static let typeKey = "Message"
    
    var senderUID: CKRecordID
    var messageText: String
    var reference: CKReference?
    var time: NSDate?
    var userPhoto: CKAsset?
    
    init(senderUID: CKRecordID, messageText: String) {
        self.senderUID = senderUID
        self.messageText = messageText
        self.reference = nil
        //        self.time = time
        //        self.userPhoto = userPhoto
    }
    
    init(record: CKRecord) {
        self.senderUID = record.creatorUserRecordID!
        self.messageText = record.objectForKey(textKey) as? String ?? ""
        self.reference = CKReference(record: record, action: .DeleteSelf)
        if record.creationDate != nil {
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .ShortStyle
        }
        self.time = record.creationDate as NSDate!
        self.userPhoto = (record.objectForKey(userPhotoKey) as? CKAsset)!
    }
    
    func toAnyObject() -> AnyObject {
        return [textKey:messageText]
    }
    
}
