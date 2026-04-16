//
//  MockAPI.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import Foundation
@testable import iTunesSearchSong

class MockAPI: MockClientObjectResponse, @unchecked Sendable {
    override init(response: Any) {
        super.init(response: response)
    }
}

extension MockAPI: FetchAlbumProtocol {
    func fetchAlbum(collectionId id: Int) async throws -> Album {
        guard let url = URL(string: "http://test.com") else { throw AppError.invalidURL }
        let data: Album = try await request(url: url)
        return data
    }
}

extension MockAPI: SearchSongProtocol {
    func search(for term: String, limit: Int, offset: Int) async throws -> [Track] {
        guard let url = URL(string: "http://test.com") else { throw AppError.invalidURL }
        let data: [Track] = try await request(url: url)
        return data
    }
}
