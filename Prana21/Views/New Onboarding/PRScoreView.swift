//
//  PRScoreView.swift
//  Prana21
//
//  Created by Vishal Thakur on 15/02/25.
//

import SwiftUI

struct PRScoreView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    
    @State private var name: String = ""
    @State private var age: String = "25-35"
    @State private var isReady: Bool = false
    
    @State private var title1: String
    @State private var title2: String
    @State private var title3: String
    @State private var title4: String
    @State private var CTA: String
    
    var totalDuration: TimeInterval
    var durations: [TimeInterval]
    var screenType: MoodScreenType
    
    
    init(totalDuration: TimeInterval,durations: [TimeInterval],screenType: MoodScreenType) {
        self.screenType = screenType
        switch screenType {
        case .before:
            self.title1 = AppTexts.yourBreathScore
            self.title2 = AppTexts.scoreIsReady
            self.title3 = AppTexts.thatWasGreat
            self.title4 = AppTexts.youCanDoBetter
            self.CTA = AppActions.continueAction
        case .after:
            self.title1 = AppTexts.yourNewBreathScore
            self.title2 = AppTexts.scoreIsReady
            self.title3 = AppTexts.seeAlreaySoMuch
            self.title4 = AppTexts.muchBetter
            self.CTA = AppActions.more
        }
        self.totalDuration = totalDuration
        self.durations = durations
    }
    
    //back button
    var btnBack : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(Constants.AppImages.backIcon)
                .padding([.top],10)
        }
    }
    var btnMute : some View {
        Button(action: {
            BackgroundAudioManager.shared.pause()
        }) {
            Image(systemName: "speaker.fill")
                .renderingMode(.template)
                .foregroundStyle(AppTheme.primaryCTABackgroundColor)
                .padding([.top],10)
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Image(Constants.AppImages.getStarted)
                    .resizable()
                    .ignoresSafeArea(edges: .all)
                VStack {
                    VStack {
                        Text(title1)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                        
                        Text(title2)
                            .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        
                    }
                    .padding(.top,20)
                    Spacer()
                    ZStack {
                        PRAuraView(hideLogo: true, isVisible: $isReady) .onAppear{
                            DispatchQueue.main.async {
                                self.isReady = true
                            }
                        }
                        Text("65%")
                            .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                        
                    }
                    
                    .frame(height: geometry.size.height * 0.3)
                    
                    
                    Spacer()
                    
                    VStack {
                        HStack{
                            VStack {
                                Text("05")
                                    .font(.system(size: 18.0,weight: .semibold,design: .rounded))
                                    .foregroundColor(AppTheme.primaryTextColor)
                                Text("Breaths")
                                    .font(.system(size: 18.0,weight: .semibold,design: .rounded))
                                    .foregroundColor(AppTheme.primaryCTABackgroundColor)
                            }
                            Spacer()
                            VStack {
                                Text("\(totalDuration, specifier: "%.2f")s")
                                    .font(.system(size: 18.0,weight: .semibold,design: .rounded))
                                    .foregroundColor(AppTheme.primaryTextColor)
                                Text("Duration")
                                    .font(.system(size: 18.0,weight: .semibold,design: .rounded))
                                    .foregroundColor(AppTheme.primaryCTABackgroundColor)
                            }
                           
                        }
                        .padding()
                        
                        DemoChart(overallData: getBreathDurations())
                            .frame(height: geometry.size.height * 0.2)
                        
                    }
                    .background{
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "6E88B8"),Color(hex: "4767A1")]), startPoint: .top, endPoint: .bottom)
                    }
                    .cornerRadius(16.0)
                    .padding()
                    
                    Spacer()
                    VStack {
                        
                        
                        Text(title3)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                            .padding(.zero)
                        
                        
                        Text(title4)
                            .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        
                    }
                    
                    NavigationLink(destination: {
                        switch screenType {
                        case .before:
                            PRStasticsView(type: .before,totalBreathingTime: totalDuration,durations: durations)
                        case .after:
                            PRStasticsView(type: .after,totalBreathingTime: totalDuration,durations: durations)
                        }
                    }, label: {
                        Text(CTA)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .font(.custom(Constants.AppFonts.inter18SemiBold, size: 20.0))
                            .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        Capsule()
                            .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                        
                    )
                    .navigationBarBackButtonHidden()
                    .padding(.horizontal,40)
                    Spacer()
                }
                
            }
        }
        .modifier(CustomToolbarModifier())
    }
    
    func getBreathDurations() -> [BreathData] {
        
        var breaths: [BreathData] = [BreathData(breathNo: 0, seconds: 0.0)]
        var key = 1
        for duration in durations {
            breaths.append(BreathData(breathNo: key, seconds: Float(duration)))
            print("Breaath ka Data: \(BreathData(breathNo: key, seconds: Float(duration)))")
            key += 1
            
        }
       
        return breaths
    }
}

#Preview {
    PRScoreView(totalDuration: 0.0, durations: [], screenType: .before)
}
