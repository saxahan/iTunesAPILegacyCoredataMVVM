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
        self.delegate = self
    }

    @objc private func performSearch() {
        self.onSearch?(self.text ?? "")
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.onCancel?()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // no necessary :)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // to limit network activity, reload half a second after last key press.
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
        self.perform(#selector(performSearch), with: nil, afterDelay: throttleInterval)
    }
}
