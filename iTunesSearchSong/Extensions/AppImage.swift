//
//  Image+Extension.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import SwiftUI

enum AppImage: String {
    case musicalNote = "musical_note"
    case magnifyingGlass = "magnifying_glass"
    case backward = "backward"
    case forward = "forward"
    case repeatIcon = "repeat"
    
    var image: Image {
        Image(self.rawValue)
    }
}

enum AppSymbol: String {
    case play = "play.fill"
    case pause = "pause.fill"
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case ellipsis
    case listBullet = "list.bullet"
    case circleFill = "circle.fill"
    case errorCircle = "exclamationmark.circle"
    case musicNote = "music.note"
    
    var image: Image {
        Image(systemName: self.rawValue)
    }
}
