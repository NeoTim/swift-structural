import StructuralCore

// Protocol that mutates itself by
// the value of the inplaceAdd function argument.
public protocol InplaceAddStructural {
    mutating func inplaceAdd(_ other: Self)
}

// Inductive cases. 

extension Struct: InplaceAddStructural where Properties: InplaceAddStructural {
    public mutating func inplaceAdd(_ other: Self) {
        self.properties.inplaceAdd(other.properties)
    }
}

extension Property: InplaceAddStructural
where Value: InplaceAddStructural, Next: InplaceAddStructural {
    public mutating func inplaceAdd(_ other: Self) {
        if isMutable {
            self.value.inplaceAdd(other.value)
            next.inplaceAdd(other.next)
        } else {
            next.inplaceAdd(other.next)
        }
    }
}

// Base cases. 

extension Empty: InplaceAddStructural {
    public mutating func inplaceAdd(_ other: Self) {}
}

extension Int: InplaceAddStructural {
    public mutating func inplaceAdd(_ other: Self) {
        self += other
    }
}

extension Float: InplaceAddStructural {
    public mutating func inplaceAdd(_ other: Self) {
        self += other
    }
}

// Sugar

extension InplaceAddStructural where Self: Structural, Self.AbstractValue: InplaceAddStructural {
    public mutating func inplaceAdd(_ other: Self) {
        var shape = self.abstractValue
        shape.inplaceAdd(other.abstractValue)
        self = .init(abstractValue: shape)
    }
}
