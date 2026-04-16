//
//  AlbumView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 10/04/26.
//

import SwiftUI

struct AlbumView: View {

    @State private var viewModel: AlbumViewModel
    @Environment(Router.self) private var router

    init(collectionId: Int) {
        _viewModel = State(wrappedValue: AlbumViewModel(collectionId: collectionId))
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingView
            case .loaded:
                content
            case .failed:
                errorView
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(.top, AppConstants.Offset.mediumLarge)
        .padding(.leading, AppConstants.Offset.medium)
        .toolbar { backButton }
        .task { await loadAlbum() }
    }

    var content: some View {
        VStack {
            albumHeader
            trackList
                .padding(.leading, AppConstants.Offset.negativeSmall)
        }
    }

    var albumHeader: some View {
        HStack {
            TrackArtworkView(
                url: viewModel.albumImageURL,
                size: AppConstants.Size.huge,
                cornerRadius: AppConstants.Radius.large,
            )

            TrackInfoView(
                title: viewModel.collectionName,
                subtitle: viewModel.artistName,
                titleFont: .system(size: AppConstants.FontSize.xLargeTitle, weight: .bold),
                subtitleFont: .system(size: AppConstants.FontSize.title1, weight: .medium),
                titleColor: .primaryWhite,
                subtitleColor: .primaryWhite
            )
            .padding(.horizontal, AppConstants.Padding.xLarge)

            Spacer()
        }
        .padding(.bottom, AppConstants.Padding.xxxLarge)
    }

    var trackList: some View {
        List(viewModel.tracks) { track in
            trackRow(track)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }

    private func trackRow(_ track: Track) -> some View {
        HStack {
            TrackArtworkView(
                url: URL(string: track.artworkUrl100),
                size: AppConstants.Size.xxLarge,
                cornerRadius: AppConstants.Radius.medium
            )

            TrackInfoView(
                title: track.trackName,
                subtitle: track.artistName,
                titleFont: .system(size: AppConstants.FontSize.title2, weight: .medium),
                subtitleFont: .system(size: AppConstants.FontSize.subheadline)
            )
            .padding(.horizontal, AppConstants.Padding.large)

            Spacer()
        }
    }

    var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button { router.goBack() } label: {
                AppSymbol.chevronLeft.image
            }
            .buttonStyle(.plain)
        }
    }

    private func loadAlbum() async {
        await viewModel.fetchAlbum()
    }

    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    var errorView: some View {
        VStack(spacing: AppConstants.Spacing.medium) {
            AppSymbol.errorCircle.image
                .font(.system(size: AppConstants.Size.medium))
                .foregroundStyle(.secondary)

            Text(AppStrings.unableToLoadAlbum.localized)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
