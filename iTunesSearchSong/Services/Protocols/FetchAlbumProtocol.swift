//
//  FetchAlbumProtocol.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

protocol FetchAlbumProtocol: Sendable {
    func fetchAlbum(collectionId id: Int) async throws -> Album
}
