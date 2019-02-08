//
//  Media.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation

enum MediaType: String, CaseIterable {
    case movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
}

struct Media: Codable {
    var wrapperType, kind: String?
    var artistId, trackId: Int?
    var artistName, trackName, trackCensoredName: String?
    var artistViewUrl, trackViewUrl: String?
    var previewUrl: String?
    var artworkUrl30, artworkUrl60, artworkUrl100, artworkUrl600: String?
    var collectionPrice, trackPrice: Double?
    var releaseDate: String?
    var collectionExplicitness, trackExplicitness: String?
    var trackTimeMillis: Int?
    var country, currency, primaryGenreName: String?
    var description: String?
}
