//
//  SecretDetailView.swift
//  SecureSecretManager
import SwiftUI

struct SecretDetailView: View {
    @ObservedObject var viewModel: VaultViewModel
    let item: SecretItem
    @Environment(\.dismiss) private var dismiss

    @State private var revealedPassword: String?
    @State private var authFailed = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Bilgiler") {
                    LabeledContent("Başlık", value: item.title)
                    LabeledContent("Kullanıcı Adı", value: item.username)
                }

                Section("Parola") {
                    if let password = revealedPassword {
                        HStack {
                            Text(password)
                                .font(.system(.body, design: .monospaced))
                            Spacer()
                            Button {
                                UIPasteboard.general.string = password
                            } label: {
                                Image(systemName: "doc.on.doc")
                            }
                        }
                    } else {
                        Button {
                            authenticateAndReveal()
                        } label: {
                            Label("Face ID / Touch ID ile Göster", systemImage: "faceid")
                        }
                    }

                    if authFailed {
                        Text("Doğrulama başarısız oldu, tekrar deneyin")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }

                if !item.notes.isEmpty {
                    Section("Notlar") {
                        Text(item.notes)
                    }
                }
            }
            .navigationTitle(item.title)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kapat") { dismiss() }
                }
            }
        }
    }

    private func authenticateAndReveal() {
        BiometricAuthService.shared.authenticate(
            reason: "Parolanızı görüntülemek için kimliğinizi doğrulayın"
        ) { result in
            switch result {
            case .success:
                authFailed = false
                revealedPassword = viewModel.revealPassword(for: item)
            case .failure:
                authFailed = true
            }
        }
    }
}

#Preview {
    SecretDetailView(
        viewModel: VaultViewModel(),
        item: SecretItem(title: "Test", username: "test@test.com", keychainKey: "test")
    )
}
