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

    var viewModel: MediaListViewModel!
    let gridFilter = Observable<Int>(DeviceManager.shared.isLandscape() ? 2 : (DeviceManager.shared.isPhone() ? 1 : 2))

    override func setup() {
        super.setup()

        view.dismissKeyboardOnTapOutside(cancelsTouchesInView: false)
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
                vc.hidesBottomBarWhenPushed = true
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

        // grid filter
        gridFilter.addObserver(fireNow: false) { [weak self] (_) in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView?.collectionViewLayout.invalidateLayout()
            }
        }
    }

    @objc func filterTapped() {
        guard let filters = viewModel.filter.value.filters else { return }

        var selecteds: (Int, Int)?
        if let selected = viewModel.filter.value.selecteds.first, let found = filters.firstIndex(where: { (m) -> Bool in
            m == selected
        }){
            selecteds = (0, found)
        }

        let rows = filters.map { return FilterRowViewModel(imageName: "checked", title: $0.rawValue.uppercased()) }
        let dataSource = [SectionViewModel<FilterRowViewModel>(title: "MEDIA_TYPES".localized, cells: rows, selected: selecteds)]
        ChoicePopup<SectionViewModel<FilterRowViewModel>>.create(dataSource,
                                                                 shouldDismissOnSelection: false,
                                                                 completion: { [weak self] data in
                                                                    _ = self?.viewModel.filter.value.updateSelected(at: data?.selected?.row)

        }).show()
    }

    @objc func layoutTapped() {
        var selecteds: (Int, Int)?

        if let found = viewModel.layouts.firstIndex(of: gridFilter.value) {
            selecteds = (0, found)
        }

        let rows = viewModel.layouts.map { return FilterRowViewModel(imageName: "checked", title: "\($0)") }
        ChoicePopup<SectionViewModel<FilterRowViewModel>>.create([SectionViewModel<FilterRowViewModel>(title: "GRID_LIST_COUNT".localized, cells: rows, selected: selecteds)],
                                                                 shouldDismissOnSelection: true,
                                                                 completion: { [weak self] data in
                                                                    self?.gridFilter.value = self?.viewModel.layouts[data?.selected?.row ?? 0] ?? 0

        }).show()
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
        cell.bottomView.isHidden = gridFilter.value >= 3
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
        gridFilter.value = DeviceManager.shared.isLandscape() ? 2 : (DeviceManager.shared.isPhone() ? 1 : 2)
        super.viewWillTransition(to: size, with: coordinator)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if gridFilter.value >= 3 {
            return .zero
        }

        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var margins: CGFloat = padding * 2 + padding * CGFloat(gridFilter.value - 1)

        if #available(iOS 11.0, *) {
            margins += collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
        }

        let itemWidth = ((collectionView.bounds.size.width - margins) / CGFloat(gridFilter.value)).rounded(.down)
        let itemHeight = itemWidth
        let cellSize = CGSize(width: itemWidth, height: itemHeight)
        
        return cellSize
    }
}

