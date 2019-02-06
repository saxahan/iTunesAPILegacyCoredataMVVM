//
//  MediaListViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class MediaListViewController: BaseViewController, ViewModelBased {

    @IBOutlet weak var collectionView: UICollectionView!

    var numOfColumns: Int = DeviceManager.shared.isPhone() ? 1 : 2
    var viewModel: MediaListViewModel!

    override func setup() {
        super.setup()

        collectionView.register(MediaCollectionViewCell.self)
        bindings()
    }

    func bindings() {
        let refresher = collectionView.addRefreshControl(target: self, action: #selector(refreshed))

        // FIXME: remove this line before production
        viewModel.search("steve jobs", media: .all)

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
            if let slf = self {
                slf.collectionView.reloadData()

                // search result count
                // slf.viewModel.resultCount
            }
        }
    }

    @objc func refreshed() {
        viewModel.reload()
    }
}

extension MediaListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionViewModels.value.count > 0 ? viewModel.sectionViewModels.value.count : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.sectionViewModels.value.count > section {
            let sectionViewModel = viewModel.sectionViewModels.value[section]
            return sectionViewModel.cellViewModels.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.identifier, for: indexPath) as! MediaCollectionViewCell
        let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
        let cellViewModel = sectionViewModel.cellViewModels[indexPath.row]

        cell.setup(cellViewModel)
        cell.setNeedsDisplay()
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

// MARK: UICollectionView dynamic columns layout

extension MediaListViewController: UICollectionViewDelegateFlowLayout {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            numOfColumns = 2
        }
        else {
            debugPrint("Portrait")
            numOfColumns = DeviceManager.shared.isPhone() ? 1 : 2
        }

        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var margins: CGFloat = padding * 2 + padding * CGFloat(numOfColumns - 1)

        if #available(iOS 11.0, *) {
            margins += collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
        }

        let itemWidth = ((collectionView.bounds.size.width - margins) / CGFloat(numOfColumns)).rounded(.down)
        let itemHeight = itemWidth

        return CGSize(width: itemWidth, height: itemHeight)
    }
}

