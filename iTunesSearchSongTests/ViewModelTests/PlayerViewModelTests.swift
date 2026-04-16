//
//  PlayerViewModel.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import XCTest
@testable import iTunesSearchSong

@MainActor
final class PlayerViewModelTests: XCTestCase {
    
    var sut: PlayerViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        sut = PlayerViewModel()
    }
    
    override func tearDown() async throws {
        sut = nil
        try await super.tearDown()
    }
    
    private func audioURL() -> String {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "audioTest", withExtension: "m4a") else {
            return ""
        }
        
        return url.absoluteString
    }
    
    func test_load_validURL_shouldCreatePlayer() {
        sut.load(url: audioURL())
        
        XCTAssertEqual(sut.currentTime, 0)
        XCTAssertEqual(sut.duration, 0)
        XCTAssertFalse(sut.isPlaying)
    }
    
    func test_load_invalidURL_shouldNotCrash() {
        let url = ""
        
        sut.load(url: url)
        
        XCTAssertEqual(sut.currentTime, 0)
        XCTAssertFalse(sut.isPlaying)
    }
    
    func test_reload_shouldReloadPlayer() async throws {
        sut.reload(url: audioURL(), keepPlaying: true)
        
        XCTAssertEqual(sut.currentTime, 0)
        XCTAssertEqual(sut.duration, 0)
        XCTAssertTrue(sut.isPlaying)
    }
    
    func test_togglePlayback_whenNotPlaying_shouldPlay() {
        sut.load(url: audioURL())
        XCTAssertFalse(sut.isPlaying)
        
        sut.togglePlayback()
        
        XCTAssertTrue(sut.isPlaying)
    }
    
    func test_togglePlayback_whenPlaying_shouldPause() {
        sut.load(url: audioURL())
        sut.togglePlayback()
        XCTAssertTrue(sut.isPlaying)
        
        sut.togglePlayback()
        
        XCTAssertFalse(sut.isPlaying)
    }
    
    @MainActor
    func test_cleanup_shouldResetAllState() {
        sut.load(url: audioURL())
        sut.reload(url: audioURL(), keepPlaying: true)
        sut.currentTime = 15.0
        sut.duration = 30.0
        
        sut.cleanup()
        
        XCTAssertEqual(sut.currentTime, 0)
        XCTAssertEqual(sut.duration, 0)
        XCTAssertFalse(sut.isPlaying)
    }
    
    @MainActor func test_onNext_canBeSet() {
        var called = false
        sut.onNext = { called = true }
        
        sut.onNext?()
        
        XCTAssertTrue(called)
    }
    
    @MainActor
    func test_handleTrackEnd_shouldGoToNext() async {
        sut.load(url: audioURL())
        
        let expectation = XCTestExpectation(description: "Should go to next song")
        sut.onNext = {
            expectation.fulfill()
        }
        
        sut.handleTrackEnd()
        sut.seek(to: 29)
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    @MainActor
    func test_handleTrackEnd_shouldRepeatSong() async {
        sut.load(url: audioURL())
        sut.isRepeating = true
        
        sut.handleTrackEnd()
        
        XCTAssertTrue(sut.isPlaying)
        XCTAssertLessThan(sut.currentTime, 3)
    }
    
}
