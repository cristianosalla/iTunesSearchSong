//
//  PlayerViewModel.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import AVFoundation
import SwiftUI

@Observable
@MainActor
class PlayerViewModel {
    
    private enum Constants {
        static let timerInterval: Double = 0.05
        static let endThreshold: Double = 0.1
        static let preferredTimescale: CMTimeScale = 600
    }
    
    // MARK: - Published State
    
    var currentTime: Double = 0
    var duration: Double = 0
    var isPlaying = false
    var isRepeating = false
    var isDragging = false
    
    // MARK: - Private
    
    private var player: AVPlayer?
    private var timer: Timer?
    var onNext: (() -> Void)?
    
    // MARK: - Setup
    
    func load(url: String) {
        cleanup()
        createPlayer(url: url)
        startTimer()
    }
    
    func reload(url: String, keepPlaying: Bool) {
        let wasPlaying = isPlaying
        cleanup()
        createPlayer(url: url)
        startTimer()
        
        if wasPlaying || keepPlaying {
            player?.play()
            isPlaying = true
        }
    }
    
    private func createPlayer(url: String) {
        guard let url = URL(string: url) else { return }
        player = AVPlayer(playerItem: AVPlayerItem(url: url))
    }
    
    // MARK: - Controls
    
    func togglePlayback() {
        isPlaying ? player?.pause() : player?.play()
        isPlaying.toggle()
    }
    
    func seek(to time: Double) {
        player?.seek(to: CMTime(seconds: time, preferredTimescale: Constants.preferredTimescale))
    }
    
    // MARK: - Timer

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timerInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.updatePlaybackTime()
            }
        }
    }

    private func updatePlaybackTime() {
        guard let player, !isDragging else { return }
        
        let time = player.currentTime().seconds
        let dur = player.currentItem?.duration.seconds ?? .zero
        
        currentTime = time
        if !dur.isNaN { duration = dur }
        
        if !dur.isNaN && time >= dur - Constants.endThreshold {
            handleTrackEnd()
        }
    }
    
    func handleTrackEnd() {
        if isRepeating {
            player?.seek(to: .zero)
            player?.play()
            isPlaying = true
        } else {
            onNext?()
        }
    }
    
    // MARK: - Cleanup
    
    func cleanup() {
        timer?.invalidate()
        timer = nil
        
        player?.pause()
        player?.currentItem?.asset.cancelLoading()
        player?.replaceCurrentItem(with: nil)
        player = nil
        
        currentTime = .zero
        duration = .zero
        isPlaying = false
    }
}
