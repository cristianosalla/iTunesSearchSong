//
//  PlayerView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 10/04/26.
//

import SwiftUI
import AVKit

struct PlayerView: View {

    private enum Constants {
        static let compactHeightThreshold: CGFloat = 600
        static let smallWindowThreshold: CGFloat = 500
    }

    @Binding var track: Track
    var onNext: (() -> Void)
    var onPrevious: (() -> Void)

    @State private var viewModel = PlayerViewModel()
    @Environment(Router.self) private var router

    // MARK: - Body

    var body: some View {
        playerContent
            .padding(.horizontal, AppConstants.Padding.xxLarge)
            .padding(.bottom, AppConstants.Offset.large)
            .onAppear {
                viewModel.onNext = onNext
                viewModel.load(url: track.previewUrl)
            }
            .onChange(of: track) { _, _ in
                viewModel.reload(url: track.previewUrl, keepPlaying: viewModel.isPlaying)
            }
            .onDisappear { viewModel.cleanup() }
            .toolbar { backButton }
            .toolbar { menuButton }
    }

    // MARK: - Layout

    private var playerContent: some View {
        GeometryReader { geometry in
            let compact = geometry.size.height < Constants.compactHeightThreshold
            let window = geometry.size.height < Constants.smallWindowThreshold

            VStack(alignment: .leading) {
                Spacer()

                if !window {
                    albumImage
                        .padding(.top, AppConstants.Offset.xLarge)
                        .frame(maxHeight: .infinity, alignment: .center)
                }

                trackInfo
                    .padding(.top, compact ? AppConstants.Padding.small : AppConstants.Offset.xxLarge)
                slider
                controls

                if compact { Spacer() }
            }
        }
    }

    // MARK: - Album Image

    var albumImage: some View {
        TrackArtworkView(
            url: track.artworkURL600,
            size: AppConstants.Size.xxHuge,
            cornerRadius: AppConstants.Radius.xLarge
        )
        .frame(maxWidth: .infinity)
    }

    // MARK: - Track Info

    var trackInfo: some View {
        VStack(alignment: .leading, spacing: AppConstants.Spacing.xSmall) {
            Text(track.trackName)
                .font(.system(size: AppConstants.FontSize.largeTitle, weight: .bold))
                .foregroundStyle(Color.primaryWhite.opacity(AppConstants.Opacity.full))
            HStack {
                Text(track.artistName)
                    .font(.system(size: AppConstants.FontSize.title3))
                    .foregroundStyle(Color.primaryWhite.opacity(AppConstants.Opacity.medium))
                Spacer()
                repeatButton
            }
        }
    }

    var repeatButton: some View {
        Button { viewModel.isRepeating.toggle() } label: {
            AppImage.repeatIcon.image
                .frame(width: AppConstants.Size.xxSmall, height: AppConstants.Size.xxSmall)
                .tint(viewModel.isRepeating ? Color.primaryWhite.opacity(AppConstants.Opacity.full) : Color.primaryWhite.opacity(AppConstants.Opacity.medium))
        }
    }

    // MARK: - Slider

    var slider: some View {
        VStack {
            Slider(value: $viewModel.currentTime, in: 0...max(viewModel.duration, 1)) { editing in
                viewModel.isDragging = editing
                if !editing {
                    viewModel.seek(to: viewModel.currentTime)
                }
            }
            .tint(Color.primaryWhite.opacity(AppConstants.Opacity.light))
            .onAppear { configureSliderThumb() }

            HStack {
                Text(viewModel.currentTime.formattedTime)
                Spacer()
                Text("-" + (viewModel.duration - viewModel.currentTime).formattedTime)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .monospacedDigit()
        }
    }

    // MARK: - Controls

    var controls: some View {
        HStack(spacing: AppConstants.Spacing.large) {
            Button { onPrevious() } label: {
                AppImage.backward.image
                    .font(.system(size: AppConstants.Size.small))
            }

            Button { viewModel.togglePlayback() } label: {
                (viewModel.isPlaying ? AppSymbol.pause : AppSymbol.play).image
                    .font(.system(size: AppConstants.Size.smallMedium))
                    .frame(width: AppConstants.Size.xxxLarge, height: AppConstants.Size.xxxLarge)
            }
            .buttonStyle(GlassButtonStyle())
            .clipShape(Circle())

            Button { onNext() } label: {
                AppImage.forward.image
                    .font(.system(size: AppConstants.Size.small))
            }
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.primary)
        .padding(.top, AppConstants.Offset.small)
    }

    // MARK: - Toolbar

    var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button { router.goBack() } label: {
                AppSymbol.chevronLeft.image
            }
            .buttonStyle(.plain)
        }
    }

    var menuButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    router.navigate(to: .album(track))
                } label: {
                    Text(AppStrings.viewAlbum.localized)
                    AppSymbol.chevronRight.image
                }
            } label: {
                AppSymbol.ellipsis.image
                    .font(.title3)
            }
            .buttonStyle(GlassButtonStyle())
            .clipShape(Circle())
        }
    }

    private func configureSliderThumb() {
        let config = UIImage.SymbolConfiguration(pointSize: AppConstants.Size.xSmall)
        let thumbImage = UIImage(systemName: AppSymbol.circleFill.rawValue, withConfiguration: config)?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        UISlider.appearance().setThumbImage(thumbImage, for: .normal)
    }
}
