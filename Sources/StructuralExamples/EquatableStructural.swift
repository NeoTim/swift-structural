import StructuralCore

/// A duplicate, simplified version of the `Equatable` protocol.
/// - Note: a duplicate protocol is used to avoid triggering existing `Equatable` derived
///   conformances.
public protocol EquatableStructural {
    func genericEqual(_ other: Self) -> Bool
}

// Inductive cases.

extension Cons: EquatableStructural
where Value: EquatableStructural, Next: EquatableStructural {
    public func genericEqual(_ other: Self) -> Bool {
        return value.genericEqual(other.value) && next.genericEqual(other.next)
    }
}

extension Case: EquatableStructural
where AssociatedValues: EquatableStructural, Next: EquatableStructural {
    public func genericEqual(_ other: Self) -> Bool {
        switch (self, other) {
        case let (.of(_, _, x), .of(_, _, y)):
            return x.genericEqual(y)
        case let (.next(x), .next(y)):
            return x.genericEqual(y)
        default:
            return false
        }
    }
}

extension Property: EquatableStructural
where Value: EquatableStructural {
    public func genericEqual(_ other: Self) -> Bool {
        return value.genericEqual(other.value)
    }
}

extension Enum: EquatableStructural where Cases: EquatableStructural {
    public func genericEqual(_ other: Self) -> Bool {
        cases.genericEqual(other.cases)
    }
}

extension Struct: EquatableStructural where Properties: EquatableStructural {
    public func genericEqual(_ other: Self) -> Bool {
        properties.genericEqual(other.properties)
    }
}

// Base cases.

extension Empty: EquatableStructural {
    public func genericEqual(_ other: Empty) -> Bool {
        return true
    }
}

extension Int: EquatableStructural {
    public func genericEqual(_ other: Int) -> Bool {
        return self == other
    }
}

extension Float: EquatableStructural {
    public func genericEqual(_ other: Float) -> Bool {
        return self == other
    }
}

extension Double: EquatableStructural {
    public func genericEqual(_ other: Double) -> Bool {
        return self == other
    }
}

// Syntactic Sugar

extension EquatableStructural where Self: Structural, Self.AbstractValue: EquatableStructural {
    public func genericEqual(_ other: Self) -> Bool {
        return self.abstractValue.genericEqual(other.abstractValue)
    }
}
