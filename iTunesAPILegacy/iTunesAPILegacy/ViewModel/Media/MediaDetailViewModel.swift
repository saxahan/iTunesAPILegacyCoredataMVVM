//
//  MediaDetailViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaDetailViewModel: BaseViewModel<Media, MediaService> {

    let collapsed = Observable<Bool>(true)
    
    override init(_ element: Media? = nil) {
        super.init(element)

        visit = { [weak self] in
            if let el = element, let trackId = el.trackId {
                let history = History(trackId: trackId, isRemoved: false, isVisited: true)
                
                do {
                    try history.save()
                    self?.state.value = .isVisited(true)
                }
                catch {
                    debugPrint(error)
                }
            }
        }

        delete = { [weak self] in
            if let el = element, let trackId = el.trackId {
                let history = History(trackId: trackId, isRemoved: true, isVisited: false)

                do {
                    try history.save()
                    self?.state.value = .isDeleted(true)
                }
                catch {
                    debugPrint(error)
                }
            }
        }
    }
}
