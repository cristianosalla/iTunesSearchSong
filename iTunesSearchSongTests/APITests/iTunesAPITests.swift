//
//  iTunesAPITests.swift
//  iTunesSearchSongTests
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import XCTest
@testable import iTunesSearchSong

@MainActor
final class iTunesAPITests: XCTestCase {
 
    var sut: iTunesAPI!
    
    override func setUp() async throws {
        let client = MockClientJsonRequest()
        sut = iTunesAPI(client: client)
        try await super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_fetchAlbum() async {
        let client = MockClientJsonRequest()
        client.filename = "album_response"
        sut = iTunesAPI(client: client)
        
        let album = try? await sut.fetchAlbum(collectionId: 1)
        
        XCTAssertEqual(album?.tracks?.count, 2)
        XCTAssertEqual(album?.artistName, "Bruno Mars")
        XCTAssertNotNil(album)
    }
    
    func test_searchResponse() async {
        let client = MockClientJsonRequest()
        client.filename = "search_response"
        sut = iTunesAPI(client: client)
        
        let search = try? await sut.search(for: "Bruno Mars", limit: 1, offset: 1)
        
        XCTAssertEqual(search?.count, 3)
        XCTAssertNotNil(search)
    }
    
}

