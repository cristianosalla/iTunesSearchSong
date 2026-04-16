//
//  HomeView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 09/04/26.
//

import SwiftUI

struct HomeView: View {

    private enum Constants {
        static let debounceSeconds: Double = 2
    }

    @State private var searchText = ""
    @State private var searchTask: Task<Void, Never>?
    @State private var viewModel = HomeViewModel()

    @Environment(Router.self) private var router

    var body: some View {
        @Bindable var router = router

        NavigationStack(path: $router.path) {
            VStack(spacing: .zero) {
                searchBar
                contentView
            }
            .navigationTitle(AppStrings.homeTitle.localized)
            .navigationDestination(for: Route.self) { route in
                destinationView(for: route)
            }
        }
        .onChange(of: searchText) { _, _ in debounceSearch() }
    }

    var searchBar: some View {
        HStack(spacing: AppConstants.Spacing.small) {
            AppImage.magnifyingGlass.image
                .foregroundStyle(.gray)

            TextField(AppStrings.searchPlaceholder.localized, text: $searchText)
                .autocorrectionDisabled()
        }
        .padding(AppConstants.Padding.small)
        .background(.ultraThinMaterial)
        .cornerRadius(AppConstants.Radius.medium)
        .padding(.horizontal, AppConstants.Padding.medium)
        .padding(.vertical, AppConstants.Padding.xSmall)
    }

    @ViewBuilder
    var contentView: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .loaded:
            songList
        case .failed:
            errorView
        case .empty:
            emptyView
        }
    }
    
    @ViewBuilder
    var songList: some View {
        List(Array(viewModel.songs.enumerated()), id: \.element) { item in
            songRow(item: item)
        }
        .listStyle(.plain)
    }

    private func songRow(item: EnumeratedSequence<[Track]>.Element) -> some View {
        ZStack {
            NavigationLink(value: Route.player(item.offset)) {
                EmptyView()
            }
            .opacity(.zero)

            HomeViewItem(item.element)
        }
        .listRowSeparator(.hidden)
        .padding(.trailing, AppConstants.Padding.medium)
        .onAppear { loadMoreIfNeeded(item.element) }
    }

    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .player(let index):
            if viewModel.songs.indices.contains(index) {
                PlayerSplitView(
                    tracks: viewModel.songs,
                    selectedTrack: viewModel.songs[index],
                    trackIndex: index
                )
            }
        case .album(let track):
            AlbumView(collectionId: track.collectionId)
        }
    }

    private func loadMoreIfNeeded(_ track: Track) {
        guard track == viewModel.songs.last else { return }
        Task {
            try? await viewModel.searchMore(query: searchText)
        }
    }

    private func debounceSearch() {
        searchTask?.cancel()
        searchTask = Task { @MainActor in
            do {
                try await Task.sleep(for: .seconds(Constants.debounceSeconds))
                try await viewModel.search(query: searchText)
            } catch { }
        }
    }
}
