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
    @IBOutlet weak var searchBar: SearchBar!

    var numOfColumns: Int = DeviceManager.shared.isLandscape() ? 2 : (DeviceManager.shared.isPhone() ? 1 : 2)
    var viewModel: MediaListViewModel!

    override func setup() {
        super.setup()

        // dismissKeyboardOnTapOutside()
        bindings()
    }

    override func initNavbar() {
        super.initNavbar()
        let filterBtn = UIBarButtonItem.createButton(imageName: "filter", target: self, action: #selector(filterTapped))
        let layoutBtn = UIBarButtonItem.createButton(imageName: "keypad", target: self, action: #selector(layoutTapped))

        navigationItem.rightBarButtonItems = [filterBtn, layoutBtn]
    }

    func bindings() {
        // searchbar
        searchBar.onSearch = { [unowned self] text in
            let txt = text.trim()
            if txt.count > Constants.minimumSearchCharacter {
                if self.viewModel.term.value != txt {
                    self.viewModel.term.value = txt
                }
            }
        }
        searchBar.onCancel = { [weak self] in
            self?.viewModel.clearList()
        }

        // collection view
        collectionView.showPlaceholder()
        collectionView.register(MediaCollectionViewCell.self)

        viewModel.sectionViewModels.addObserver(fireNow: false) { [weak self] (sections) in
            if let slf = self {
                slf.collectionView.reloadData()

                // search result count
                if slf.viewModel.resultCount == 0 {
                    let cleared = slf.viewModel.cleared.value
                    slf.collectionView.showPlaceholder("\(cleared ? "PLACEHOLDER_YOU_CAN_SEARCH" : "PLACEHOLDER_SEARCHED_NO_RESULT")".localized, image: cleared ? #imageLiteral(resourceName: "search") : #imageLiteral(resourceName: "visible") )
                }
                else {
                    slf.collectionView.hidePlaceholder()
                }
            }
        }

        // selected cell change listener according to state
        viewModel.selectedDetail.addObserver(fireNow: false) { [unowned self] (detail) in
            detail?.state.addObserver(fireNow: false) { (state) in
                let indexPath = IndexPath(row: self.viewModel.selectedRow, section: self.viewModel.selectedSection)
                let indexArr = [indexPath]
//                var dataSource = self.viewModel.sectionViewModels.value

                switch state {
                case .initial:
                    break

                case .isVisited(let isVisited):
                    if isVisited {
                        self.viewModel.sectionViewModels.value[self.viewModel.selectedSection].cells[self.viewModel.selectedRow].isVisited = isVisited

                        self.collectionView.performBatchUpdates({
                            self.collectionView.reloadItems(at: indexArr)
                        })
                    }
                    break

                case .isDeleted(let isDeleted):
                    if isDeleted {
                        self.viewModel.sectionViewModels.value[self.viewModel.selectedSection].cells.remove(at: self.viewModel.selectedRow)

                        self.collectionView.performBatchUpdates({
                            self.collectionView.deleteItems(at: indexArr)
                        })
                    }
                    break
                }
            }

            if let dt = detail {
                let vc = MediaDetailViewController.instantiate(with: dt, title: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
        }

        // loader
        let refresher = collectionView.addRefreshControl(target: self, action: #selector(refreshed))
        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.collectionView.hidePlaceholder()
                self?.collectionView.showIndicator()
            }
            else {
                self?.collectionView.hideIndicator()
                refresher.endRefreshing()
            }
        }

        // error
        viewModel.error.addObserver(fireNow: false) { [weak self] (err) in
            self?.collectionView.showPlaceholder(err?.localizedDescription ?? "", image: #imageLiteral(resourceName: "error"))
        }
    }

    @objc func filterTapped() {
        debugPrint(#function)
    }

    @objc func layoutTapped() {
        debugPrint(#function)
    }

    @objc func refreshed() {
        viewModel.reload()
    }
}

extension MediaListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionViewModels.value.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionViewModel = viewModel.sectionViewModels.value[section]
        return sectionViewModel.cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.identifier, for: indexPath) as! MediaCollectionViewCell
        let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
        let cellViewModel = sectionViewModel.cells[indexPath.row]

        cell.setup(cellViewModel)
        cell.setNeedsDisplay()
        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
        if let cellViewModel = sectionViewModel.cells[indexPath.row] as? CellViewModelTouchable {
            cellViewModel.cellTouched?()
        }
    }
}

// MARK: UICollectionView dynamic columns layout

extension MediaListViewController: UICollectionViewDelegateFlowLayout {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        numOfColumns = DeviceManager.shared.isLandscape() ? 2 : (DeviceManager.shared.isPhone() ? 1 : 2)
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var margins: CGFloat = padding * padding * CGFloat(numOfColumns - 1)

        if #available(iOS 11.0, *) {
            margins += collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
        }

        let itemWidth = ((collectionView.bounds.size.width - margins) / CGFloat(numOfColumns)).rounded(.down)
        let itemHeight = itemWidth

        return CGSize(width: itemWidth, height: itemHeight)
    }
}

