// MARK: - UnionProtocol

public protocol UnionProtocol {
    associatedtype Value1
    associatedtype Value2
}

// MARK: - Union

@propertyWrapper
public struct Union<Value1, Value2>: UnionProtocol {
    public let wrappedValue: Any

    public init(wrappedValue: Value1) {
        self.wrappedValue = wrappedValue
    }

    public init(wrappedValue: Value2) {
        self.wrappedValue = wrappedValue
    }

    public init(_ value: Any) {
        self.init(wrappedValue: value)
    }

    public init(wrappedValue: Any) {
        if wrappedValue is Value1 {
            self.wrappedValue = wrappedValue
        }
        else if wrappedValue is Value2 {
            self.wrappedValue = wrappedValue
        }
        else if let value2Type = Value2.self as? _UnionProtocol.Type {
            if value2Type.allUnionTypes.contains(where: { $0 == type(of: wrappedValue) }) {
                self.wrappedValue = wrappedValue
            }
            else {
                fatalError("`wrappedValue` (\(wrappedValue): \(type(of: wrappedValue))) is not included in Union type `\(value2Type.allUnionTypes)`.")
            }
        }
        else {
            fatalError("Should never reach here.")
        }
    }

    public var projectedValue: Union<Value1, Value2> {
        self
    }
}

// MARK: - _UnionProtocol

fileprivate protocol _UnionProtocol {
    static var allUnionTypes: [Any.Type] { get }
}

extension Union: _UnionProtocol {
    fileprivate static var allUnionTypes: [Any.Type] {
        if let value2Type = Value2.self as? _UnionProtocol.Type {
            return [Value1.self] + value2Type.allUnionTypes
        }
        else {
            return [Value1.self, Value2.self]
        }
    }
}

// MARK: - value(of:)

extension Union {
    public func value(of type: Value1.Type) -> Value1? {
        wrappedValue as? Value1
    }

    public func value(of type: Value2.Type) -> Value2? {
        wrappedValue as? Value2
    }
}

extension Union where Value2: UnionProtocol {
    public func value(of type: Value2.Value1.Type) -> Value2.Value1? {
        wrappedValue as? Value2.Value1
    }

    public func value(of type: Value2.Value2.Type) -> Value2.Value2? {
        wrappedValue as? Value2.Value2
    }
}

extension Union where Value2: UnionProtocol, Value2.Value2: UnionProtocol {
    public func value(of type: Value2.Value2.Value1.Type) -> Value2.Value2.Value1? {
        wrappedValue as? Value2.Value2.Value1
    }

    public func value(of type: Value2.Value2.Value2.Type) -> Value2.Value2.Value2? {
        wrappedValue as? Value2.Value2.Value2
    }
}

extension Union where Value2: UnionProtocol, Value2.Value2: UnionProtocol, Value2.Value2.Value2: UnionProtocol {
    public func value(of type: Value2.Value2.Value2.Value1.Type) -> Value2.Value2.Value2.Value1? {
        wrappedValue as? Value2.Value2.Value2.Value1
    }

    public func value(of type: Value2.Value2.Value2.Value2.Type) -> Value2.Value2.Value2.Value2? {
        wrappedValue as? Value2.Value2.Value2.Value2
    }
}

// MARK: - UnionN

public typealias Union3<T1, T2, T3> = Union<T1, Union<T2, T3>>
public typealias Union4<T1, T2, T3, T4> = Union<T1, Union3<T2, T3, T4>>
public typealias Union5<T1, T2, T3, T4, T5> = Union<T1, Union4<T2, T3, T4, T5>>

// MARK: - Protocol conformances

// FIXME: This is NOT correct impl when `Value2` is also `Union`.
//
//extension Union: Equatable where Value1: Equatable, Value2: Equatable {
//    public static func == (lhs: Union<Value1, Value2>, rhs: Union<Value1, Value2>) -> Bool {
//        lhs.value(of: Value1.self) == rhs.value(of: Value1.self)
//            ||  lhs.value(of: Value2.self) == rhs.value(of: Value2.self)
//    }
//}
//
//extension Union: Hashable where Value1: Hashable, Value2: Hashable {
//    public func hash(into hasher: inout Hasher) {
//        if let value = value(of: Value1.self) {
//            value.hash(into: &hasher)
//            "\(Value1.self)".hash(into: &hasher)
//        }
//        else if let value = value(of: Value2.self) {
//            value.hash(into: &hasher)
//            "\(Value2.self)".hash(into: &hasher)
//        }
//    }
//}
