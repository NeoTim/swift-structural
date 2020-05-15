import StructuralCore

/// A duplicate protocol, similar to CustomDebugStringConvertible
public protocol DebugStringStructural {
    var debugDescriptionStructural: String { get }
}

// Inductive cases. 

extension Struct: DebugStringStructural where A: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return "\(self.name)(\(self.shape.debugDescriptionStructural))"
    }
}

extension Field: DebugStringStructural where A: DebugStringStructural, B: DebugStringStructural {
    public var debugDescriptionStructural: String {
        var fld: String
        if self.name == "" {
            fld = self.value.debugDescriptionStructural
        } else {
            fld = "\(self.name): \(self.value.debugDescriptionStructural)"
        }
        let rest = next.debugDescriptionStructural
        if rest == "" {
            return fld
        } else {
            return "\(fld), \(rest)"
        }
    }
}

extension Enum: DebugStringStructural where A: DebugStringStructural {
    public var debugDescriptionStructural: String {
        return "\(self.name).\(self.shape.debugDescriptionStructural)"
    }
}

extension Case: DebugStringStructural where A: DebugStringStructural, B: DebugStringStructural {
    public var debugDescriptionStructural: String {
        switch self {
        case let .of(name, _, shape):
            let fields = shape.debugDescriptionStructural
            if (fields == "") {
                return name
            } else {
                return "\(name)(\(fields))"
            }
        case let .next(shape):
            return shape.debugDescriptionStructural
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
