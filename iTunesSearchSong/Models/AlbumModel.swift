//
//  Album.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//


import Foundation

struct Album: Decodable, ArtworkScalable {
    let collectionId: Int
    let artworkUrl100: String
    let collectionName: String
    let artistName: String

    var tracks: [Track]?
}
