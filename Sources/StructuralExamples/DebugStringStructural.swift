import StructuralCore

/// A duplicate protocol, similar to CustomDebugStringConvertible
public protocol DebugStringStructural {
    var debugDescriptionStructural: String { get }
}

// Inductive cases. 

extension Struct: DebugStringStructural where Properties: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return "\(self.name)(\(properties.debugDescriptionStructural))"
    }
}

extension Cons: DebugStringStructural
where Value: DebugStringStructural, Next: DebugStringStructural {
    public var debugDescriptionStructural: String {
        let valueString = self.value.debugDescriptionStructural
        let nextString = self.next.debugDescriptionStructural
        if nextString == "" {
            return valueString
        } else {
            return "\(valueString), \(nextString)"
        }
    }
}

extension Property: DebugStringStructural
where Value: DebugStringStructural {
    public var debugDescriptionStructural: String {
        if self.name == "" {
            return self.value.debugDescriptionStructural
        } else {
            return "\(self.name): \(self.value.debugDescriptionStructural)"
        }
    }
}

extension Enum: DebugStringStructural where Cases: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return "\(self.name).\(self.cases.debugDescriptionStructural)"
    }
}

extension Case: DebugStringStructural
where AssociatedValues: DebugStringStructural, Next: DebugStringStructural {
    public var debugDescriptionStructural: String {
        switch self {
        case let .of(name, _, values):
            let valuesString = values.debugDescriptionStructural
            if (valuesString == "") {
                return name
            } else {
                return "\(name)(\(valuesString))"
            }
        case let .next(next):
            return next.debugDescriptionStructural
        }
    }
}

// Base cases.

extension Empty: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return ""
    }
}

extension String: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return String(reflecting: self)
    }
}

extension Int: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return String(reflecting: self)
    }
}

extension Float: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return String(reflecting: self)
    }
}

extension Double: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return String(reflecting: self)
    }
}

// Sugar

extension DebugStringStructural where Self: Structural, Self.AbstractValue: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return self.abstractValue.debugDescriptionStructural
    }
}
