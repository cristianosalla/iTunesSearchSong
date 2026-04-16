//
//  Array+Extension.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

extension Array where Element == iTunesResult {
    var tracks: [Track] {
        compactMap { if case .track(let t) = $0 { return t } else { return nil } }
    }
    
    var albums: [Album] {
        compactMap { if case .album(let a) = $0 { return a } else { return nil } }
    }
}
