//
//  HomeViewItem.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 10/04/26.
//

import SwiftUI

struct HomeViewItem: View {

    let track: Track
    @Environment(Router.self) private var router

    init(_ track: Track) {
        self.track = track
    }

    var body: some View {
        HStack {
            TrackArtworkView(
                url: track.artworkURL600,
                size: AppConstants.Size.xxLarge,
                cornerRadius: AppConstants.Radius.medium
            )
            .padding(.trailing, AppConstants.Padding.small)

            TrackInfoView(
                title: track.trackName,
                subtitle: track.artistName,
                titleFont: .headline,
                subtitleFont: .subheadline
            )

            Spacer()
            menuButton
        }
    }

    var menuButton: some View {
        Menu {
            Button {
                router.navigate(to: .album(track))
            } label: {
                Text(AppStrings.viewAlbum.localized)
                AppSymbol.chevronRight.image
            }
        } label: {
            AppSymbol.ellipsis.image
                .font(.system(size: AppConstants.Size.xSmall, weight: .bold))
                .foregroundStyle(Color.darkElement)
                .frame(width: AppConstants.Size.mediumLarge, height: AppConstants.Size.mediumLarge)
                .contentShape(Rectangle())
        }
    }
}
