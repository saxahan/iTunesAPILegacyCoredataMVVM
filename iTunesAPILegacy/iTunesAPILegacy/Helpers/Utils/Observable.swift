//
//  Observable.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class Observable<T> {

    private var _value : T! = nil

    var value: T {
        get {
            return self._value
        }
        set {
            self._value = newValue
            self.notifyAllObserver(newValue)
        }
    }
    
    private var observers: [((T) -> Void)] = []

    init(_ value: T) {
        self.value = value
    }

    func addObserver(fireNow: Bool = true, _ onChange: @escaping ((T) -> Void)) {
        observers.append(onChange)

        if fireNow {
            onChange(value)
        }
    }

    func removeObservers() {
        observers.removeAll()
    }

    func notifyAllObserver(_ newValue: T) {
        for observer in observers {
            DispatchQueue.main.async {
                observer(newValue)
            }
        }
    }

    func changeValueWithoutNotify(_ newValue: T) {
        self._value = newValue
    }
}
