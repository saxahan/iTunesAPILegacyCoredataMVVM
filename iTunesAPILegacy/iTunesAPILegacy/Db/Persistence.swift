//
//  Persistence.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 9.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation
import CoreData

struct Persistense {

    static var shared = Persistense()

    private let databaseName: String = "iTunesAPILegacy"

    @available(iOS 10.0, *)
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.databaseName)
        container.loadPersistentStores { (storeDescription, error) in
            debugPrint("CoreData: Initialized \(storeDescription)")

            guard error == nil else {
                debugPrint("CoreData: Unresolved error \(String(describing: error))")
                return
            }
        }
        return container
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        do {
            return try NSPersistentStoreCoordinator.coordinator(name: self.databaseName)
        } catch {
            debugPrint("CoreData: Unresolved error \(error)")
        }
        return nil
    }()

    private lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.retainsRegisteredObjects = true
        return managedObjectContext
    }()

    // MARK: Public methods

    enum SaveStatus {
        case saved, rolledBack, hasNoChanges
    }

    var context: NSManagedObjectContext {
        mutating get {
            if #available(iOS 10.0, *) {
                return persistentContainer.viewContext
            } else {
                return managedObjectContext
            }
        }
    }

    mutating func save() -> SaveStatus {
        if context.hasChanges {
            do {
                try context.save()
                return .saved
            } catch {
                context.rollback()
                return .rolledBack
            }
        }
        return .hasNoChanges
    }
}
