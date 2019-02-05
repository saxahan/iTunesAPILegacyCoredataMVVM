//
//  BaseViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

//protocol ViewModel {
//    associatedtype Services
//    init (withServices services: Services)
//}

protocol ViewModelBased: class {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
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
    let isLoading = Observable<Bool>(false)
    let error = Observable<Error>()
    let refreshTrigger = Observable<Void>()

    // data provider
    internal var provider: APIProvider<S>

    init() {
        provider = APIProvider<S>()
    }
}

