
public final class ServiceLocator {

    public struct Name: RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }

    public typealias Factory<Service> = () -> Service

    public static var main = ServiceLocator()

    private struct MutableState {
        var factories: [String: Any] = [:]
        var instances: [String: Weak<AnyObject>] = [:]
    }

    private let lock = Lock.make()
    private var mutableState = MutableState()

    public init() {}

    public func register<Service>(
        _ metaType: Service.Type = Service.self,
        name: Name? = nil,
        factory: @escaping Factory<Service>
    ) {
        let key = makeKey(forMetaType: metaType, name: name?.rawValue)

        lock.around {
            precondition(
                mutableState.factories[key] == nil,
                "Service of type \(metaType) registered twice with the same key."
            )
            mutableState.factories[key] = factory
        }
    }

    public func resolve<Service>(
        _ metaType: Service.Type = Service.self,
        name: Name? = nil
    ) -> Service {
        let key = makeKey(forMetaType: metaType, name: name?.rawValue)

        guard let instance = optional(metaType, name: name) else {
            fatalError("Could not find instance of type \(metaType) with key \(key), maybe you forgot to register it.")
        }

        return instance
    }

    public func optional<Service>(
        _ metaType: Service.Type = Service.self,
        name: Name? = nil
    ) -> Service? {
        let key = makeKey(forMetaType: metaType, name: name?.rawValue)

        return lock.around {
            if let instance = mutableState.instances[key]?.value as? Service {
                return instance
            }

            if let factory = mutableState.factories[key] as? Factory<Service> {
                let instance = factory()
                mutableState.instances[key] = Weak(instance as AnyObject)
                return instance
            }

            return nil
        }
    }

    // MARK: - Static Methods

    public static func register<Service>(
        _ metaType: Service.Type = Service.self,
        name: Name? = nil,
        factory: @escaping Factory<Service>
    ) {
        ServiceLocator.main.register(metaType, name: name, factory: factory)
    }

    public static func resolve<Service>(
        _ metaType: Service.Type = Service.self,
        name: Name? = nil
    ) -> Service {
        ServiceLocator.main.resolve(metaType, name: name)
    }

    public static func optional<Service>(
        _ metaType: Service.Type = Service.self,
        name: Name? = nil
    ) -> Service? {
        ServiceLocator.main.optional(metaType, name: name)
    }

    // MARK: - Private Methods

    private func makeKey<Service>(forMetaType metaType: Service.Type, name: String?) -> String {
        if let name = name {
            return "\(metaType)-\(name)"
        }

        return "\(metaType)"
    }

}
