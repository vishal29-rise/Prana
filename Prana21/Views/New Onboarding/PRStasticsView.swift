//
//  PRStasticsView.swift
//  Prana21
//
//  Created by Vishal Thakur on 22/02/25.
//

import SwiftUI

struct PRStasticsView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var title1: String
    @State private var title2: String
    @State private var title3: String
    @State private var title4: String
    @State private var CTA: String
    private var type: MoodScreenType
    @State private var totalBreathingTime: TimeInterval
    @State private var durations: [TimeInterval]
    
    init(type: MoodScreenType, totalBreathingTime: TimeInterval, durations: [TimeInterval]) {
        self.type = type
        switch type {
        case .before:
            title1 = AppTexts.yourBreathing
            title2 = AppTexts.statistics
            title3 = AppTexts.readyToMakeYourBreath
            title4 = AppTexts.evenBetter
            self.CTA = AppActions.continueAction
        case .after:
            title1 = AppTexts.yourImproved
            title2 = AppTexts.statistics
            title3 = AppTexts.whatsTheBenefit
            title4 = AppTexts.deStress
            self.CTA = AppActions.great
        }
        self.totalBreathingTime = totalBreathingTime
        self.durations = durations
    }
    
    // MARK: - Calculated Values
    var longestBreath: TimeInterval {
        durations.max() ?? 0
    }
    
    var shortestBreath: TimeInterval {
        durations.min() ?? 0
    }
    
    var averageBreath: TimeInterval {
        durations.isEmpty ? 0 : durations.reduce(0, +) / Double(durations.count)
    }
    
    var averageInhaleTime: TimeInterval {
        let inhaleTimes = durations.enumerated().compactMap { $0.offset % 2 == 0 ? $0.element : nil }
        return inhaleTimes.isEmpty ? 0 : inhaleTimes.reduce(0, +) / Double(inhaleTimes.count)
    }
    
    var averageExhaleTime: TimeInterval {
        let exhaleTimes = durations.enumerated().compactMap { $0.offset % 2 != 0 ? $0.element : nil }
        return exhaleTimes.isEmpty ? 0 : exhaleTimes.reduce(0, +) / Double(exhaleTimes.count)
    }
    
    var body: some View {
        ZStack {
            Image(Constants.AppImages.getStarted)
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack {
                VStack {
                    Text(title1)
                        .font(.system(size: 24.0, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    Text(title2)
                        .font(.system(size: 36.0, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                VStack {
                    Text(AppTexts.areasToFocus)
                        .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                    
                    VStack {
                        Text(AppTexts.totalBreathinTime)
                            .font(.system(size: 12.0, weight: .semibold, design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                        Text("\(formattedTime(totalBreathingTime, isTotal: true))") // In minutes

                            .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    }
                    
                    HStack {
                        VStack {
                            Text(AppTexts.longestBreath)
                                .font(.system(size: 12.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                            Text("\(formattedTime(longestBreath))")
                                .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        }
                        .padding(.bottom, 20)
                        
                        Image(Constants.AppImages.pentagon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                        
                        VStack {
                            Text(AppTexts.shortestBreath)
                                .font(.system(size: 12.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                            Text("\(formattedTime(shortestBreath))")
                                .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        }
                        .padding(.bottom, 20)
                    }
                    
                    HStack {
                        VStack {
                            Text(AppTexts.averageExhaleTime)
                                .font(.system(size: 12.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                            Text("\(formattedTime(averageExhaleTime))")
                                .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                        
                        Spacer()
                        
                        VStack {
                            Text(AppTexts.averageInhaleTime)
                                .font(.system(size: 12.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                            Text("\(formattedTime(averageInhaleTime))")
                                .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                    .padding(.bottom, 10)
                }
                .background(
                    LinearGradient(colors: [Color(hex: "#7497CC"), Color(hex: "#4767A1")], startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(10)
                .padding(.horizontal, 10)
                
                Spacer()
                
                VStack {
                    if type == .before {
                        Text(title3)
                            .font(.system(size: 24.0, weight: .semibold, design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                        
                        Text(title4)
                            .font(.system(size: 36.0, weight: .semibold, design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    } else {
                        Text(title3)
                            .font(.system(size: 36.0, weight: .semibold, design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        
                        Text(title4)
                            .font(.system(size: 24.0, weight: .semibold, design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                }
                
                NavigationLink(destination: {
                    switch type {
                    case .before:
                        PRBellyBreathingIntroView()
                    case .after:
                        PRMultiScreenView(type: .screen3)
                    }
                }, label: {
                    Text(CTA)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .font(.custom(Constants.AppFonts.inter18SemiBold, size: 20.0))
                        .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .background(
                    Capsule()
                        .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                )
                .padding(.bottom, 20)
                .padding(.horizontal, 40)
                .navigationBarBackButtonHidden()
            }
        }
        .modifier(CustomToolbarModifier())
    }
    private func formattedTime(_ time: TimeInterval, isTotal: Bool = false) -> String {
        if isTotal {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return minutes > 0 ? "\(minutes) min \(seconds) sec" : "\(seconds) sec"
        } else {
            return String(format: "%.1f sec", time)
        }
    }
}

#Preview {
    PRStasticsView(type: .after, totalBreathingTime: 0.0, durations: [])
}
