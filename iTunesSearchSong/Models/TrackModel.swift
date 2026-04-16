//
//  Track.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//


import Foundation

struct Track: Decodable, Identifiable, Hashable, ArtworkScalable {
    let collectionId: Int
    let trackId: Int
    let artistName: String
    let trackName: String
    let previewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String

    var id: Int { trackId }
}
