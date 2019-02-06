//
//  Settings.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation
import CoreData

class Settings: NSManagedObject, Codable {

    // MARK: - Core Data Managed Object

    @NSManaged var id: NSNumber?

    enum CodingKeys: String, CodingKey {
        case id
    }

    // MARK: - Decodable

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: CoreDataStack.Entities.settings, in: CoreDataStack.managedObjectContext) else {
                fatalError("Failed to decode Media")
        }
        
        self.init(entity: entity, insertInto: CoreDataStack.managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)

    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
}
