//
//  MediaDetailViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaDetailViewModel: BaseViewModel<Media, MediaService>, HistoryLifeCycle {
    let collapsed = Observable<Bool>(true)
    private var history: History?

    override init(_ element: Media? = nil) {
        super.init(element)

        visit = { [weak self] in
            if let el = element, let trackId = el.trackId {

                self?.fetchHistory(trackId: trackId)
                if self?.history == nil {
                    self?.history = History(trackId: trackId, isRemoved: false, isVisited: true)
                }

                self?.history?.removed = false
                self?.history?.visited = true

                do {
                    try self?.history?.save()
                    self?.state.value = .isVisited(true)
                }
                catch {
                    debugPrint(error)
                }
            }
        }

        delete = { [weak self] in
            if let el = element, let trackId = el.trackId {
                self?.fetchHistory(trackId: trackId)
                if self?.history == nil {
                    self?.history = History(trackId: trackId, isRemoved: true, isVisited: false)
                }

                self?.history?.removed = true
                self?.history?.visited = false

                do {
                    try self?.history?.save()
                    self?.state.value = .isDeleted(true)
                }
                catch {
                    debugPrint(error)
                }
            }
        }
    }

    func fetchHistory(trackId: Int) {
        do {
            let predicate = NSPredicate(format: "trackId = %d", trackId)
            history = try Persistense.shared.context.fetchObjects(History.self, predicate: predicate).first
        } catch {
            debugPrint(error)
        }
    }
}

