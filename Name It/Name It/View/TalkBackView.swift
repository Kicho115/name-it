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
    @StateObject private var cameraModel = CameraModel()
    
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

                Button("¿Qué ves?") {
                    cameraModel.speakDetectedObject()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

            }
            .padding(.bottom, 50)
        }
        .onAppear {
            cameraModel.startSession(isFlashOn: isFlashOn)
        }
        .onDisappear {
            cameraModel.stopSession()
        }
    }
}
