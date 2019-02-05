//
//  MediaCellViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaCellViewModel: CellViewModel, CellViewModelTouchable {
    
    var cellTouched: (() -> Void)?

    let trackId: NSNumber?
    let name: String?
    let previewUrl: String?
    let price: NSNumber?

    init(trackId: NSNumber?, name: String?, previewUrl: String?, price: NSNumber?) {
        self.trackId = trackId
        self.name = name
        self.previewUrl = previewUrl
        self.price = price
    }
}
