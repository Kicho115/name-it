//
//  TalkBackView.swift
//  Name It
//
//  Created by Oscar Angulo on 4/10/25.
//

import SwiftUI
import AVFoundation

struct TalkBackView: View {
    @Binding var isFlashOn: Bool
    @Binding var isVoiceFeedbackOn: Bool
    @Binding var isVibrationOn: Bool
    @StateObject private var cameraModel = CameraModel()
    
    private var generator: UIImpactFeedbackGenerator? {
        isVibrationOn ? UIImpactFeedbackGenerator(style: .medium) : nil
    }
    
    var body: some View {
        ZStack {
            TalkBackCamera(session: cameraModel.session)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text(cameraModel.detectedLabel)
                    .font(.title)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(12)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 50)
        }
        .onAppear {
            cameraModel.startSession(isFlashOn: isFlashOn)
        }
        .onDisappear {
            cameraModel.stopSession()
        }
        .onTapGesture {
            if isVoiceFeedbackOn {
                cameraModel.speakDetectedObject()
            }
            if isVibrationOn {
                generator?.impactOccurred()
            }
            
        }
    }
}
