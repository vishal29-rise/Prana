//
//  ContentView.swift
//  Prana21
//
//  Created by Vishal Thakur on 28/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isInhaling = true
        
        // Set inhale and exhale duration to 5 seconds each
        private let duration: Double = 5.0
    
    init(isInhaling: Bool = true) {
        self.isInhaling = isInhaling
        setupNavigationBarAppearance()
    }
        
    var body: some View {
       PRLandingView()
    }
}

#Preview {
    ContentView()
}

private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        
        // Set a consistent background color
        appearance.backgroundColor = .clear // Or any custom color
        appearance.shadowColor = .clear // Remove shadow if needed
        
       
        
        // Apply the appearance globally
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance // Disable scroll effects
    }



struct BoxBreathingView: View {
    @State private var phase: Int = 0
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    @State private var message: String = "Inhale"

    // Duration for each phase (inhale, hold, exhale, hold)
    let duration: Double = 4.0

    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, 40)

            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(0.2), lineWidth: 20)
                    .frame(width: 200, height: 200)

                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .animation(.easeInOut(duration: duration), value: scale)
                    .animation(.easeInOut(duration: duration), value: opacity)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            startBreathingAnimation()
        }
    }

    private func startBreathingAnimation() {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            phase = (phase + 1) % 4
            updatePhase()
        }
    }

    private func updatePhase() {
        switch phase {
        case 0: // Inhale
            message = "Inhale"
            scale = 1.5
            opacity = 1.0
        case 1: // Hold
            message = "Hold"
            scale = 1.5
            opacity = 1.0
        case 2: // Exhale
            message = "Exhale"
            scale = 1.0
            opacity = 0.5
        case 3: // Hold
            message = "Hold"
            scale = 1.0
            opacity = 0.5
        default:
            break
        }
    }
}


struct CircleSquareAnimationView: View {
    @State private var animationProgress: CGFloat = 0.0
    @State private var squareColor: Color = .blue

    let animationDuration: Double = 8.0 // Total time for one loop

    var body: some View {
        ZStack {
            // Square with dynamic fill color
            Rectangle()
                .fill(squareColor)
                .frame(width: 200, height: 200)
                .animation(.easeInOut(duration: animationDuration), value: squareColor)

            // Circle moving along the edges
            GeometryReader { geometry in
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .position(calculateCirclePosition(for: geometry.size, progress: animationProgress))
            }
            .frame(width: 200, height: 200) // Restrict GeometryReader's size to the square
        }
        .onAppear {
            startAnimation()
        }
    }

    /// Calculate the position of the circle along the edges of the square
    private func calculateCirclePosition(for size: CGSize, progress: CGFloat) -> CGPoint {
        let sideLength = size.width        // Length of each edge
        let perimeter = sideLength * 4    // Total perimeter of the square
        let distance = progress * perimeter // Distance traveled along the perimeter

        if distance < sideLength {
            // Top edge: Moving left to right
            return CGPoint(x: distance, y: 0)
        } else if distance < 2 * sideLength {
            // Right edge: Moving top to bottom
            return CGPoint(x: sideLength, y: distance - sideLength)
        } else if distance < 3 * sideLength {
            // Bottom edge: Moving right to left
            return CGPoint(x: sideLength - (distance - 2 * sideLength), y: sideLength)
        } else {
            // Left edge: Moving bottom to top
            return CGPoint(x: 0, y: sideLength - (distance - 3 * sideLength))
        }
    }

    /// Start the animation for circle movement and square color change
    private func startAnimation() {
        // Animate the circle's movement
        withAnimation(.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
            animationProgress = 1.0
        }

        // Change the square's color every quarter of the animation
        Timer.scheduledTimer(withTimeInterval: animationDuration / 4, repeats: true) { _ in
            squareColor = Color.random()
        }
    }
}

extension Color {
    /// Generate a random color
    static func random() -> Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
