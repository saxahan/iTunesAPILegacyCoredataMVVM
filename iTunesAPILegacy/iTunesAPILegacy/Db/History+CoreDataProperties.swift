//
//  History+CoreDataProperties.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var isRemoved: Bool
    @NSManaged public var isVisited: Bool
    @NSManaged public var visitedDate: NSDate?
    @NSManaged public var trackId: Int64

}
