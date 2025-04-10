//
//  HomeView.swift
//  Name It
//
//  Created by Oscar Angulo on 4/9/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isVoiceFeedbackOn = true
    @State private var isFlashOn = true
    @State private var isVibrationOn = true
    @State private var isAutoDetectionOn = true

    var body: some View {
        ZStack {
            // Background
            Color(Color(hex: "#323232"))
                .ignoresSafeArea()
            
            // Content
            VStack {
                // Header
                HStack {
                    Text("Real Talk")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    Image(systemName: "bell.fill")
                        .font(.title)
                        .padding()
                }
                .foregroundColor(.white)
                
                // CTA Button
                Button(action: {
                    // Action for the button
                }) {
                    VStack {
                        Image(systemName: "eye.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                        Text("Start TalkBack")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    }
                    .background(Color(hex: "#4318D1"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                // Quick Settings
                VStack(alignment: .leading, spacing: 16) {
                    Text("Quick Settings")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.top, 32)

                    ToggleRow(
                        icon: "voiceover",
                        title: "Voice Feedback",
                        isOn: $isVoiceFeedbackOn
                    )

                    ToggleRow(
                        icon: "flashlight.off.fill",
                        title: "Flash",
                        isOn: $isFlashOn
                    )

                    ToggleRow(
                        icon: "iphone.gen2.radiowaves.left.and.right",
                        title: "Vibration",
                        isOn: $isVibrationOn
                    )

                    ToggleRow(
                        icon: "eye",
                        title: "Auto-Detection",
                        isOn: $isAutoDetectionOn
                    )
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
