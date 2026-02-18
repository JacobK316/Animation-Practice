//
//  FireWorksView.swift
//  Animation Practice
//
//  Created by Jacob Kappler on 2/18/26.
//

import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGVector
    var color: Color
    var life: Double // 0...1
}

struct FireWorksView: View {
    @State private var particles: [Particle] = []
    @State private var timer: Timer? = nil
    let particleCount = 50
    let center = CGPoint(x: 200, y: 180) // Adjust for your view size

    var body: some View {
        ZStack {
            // Background fireworks layer
            Canvas { context, size in
                for particle in particles {
                    let alpha = particle.life
                    let color = particle.color.opacity(alpha)
                    var path = Path()
                    path.addArc(center: particle.position, radius: 5, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
                    context.fill(path, with: .color(color))
                }
            }
            .ignoresSafeArea()
            
            // Foreground button
            Button("Hello, World!") {
                launchFirework(in: CGSize(width: 400, height: 360)) // Adjust for your view size
            }
            .foregroundStyle(Color(red: 0.8, green: 0.9, blue: 0.2, opacity: 1))
            .bold()
            .padding()
            .font(.title2)
            .background(.red)
            .clipShape(.capsule)
            .position(x: center.x, y: center.y)
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    // Launch a firework effect by spawning new particles
    func launchFirework(in size: CGSize) {
        let origin = center
        for _ in 0..<particleCount {
            let angle = Double.random(in: 0..<2 * .pi)
            let speed = Double.random(in: 80...180)
            let dx = cos(angle) * speed
            let dy = sin(angle) * speed
            let color = Color(hue: Double.random(in: 0...1), saturation: 0.7, brightness: 1)
            particles.append(Particle(position: origin, velocity: CGVector(dx: dx, dy: dy), color: color, life: 1))
        }
    }
    
    // Animate and fade particles
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60, repeats: true) { _ in
            let delta: CGFloat = 1.0 / 60
            for i in particles.indices {
                particles[i].position.x += particles[i].velocity.dx * delta
                particles[i].position.y += particles[i].velocity.dy * delta
                particles[i].velocity.dy += 100 * delta // gravity
                particles[i].life -= 0.013
            }
            particles.removeAll { $0.life <= 0 }
        }
    }
}

#Preview {
    FireWorksView()
}
