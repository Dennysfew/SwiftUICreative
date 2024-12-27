//
//  AnimatedContainerView.swift
//

import SwiftUI

// A container view that animates text items based on the selected animation type
struct AnimatedContainerView: View {
    let items: [String] // Items to be displayed
    let colors: [Color] // Corresponding colors for each item
    @Binding var currentIndex: Int // Tracks the currently displayed item
    var animationType: AnimationType // Defines the type of animation to apply

    var body: some View {
        ZStack {
            // Displays only the current item with the selected animation
            ForEach(0..<items.count, id: \.self) { index in
                if index == currentIndex {
                    Text(items[index])
                        .bold()
                        .foregroundColor(colors[index])
                        .transition(CustomTransitions.transition(for: animationType))
                }
            }
        }
        .clipped() // Ensures the view does not overflow its bounds
    }
}
