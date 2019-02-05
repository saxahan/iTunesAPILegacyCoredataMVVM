//
//  BaseListViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class BaseListViewModel<T, S: ServiceDefinable>: BaseViewModel<T, S> {
    var searchTrigger = Observable<String>()
    let query = Observable<String>("")
    let elements = Observable<[T]>([])
    let totalElements = Observable<Int>(0)

    override init() {
        super.init()
    }
}
