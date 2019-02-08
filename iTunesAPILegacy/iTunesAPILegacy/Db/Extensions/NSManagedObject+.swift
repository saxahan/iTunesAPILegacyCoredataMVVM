//
//  NSManagedObject+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 7.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import CoreData

extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let eName = type(of: self).entityName()
        let entity = NSEntityDescription.entity(forEntityName: eName, in: context)!
        self.init(entity: entity, insertInto: context)
    }

    // MARK: Generic Methods
    class func entityName() -> String {
        return String(describing: self)
    }

    class func countAll(for context: NSManagedObjectContext = CoreDataStack.managedObjectContext) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: self))
        do {
            return try context.count(for: request)
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }

    func save() throws {
        do {
            try self.managedObjectContext?.save()
        } catch {
            debugPrint(error)
        }
    }

}
