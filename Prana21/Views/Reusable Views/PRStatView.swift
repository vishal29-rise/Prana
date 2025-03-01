//
//  PRStatView.swift
//  Prana21
//
//  Created by Vishal Thakur on 15/02/25.
//


import SwiftUI
import Charts

struct BreathingStatsView: View {
    @State private var selectedIndex: Int? = 10
    let dataPoints: [(x: Int, y: Double)] = [
        (1, 10), (2, 12), (3, 18), (4, 25),
        (5, 30)
    ]

    var body: some View {
        Text("")
    }
}



// Preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DemoChart()
//            .preferredColorScheme(.dark)
//    }
//}
struct BreathData: Identifiable {
    let id = UUID()
    let breathNo: Int
    let seconds: Float
    
    static func mockData() -> [BreathData] {
        
        return [
            .init(breathNo: 0, seconds: 0),
            .init(breathNo: 1, seconds: 7),
            .init(breathNo: 2, seconds: 9),
            .init(breathNo: 3, seconds: 6),
            .init(breathNo: 4, seconds: 4),
            .init(breathNo: 5, seconds: 11),
        ]
    }
}

struct DemoChart: View {
    
   
    var overallData:  [BreathData]

  private var areaBackground: Color {
      return Color(AppTheme.primaryCTABackgroundColor)
  }

    var body: some View {
        GeometryReader{ geometry in
            VStack {
                
                Chart(overallData) {
                    LineMark(
                        x: .value("Month", $0.breathNo),
                        y: .value("Amount", $0.seconds)
                    )
                    .symbol(.circle)
                    .interpolationMethod(.catmullRom)
                    
                    AreaMark(
                        x: .value("Month", $0.breathNo),
                        y: .value("Amount", $0.seconds)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(areaBackground)
                }
                
                
                //    .chartXAxis {
                //        AxisMarks(format: .interval)
                //    }
                // .chartXAxis(<#T##visibility: Visibility##Visibility#>)
                .chartXAxis{
                    AxisMarks(values: .automatic(desiredCount: 5)){ value in
                        AxisValueLabel().foregroundStyle(Color(hex: "#F5D3D3"))
                    }
                }
                
                // .chartYScale(domain: 0 ... 15)
                .chartYAxis(.hidden)
                .frame(minHeight: geometry.size.height * 0.8,maxHeight: 300)
                .padding()
            }
            
            .padding()
            .cornerRadius(20.0)
        }
    }
}
