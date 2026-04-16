//
//  AlbumViewModel.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 10/04/26.
//

import Combine
import Foundation

@Observable
class AlbumViewModel {
    
    var album: Album?
    var collectionId: Int
    
    private(set) var state: State = .loading
    
    enum State {
        case loading
        case loaded
        case failed
    }
    
    private var albumClient: FetchAlbumProtocol
    
    init(collectionId: Int, albumClient: FetchAlbumProtocol = iTunesAPI()) {
        self.collectionId = collectionId
        self.albumClient = albumClient
    }
    
    @MainActor
    func fetchAlbum() async {
        state = .loading
        do {
            let response = try await albumClient.fetchAlbum(collectionId: collectionId)
            album = response
            state = .loaded
        } catch {
            state = .failed
        }
    }
    
    var collectionName: String {
        album?.collectionName ?? ""
    }
    
    var artistName: String {
        album?.artistName ?? ""
    }
    
    var albumImageURL: URL? {
        album?.artworkURL600
    }
    
    var tracks: [Track] {
        album?.tracks ?? []
    }
}
