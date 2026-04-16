//
//  Double+Extension.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import Foundation

extension Double {
    var formattedTime: String {
        let mins = Int(self) / 60
        let secs = Int(self) % 60
        return String(format: "%d:%02d", mins, secs)
    }
}
