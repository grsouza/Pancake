import CoreData

open class NestedContextCoreDataStack: CoreDataStack {
    private let backgroundContext: NSManagedObjectContext
    private let workContext: NSManagedObjectContext

    public convenience required init(
        storeType: CoreDataStackStoreType,
        storeName: String,
        managedObjectModel: NSManagedObjectModel
    ) {
        self.init(
            storeType: storeType,
            storeName: storeName,
            managedObjectModel: managedObjectModel,
            // use parameter to avoid infinite loop since Swift won't use the designated initializer below 🤷‍♂️
            shouldAddStoreAsynchronously: false
        )
    }

    public init(
        storeType: CoreDataStackStoreType,
        storeName: String,
        managedObjectModel: NSManagedObjectModel,
        shouldAddStoreAsynchronously: Bool = false,
        shouldMigrateStoreAutomatically: Bool = true,
        shouldInferMappingModelAutomatically: Bool = true,
        storeLoadCompletionHandler: @escaping (Any, Error?) -> Void = { store, error in
            if let error = error {
                fatalError("💥 Failed to load persistent store \(store)! Error: \(error)")
            }
        },
        workContextConcurrencyType: NSManagedObjectContextConcurrencyType = .privateQueueConcurrencyType,
        mergePolicy: NSMergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)
    ) {
        backgroundContext = NestedContextCoreDataStack.makeBackgroundContext(
            storeType: storeType,
            storeName: storeName,
            managedObjectModel: managedObjectModel,
            shouldAddStoreAsynchronously: shouldAddStoreAsynchronously,
            shouldMigrateStoreAutomatically: shouldMigrateStoreAutomatically,
            shouldInferMappingModelAutomatically: shouldInferMappingModelAutomatically,
            storeLoadCompletionHandler: storeLoadCompletionHandler
        )

        backgroundContext.name = "Background (persisting)"
        backgroundContext.mergePolicy = mergePolicy

        workContext = NSManagedObjectContext(concurrencyType: workContextConcurrencyType)
        workContext.parent = backgroundContext
        workContext.name = "Work (\(workContextConcurrencyType.typeString))"
    }

    public func context(withType type: CoreDataStackContextType) -> NSManagedObjectContext {
        switch type {
        case .work: return workContext
        case .background: return backgroundContext
        }
    }
}

extension NestedContextCoreDataStack {

    public static func makeBackgroundContext(
        storeType: CoreDataStackStoreType,
        storeName: String,
        managedObjectModel: NSManagedObjectModel,
        shouldAddStoreAsynchronously: Bool,
        shouldMigrateStoreAutomatically: Bool,
        shouldInferMappingModelAutomatically: Bool,
        storeLoadCompletionHandler: @escaping (Any, Error?) -> Void
    ) -> NSManagedObjectContext {
        let container = NestedContextCoreDataStack.makePersistentContainer(
            withType: storeType,
            name: storeName,
            managedObjectModel: managedObjectModel,
            shouldAddStoreAsynchronously: shouldAddStoreAsynchronously,
            shouldMigrateStoreAutomatically: shouldMigrateStoreAutomatically,
            shouldInferMappingModelAutomatically: shouldInferMappingModelAutomatically,
            storeLoadCompletionHandler: storeLoadCompletionHandler
        )

        return container.newBackgroundContext()
    }
}

// MARK: MainQueue
public final class MainQueueNestedContextCoreDataStack: NestedContextCoreDataStack {

    public required init(
        storeType: CoreDataStackStoreType,
        storeName: String,
        managedObjectModel: NSManagedObjectModel
    ) {

        super.init(
            storeType: storeType,
            storeName: storeName,
            managedObjectModel: managedObjectModel,
            workContextConcurrencyType: .mainQueueConcurrencyType
        )
    }
}

// MARK: PrivateQueue
public typealias PrivateQueueNestedContextCoreDataStack = NestedContextCoreDataStack

// MARK: Utils
extension NSManagedObjectContextConcurrencyType {

    fileprivate var typeString: String {

        switch self {
        case .confinementConcurrencyType: return "confinement"
        case .mainQueueConcurrencyType: return "mainQueue"
        case .privateQueueConcurrencyType: return "privateQueue"
        @unknown
        default: return "unknown"
        }
    }
}