//
//  NSManagedObject+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 7.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import CoreData

extension NSManagedObject {

    // MARK: Generic Methods
    class func entityName() -> String {
        return String(describing: self)
    }

    convenience init(context: NSManagedObjectContext) {
        let eName = type(of: self).entityName()
        let entity = NSEntityDescription.entity(forEntityName: eName, in: context)!
        self.init(entity: entity, insertInto: context)
    }

    class func countAll(for context: NSManagedObjectContext = Persistense.shared.context) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName())
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
