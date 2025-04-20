import SwiftUI

struct HomeView: View {
    @State private var isVoiceFeedbackOn = UserDefaultsManager.shared.isVoiceFeedbackOn()
    @State private var isFlashOn = UserDefaultsManager.shared.isFlashOn()
    @State private var isVibrationOn = UserDefaultsManager.shared.isVibrationOn()


    
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

                    // Toggle para Voice Feedback
                    ToggleRow(
                        icon: "voiceover",
                        title: "Voice Feedback",
                        isOn: Binding(
                            get: { UserDefaultsManager.shared.isVoiceFeedbackOn() },
                            set: { UserDefaultsManager.shared.setVoiceFeedbackOn($0) }
                        )
                    )

                    // Toggle para Flash
                    ToggleRow(
                        icon: "flashlight.off.fill",
                        title: "Flash",
                        isOn: Binding(
                            get: { UserDefaultsManager.shared.isFlashOn() },
                            set: { UserDefaultsManager.shared.setFlashOn($0) }
                        )
                    )

                    // Toggle para Vibration
                    ToggleRow(
                        icon: "iphone.gen2.radiowaves.left.and.right",
                        title: "Vibration",
                        isOn: Binding(
                            get: { UserDefaultsManager.shared.isVibrationOn() },
                            set: { UserDefaultsManager.shared.setVibrationOn($0) }
                        )
                    )
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
