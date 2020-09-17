import CoreData

public protocol CoreDataEntity: NSFetchRequestResult {
    static var entityName: String { get }
}

extension CoreDataEntity where Self: NSManagedObject {
    public static var entityName: String { "\(Self.self)" }

    public static func fetchRequest<ResultType: NSFetchRequestResult>() -> NSFetchRequest<ResultType> {
        NSFetchRequest(entityName: entityName)
    }

    public static func batchUpdateRequest() -> NSBatchUpdateRequest {
        NSBatchUpdateRequest(entity: entity())
    }
}
