//
//  MediaDetailViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaDetailViewModel: BaseViewModel<Media, MediaService> {

    override init(_ element: Media? = nil) {
        super.init(element)

//        name = element?.trackName ?? ""
//        previewUrl = element?.previewUrl ?? element?.artworkUrl60
//        description = element?.longDescription ?? element?.description ?? element?.shortDescription ?? ""
//        price = element?.trackPrice ?? 0.0

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
