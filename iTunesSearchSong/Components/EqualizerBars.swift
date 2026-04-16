//
//  EqualizerBars.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import SwiftUI

struct EqualizerBars: View {
    @State private var animating = false
    
    let durations: [Double] = [0.4, 0.55, 0.35, 0.48, 0.6]
    let heights: [CGFloat] = [18, 6, 12, 3, 18]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.primaryWhite)
                    .frame(width: 1.5, height: animating ? heights[index] : 1)
                    .animation(
                        .easeInOut(duration: durations[index])
                        .repeatForever(autoreverses: true)
                        .delay(durations[index] * 0.3),
                        value: animating
                    )
            }
        }
        .frame(height: 48, alignment: .center)
        .onAppear {
            animating = true
        }
    }
}
