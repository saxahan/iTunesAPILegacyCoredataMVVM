//
//  CellViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

protocol CellViewModel {

}

protocol CellViewModelTouchable {
    var cellTouched: (() -> Void)? { get set}
}
