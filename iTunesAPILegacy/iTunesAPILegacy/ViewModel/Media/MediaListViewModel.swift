//
//  MediaListViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaListViewModel: BaseListViewModel<Media, MediaService> {
    let mediaType = Observable<MediaType>(.all)
    let selectedDetail = Observable<MediaDetailViewModel?>(nil)
    let histories = Observable<[History]>([])

    override init(_ element: Media? = nil) {
        super.init(element)
        
        term.addObserver(fireNow: false) { [weak self] (text) in
            if !text.isEmpty {
                self?.reload()
            }
        }
    }

    override func reload() {
        search(term.value, media: mediaType.value)
    }

    override func clearList() {
        super.clearList()
        term.value = ""
        sectionViewModels.value = []
    }

    // MARK: Service calls
    
    func fetchHistories() {
        do {
            histories.value = try CoreDataStack.managedObjectContext.fetchObjects(History.self)
        } catch {
            debugPrint(error)
        }
    }
    
    func search(_ term: String, media: MediaType = .all, limit: Int = 100) {
        self.mediaType.value = media
        isLoading.value = true

        provider.request(.searchItunes(term: term, media: media, limit: limit)) { [unowned self] (result) in
            self.cleared.value = false
            self.isLoading.value = false

            switch result {
            case .success(let response):
                self.resultCount = (try? response.map(Int.self, atKeyPath: "resultCount")) ?? 0
                let mediaList = ((try? response.map([Media].self, atKeyPath: "results")) ?? [])
                self.fetchHistories()

                var cells = [MediaCellViewModel]()
                for (index, obj) in mediaList.enumerated() {
                    if let trackId = obj.trackId {
                        let deleted = self.histories.value.contains { $0.trackId == Int64(trackId) && $0.isRemoved }

                        if !deleted {
                            let visited = self.histories.value.contains { $0.trackId == Int64(trackId) && $0.isVisited }
                            let cell = MediaCellViewModel(trackId: trackId,
                                                          name: obj.trackName,
                                                          previewUrl: obj.artworkUrl600 ?? obj.artworkUrl100,
                                                          price: obj.trackPrice,
                                                          isVisited: visited,
                                                          isDeleted: deleted,
                                                          row: index)

                            cell.cellTouched = {
                                // open media detail
                                self.selectedSection = cell.section
                                self.selectedRow = cell.row
                                self.selectedDetail.value = MediaDetailViewModel(obj)
                            }

                            cells.append(cell)
                        }
                    }
                    else {
                        debugPrint("no trackId")
                    }
                }

                self.sectionViewModels.value = [SectionViewModel(title: nil, cells: cells)]
                break
            case .failure(let error):
                self.error.value = error
                break
            }
        }
    }
}
