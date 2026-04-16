//
//  iTunesAPI+SearchSongProtocol.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import Foundation

extension iTunesAPI: SearchSongProtocol {
    func search(for term: String, limit: Int, offset: Int) async throws -> [Track] {
        guard let url = iTunesEndpoint.search(term: term).url else {
            throw AppError.invalidURL
        }
        
        let response: iTunesResponse = try await client.request(url: url)
        return response.results.tracks
    }
}

