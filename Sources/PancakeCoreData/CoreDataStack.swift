import CoreData

public enum CoreDataStackContextType {
    case work, background
}

public enum CoreDataStackStoreType: Equatable {
    case inMemory
    case sqlite(storeURL: URL)

    public var nsStoreType: String {
        switch self {
        case .inMemory: return NSInMemoryStoreType
        case .sqlite: return NSSQLiteStoreType
        }
    }

    public var storeURL: URL? {
        switch self {
        case .inMemory: return nil
        case .sqlite(let url): return url
        }
    }
}

public protocol CoreDataStack: AnyObject {
    init(
        storeType: CoreDataStackStoreType,
        storeName: String,
        managedObjectModel: NSManagedObjectModel
    )

    func context(withType type: CoreDataStackContextType) -> NSManagedObjectContext
}
