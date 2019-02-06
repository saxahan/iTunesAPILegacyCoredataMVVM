//
//  BaseListViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class BaseListViewModel<T, S: HttpServiceDefinable>: BaseViewModel<T, S> {
    internal var searchTrigger = Observable<String>("")
    internal let term = Observable<String>("")
    internal let elements = Observable<[T]>([])
    internal let resultCount = Observable<Int>(0)

    override init() {
        super.init()
    }

    func reload() {

    }
}
