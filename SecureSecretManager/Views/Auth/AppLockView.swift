//
//  AppLockView.swift
//  SecureSecretManager
import SwiftUI

struct AppLockView: View {
    @State private var isUnlocked = false
    @State private var authFailed = false
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if isUnlocked {
                VaultListView()
            } else {
                lockScreen
            }
        }
        .onAppear {
            authenticate()
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                isUnlocked = false
            } else if newPhase == .active && !isUnlocked {
                authenticate()
            }
        }
    }

    private var lockScreen: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color.accentColor.opacity(0.12))
                    .frame(width: 96, height: 96)
                Image(systemName: "lock.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.accentColor)
            }

            Text("Secure Secret Manager")
                .font(.title2.bold())

            Text("Devam etmek için kimliğinizi doğrulayın")
                .font(.subheadline)
                .foregroundColor(.secondary)

            if authFailed {
                Text("Doğrulama başarısız, tekrar deneyin")
                    .font(.caption)
                    .foregroundColor(.red)
            }

            Button {
                authenticate()
            } label: {
                Label("Tekrar Dene", systemImage: "faceid")
                    .font(.subheadline.bold())
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }

    private func authenticate() {
        BiometricAuthService.shared.authenticate(
            reason: "Kasanıza erişmek için kimliğinizi doğrulayın"
        ) { result in
            switch result {
            case .success:
                authFailed = false
                withAnimation {
                    isUnlocked = true
                }
            case .failure:
                authFailed = true
            }
        }
    }
}

#Preview {
    AppLockView()
}
