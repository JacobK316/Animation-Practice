//
//  CircleMovement.swift
//  Animation Practice
//
//  Created by Jacob Kappler on 2/18/26.
//

import SwiftUI

struct CircleMovement: View {
    @State private var animationToggle = false
    var body: some View {
        Button("Animate") {
            animationToggle.toggle()
        }
        .padding()
        .foregroundStyle(.yellow)
        .bold()
        .background(.red)
        .clipShape(.capsule)
        
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.green)
                .phaseAnimator([Phases.initial,
                                Phases.down, Phases.right, Phases.left, Phases.center],
                               trigger: animationToggle) { content, phase in
                    content
                        .offset(x: phase.xOffset, y: phase.yOffset)
                        .scaleEffect(phase.scale)
                } animation: { phase in
                    switch phase {
                    case .initial, .down: .bouncy()
                    case .left, .right, .center: .easeInOut(duration: 0.1)
                    }
                }
            
            Circle()
                .frame(width: 10, height: 10)
                .foregroundStyle(.green)
                .offset(x: 50)
                .rotationEffect(.degrees(animationToggle ? 360 : 0))
                .animation(
                        .linear(duration: 2).repeatForever(autoreverses: false),
                            value: animationToggle
                )
        }
    }
}

enum Phases: CaseIterable {
    case initial, down, right, left, center
    
    var yOffset: CGFloat {
        switch self {
        case .initial: 0
        case .down: 100
        case .right: 100
        case .left: 100
        case .center: 100
        }
    }
    
    var xOffset: CGFloat {
        switch self {
        case .initial: 0
        case .down: 0
        case .right: 100
        case .left: -100
        case .center: 0
        }
    }
    
    var scale: Double {
        switch self {
        case .initial: 1
        case .down: 1.1
        case .right: 1.2
        case .left: 1.3
        case .center: 1.4
        }
    }
}

#Preview {
    CircleMovement()
}
