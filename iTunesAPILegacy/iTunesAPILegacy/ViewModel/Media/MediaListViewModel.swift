//
//  MediaListViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaListViewModel: BaseListViewModel<Media, MediaService> {

    let sectionViewModels = Observable<[SectionViewModel]>([])
    let mediaType = Observable<MediaType>(.all)
    let openDetail = Observable<MediaDetailViewModel?>(nil)
    let histories = Observable<[History]>([])

    override init(_ element: Media? = nil) {
        super.init(element)

        do {
            histories.value = try CoreDataStack.managedObjectContext.fetchObjects(History.self)
        } catch {
            debugPrint(error)
        }

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
                let sections = SectionViewModel(cellViewModels: mediaList.map {
                    let obj = $0
                    let visitedBefore = self.histories.value.contains { $0.trackId == Int64(obj.trackId ?? 0) && $0.isVisited }
                    let tmp = MediaCellViewModel(trackId: obj.trackId, name: obj.trackName, previewUrl: obj.artworkUrl600 ?? obj.artworkUrl100, price: obj.trackPrice, isVisited: visitedBefore)
                    tmp.cellTouched = {
                        let detail = MediaDetailViewModel(obj)
                        self.openDetail.value = detail
                        // open media detail
                        
                    }
                    return tmp
                })
                self.sectionViewModels.value = [sections]
                break
            case .failure(let error):
                self.error.value = error
                break
            }
        }
    }
}
