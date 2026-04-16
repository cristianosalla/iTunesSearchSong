//
//  Color+Extension.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double((rgbValue & 0x0000FF)) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
    static let primaryWhite = Color(hex: "#FFFFFF")
    static let darkText = Color(hex: "737373")
    static let darkElement = Color(hex: "545454")
    static let gradientCian = Color(hex: "#0086A0")
}
