//
//  MediaFilterViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

struct MediaFilterViewModel: FilterLifeCycle {
    typealias FilterType = MediaType

    var selecteds: [MediaType]! = [.all]
    var filters: [MediaType]! = MediaType.allCases.sorted {$0.rawValue < $1.rawValue}

    mutating func updateSelected(at index: Int?) -> [MediaType] {
        guard let index = index, index < filters.count else { return [] }
        selecteds = [filters[index]]
        return selecteds
    }
}
