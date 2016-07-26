//
//  Stack.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/19/16.
//  Copyright © 2016 trianglez. All rights reserved.
//
import Foundation

import CoreData

class Stack {
    
    static let sharedStack = Stack()
    
    // TEACHING NOTE: - lazy variables do not get initialized until the first time they are called
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext()
    
    static func setUpMainContext() -> NSManagedObjectContext {
        // TEACHING NOTE: - merging all models from bundle (if there are more than one)
        let bundle = NSBundle.mainBundle()
        guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle])
            else { fatalError("model not found") }
        // TEACHING NOTE: - initializing persistent store coordinator using merged model
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil,
                                                                   URL: storeURL(), options: nil)
        // TEACHING NOTE: - initializing managed object context and assigning its persistent store coordinator
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }
    
    static func storeURL () -> NSURL? {
        // TEACHING NOTE: - creating url for persistent store
        let documentsDirectory: NSURL? = try? NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true)
        
        return documentsDirectory?.URLByAppendingPathComponent("db.sqlite")
    }
}