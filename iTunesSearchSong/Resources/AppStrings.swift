//
//  AppStrings.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import SwiftUI

enum AppStrings: String, CaseIterable {

    case homeTitle = "Songs"
    case searchPlaceholder = "Search your library"
    case viewAlbum = "View album"
    case error = "Error"
    case unableToLoadAlbum = "Unable to load album"
    case emptySearchTitle = "No songs to list"
    case emptySearchSubtitle = "Type a song, artist, or album name to get started"
    case errorTitle = "Something went wrong"
    case errorDescription = "Error while searching for songs"
        
    var localized: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
}
