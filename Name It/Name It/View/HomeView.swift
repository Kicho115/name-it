import SwiftUI

struct HomeView: View {
    @AppStorage("isVoiceFeedbackOn") private var isVoiceFeedbackOn = true
    @AppStorage("isFlashOn") private var isFlashOn = true
    @AppStorage("isVibrationOn") private var isVibrationOn = true
    
    var body: some View {

            NavigationStack {
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
                    
                    Spacer()
                    
                    // CTA Button with NavigationLink
                    NavigationLink(destination: TalkBackView(isFlashOn: $isFlashOn, isVoiceFeedbackOn: $isVoiceFeedbackOn, isVibrationOn: $isVibrationOn)) {
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
                    
                    Spacer()
                    
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
                    }
                    .padding(.horizontal, 24)
                    Spacer()
                }
                .background(Color(hex: "#323232"))
            }
        }
    }


#Preview {
    HomeView()
}
