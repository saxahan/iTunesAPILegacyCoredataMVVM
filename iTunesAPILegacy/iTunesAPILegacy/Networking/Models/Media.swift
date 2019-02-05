//
//  Media.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import Foundation
import CoreData

/*
 {
 "wrapperType": "track",
 "kind": "music-video",
 "artistId": 909253,
 "trackId": 99280537,
 "artistName": "Jack Johnson",
 "trackName": "Better Together",
 "trackCensoredName": "Better Together (A Weekend At the Greek)",
 "artistViewUrl": "https://itunes.apple.com/us/artist/jack-johnson/909253?uo=4",
 "trackViewUrl": "https://itunes.apple.com/us/music-video/better-together-a-weekend-at-the-greek/99280537?uo=4",
 "previewUrl": "https://video-ssl.itunes.apple.com/apple-assets-us-std-000001/Video125/v4/e9/39/bb/e939bb7a-4aa0-8ee9-e898-055fa08dc82a/mzvf_7721131166335926701.640x360.h264lc.U.p.m4v",
 "artworkUrl30": "https://is5-ssl.mzstatic.com/image/thumb/Video/v4/85/2b/ed/852bedbc-6cbf-b4cd-dd31-26324e91c0f6/source/30x30bb.jpg",
 "artworkUrl60": "https://is5-ssl.mzstatic.com/image/thumb/Video/v4/85/2b/ed/852bedbc-6cbf-b4cd-dd31-26324e91c0f6/source/60x60bb.jpg",
 "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Video/v4/85/2b/ed/852bedbc-6cbf-b4cd-dd31-26324e91c0f6/source/100x100bb.jpg",
 "collectionPrice": 1.49,
 "trackPrice": 1.49,
 "releaseDate": "2005-11-22T08:00:00Z",
 "collectionExplicitness": "notExplicit",
 "trackExplicitness": "notExplicit",
 "trackTimeMillis": 247047,
 "country": "USA",
 "currency": "USD",
 "primaryGenreName": "Rock"
 }
 */

enum MediaType: String {
    case movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
}

enum MediaKind: String {
    case book,
    album,
    pdf,
    podcast,
    artist,
    song,
    podcastEpisode = "podcast-episode",
    softwarePackage = "software-package",
    tvEpisode = "tv-episode",
    coachedAudio = "coached-audio",
    featureMovie = "feature-movie",
    interactiveBooklet = "interactive-booklet",
    musicVideo = "music-video",
    unknown
}

class Media: NSManagedObject, Codable {

    // MARK: - Core Data Managed Object

    @NSManaged var wrapperType: String?
    @NSManaged var kind: String?
    @NSManaged var artistId: NSNumber?
    @NSManaged var trackId: NSNumber?
    @NSManaged var artistName: String?
    @NSManaged var trackName: String?
    @NSManaged var trackCensoredName: String?
    @NSManaged var artistViewUrl: String?
    @NSManaged var trackViewUrl: String?
    @NSManaged var previewUrl: String?
    @NSManaged var artworkUrl30: String?
    @NSManaged var artworkUrl60: String?
    @NSManaged var artworkUrl100: String?
    @NSManaged var collectionPrice: NSNumber?
    @NSManaged var trackPrice: NSNumber?
    @NSManaged var releaseDate: Date?
    @NSManaged var collectionExplicitness: String?
    @NSManaged var trackExplicitness: String?
    @NSManaged var trackTimeMillis: NSNumber?
    @NSManaged var country: String?
    @NSManaged var currency: String?
    @NSManaged var primaryGenreName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind, artistId, trackId,
        artistName, trackName, trackCensoredName,
        artistViewUrl, trackViewUrl, previewUrl,
        artworkUrl30, artworkUrl60, artworkUrl100,
        collectionPrice, trackPrice, releaseDate,
        collectionExplicitness, trackExplicitness,
        trackTimeMillis, country, currency, primaryGenreName
    }

    // MARK: - Decodable

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Media", in: CoreDataStack.managedObjectContext) else {
                fatalError("Failed to decode Media")
        }

        self.init(entity: entity, insertInto: CoreDataStack.managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.wrapperType = try container.decodeIfPresent(String.self, forKey: .wrapperType)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.artistId = try container.decodeIfPresent(Int64.self, forKey: .artistId) as NSNumber?
        self.trackId = try container.decodeIfPresent(Int64.self, forKey: .trackId) as NSNumber?
        self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
        self.trackCensoredName = try container.decodeIfPresent(String.self, forKey: .trackCensoredName)
        self.artistViewUrl = try container.decodeIfPresent(String.self, forKey: .artistViewUrl)
        self.trackViewUrl = try container.decodeIfPresent(String.self, forKey: .trackViewUrl)
        self.previewUrl = try container.decodeIfPresent(String.self, forKey: .previewUrl)
        self.artworkUrl30 = try container.decodeIfPresent(String.self, forKey: .artworkUrl30)
        self.artworkUrl60 = try container.decodeIfPresent(String.self, forKey: .artworkUrl60)
        self.artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100)
        self.collectionPrice = try container.decodeIfPresent(Double.self, forKey: .collectionPrice) as NSNumber?
        self.trackPrice = try container.decodeIfPresent(Double.self, forKey: .trackPrice) as NSNumber?
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)?.toDate()
        self.collectionExplicitness = try container.decodeIfPresent(String.self, forKey: .collectionExplicitness)
        self.trackExplicitness = try container.decodeIfPresent(String.self, forKey: .trackExplicitness)
        self.trackTimeMillis = try container.decodeIfPresent(Int64.self, forKey: .trackTimeMillis) as NSNumber?
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName)

    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(wrapperType, forKey: .wrapperType)
        try container.encode(kind, forKey: .kind)
        try container.encodeIfPresent(Int64(exactly: artistId ?? 0), forKey: .artistId)
        try container.encodeIfPresent(Int64(exactly: trackId ?? 0), forKey: .trackId)
        try container.encodeIfPresent(artistName, forKey: .artistName)
        try container.encodeIfPresent(trackName, forKey: .trackName)
        try container.encodeIfPresent(trackCensoredName, forKey: .trackCensoredName)
        try container.encodeIfPresent(artistViewUrl, forKey: .artistViewUrl)
        try container.encodeIfPresent(trackViewUrl, forKey: .trackViewUrl)
        try container.encodeIfPresent(previewUrl, forKey: .previewUrl)
        try container.encodeIfPresent(artworkUrl30, forKey: .artworkUrl30)
        try container.encodeIfPresent(artworkUrl60, forKey: .artworkUrl60)
        try container.encodeIfPresent(artworkUrl100, forKey: .artworkUrl100)
        try container.encodeIfPresent(Double(exactly: collectionPrice ?? 0), forKey: .collectionPrice)
        try container.encodeIfPresent(Double(exactly: trackPrice ?? 0), forKey: .trackPrice)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(collectionExplicitness, forKey: .collectionExplicitness)
        try container.encodeIfPresent(trackExplicitness, forKey: .trackExplicitness)
        try container.encodeIfPresent(Int64(exactly: trackTimeMillis ?? 0), forKey: .trackTimeMillis)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(primaryGenreName, forKey: .primaryGenreName)
    }

}
