//
//  SearchSongProtocol.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

protocol SearchSongProtocol: Sendable {
    func search(for term: String, limit: Int, offset: Int) async throws -> [Track]
}
