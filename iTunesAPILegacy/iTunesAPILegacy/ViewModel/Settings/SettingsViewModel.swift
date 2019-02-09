//
//  SettingsViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class SettingsViewModel: HistoryLifeCycle {
    let dataSource = Observable<([SectionViewModel<SettingsRowViewModel>], Bool)>(([], false))

    init() {
        fetchHistories()
    }

    func fetchHistories() {
        do {
            let histories = try Persistense.shared.context.fetchObjects(History.self)
            let cells = histories.map { SettingsRowViewModel(history: $0) }
            self.dataSource.value = ([SectionViewModel(title: "HISTORY".localized, cells: cells)], false)
        } catch {
            debugPrint(error)
        }
    }
}
