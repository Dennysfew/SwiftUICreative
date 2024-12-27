//
//  RotationModifier.swift
//

import SwiftUI

/// ViewModifier for applying a 3D rotation effect.
struct RotationModifier: ViewModifier {
    let angle: Double
    let axis: (x: CGFloat, y: CGFloat, z: CGFloat)

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(angle),
                axis: axis
            )
    }
}
