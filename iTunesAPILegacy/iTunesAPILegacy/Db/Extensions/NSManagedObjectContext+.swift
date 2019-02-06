//
//  NSManagedObjectContext+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 7.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    func fetchObjects<T: NSManagedObject>(_ entityClass: T.Type, sortBy: [NSSortDescriptor]? = nil, predicate: NSPredicate? = nil) throws -> [T] {
        let request: NSFetchRequest<NSFetchRequestResult>
        if #available(iOS 10.0, *) {
            request = entityClass.fetchRequest()
        } else {
            let entityName = String(describing: entityClass)
            request = NSFetchRequest(entityName: entityName)
        }

        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = sortBy

        let fetchedResult = try self.fetch(request) as! [T]
        return fetchedResult
    }
}

