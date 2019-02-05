//
//  MediaSearchViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class MediaSearchViewController: BaseViewController, ViewModelBased {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: MediaSearchViewModel!

    override func setup() {
        super.setup()

        collectionView.register(MediaCollectionViewCell.self)
        bindings()
    }

    func bindings() {
        let refresher = collectionView.addRefreshControl(target: self, action: #selector(refreshed))

        viewModel.isLoading.value = true
        viewModel.search("matrix", entity: .movie)

        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.collectionView.showIndicator()
            }
            else {
                self?.collectionView.hideIndicator()
                refresher.endRefreshing()
            }

            self?.collectionView.reloadData()
        }

        viewModel.sectionViewModels.addObserver(fireNow: false) { [weak self] (sections) in
            self?.collectionView.reloadData()
        }
    }

    @objc func refreshed() {
        viewModel.reload()
    }
}

extension MediaSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionViewModels.value.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionViewModel = viewModel.sectionViewModels.value[section]
        return sectionViewModel.cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.identifier, for: indexPath) as! MediaCollectionViewCell
        let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
        let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]
        
        cell.setup(cellViewModel)
        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
        if let cellViewModel = sectionViewModel.cellViewModels[indexPath.row] as? CellViewModelTouchable {
            cellViewModel.cellTouched?()
        }
    }
}
