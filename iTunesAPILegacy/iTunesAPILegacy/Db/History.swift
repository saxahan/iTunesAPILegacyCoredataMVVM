//
//  History+CoreDataClass.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(History)
public class History: NSManagedObject {
    @NSManaged public var removed: Bool
    @NSManaged public var visited: Bool
    @NSManaged public var visitedDate: NSDate?
    @NSManaged public var removedDate: NSDate?
    @NSManaged public var trackId: Int64

    convenience init(trackId: Int, isRemoved: Bool, isVisited: Bool) {
        self.init(context: CoreDataStack.managedObjectContext)
        self.trackId = Int64(trackId)
        self.removed = isRemoved
        self.visited = isVisited

        if isVisited {
            self.visitedDate = Date() as NSDate
        }

        if isRemoved {
            self.removedDate = Date() as NSDate
        }
    }
}
