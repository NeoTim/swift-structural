import Foundation
import StructuralCore

public func decodeJSONObject(from value: String) -> Any {
    let data = value.data(using: .utf8)!
    let parsed = try! JSONSerialization.jsonObject(with: data)
    return parsed
}

public func decodeJSONString<T: DecodeJSONStructural>(from input: String, into out: inout T) {
    out.decodeJson(decodeJSONObject(from: input))
}
// Protocol that mutates itself by decoding
// the parsed JSON-encoded argument. 
public protocol DecodeJSONStructural {
    mutating func decodeJson(_ other: Any)
}

// Inductive cases. 

extension Struct: DecodeJSONStructural where A: DecodeJSONStructural {
    public mutating func decodeJson(_ other: Any) {
        shape.decodeJson(other)
    }
}

extension Field: DecodeJSONStructural where A: DecodeJSONStructural, B: DecodeJSONStructural {
    public mutating func decodeJson(_ other: Any) {
        let dict = other as! [String: Any]
        self.value.decodeJson(dict[self.name]!)
        self.next.decodeJson(other)
    }
}

// Base cases. 

extension Empty: DecodeJSONStructural {
    public mutating func decodeJson(_ other: Any) {}
}

extension Int: DecodeJSONStructural {
    public mutating func decodeJson(_ other: Any) {
        self = other as! Int
    }
}

extension Float: DecodeJSONStructural {
    public mutating func decodeJson(_ other: Any) {
        self = other as! Float
    }
}

extension String: DecodeJSONStructural {
    public mutating func decodeJson(_ other: Any) {
        self = other as! String
    }
}

extension Array: DecodeJSONStructural where Element: DecodeJSONStructural, Element: ZeroStructural {
    public mutating func decodeJson(_ other: Any) {
        let arr = other as! [Any]
        self = []
        self.reserveCapacity(arr.count)
        for el in arr {
            var decoded = zero(Element.self)
            decoded.decodeJson(el)
            self.append(decoded)
        }
    }
}

// Sugar

extension DecodeJSONStructural where Self: Structural, Self.Representation: DecodeJSONStructural {
    public mutating func decodeJson(_ other: Any) {
        var shape = self.representation
        shape.decodeJson(other)
        self = .init(representation: shape)
    }
}
