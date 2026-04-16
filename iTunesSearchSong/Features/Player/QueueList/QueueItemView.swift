//
//  QueueItemView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//


import SwiftUI

struct QueueItemView: View {

    let track: Track
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppConstants.Spacing.medium) {
                TrackArtworkView(
                    url: URL(string: track.artworkUrl60),
                    size: AppConstants.Size.large,
                    cornerRadius: AppConstants.Radius.small
                )

                TrackInfoView(
                    title: track.trackName,
                    subtitle: track.artistName,
                    titleFont: .system(size: AppConstants.FontSize.body, weight: .medium),
                    subtitleFont: .system(size: AppConstants.FontSize.caption)
                )

                Spacer()

                if isSelected {
                    EqualizerBars()
                }
            }
            .frame(height: AppConstants.Size.xLarge)
        }
    }
}
