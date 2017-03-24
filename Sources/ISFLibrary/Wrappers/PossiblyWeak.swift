/*
    PossiblyWeak.swift

    Copyright (c) 2017 Stephen Whittle  All rights reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
*/

/// A enum wrapper around a type (usually a class type) so its ownership can be
/// set at runtime.
public enum PossiblyWeak<T: AnyObject> {
    case StrongType(T)
    case WeakType(Weak<T>)
        
    public init(strong value: T) {
        self = PossiblyWeak<T>.StrongType(value)
    }
                    
    public init(weak value: T) {
        self = PossiblyWeak<T>.WeakType(Weak(value))
    }
                                
    public var value: T? {
        switch self {
            case .StrongType(let strongType):
                return strongType
            case .WeakType(let weakType):
                return weakType.value
        }
    }
                                                          
    public func contains(_ other: T) -> Bool {
        switch self {
            case .StrongType(let strongType):
                return (strongType === other)
            case .WeakType(let weakType):
                if let type = weakType.value {
                    return (type === other)
                }

                return false
        }
    }
}

extension PossiblyWeak: CustomStringConvertible {
    public var description: String {
        switch self {
            case .StrongType(let value):
                return "\(value)"
            case .WeakType(let value):
                return "\(value)"
        }
    }
}
