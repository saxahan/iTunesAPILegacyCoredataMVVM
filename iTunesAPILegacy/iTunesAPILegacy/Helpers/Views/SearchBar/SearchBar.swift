//
//  SearchBar.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {

    @IBInspectable
    var throttleInterval: Double = 0.5

    var onCancel: (() -> (Void))? = nil
    var onSearch: ((String) -> (Void))? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        self.placeholder = "PLACEHOLDER_SEARCH".localized
        self.showsCancelButton = true
        self.tintColor = Constants.Color.navbarForeground
        self.delegate = self

        if let buttonItem = self.subviews.first?.subviews.last as? UIButton {
            buttonItem.setTitleColor(Constants.Color.navbarForeground, for: .normal)
        }
    }

    private func clear() {
        self.text = ""
        self.onCancel?()
    }

    private func throttleSearch(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty == true {
            // cleared text
            clear()
            return
        }

        // to limit network activity, wait for throttle time interval
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
        self.perform(#selector(performSearch), with: nil, afterDelay: throttleInterval)
    }

    @objc private func performSearch() {
        self.onSearch?(self.text ?? "")
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clear()
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        throttleSearch(searchBar)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttleSearch(searchBar)
    }
}
