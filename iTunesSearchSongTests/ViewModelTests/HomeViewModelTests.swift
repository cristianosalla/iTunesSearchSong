//
//  HomeViewModelTests.swift
//  iTunesSearchSongTests
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import XCTest
@testable import iTunesSearchSong

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    var mockAPI: MockAPI!
    
    override func tearDown() async throws {
        sut = nil
        mockAPI = nil
        try await super.tearDown()
    }
    
    @MainActor
    func test_search_success() async {
        let response = makeTracks(count: 3)
        mockAPI = MockAPI(response: response)
        sut = HomeViewModel(searchAPI: mockAPI)
        
        do {
           try await sut.search(query: "test")
            XCTAssertFalse(sut.songs.isEmpty, "Array should not be empty")
        } catch {
            XCTFail("Search response should not fail")
        }
    }
    
    func test_search_empty() async {
        let response: [Track] = []
        
        mockAPI = MockAPI(response: response)
        sut = HomeViewModel(searchAPI: mockAPI)
        
        do {
           try await sut.search(query: "test")
            XCTAssertTrue(sut.songs.isEmpty, "Array should be empty")
        } catch {
            XCTFail("Search response should not fail")
        }
        
    }
    
    func test_search_error() async {
        let response = "Wrong response"
        
        mockAPI = MockAPI(response: response)
        sut = HomeViewModel(searchAPI: mockAPI)
        
        do {
           try await sut.search(query: "test")
        } catch {
            XCTAssertNotNil(error, "Should return an error")
            XCTAssertTrue(sut.songs.isEmpty, "Array should be empty")
        }
    }

    private func makeTracks(count: Int, startingId: Int = 1) -> [Track] {
        (startingId..<startingId + count).map { id in
            Track(
                collectionId: id,
                trackId: id,
                artistName: "Artist \(id)",
                trackName: "Track \(id)",
                previewUrl: "",
                artworkUrl60: "",
                artworkUrl100: ""
            )
        }
    }
}
