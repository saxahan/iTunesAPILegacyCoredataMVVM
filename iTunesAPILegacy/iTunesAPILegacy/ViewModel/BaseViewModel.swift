//
//  BaseViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

protocol DetailLifeCycle {
    var didAppeared: (() -> Void)? { get set }
}

class BaseViewModel<T, S: HttpServiceDefinable>: DetailLifeCycle {
    
    var didAppeared: (() -> Void)?

    // view states
    internal let isLoading = Observable<Bool>(false)
    internal let error = Observable<APIError?>(nil)
    internal let refreshTrigger = Observable<Void>(())
    internal let element = Observable<T?>(nil)
    
    // data provider
    internal let provider: APIProvider<S>

    init(_ element: T? = nil) {
        self.element.value = element
        provider = APIProvider<S>()
    }
}

