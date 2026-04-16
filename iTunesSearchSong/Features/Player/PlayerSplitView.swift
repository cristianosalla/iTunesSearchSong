//
//  PlayerSplitView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 11/04/26.
//

import SwiftUI

struct PlayerSplitView: View {
    let tracks: [Track]
    @State var selectedTrack: Track
    @State var trackIndex: Int
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var preferredColumn: NavigationSplitViewColumn = .detail

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility, preferredCompactColumn: $preferredColumn) {
            QueueListView(
                tracks: tracks,
                selectedTrack: $selectedTrack,
                trackIndex: $trackIndex
            )
            .environment(\.layoutDirection, .leftToRight)
        } detail: {
            PlayerView(
                track: $selectedTrack,
                onNext: { goToNextTrack() },
                onPrevious: { goToPreviousTrack() }
            )
            .environment(\.layoutDirection, .leftToRight)
        }
        .navigationBarBackButtonHidden(true)
        .environment(\.layoutDirection, .rightToLeft)
    }
    
    private func goToNextTrack() {
        if trackIndex < tracks.count - 1 {
            trackIndex += 1
            selectedTrack = tracks[trackIndex]
        }
    }
    
    private func goToPreviousTrack() {
        if trackIndex > 0 {
            trackIndex -= 1
            selectedTrack = tracks[trackIndex]
        }
    }
}


