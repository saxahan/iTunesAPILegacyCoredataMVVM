//
//  BaseViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class BaseViewModel<T, S: HttpServiceDefinable>: DetailLifeCycle {
    
    var visit: (() -> Void)?
    var delete: (() -> Void)?

    // view props
    internal let isLoading = Observable<Bool>(false)
    internal let error = Observable<APIError?>(nil)
    internal let element = Observable<T?>(nil)
    internal let state = Observable<States>(.initial)

    // data provider
    internal let provider: APIProvider<S>

    init(_ element: T? = nil) {
        self.element.value = element
        provider = APIProvider<S>()
    }
}

