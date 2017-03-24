/*
    Result.swift

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

/// Either a Value value or an ErrorType
public enum Result<T> {
    case Success(T)       // Success wraps a T value
    case Failure(Error)   // Failure wraps an Error

    /// Construct a result from a `throws` function
    public init(_ capturing: () throws -> T) {
        do {
            self = .Success(try capturing())
        } catch {
            self = .Failure(error)
        }
    }

    /// Convenience tester/getter for the value
    public var value: T? {
        switch self {
            case .Success(let v):
                return v
            case .Failure:
                return nil
        }
    }

    /// Convenience tester/getter for the error
    public var error: Error? {
        switch self {
            case .Success:
                return nil
            case .Failure(let e):
                return e
        }
    }

    /// Test whether the result is an error.
    public var isError: Bool {
        switch self {
            case .Success:
                return false
            case .Failure:
                return true
        }
    }

    /// Adapter method used to convert a Result to a value while throwing on error.
    public func unwrap() throws -> T {
        switch self {
            case .Success(let v):
                return v
            case .Failure(let e):
                throw e
        }
    }

    /// Chains another Result to this one. In the event that this Result is a .Success,
    /// the provided transformer closure is used to generate another Result (wrapping a
    /// potentially new type). In the event that this Result is a .Failure, the next
    /// Result will have the same error as this one.
    public func flatMap<U>(_ transform: (T) -> Result<U>) -> Result<U> {
        switch self {
            case .Success(let v):
                return transform(v)
            case .Failure(let e):
                return .Failure(e)
        }
    }

    /// Chains another Result to this one. In the event that this Result is a .Success,
    /// the provided transformer closure is used to transform the value into another value
    /// (of a potentially new type) and a new Result is made from that value. In the event
    /// that this Result is a .Failure, the next Result will have the same error as this one.
    public func map<U>(_ transform: (T) throws -> U) -> Result<U> {
        switch self {
            case .Success(let v):
                return Result<U> {
                    try transform(v)
                }
            case .Failure(let e):
                return .Failure(e)
        }
    }
}

extension Result: CustomStringConvertible {
    public var description: String {
        switch self {
            case .Success(let v):
                return "\(v)"
            case .Failure(let e):
                return "\(e)"
        }
    }
}
