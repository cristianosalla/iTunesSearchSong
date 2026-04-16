//
//  TrackArtworkView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import SwiftUI

struct TrackArtworkView: View {

    let url: URL?
    let size: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            placeholderView
        }
        .frame(width: size, height: size)
        .cornerRadius(cornerRadius)
        .clipped()
    }

    @ViewBuilder
    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.ultraThinMaterial)
            .overlay(ProgressView())
    }
}
