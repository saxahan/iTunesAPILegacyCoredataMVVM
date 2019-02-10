//
//  States.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 7.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum States {
    case initial
    case isVisited(Bool)
    case isDeleted(Bool)
}

protocol DetailLifeCycle {
    var visit: (() -> Void)? { get set }
    var delete: (() -> Void)? { get set }
}

protocol HistoryLifeCycle {
    func fetchHistories()
    func fetchHistory(trackId: Int)
}

extension HistoryLifeCycle {
    func fetchHistories() {}
    func fetchHistory(trackId: Int) {}
}
