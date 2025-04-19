//
//  CameraManager.swift
//  Name It
//
//  Created by Jose Quezada Araiza on 17/04/25.
//


import Foundation
import AVFoundation
import Vision
import CoreML

class CameraModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var detectedLabel: String = "Nada detectado"
    let session = AVCaptureSession()
    private let speechSynthesizer = AVSpeechSynthesizer()
    private var visionModel: VNCoreMLModel?

    override init() {
        super.init()
        setupModel()
    }

    // Load the coreml model
    func setupModel() {
        do {
            let config = MLModelConfiguration()
            let model = try FastViTT8F16(configuration: config)
            visionModel = try VNCoreMLModel(for: model.model)
        } catch {
            print("Error cargando el modelo: \(error.localizedDescription)")
        }
    }

    // Start the camera session and configure the input and output
    func startSession(isFlashOn: Bool) {
        session.beginConfiguration()
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device)
        else { return }

        if session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "cameraQueue"))

        if session.canAddOutput(output) {
            session.addOutput(output)
        }

        session.commitConfiguration()
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
            self.toggleFlash(isOn: isFlashOn)
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

    // Stop the camera session
    func stopSession() {
        session.stopRunning()
        self.toggleFlash(isOn: false)
        
    }

    // Capture the output from the camera and process it with the Vision framework
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let buffer = CMSampleBufferGetImageBuffer(sampleBuffer),
              let visionModel = visionModel else { return }

        let request = VNCoreMLRequest(model: visionModel) { request, _ in
            if let result = request.results?.first as? VNClassificationObservation {
                DispatchQueue.main.async {
                    self.detectedLabel = "\(result.identifier) (\(String(format: "%.1f", result.confidence * 100))%)"
                }
            }
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: buffer, options: [:])
        try? handler.perform([request])
    }

    // Speak the detected object using AVSpeechSynthesizer
    func speakDetectedObject() {
        let utterance = AVSpeechUtterance(string: detectedLabel)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }
}
