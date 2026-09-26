//
//  AddSecretView.swift
//  SecureSecretManager
import SwiftUI

struct AddSecretView: View {
    @ObservedObject var viewModel: VaultViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var username = ""
    @State private var password = ""
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Bilgiler") {
                    TextField("Başlık (örn. Gmail)", text: $title)
                    TextField("Kullanıcı Adı / E-posta", text: $username)
                    SecureField("Parola", text: $password)
                }
                Section("Notlar (opsiyonel)") {
                    TextField("Not ekle", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Yeni Kayıt")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Vazgeç") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        viewModel.addItem(
                            title: title,
                            username: username,
                            password: password,
                            notes: notes
                        )
                        dismiss()
                    }
                    .disabled(title.isEmpty || password.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddSecretView(viewModel: VaultViewModel())
}
