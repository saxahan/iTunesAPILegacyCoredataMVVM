//
//  BaseListViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class BaseListViewModel<T, S: HttpServiceDefinable>: BaseViewModel<T, S> {
    // base observers
    internal var searchTrigger = Observable<String>("")
    internal let term = Observable<String>("")
    internal let elements = Observable<[T]>([])
    internal let cleared  = Observable<Bool>(true)

    // list observers
    internal let sectionViewModels = Observable<[SectionViewModel]>([])

    // variables
    internal var resultCount = 0
    internal var selectedSection = 0
    internal var selectedRow = 0

    // MARK - Override if needed
    func reload() {

    }

    func clearList() {
        resultCount = 0
        elements.value = []
        cleared.value = true
    }
}
