//
//  AlbumViewModelTests.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import XCTest
@testable import iTunesSearchSong

@MainActor
final class AlbumViewModelTests: XCTestCase {
    
    var sut: AlbumViewModel!
    
    override func setUp() async throws {
        try await super.setUp()

        let mockAPI = MockAPI(response: createAlbum())
        sut = AlbumViewModel(collectionId: 1, albumClient: mockAPI)
    }
    
    override func tearDown() async throws {
        sut = nil
        try await super.tearDown()
    }
        
    func test_albumShouldBeNil() async {
        await sut.fetchAlbum()
        
        XCTAssertEqual(sut.album?.collectionId, 1)
    }
  
    func test_trackListNotEmpty() async {
        await sut.fetchAlbum()
        
        XCTAssertFalse(sut.tracks.isEmpty)
    }
    
    func test_collectionName_withAlbum_shouldReturnName() async throws {
        await sut.fetchAlbum()
        
        XCTAssertEqual(sut.collectionName, "Collection Name")
    }
    
    func test_collectionName_withoutAlbum_shouldReturnEmpty() async throws {
        sut.album = nil
        
        XCTAssertEqual(sut.collectionName, "")
    }
    
    func test_artistName_withoutAlbum_shouldReturnArtist() async throws {
        await sut.fetchAlbum()
        
        XCTAssertEqual(sut.artistName, "Album Artist Name")
    }
    
    func test_artistName_withoutAlbum_shouldReturnNil() async throws {
        sut.album = nil

        XCTAssertEqual(sut.artistName, "")
    }
    
    func test_albumImageURL_withAlbum_shouldReturnURL() async throws {
        await sut.fetchAlbum()
        
        XCTAssertNotNil(sut.albumImageURL)
    }

    func test_albumImageURL_withoutAlbum_shouldReturnNil() {
        sut.album = nil
        
        XCTAssertNil(sut.albumImageURL)
    }
    
    func test_tracks_withAlbum_shouldReturnTracks() async throws {
        await sut.fetchAlbum()
        
        XCTAssertEqual(sut.tracks.count, 3)
        XCTAssertEqual(sut.tracks.first?.trackName, "First track")
        XCTAssertEqual(sut.tracks.last?.trackName, "Third track")
    }

    func test_tracks_withoutAlbum_shouldReturnEmpty() {
        sut.album = nil
        
        XCTAssertTrue(sut.tracks.isEmpty)
    }
    
    func test_fetchAlbum_shouldStartWithLoading() async {
        sut = AlbumViewModel(collectionId: 1)
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_fetchAlbum_success_shouldBeLoaded() async {
        await sut.fetchAlbum()
        
        XCTAssertEqual(sut.state, .loaded)
    }
    
    func test_fetchAlbum_failure_shouldBeFailed() async {
        let mockAPI = MockAPI(response: "invalid")
        sut = AlbumViewModel(collectionId: -1, albumClient: mockAPI)
        
        await sut.fetchAlbum()
        
        XCTAssertEqual(sut.state, .failed)
        XCTAssertNil(sut.album)
    }
    
    private func createAlbum() -> Album {
        let tracks = [
            Track(collectionId: 1, trackId: 1, artistName: "Artist Name", trackName: "First track", previewUrl: "", artworkUrl60: "", artworkUrl100: ""),
            Track(collectionId: 1, trackId: 2, artistName: "Artist Name", trackName: "Second track", previewUrl: "", artworkUrl60: "", artworkUrl100: ""),
            Track(collectionId: 1, trackId: 3, artistName: "Artist Name", trackName: "Third track", previewUrl: "", artworkUrl60: "", artworkUrl100: "")
        ]
        
        var album = Album(collectionId: 1, artworkUrl100: "http://image.url", collectionName: "Collection Name", artistName: "Album Artist Name")
        album.tracks = tracks
        return album
    }
}
