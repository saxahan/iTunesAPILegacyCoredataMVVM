//
//  Observable.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }

    private var valueChanged: ((T?) -> Void)?

    init(_ value: T? = nil) {
        self.value = value
    }

    func addObserver(fireNow: Bool = true, _ onChange: ((T?) -> Void)?) {
        valueChanged = onChange

        if fireNow {
            onChange?(value)
        }
    }

    func removeObserver() {
        valueChanged = nil
    }

    static func emptyArray() -> Observable<[T]> {
        return Observable<[T]>([])
    }
}
