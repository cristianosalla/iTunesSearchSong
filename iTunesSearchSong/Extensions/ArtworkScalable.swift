//
//  ArtworkScalable.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import Foundation

protocol ArtworkScalable {
    var artworkUrl100: String { get }
}

extension ArtworkScalable {
    var artworkURL600: URL? {
        let urlString = artworkUrl100.replacingOccurrences(of: "100x100", with: "600x600")
        return URL(string: urlString)
    }
}
