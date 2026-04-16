//
//  HomeViewExtension.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 15/04/26.
//

import SwiftUI

extension HomeView {
    
    // MARK: Error View
    
    var errorView: some View {
        VStack(spacing: AppConstants.Spacing.medium) {
            AppSymbol.errorCircle.image
                .font(.system(size: AppConstants.FontSize.largeTitle))
                .foregroundStyle(.red)

            VStack(spacing: AppConstants.Spacing.xSmall) {
                Text(AppStrings.errorTitle.localized)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(AppStrings.errorDescription.localized)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, AppConstants.Padding.xLarge)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Empty View
    
    var emptyView: some View {
        VStack(spacing: AppConstants.Spacing.medium) {
            AppSymbol.musicNote.image
                .font(.system(size: AppConstants.FontSize.largeTitle))
                .foregroundStyle(.secondary)

            VStack(spacing: AppConstants.Spacing.xSmall) {
                Text(AppStrings.emptySearchTitle.localized)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(AppStrings.emptySearchSubtitle.localized)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, AppConstants.Padding.xLarge)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Loading View
    
    var loadingView: some View {
        VStack(spacing: AppConstants.Spacing.medium) {
            ProgressView()
                .controlSize(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
