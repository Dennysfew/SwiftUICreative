//
//  TextAnimationsView.swift
//

import SwiftUI

struct TextAnimationsView: View {
    let items = ["Buttons", "Text", "Images", "Cards", "Forms"] // Items to display in animation
    let colors: [Color] = [.blue, .indigo, .red, .cyan, .yellow] // Corresponding colors for each item

    @State private var currentIndex = 0 // Tracks the current visible item

    @State private var activeAnimation: AnimationType = .scale // Active animation type; starts with default scale animation

    var body: some View {
        VStack(spacing: 30) {
            // Row for each animation with its toggle and animated view
            animationRow(title: "Scale Animation", animationType: .scale)
            animationRow(title: "Slide Animation", animationType: .slide)
            animationRow(title: "Rotation Animation", animationType: .rotation)
            animationRow(title: "Move Up/Down Animation", animationType: .moveUpDown)
        }
        .padding()
        .onAppear {
            startAnimation(for: .scale) // Automatically start the default animation on load
        }
        .onDisappear {
            stopAnimation() // Stop all animations when the view disappears
        }
    }

    /// Creates a reusable row for toggling and previewing animations
    @ViewBuilder
    private func animationRow(title: String, animationType: AnimationType) -> some View {
        VStack {
            // Toggle to activate the animation
            Toggle(isOn: Binding(
                get: { activeAnimation == animationType },
                set: { isActive in
                    if isActive {
                        setActiveAnimation(animationType)
                    }
                }
            )) {
                Text(title)
                    .font(.headline)
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))

            // Animated view if the animation is active; otherwise, show default view
            if activeAnimation == animationType {
                AnimatedContainerView(
                    items: items,
                    colors: colors,
                    currentIndex: $currentIndex,
                    animationType: animationType
                )
                .frame(width: 150, height: 30)
            } else {
                Text(items.first ?? "") // Default static view
                    .bold()
                    .foregroundColor(.gray)
                    .frame(width: 150, height: 30)
            }
        }
    }

    /// Activates the selected animation, stopping any previously active animation
    private func setActiveAnimation(_ animationType: AnimationType) {
        stopAnimation() // Ensure only one animation runs at a time
        activeAnimation = animationType
        startAnimation(for: animationType)
    }

    /// Starts the animation loop for the given animation type
    private func startAnimation(for animationType: AnimationType) {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in // Timer with delay for smooth animation
            withAnimation(.easeInOut(duration: 1)) { // Smooth easing animation
                currentIndex = (currentIndex + 1) % items.count
            }

            // Stop the timer if the animation type is no longer active
            if activeAnimation != animationType {
                timer.invalidate()
            }
        }
    }

    /// Stops the currently running animation
    private func stopAnimation() {
        activeAnimation = .none
    }
}

#Preview {
    TextAnimationsView()
}
