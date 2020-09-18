import Foundation

extension Data {
    public var bytes: [UInt8] {
        [UInt8](self)
    }

    public func string(encoding: String.Encoding) -> String? {
        String(data: self, encoding: encoding)
    }

    public func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        try JSONSerialization.jsonObject(with: self, options: options)
    }
}
