import SwiftUI

struct PRUserProfileView: View {
    @State private var streakCount = 0
    @State private var breathsCount = 11
    @State private var minutesCount = 2
    @State private var level = 1
    @State private var levelProgress = 19
    @State private var breathScore = 50

    // Mock data: Exercise days (dates the user completed the exercise)
    @State private var completedDays: [Date] = [
        Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
        Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
        Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    ]

    var body: some View {
        VStack {
            // Top Bar
            HStack {
                Button(action: {
                    // Menu action
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.white)
                }

                Spacer()

                Text("Prana21")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                Button(action: {
                    // Notification action
                }) {
                    Image(systemName: "bell.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // User Profile Section
            HStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 60, height: 60)

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("0 Streak")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("\(breathsCount) Breaths")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("\(minutesCount) Minutes")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)

                VStack {
                    Text("Level \(level)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    Text("\(levelProgress)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.black.opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal)

            // Breath Score Section
            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 6)
                        .frame(width: 120, height: 120)

                    Text("\(breathScore)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("out of 100")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .offset(y: 20)
                }

                Text("Breath Score")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding()

            // Sessions Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Sessions")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                // Calendar View
                CalendarView(completedDays: completedDays)
                    .padding(.horizontal)
            }
            .padding(.top)

            Spacer()

            // Bottom Navigation (Optional)
            HStack {
                NavigationButton(title: "Breathe", icon: "circle.grid.3x3.fill")
                Spacer()
                NavigationButton(title: "Explore", icon: "magnifyingglass")
                Spacer()
                NavigationButton(title: "Activity", icon: "chart.bar.fill")
            }
            .padding()
            .background(Color.black.opacity(0.8))
        }
        .background(LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Calendar View
struct CalendarView: View {
    let completedDays: [Date]
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let calendar = Calendar.current

    var body: some View {
        VStack {
            // Weekday Header
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }

            // Days Grid
            let days = generateDaysForMonth()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { date in
                    if let date = date {
                        Circle()
                            .fill(completedDays.contains(where: { isSameDay($0, date) }) ? Color.green : Color.gray.opacity(0.2))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Text("\(calendar.component(.day, from: date))")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            )
                    } else {
                        Spacer()
                    }
                }
            }
        }
    }

    // Generate the grid of days for the current month
    private func generateDaysForMonth() -> [Date?] {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!

        let startWeekday = calendar.component(.weekday, from: startOfMonth)
        var days: [Date?] = Array(repeating: nil, count: startWeekday - 1)

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }

        return days
    }

    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }
}

// Navigation Button
struct NavigationButton: View {
    var title: String
    var icon: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)

            Text(title)
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    PRUserProfileView()
}
