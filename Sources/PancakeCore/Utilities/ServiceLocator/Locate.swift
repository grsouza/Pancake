//
//  File.swift
//  
//
//  Created by Guilherme Souza on 18/09/20.
//

import Foundation

@propertyWrapper
public struct Locate<Service> {
    private var instance: Service

    public init(name: ServiceLocator.Name? = nil, locator: ServiceLocator = .main) {
        instance = locator.resolve(name: name)
    }

    public var wrappedValue: Service {
        get { instance }
        mutating set { instance = newValue }
    }
}

@propertyWrapper
public struct LazyLocate<Service> {

    public var name: ServiceLocator.Name?
    public var locator: ServiceLocator

    private var instance: Service?

    public init(name: ServiceLocator.Name? = nil, locator: ServiceLocator = .main) {
        self.name = name
        self.locator = locator
    }

    /// Returns `true` if the instance has not been injected yet, `false` otherwise.
    public var isEmpty: Bool { instance == nil }

    public var wrappedValue: Service {
        mutating get {
            if instance == nil {
                instance = locator.resolve(Service.self, name: name)
            }

            return instance!
        }
        mutating set { instance = newValue }
    }

    public var projectedValue: LazyLocate<Service> {
        get { self }
        mutating set { self = newValue }
    }

    public mutating func release() {
        instance = nil
    }
}

@propertyWrapper
public struct OptionalLocate<Service> {
    private var instance: Service?

    public init(name: ServiceLocator.Name? = nil, locator: ServiceLocator = .main) {
        instance = locator.optional(Service.self, name: name)
    }

    public var wrappedValue: Service? {
        get { instance }
        mutating set { instance = newValue }
    }
}
