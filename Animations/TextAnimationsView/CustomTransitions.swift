//
//  CustomTransitions.swift
//

import SwiftUI

// Defines the types of animations available
enum AnimationType {
    case none
    case scale
    case slide
    case rotation
    case moveUpDown
}

// Provides custom transitions based on the animation type
struct CustomTransitions {
    static func transition(for animationType: AnimationType) -> AnyTransition {
        switch animationType {
        case .scale:
            // Scale animation with opacity transition
            return AnyTransition.asymmetric(
                insertion: .scale(scale: 0, anchor: .center).combined(with: .opacity),
                removal: .scale(scale: 0.1, anchor: .center).combined(with: .opacity)
            )
        case .slide:
            // Slide animation with horizontal offset and opacity
            return AnyTransition.asymmetric(
                insertion: .offset(x: -100).combined(with: .opacity),
                removal: .offset(x: 100).combined(with: .opacity)
            )
        case .rotation:
            // 3D rotation animation combined with opacity
            return AnyTransition.asymmetric(
                insertion: .modifier(
                    active: RotationModifier(angle: 90, axis: (x: 0, y: 1, z: 0)),
                    identity: RotationModifier(angle: 0, axis: (x: 0, y: 1, z: 0))
                ).combined(with: .opacity),
                removal: .modifier(
                    active: RotationModifier(angle: -90, axis: (x: 0, y: 1, z: 0)),
                    identity: RotationModifier(angle: 0, axis: (x: 0, y: 1, z: 0))
                ).combined(with: .opacity)
            )
        case .moveUpDown:
            // Vertical move animation with opacity transition
            return AnyTransition.asymmetric(
                insertion: .offset(y: 50).combined(with: .opacity),
                removal: .offset(y: -50).combined(with: .opacity)
            )
        case .none:
            // No animation transition
            return AnyTransition.identity
        }
    }
}
