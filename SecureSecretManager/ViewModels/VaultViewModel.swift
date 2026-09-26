//
//  VaultViewModel.swift
//  SecureSecretManager


import Foundation
import CoreData
import Combine

@MainActor
final class VaultViewModel: ObservableObject {

    @Published var items: [SecretItem] = []
    @Published var errorMessage: String?

    private let context: NSManagedObjectContext
    private let keychainService = KeychainService.shared

    init(context: NSManagedObjectContext? = nil) {
        self.context = context ?? CoreDataStack.shared.context
        fetchItems()
    }


    func fetchItems() {
        let request: NSFetchRequest<SecretItemEntity> = SecretItemEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SecretItemEntity.updatedAt, ascending: false)]

        do {
            let entities = try context.fetch(request)
            items = entities.map { SecretItem(entity: $0) }
        } catch {
            errorMessage = "Kayıtlar yüklenemedi: \(error.localizedDescription)"
        }
    }


    func addItem(title: String, username: String, password: String, notes: String = "") {
        let keychainKey = UUID().uuidString

        do {
            try keychainService.save(key: keychainKey, value: password)

            let entity = SecretItemEntity(context: context)
            entity.id = UUID()
            entity.title = title
            entity.username = username
            entity.notes = notes
            entity.createdAt = Date()
            entity.updatedAt = Date()
            entity.keychainKey = keychainKey

            try context.save()
            fetchItems()
        } catch {
            errorMessage = "Kayıt eklenemedi: \(error.localizedDescription)"
        }
    }

    func revealPassword(for item: SecretItem) -> String? {
        do {
            return try keychainService.read(key: item.keychainKey)
        } catch {
            errorMessage = "Parola okunamadı: \(error.localizedDescription)"
            return nil
        }
    }

    func deleteItem(_ item: SecretItem) {
        let request: NSFetchRequest<SecretItemEntity> = SecretItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)

        do {
            if let entity = try context.fetch(request).first {
                context.delete(entity)
                try context.save()
            }
            try keychainService.delete(key: item.keychainKey)

            fetchItems()
        } catch {
            errorMessage = "Kayıt silinemedi: \(error.localizedDescription)"
        }
    }
}
