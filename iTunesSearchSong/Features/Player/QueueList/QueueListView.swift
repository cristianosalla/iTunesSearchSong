//
//  QueueListView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//


import SwiftUI

struct QueueListView: View {

    let tracks: [Track]
    @Binding var selectedTrack: Track
    @Binding var trackIndex: Int

    var body: some View {
        List {
            ForEach(Array(tracks.enumerated()), id: \.element) { item in
                QueueItemView(
                    track: item.element,
                    isSelected: item.element == selectedTrack,
                    onTap: {
                        selectedTrack = item.element
                        trackIndex = item.offset
                    }
                )
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: AppConstants.Padding.xxSmall,
                        leading: AppConstants.Padding.small,
                        bottom: AppConstants.Padding.xxSmall,
                        trailing: AppConstants.Padding.small
                    )
                )
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
