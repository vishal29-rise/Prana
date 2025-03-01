import SwiftUI

struct BreathingExerciseView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
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
    
    @State private var breathCount = 5
    @State private var currentStep = 5
    @State private var isBreathing = false
    @State private var buttonText: String = "Start Breathing"
    
    
    @State private var isInhaling = false
    @State private var activeIndex = -1
    @State private var isAnimating = false
   
    @State private var breathScale: CGFloat = 1.0
    @State private var inhaleTimes: [TimeInterval] = []
    @State private var exhaleTimes: [TimeInterval] = []
    @State private var lastBreathStartTime = Date()
    @State private var exerciseCompleted: Bool = true
    @State private var animateForward: Bool = false
    
    let totalSteps = 5
    let selectedColor: Color = Color(hex: "#90BFFF")
    
    var totalDuration: TimeInterval {
        return (inhaleTimes + exhaleTimes).reduce(0, +)
    }

    var breathDurations: [TimeInterval] {
        return zip(inhaleTimes, exhaleTimes).map { $0 + $1 }
    }
    
    
    var body: some View {
        ZStack {
            Image(Constants.AppImages.getStarted)
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack {
                
                VStack {
                    Text(AppTexts.letsTake)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    Text(AppTexts.fiveNaturalBreaths)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                }
                .padding(.top,20)
                Spacer()
                
                VStack {
                    ZStack{
                        PRAuraView(hideLogo: true, isVisible: $animateForward)
                            
//                        Button(action: {
//                            startBreathing()
//                        }, label: {
                            Text(buttonText)
                                .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                       // })
                        .frame(minWidth: 100,minHeight: 100)
                        
                    }
                    .onTapGesture {
                        startBreathing()
                    }
                   
                    
                    
                    .padding(.bottom, 80)
                    
                    
                    Text(isBreathing ? isInhaling ? "Inhaling..." : "Exhaling..." : "")
                        .foregroundColor(.white)
                    HStack(spacing: 20) {
                        ForEach(0..<totalSteps, id: \ .self) { index in
                            ZStack {
                                Circle()
                                    .strokeBorder(Color.white.opacity(0.55), lineWidth: 3)
                                    .frame(width: 50, height: 50)
                                    .overlay(Text("\(index + 1)").foregroundColor(.white))
                                    .background(activeIndex >= index ? selectedColor : Color.clear)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                .padding()
                
                
                // Retake Button
                Button(action: {
                    resetBreathing()
                }) {
                    Text("Retake")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(ThemeManager.shared.theme.primaryCTABackgroundColor)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(ThemeManager.shared.theme.primaryCTABackgroundColor, lineWidth: 1))
                }
                .padding(.top)
                .padding(.bottom,20)
                
                
                
               
                
                // Submit Button
//                Button(action: {
//                    // Handle submit action
//                    if buttonText == "Finished" {
//                        PRScoreView(totalDuration: totalDuration, durations: breathDurations)
//                    }
//                }) {
//                    Text("Submit")
//                        .font(.headline)
//                        .foregroundColor(.black)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(ThemeManager.shared.theme.primaryCTABackgroundColor)
//                        .opacity(buttonText == "Finished" ? 1.0 : 0.5)
//                        .cornerRadius(25)
//                }
                NavigationLink(destination: {
                    if buttonText == "Finished" {
                        PRScoreView(totalDuration: totalDuration, durations: breathDurations, screenType: .before)
                    }
                }, label: {
                    Text("Submit")
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
                        .opacity(buttonText == "Finished" ? 1.0 : 0.5)
                )
                
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden()
            .padding(.vertical)
        }
        .modifier(CustomToolbarModifier())
    }
    
    func startBreathing() {
        
        if !exerciseCompleted {
            
            isBreathing = true
            let currentTime = Date()
            let duration = currentTime.timeIntervalSince(lastBreathStartTime)
            lastBreathStartTime = currentTime
            
            
            isInhaling.toggle()
            
            
            
            if isInhaling {
                inhaleTimes.append(duration)
                animateForward = true
            } else {
                exhaleTimes.append(duration)
                animateForward = false
            }
            
            
            
            if activeIndex < totalSteps - 1{
                if !isInhaling {
                    activeIndex += 1
                }
                if activeIndex == 4 {
                    breathScale = isInhaling ? 0.5 : 1.2
                    buttonText = "Finish"
                    return
                }
                
                buttonText = "     "
            } else {
                // activeIndex = 0
                isBreathing = false
                buttonText = "Finished"
                breathScale = 1.0
                exerciseCompleted = true
                
                return
            }
            
            breathScale = isInhaling ? 0.5 : 1.2
        } else {
            buttonText = "Tap"
            exerciseCompleted = false
           
        }
        
    }
    
    func resetBreathing() {
            activeIndex = -1
        isBreathing = false
            isInhaling = true
            buttonText = "Start Breathing"
        exerciseCompleted = false
        animateForward = false
            inhaleTimes.removeAll()
            exhaleTimes.removeAll()
            breathScale = 1.0
            lastBreathStartTime = Date()
        }
}

struct BreathingExerciseView_Previews: PreviewProvider {
    
    static var previews: some View {
       // BreathingView(buttonText: $button)
        BreathingExerciseView()
    }
}








