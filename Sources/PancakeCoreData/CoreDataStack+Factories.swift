import CoreData

extension CoreDataStack {
    // MARK: NSPersistentContainer

    public static func makePersistentContainer(
        withType storeType: CoreDataStackStoreType,
        name: String,
        managedObjectModel: NSManagedObjectModel,
        shouldAddStoreAsynchronously: Bool = false,
        shouldMigrateStoreAutomatically: Bool = true,
        shouldInferMappingModelAutomatically: Bool = true,
        storeLoadCompletionHandler: @escaping (NSPersistentStoreDescription, Error?) -> Void = { store, error in
            if let error = error {
                fatalError("💥 Failed to load persistent store \(store)! Error: \(error)")
            }
        }
    ) -> NSPersistentContainer {
        let storeDescription = NSPersistentStoreDescription(storeType: storeType)
        storeDescription.shouldAddStoreAsynchronously = shouldAddStoreAsynchronously
        storeDescription.shouldMigrateStoreAutomatically = shouldMigrateStoreAutomatically
        storeDescription.shouldInferMappingModelAutomatically = shouldInferMappingModelAutomatically

        let container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)

        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: storeLoadCompletionHandler)

        return container
    }
}

extension NSPersistentStoreDescription {
    public convenience init(storeType: CoreDataStackStoreType) {
        switch storeType {
        case .inMemory:
            self.init()
            type = NSInMemoryStoreType
        case .sqlite(let url):
            self.init(url: url)
            type = NSSQLiteStoreType
        }
    }
}
