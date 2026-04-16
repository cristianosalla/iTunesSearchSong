//
//  iTunesSearchSongApp.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 09/04/26.
//

import SwiftUI
import SwiftData
import Combine

@main
struct iTunesSearchSongApp: App {
    @State private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(router)
                .preferredColorScheme(.dark)
        }
    }
}
