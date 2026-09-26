//
//  SecretItem.swift
//  SecureSecretManager

import Foundation

struct SecretItem: Identifiable {
    let id: UUID
    var title: String
    var username: String
    var notes: String
    var createdAt: Date
    var updatedAt: Date
    let keychainKey: String

    init(entity: SecretItemEntity) {
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.username = entity.username ?? ""
        self.notes = entity.notes ?? ""
        self.createdAt = entity.createdAt ?? Date()
        self.updatedAt = entity.updatedAt ?? Date()
        self.keychainKey = entity.keychainKey ?? ""
    }

    init(
        id: UUID = UUID(),
        title: String,
        username: String,
        notes: String = "",
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        keychainKey: String
    ) {
        self.id = id
        self.title = title
        self.username = username
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.keychainKey = keychainKey
    }
}
