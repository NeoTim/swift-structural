import GenericCore

/// A duplicate, simplified version of the `Additive` protocol.
/// - Note: a duplicate protocol is used to avoid triggering existing `Equatable` derived
///   conformances.
public protocol AdditiveGeneric {
    static func + (lhs: Self, rhs: Self) -> Self
}

// Inductive cases. 

extension Case: AdditiveGeneric
where A: AdditiveGeneric, B: AdditiveGeneric {
    public static func + (lhs: Self, rhs: Self) -> Self {
        switch (lhs, rhs) {
        case let (.of(name, index, x), .of(_, _, y)):
            return .of(name, index, x + y)
        case let (.next(x), .next(y)):
            return .next(x + y)
        default:
            fatalError("Mismatch: \(lhs), \(rhs)")
        }
    }
}

extension Field: AdditiveGeneric
where A: AdditiveGeneric, B: AdditiveGeneric {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Field(lhs.value + rhs.value, lhs.next + rhs.next)
    }
}

extension Struct: AdditiveGeneric where A: AdditiveGeneric {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Struct(lhs.shape + rhs.shape)
    }
}

extension Enum: AdditiveGeneric where A: AdditiveGeneric {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Enum(lhs.shape + rhs.shape)
    }
}

// Base cases.

extension Empty: AdditiveGeneric {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Empty()
    }
}

extension Int: AdditiveGeneric {}

extension Float: AdditiveGeneric {}

extension Double: AdditiveGeneric {}

// Sugar

extension AdditiveGeneric where Self: Generic, Self.Representation: AdditiveGeneric {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return .init(representation: lhs.representation + rhs.representation)
    }
}
