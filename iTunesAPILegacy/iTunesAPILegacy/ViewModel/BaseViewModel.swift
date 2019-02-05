//
//  BaseViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

protocol ViewModelBased: class {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
    func bindings() 
}

extension ViewModelBased where Self: StoryboardBased & UIViewController {
    static func instantiate (with viewModel: ViewModel, storyboardName: String) -> Self {
        let viewController = Self.instantiate(storyboardName)
        viewController.viewModel = viewModel
        return viewController
    }
}

class BaseViewModel<T, S: ServiceDefinable> {
    // view states
    internal let isLoading = Observable<Bool>(false)
    internal let refreshTrigger = Observable<Void>(())
    internal var element: Observable<T>?
    internal var error: Observable<Error>?
    
    // data provider
    internal let provider: APIProvider<S>

    init() {
        provider = APIProvider<S>()
    }
}

