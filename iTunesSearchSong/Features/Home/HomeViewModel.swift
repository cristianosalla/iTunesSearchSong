//
//  HomeViewModel.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 10/04/26.
//

import Combine
import Foundation

@Observable
class HomeViewModel {

    private(set) var songs: [Track] = []
    private(set) var state: State = .empty
    
    enum State {
        case loading
        case loaded
        case failed
        case empty
    }

    private let searchAPI: SearchSongProtocol
    private let limit = 40
    private var offset = 0
    private var canLoadMore = true
    
    init(searchAPI: SearchSongProtocol = iTunesAPI()) {
        self.searchAPI = searchAPI
    }
    
    @MainActor
    func search(query: String) async throws {
        state = .loading
        offset = .zero
        canLoadMore = true
        
        do {
            let response = try await searchAPI.search(for: query, limit: limit, offset: offset)
            songs = response
            offset = 1
            canLoadMore = response.count == limit
            state = response.count > 0 ? .loaded : .empty
        } catch {
            state = .failed
        }
    }
    
    /*
     
     Note:
     The iTunes Search API does not support true pagination.
     All matching results are returned in the first query up to the given limit.
     This method is kept as a structural placeholder to support pagination if the API
     is replaced with one that does.
     
     */
    @MainActor
    func searchMore(query: String) async throws {
        guard canLoadMore else { return }

        let response = try await searchAPI.search(for: query, limit: limit, offset: offset)
        songs.append(contentsOf: response)
        offset += 1
        canLoadMore = response.count == limit
    }
}
