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
    var trackId: Int?
    var name: String?
    var previewUrl: String?
    var price: Double?

    init(trackId: Int?, name: String?, previewUrl: String?, price: Double?, isVisited: Bool = false, isDeleted: Bool = false) {
        super.init(isVisited: isVisited, isDeleted: isDeleted)
        self.trackId = trackId
        self.name = name
        self.previewUrl = previewUrl
        self.price = price
    }
}
