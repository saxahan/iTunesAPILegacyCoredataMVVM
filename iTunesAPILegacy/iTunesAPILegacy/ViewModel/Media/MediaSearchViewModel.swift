//
//  MediaSearchViewModel.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

class MediaSearchViewModel: BaseListViewModel<Media, MediaService> {

    func search(_ term: String, entity: MediaType, limit: Int = 100) {
        provider.request(.searchItunes(term: term, entity: .all, limit: limit)) { [weak self] (result) in
            self?.isLoading.value = false

            switch result {
            case .success(let response):
                self?.elements.value = (try? response.map([Media].self, atKeyPath: "results")) ?? []
                break
            case .failure(let error):
                self?.error.value = error
                break
            }
        }
    }
    
}
