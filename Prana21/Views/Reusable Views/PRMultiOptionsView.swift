import SwiftUI

struct PRMultiOptionsView: View {
    let options = ["Male", "Female", "Non-binary", "Prefer not to say"]
    @State private var selectedOption: String? = nil
    
    let buttonWidth: CGFloat = 140 // Adjust width to match layout
    let buttonHeight: CGFloat = 50
    
    var body: some View {
        VStack(spacing: 20) {
            GridLayoutView(options: options, selectedOption: $selectedOption)
        }
        .padding()
        
        .cornerRadius(10)
    }
}

struct GridLayoutView: View {
    let options: [String]
    @Binding var selectedOption: String?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    withAnimation {
                        selectedOption = option
                    }
                }) {
                    Text(option)
                        .font(.custom(Constants.AppFonts.inter18Medium, size: 16.0))
                        .foregroundColor(selectedOption == option ? .black : ThemeManager.shared.theme.primaryCTABackgroundColor)
                        .frame(width: 150, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(ThemeManager.shared.theme.primaryCTABackgroundColor, lineWidth: 1)
                        )
                        .background{
                            Color(selectedOption == option ? ThemeManager.shared.theme.primaryCTABackgroundColor : .clear)
                                .cornerRadius(25)
                        }
                    
                        
                        
                }
            }
        }
    }
}

struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PRMultiOptionsView()
           // .padding()
            .background(Color.black) // Simulating app background
            .previewLayout(.sizeThatFits)
    }
}
