//
//  MediaListViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaListViewModel: BaseListViewModel<Media, MediaService>, HistoryLifeCycle {
    let filter = Observable<MediaFilterViewModel>(MediaFilterViewModel())
    let selectedDetail = Observable<MediaDetailViewModel?>(nil)
    var histories: [History] = []
    let layouts = [1, 2, 3, 4]
    let imageSizes: (width: Int, height: Int) = (400, 400)

    override init(_ element: Media? = nil) {
        super.init(element)

        term.addObserver(fireNow: false) { [weak self] (text) in
            if !text.isEmpty {
                self?.reload()
            }
        }

        filter.addObserver(fireNow: false) { [weak self] (filter) in
            if let text = self?.term.value.trim(), !text.isEmpty {
                self?.reload()
            }
        }
    }

    override func reload() {
        guard let mediaType = filter.value.selecteds.first else { return }
        search(term.value, media: mediaType)
    }

    override func clearList() {
        super.clearList()
        term.value = ""
        dataSource.value = ([], false)
    }

    // MARK: Service calls
    
    func fetchHistories() {
        do {
            histories = try Persistense.shared.context.fetchObjects(History.self)
        } catch {
            debugPrint(error)
        }
    }
    
    func search(_ term: String, media: MediaType = .all, limit: Int = 100) {
        isLoading.value = true

        provider.request(.searchItunes(term: term, media: media, limit: limit)) { [unowned self] (result) in
            self.cleared.value = false
            self.isLoading.value = false

            switch result {
            case .success(let response):

                // because some media type results, like audiobook has no trackId
                // so we consider it's empty because of primary key violation
                // for demonstration purposes filter to be not nil
                let mediaList = ((try? response.map([Media].self, atKeyPath: "results")) ?? []).filter {$0.trackId != nil}
                self.fetchHistories()

                var cells = [MediaCellViewModel]()
                for obj in mediaList {
                    if let trackId = obj.trackId {
                        let deleted = self.histories.contains { $0.trackId == Int64(trackId) && $0.removed }

                        if !deleted {
                            let visited = self.histories.contains { $0.trackId == Int64(trackId) && $0.visited }
                            let cell = MediaCellViewModel(trackId: trackId,
                                                          name: obj.trackName,
                                                          previewUrl: obj.pictureUrl(width: self.imageSizes.width, height: self.imageSizes.height)?.absoluteString,
                                                          price: obj.trackPrice,
                                                          isVisited: visited,
                                                          isDeleted: deleted)

                            cell.cellTouched = {
                                // open media detail
                                self.selectedDetail.value = MediaDetailViewModel(obj)
                            }

                            cells.append(cell)
                        }
                    }
                    else {
                        debugPrint("no trackId")
                    }
                }

                self.resultCount = cells.count
                self.dataSource.value = ([SectionViewModel(title: nil, cells: cells)], false)
                break
            case .failure(let error):
                self.error.value = error
                break
            }
        }
    }
}
