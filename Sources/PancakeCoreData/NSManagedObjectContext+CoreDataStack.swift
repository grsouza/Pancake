import CoreData

extension NSManagedObjectContext {

    public typealias ContextClosure<T> = () throws -> T
    public typealias ContextCompletionClosure<T> = (Result<T, Error>) -> Void

    public func performThrowing<T>(
        _ closure: @escaping ContextClosure<T>,
        completion: @escaping ContextCompletionClosure<T>
    ) {
        perform {
            do {
                let result = Result { try closure() }
                completion(result)
            }
        }
    }

    public func performThrowingAndWait<T>(_ closure: @escaping ContextClosure<T>) throws -> T {
        var result: Result<T, Error>!

        performAndWait {
            result = Result { try closure() }
        }

        return try result.get()
    }
}

// MARK: - persistChanges

extension NSManagedObjectContext {
    public func persistChanges(
        _ description: String,
        saveParent: Bool = true,
        waitForParent: Bool = false
    ) throws {
        try persistChanges()

        guard saveParent, let parent = parent else {
            return
        }

        var parentError: Error?

        let parentSave = {
            do {
                try parent.persistChanges()
            } catch {
                parentError = error
            }
        }

        if waitForParent {
            parent.performAndWait(parentSave)
        } else {
            parent.perform(parentSave)
        }

        if let parentError = parentError {
            throw parentError
        }
    }

    private func persistChanges() throws {
        guard hasChanges else {
            return
        }

        do {
            try save()
        } catch {
            // TODO: log error
            rollback()
            throw error
        }
    }
}

// MARK: - Parent Coordinator & Store type

extension NSManagedObjectContext {

    public var topLevelPersistentStoreCoordinator: NSPersistentStoreCoordinator? {
        switch (persistentStoreCoordinator, parent) {
        case (let persistentStoreCoordinator?, _):
            return persistentStoreCoordinator
        case (_, let parent?):
            return parent.topLevelPersistentStoreCoordinator
        default:
            return nil
        }
    }

    public var isSQLiteStoreBased: Bool {

        switch topLevelPersistentStoreCoordinator?.firstStoreType {
        case .sqlite?:
            return true
        default:
            return false
        }
    }
}
