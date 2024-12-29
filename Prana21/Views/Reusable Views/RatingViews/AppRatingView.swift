//
//  AppRatingView.swift
//  Prana21
//
//  Created by Vishal Thakur on 25/12/24.
//

import SwiftUI
import StoreKit
import UIKit

struct AppRatingView: View {
    var body: some View {
        VStack {
            Text("Enjoying our app?")
                .font(.title)
                .padding()
            
            Button("Rate Us") {
                requestAppStoreReview()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
    
    func requestAppStoreReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}


 

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update required
    }
}


struct ShareSheetDemoView: View {
    @State private var isShareSheetPresented = false
    
    let textToShare = "Check out this amazing app!"
    let urlToShare = URL(string: "https://example.com")!
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Share Sheet Demo")
                .font(.title)
                .padding()
            
            Button(action: {
                isShareSheetPresented = true
            }) {
                Label("Open Share Sheet", systemImage: "square.and.arrow.up")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShareSheetPresented) {
                ShareSheet(items: [textToShare, urlToShare])
            }
        }
        .padding()
    }
}



#Preview {
    ShareSheetDemoView()
}
