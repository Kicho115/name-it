//
//  ToogleRow.swift
//  Name It
//
//  Created by Oscar Angulo on 4/9/25.
//

import SwiftUI

struct ToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 24, height: 24)

                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(CustomToggleStyle())
        }
        .padding(16)
        .background(Color.white.opacity(0.06))
        .cornerRadius(12)
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(width: 48, height: 24)
                    .foregroundColor(
                        configuration.isOn ?
                        Color(red: 67/255, green: 24/255, blue: 209/255) :
                        Color.white.opacity(0.227)
                    )
                
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(2)
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
        }
    }
}

#Preview {
    ToggleRow(icon: "voiceover", title: "Voice Feedback", isOn: .constant(true))
        
}
