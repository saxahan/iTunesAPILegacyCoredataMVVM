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
    @NSManaged public var isRemoved: Bool
    @NSManaged public var isVisited: Bool
    @NSManaged public var visitedDate: NSDate?
    @NSManaged public var trackId: Int64

    convenience init(trackId: Int, isRemoved: Bool, isVisited: Bool) {
        self.init(context: CoreDataStack.managedObjectContext)
        self.trackId = Int64(trackId)
        self.isRemoved = isRemoved
        self.isVisited = isVisited

        if isVisited {
            self.visitedDate = Date() as NSDate
        }
    }
}
