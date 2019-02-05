//
//  UICollectionView+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UICollectionView: Identifiable {
    func register(_ cellClass: Identifiable.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }

    func dequeueReusableCell<T: Identifiable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
