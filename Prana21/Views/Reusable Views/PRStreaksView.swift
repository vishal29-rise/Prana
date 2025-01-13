import SwiftUI

struct PRStreakView: View {
    @State private var selectedDayIndex: Int = 6 // Assume "Saturday" is selected
    @State private var streakCount: Int = 305
    @State private var flamesCount: Int = 0

    private let days = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        VStack {
            // Top Bar with Icons and Streak
            HStack {
                // Flame Icon with Count
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                        .font(.title3)
                    Text("\(flamesCount)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }

                Spacer()

                // Title
                Text("Prana21")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                // Streak Count with Person Icon
                HStack {
                    Text("\(streakCount)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                        .font(.title3)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Streak Tracker for Days
            HStack(spacing: 16) {
                ForEach(0..<days.count, id: \.self) { index in
                    ZStack {
                        // Background Circle
                        Circle()
                            .stroke(index == selectedDayIndex ? Color.green : Color.gray.opacity(0.5), lineWidth: 2)
                            .frame(width: 28, height: 28)

                        if index == selectedDayIndex {
                            // Filled Circle for Current Day
                            Circle()
                                .fill(Color.green)
                                .frame(width: 28, height: 28)
                        }

                        // Day Label
                        Text(days[index])
                            .font(.subheadline)
                            .fontWeight(index == selectedDayIndex ? .bold : .regular)
                            .foregroundColor(index == selectedDayIndex ? .black : .white)
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .background(LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding()
    }
}

#Preview {
    PRStreakView()
}
