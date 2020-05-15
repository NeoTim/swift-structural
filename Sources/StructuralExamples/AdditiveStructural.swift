import StructuralCore

/// A duplicate, simplified version of the `Additive` protocol.
/// - Note: a duplicate protocol is used to avoid triggering existing `Equatable` derived
///   conformances.
public protocol AdditiveStructural {
    static func + (lhs: Self, rhs: Self) -> Self
}

// Inductive cases. 

extension Cons: AdditiveStructural
where Value: AdditiveStructural, Next: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Cons(lhs.value + rhs.value, lhs.next + rhs.next)
    }
}

extension Either: AdditiveStructural
where Left: AdditiveStructural, Right: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        switch (lhs, rhs) {
        case let (.left(lhsLeft), .left(rhsLeft)):
            return .left(lhsLeft + rhsLeft)
        case let (.right(lhsRight), .right(rhsRight)):
            return .right(lhsRight + rhsRight)
        default:
            fatalError("Mismatch: \(lhs), \(rhs)")
        }
    }
}

extension Case: AdditiveStructural
where AssociatedValues: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Case(lhs.rawValue, lhs.associatedValues + rhs.associatedValues)
    }
}

extension Property: AdditiveStructural
where Value: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Property(lhs.value + rhs.value)
    }
}

extension Struct: AdditiveStructural where Properties: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Struct(lhs.properties + rhs.properties)
    }
}

extension Enum: AdditiveStructural where Cases: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Enum(lhs.cases + rhs.cases)
    }
}

// Base cases.

extension Empty: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Empty()
    }
}

extension Int: AdditiveStructural {}

extension Float: AdditiveStructural {}

extension Double: AdditiveStructural {}

// Sugar

extension AdditiveStructural where Self: Structural, Self.AbstractValue: AdditiveStructural {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return .init(abstractValue: lhs.abstractValue + rhs.abstractValue)
    }
}
