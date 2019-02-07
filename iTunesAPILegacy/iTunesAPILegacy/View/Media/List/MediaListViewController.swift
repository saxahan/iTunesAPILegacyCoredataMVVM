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

        viewModel.dataSource.addObserver(fireNow: false) { [weak self] (sections, batch) in
            if let slf = self {
                if !batch {
                    slf.collectionView.reloadData()
                }

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

                self.collectionView.performBatchUpdates({
                    switch state {
                    case .initial:
                        break

                    case .isVisited(let isVisited):
                        if isVisited {
                            self.collectionView.reloadItems(at: indexArr)

                            let sections = self.viewModel.dataSource.value.0
                            sections[self.viewModel.selectedSection].cells[self.viewModel.selectedRow].isVisited = isVisited
                            self.viewModel.dataSource.value = (sections, true)
                        }
                        break

                    case .isDeleted(let isDeleted):
                        if isDeleted {
                            self.collectionView.deleteItems(at: indexArr)

                            var sections = self.viewModel.dataSource.value.0
                            sections[self.viewModel.selectedSection].cells.remove(at: self.viewModel.selectedRow)
                            self.viewModel.dataSource.value = (sections, true)
                        }
                        break
                    }
                })
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

        let pop = PopupViewController.initFromNib()
        pop.modalPresentationStyle = .overCurrentContext
        self.present(pop, animated: true, completion: nil)
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
        return viewModel.dataSource.value.0.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionViewModel = viewModel.dataSource.value.0[section]
        return sectionViewModel.cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.identifier, for: indexPath) as! MediaCollectionViewCell
        let sectionViewModel = viewModel.dataSource.value.0[indexPath.section]
        let cellViewModel = sectionViewModel.cells[indexPath.row]

        cell.setup(cellViewModel)
        cell.setNeedsDisplay()
        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedSection = indexPath.section
        viewModel.selectedRow = indexPath.row

        let sectionViewModel = viewModel.dataSource.value.0[indexPath.section]
        if let cellViewModel = sectionViewModel.cells[indexPath.row] as? CellViewModelTouchable {
            cellViewModel.cellTouched?()
        }
    }
}

// MARK: UICollectionView dynamic columns layout

extension MediaListViewController: UICollectionViewDelegateFlowLayout {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        numOfColumns = DeviceManager.shared.isLandscape() ? 2 : (DeviceManager.shared.isPhone() ? 1 : 2)
        UIScreen.main.snapshotView(afterScreenUpdates: true)

        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.collectionViewLayout.invalidateLayout()
        }

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

