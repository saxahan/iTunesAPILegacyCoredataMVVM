//
//  NSPersistentStoreCoordinator+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 9.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import CoreData

extension NSPersistentStoreCoordinator {

    public enum CoordinatorError: Error {
        case modelFileNotFound
        case modelCreationError
        case storePathNotFound
    }

    static func coordinator(name: String) throws -> NSPersistentStoreCoordinator? {
        guard let modelURL = Bundle.main.url(forResource: name, withExtension: "momd") else {
            throw CoordinatorError.modelFileNotFound
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoordinatorError.modelCreationError
        }

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            throw CoordinatorError.storePathNotFound
        }

        debugPrint("CoreData: Database path \(documents)")
        
        do {
            let url = documents.appendingPathComponent("\(name).sqlite")
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true,
                            NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            throw error
        }

        return coordinator
    }
}
