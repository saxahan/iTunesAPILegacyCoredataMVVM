//
//  FilterViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

protocol FilterLifeCycle {
    associatedtype FilterType

    var selecteds: [FilterType]! { get set }
    var filters: [FilterType]! { get }
    mutating func updateSelected(at index: Int?) -> [FilterType]
}

class FilterRowViewModel: CellViewModel {
    var imageName: String?
    var title: String?

    init(imageName: String?, title: String) {
        super.init(isVisited: false, isDeleted: false)
        self.imageName = imageName
        self.title = title
    }

    static func build() {

    }
}

