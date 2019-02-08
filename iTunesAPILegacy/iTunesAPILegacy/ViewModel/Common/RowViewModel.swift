//
//  RowViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class RowViewModel {
    var imageName: String
    var title: String

    init(imageName: String, title: String) {
        self.imageName = imageName
        self.title = title
    }
}
