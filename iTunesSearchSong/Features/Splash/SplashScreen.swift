//
//  SplashScreen.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 10/04/26.
//


import SwiftUI

struct SplashScreen: View {

    private enum Constants {
        static let initialScale: CGFloat = 0.8
        static let finalScale: CGFloat = 1.0
        static let animationDuration: Double = 0.8
        static let splashDuration: Double = 3.0
        static let gradientOpacity: Double = 0.3
    }

    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var scale = Constants.initialScale

    var body: some View {
        if isActive {
            HomeView()
        } else {
            splash
                .onAppear { animate() }
        }
    }

    var splash: some View {
        ZStack {
            background
            logo
        }
    }

    var background: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GeometryReader { geo in
                RadialGradient(
                    colors: [Color.gradientCian.opacity(Constants.gradientOpacity), .clear],
                    center: .topLeading,
                    startRadius: .zero,
                    endRadius: geo.size.height
                )
            }
            .ignoresSafeArea()
        }
    }

    var logo: some View {
        AppImage.musicalNote.image
            .frame(width: AppConstants.Size.xHuge, height: AppConstants.Size.xHuge)
            .scaleEffect(scale)
            .opacity(opacity)
    }

    private func animate() {
        withAnimation(.easeOut(duration: Constants.animationDuration)) {
            opacity = Constants.finalScale
            scale = Constants.finalScale
        }

        Task {
            try? await Task.sleep(for: .seconds(Constants.splashDuration))
            isActive = true
        }
    }
}
