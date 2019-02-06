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

        didAppeared = {
            if let el = element, let trackId = el.trackId {
                let history = History(trackId: trackId, isRemoved: false, isVisited: true)

                do {
                    try history.save()
                }
                catch {
                    debugPrint(error)
                }
            }
        }
    }

}
