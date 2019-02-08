//
//  SectionViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class SectionViewModel<T> {
    var title: String?
    var cells: [T] = []
    var selected: (section: Int, row: Int)? = nil

    init(title: String?, cells: [T], selected: (section: Int, row: Int)? = nil) {
        self.title = title
        self.cells = cells
        self.selected = selected
    }

    // write a build method for as a helper
    class func build() -> [SectionViewModel] {
        return []
    }
}
