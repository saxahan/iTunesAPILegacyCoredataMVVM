//
//  MediaSearchViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaSearchViewModel: BaseListViewModel<Media, MediaService> {

    let sectionViewModels = Observable<[SectionViewModel]>([])
    let entity = Observable<MediaType>(.all)

    override init() {
        super.init()
    }

    override func reload() {
        search(term.value, entity: entity.value)
    }
    
    func search(_ term: String, entity: MediaType, limit: Int = 100) {
        self.term.value = term
        self.entity.value = entity

        provider.request(.searchItunes(term: term, entity: entity, limit: limit)) { [weak self] (result) in
            self?.isLoading.value = false

            switch result {
            case .success(let response):
                self?.resultCount.value = (try? response.map(Int.self, atKeyPath: "resultCount")) ?? 0

                let mediaList = ((try? response.map([Media].self, atKeyPath: "results")) ?? [])
                let sections = SectionViewModel(cellViewModels: mediaList.map {
                    let tmp = MediaCellViewModel(trackId: $0.trackId, name: $0.trackName, previewUrl: $0.artworkUrl600 ?? $0.artworkUrl100, price: $0.trackPrice)
                    tmp.cellTouched = {
                        debugPrint("tapped \(tmp.name ?? "cell")")
                    }
                    return tmp
                })
                self?.sectionViewModels.value = [sections]
                break
            case .failure(let error):
                self?.error?.value = error
                break
            }
        }
    }
}
