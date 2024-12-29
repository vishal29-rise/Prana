//
//  TextFields.swift
//  Prana21
//
//  Created by Vishal Thakur on 09/12/24.
//

import SwiftUI

//MARK: - Circular text field

struct CircularTextField: View {
    @State private var value: String = ""
    @State var isSecure: Bool = false
    
    
    var isSecureField: Bool = false
    var placeholder: String
    var rightImage: String?
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        ZStack{
            
            if isSecure && isSecureField {
                SecureField("", text: $value,prompt: Text(placeholder)
                    .foregroundColor(ThemeManager.shared.theme.textPlaceholderColor).font(.custom(Constants.AppFonts.montserratRegular, size: 14.0)))
                    .padding(12)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .keyboardType(keyboardType)
            } else {
                TextField("", text: $value,prompt: Text(placeholder)
                    .foregroundColor(ThemeManager.shared.theme.textPlaceholderColor).font(.custom(Constants.AppFonts.montserratRegular, size: 14.0)))
                    .padding(12)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .keyboardType(keyboardType)
            }
            
            
            
               // .shadow(radius: 3)
            if let rightImage {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if isSecureField {
                            isSecure.toggle()
                        }
                    }, label: {
                        if isSecureField {
                            Image(isSecure ? Constants.AppImages.eyeOff : Constants.AppImages.eyeOn) // Replace with your desired SF Symbol or custom icon
                                .foregroundColor(.gray) // Icon color
                                .padding(.trailing, 16) // Adjust padding
                        } else {
                            Image(rightImage) // Replace with your desired SF Symbol or custom icon
                                .foregroundColor(.gray) // Icon color
                                .padding(.trailing, 16) // Adjust padding
                        }
                        
                    })
                }
            }
        }// Optional shadow for better aesthetics
            .frame( height: 45) // Adjust the size
        
    }
    
}


//MARK: - OTP View

struct OTPView: View {
    @Binding var otp: String
    let maxDigits: Int = 4

    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<maxDigits, id: \.self) { index in
                OTPTextField(index: index, otp: $otp)
            }
        }
    }
}

//MARK: - OTP Textfield

struct OTPTextField: View {
    let index: Int
    @Binding var otp: String
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField("", text: Binding(
            get: {
                index < otp.count ? String(otp[otp.index(otp.startIndex, offsetBy: index)]) : ""
            },
            set: { newValue in
                guard newValue.count >= 1 else { return }
                if newValue.isEmpty {
                    otp.remove(at: otp.index(otp.startIndex, offsetBy: index))
                } else if otp.count < 5 {
                    otp.insert(newValue.first!, at: otp.index(otp.startIndex, offsetBy: index))
                }
            }
        ))
        .foregroundColor(ThemeManager.shared.theme.otpTextColor)
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
        .frame(width: 60, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(ThemeManager.shared.theme.textFieldBackground)
               // .stroke(isFocused ? Color.blue : Color.gray, lineWidth: 1)
        )
        .focused($isFocused)
        .onChange(of: otp) { _ in
            if otp.count == index + 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if index < 3 { isFocused = true }
                }
            }
        }
    }
}


struct UnderlineTextField: View {
    @Binding var text: String
    var placeholder: String
    var underlineColor: Color = Color(hex: "#727272")
    var focusedUnderlineColor: Color = .blue
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 20) {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .focused($isFocused)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .focused($isFocused)
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(isFocused ? focusedUnderlineColor : underlineColor)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
    }
}

