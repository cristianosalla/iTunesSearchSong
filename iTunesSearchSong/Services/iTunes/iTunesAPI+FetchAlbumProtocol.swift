//
//  iTunesAPI+SearchSongProtocol.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import Foundation

extension iTunesAPI: FetchAlbumProtocol {
    func fetchAlbum(collectionId id: Int) async throws -> Album {
        guard let url = iTunesEndpoint.album(collectionId: id).url else {
            throw AppError.invalidURL
        }
        
        let response: iTunesResponse = try await client.request(url: url)
        var album = response.results.albums.first
        album?.tracks = response.results.tracks
        guard let album else { throw AppError.albumNotFound }
        return album
    }
}
