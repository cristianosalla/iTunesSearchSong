//
//  AppConstants.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import CoreFoundation

enum AppConstants {

    // MARK: - Padding

    enum Padding {
        static let xxSmall: CGFloat = 2
        static let xSmall: CGFloat = 8
        static let small: CGFloat = 12
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let xLarge: CGFloat = 34
        static let xxLarge: CGFloat = 40
        static let xxxLarge: CGFloat = 42
    }

    // MARK: - Offset

    enum Offset {
        static let negativeSmall: CGFloat = -20
        static let small: CGFloat = 24
        static let medium: CGFloat = 40
        static let mediumLarge: CGFloat = 43
        static let large: CGFloat = 45
        static let xLarge: CGFloat = 57
        static let xxLarge: CGFloat = 69
    }

    // MARK: - Radius

    enum Radius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 20
        static let xLarge: CGFloat = 40
    }

    // MARK: - Size

    enum Size {
        static let xxSmall: CGFloat = 22
        static let xSmall: CGFloat = 24
        static let small: CGFloat = 28
        static let smallMedium: CGFloat = 35
        static let medium: CGFloat = 40
        static let mediumLarge: CGFloat = 44
        static let large: CGFloat = 52
        static let xLarge: CGFloat = 68
        static let xxLarge: CGFloat = 78
        static let xxxLarge: CGFloat = 80
        static let huge: CGFloat = 120
        static let xHuge: CGFloat = 256
        static let xxHuge: CGFloat = 286
    }

    // MARK: - Spacing

    enum Spacing {
        static let xSmall: CGFloat = 4
        static let small: CGFloat = 12
        static let medium: CGFloat = 16
        static let large: CGFloat = 40
    }

    // MARK: - Opacity

    enum Opacity {
        static let full: Double = 1.0
        static let medium: Double = 0.7
        static let light: Double = 0.6
    }

    // MARK: - FontSize

    enum FontSize {
        static let caption: CGFloat = 12
        static let body: CGFloat = 16
        static let subheadline: CGFloat = 18
        static let title3: CGFloat = 20
        static let title2: CGFloat = 24
        static let title1: CGFloat = 28
        static let largeTitle: CGFloat = 40
        static let xLargeTitle: CGFloat = 56
    }
}
