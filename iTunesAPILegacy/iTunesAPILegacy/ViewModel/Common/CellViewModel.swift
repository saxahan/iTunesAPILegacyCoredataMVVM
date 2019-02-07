//
//  CellViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class CellViewModel {
    var row: Int
    var section: Int
    var isVisited: Bool
    var isDeleted: Bool

    init(isVisited: Bool, isDeleted: Bool, section: Int, row: Int) {
        self.section = section
        self.row = row
        self.isVisited = isVisited
        self.isDeleted = isDeleted
    }
}

protocol CellViewModelTouchable {
    var cellTouched: (() -> Void)? { get set }
}
