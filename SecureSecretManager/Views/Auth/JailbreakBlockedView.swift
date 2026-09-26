//
//  JailbreakBlockedView.swift
//  SecureSecretManager
import SwiftUI

struct JailbreakBlockedView: View {
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.12))
                    .frame(width: 96, height: 96)
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.red)
            }

            Text("Güvenli Olmayan Cihaz")
                .font(.title2.bold())

            Text("Cihazınızda güvenlik bütünlüğünü tehlikeye atan\nbir değişiklik (jailbreak) tespit edildi.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("Hassas verilerinizin güvenliği için uygulama\nbu cihazda çalışmayı reddediyor.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 4)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    JailbreakBlockedView()
}
