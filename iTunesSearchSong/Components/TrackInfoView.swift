//
//  TrackInfoView.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import SwiftUI

struct TrackInfoView: View {

    let title: String
    let subtitle: String
    let titleFont: Font
    let subtitleFont: Font
    var titleColor: Color = .primaryWhite
    var subtitleColor: Color = .darkText
    var spacing: CGFloat? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: spacing ?? AppConstants.Spacing.xSmall) {
            Text(title)
                .font(titleFont)
                .foregroundStyle(titleColor)
            Text(subtitle)
                .font(subtitleFont)
                .foregroundStyle(subtitleColor)
        }
    }
}
