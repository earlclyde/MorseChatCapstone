//
//  User.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    private let friendsKey = "Friends"
    static let typeKey = "User"
    static let userNameKey = "UserName"
    static let userIDKey = "UserID"
    static let firstNameKey = "FirstName"
    static let lastNameKey = "LastName"
    static let friendsKey = "Friends"
    static let userPicKey = "UserPic"
    
    var userName: String
    var userID: CKRecordID?
    var firstName: String
    var lastName: String
    var friends: [CKReference]?
    var userPic: CKAsset?
//    var email: String?
    
    let cloudKitIdentifier: String
    
    init(userName: String, firstName: String, lastName: String) {
        
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.cloudKitIdentifier = NSUUID().UUIDString
        self.friends = nil
        self.userPic = nil
        self.userID = nil
//        self.email = nil
    }
    
    var recordCopy: CKRecord? {
        let recordID = CKRecordID(recordName: cloudKitIdentifier)
        let record = CKRecord(recordType: User.typeKey, recordID: recordID)
        
        record[User.firstNameKey] = self.firstName
        record[User.lastNameKey] = self.lastName
        record[User.userPicKey] = self.userPic
        record[User.userNameKey] = self.userName
        
        //TODO: May need to change the record here.
        record[User.friendsKey] = CKReference(record: record, action: .DeleteSelf)

        
        return record
    }
    
    init?(record:CKRecord) {
        
        guard let username = record[User.userNameKey] as? String,
            let firstName = record[User.firstNameKey] as? String,
            let lastName = record[User.lastNameKey] as? String,
//          let userPic = record[User.userPicKey] as? String,
            let friendReference = record[User.friendsKey] as? CKReference else { fatalError() }
        
        self.userName = username
        self.firstName = firstName
        self.lastName = lastName
//        self.userPic = userPic
        self.userPic = nil
        self.friends = [friendReference]
        self.cloudKitIdentifier = record.recordID.recordName
        
        self.userID = record.recordID
//        self.friends = record.objectForKey(friendsKey) as? [CKReference] ?? []

    }
}
// Find user info from icloud, then use that info to create a user model and save it to core data