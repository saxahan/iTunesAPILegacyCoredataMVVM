//
//  Settable.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

protocol Settable {
    associatedtype Element
    func setup(_ element: Element)
}
