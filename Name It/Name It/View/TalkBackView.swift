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

    var body: some View {            
        Text("Welcome to TalkBack!")
            .font(.largeTitle)
            .padding()
            .onAppear {
                toggleFlash(isOn: isFlashOn)
            }
            .onDisappear {
                toggleFlash(isOn: false) // Apaga el flash al salir
            }
    }

    private func toggleFlash(isOn: Bool) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
            print("Torch is not available")
            return
        }

        do {
            try device.lockForConfiguration()
            device.torchMode = isOn ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Failed to toggle flash: \(error)")
        }
    }
}
