/*
    RegularExpression.swift

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

import Foundation

public func makeRegex(with pattern: String, options: RegularExpression.Options = []) throws -> RegularExpression {
    return try RegularExpression(pattern: pattern, options: options)
}

public extension String {
    public func match(with pattern: RegularExpression) -> Int {
        return pattern.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: self.characters.count))
    }

    public func match(with pattern: RegularExpression) -> Bool {
        return (self.match(with: pattern) > 0)
    }

    public func match(with pattern: String, options: RegularExpression.Options = []) throws -> Int {
        return try self.match(with: makeRegex(with: pattern, options: options))
    }

    public func match(with pattern: String, options: RegularExpression.Options = []) throws -> Bool {
        return try (self.match(with: pattern, options: options) > 0)
    }
}

infix operator =~: ComparisonPrecedence
infix operator !~: ComparisonPrecedence

@inline(__always)
public func =~(lhs: String, pattern: RegularExpression) -> Bool {
    return (!lhs.isEmpty && lhs.match(with: pattern))
}

@inline(__always)
public func !~(lhs: String, pattern: RegularExpression) -> Bool {
    return (lhs.isEmpty || !lhs.match(with: pattern))
}

@inline(__always)
public func =~(lhs: String, pattern: String) -> Bool {
    if let result = wrapper(do: {
                                return try (!lhs.isEmpty && lhs.match(with: pattern))
                            },
                            catch: { failure in
                                logger(failure)
                            },
                            capture: {
                                return [lhs, "~=", pattern]
                            }) {
        return result
    }

    return false
}

@inline(__always)
public func !~(lhs: String, pattern: String) -> Bool {
    if let result = wrapper(do: {
                                return try (lhs.isEmpty || !lhs.match(with: pattern))
                            },
                            catch: { failure in
                                logger(failure)
                            },
                            capture: {
                                return [lhs, "~=", pattern]
                            }) {
        return result
    }

    return false
}
