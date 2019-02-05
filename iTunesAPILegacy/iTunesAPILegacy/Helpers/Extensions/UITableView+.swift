//
//  UITableView+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UITableView: Identifiable {
    func register(_ cellClass: Identifiable.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }

    func dequeueReusableCell<T: Identifiable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}


