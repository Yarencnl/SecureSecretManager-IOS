//
//  CoreDataStack.swift
//  SecureSecretManager

import Foundation
import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SecureSecretManager")

        if let storeDescription = container.persistentStoreDescriptions.first {
            storeDescription.setOption(
                FileProtectionType.complete as NSObject,
                forKey: NSPersistentStoreFileProtectionKey
            )
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data yüklenemedi: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }


    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("❌ Core Data kayıt hatası: \(error)")
        }
    }
}
