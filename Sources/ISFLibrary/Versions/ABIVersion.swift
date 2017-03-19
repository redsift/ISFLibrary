/*
    ABIVersion.swift

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

public struct ABIVersion: VersionRepresentable {
    public fileprivate(set) var current: UInt = 0
    public fileprivate(set) var revision: UInt = 0
    public fileprivate(set) var age: UInt = 0

    public init(current: UInt, revision: UInt, age: UInt) {
        self.current = current
        self.revision = revision
        self.age = age
    }
}

extension ABIVersion: RawRepresentable {
    public init?(rawValue: String) {
        if let version = getVersion(from: rawValue) {
            self.current = version[0]
            self.revision = version[1]
            self.age = version[2]
        } else {
            return nil
        }
    }

    public var rawValue: String {
        return "\(current).\(revision).\(age)"
    }
}

extension ABIVersion: Comparable {
    public static func <(lhs: ABIVersion, rhs: ABIVersion) -> Bool {
        return ((lhs.current < rhs.current) ||
                (lhs.current == rhs.current && lhs.revision < rhs.revision) ||
                (lhs.current == rhs.current && lhs.revision == rhs.revision && lhs.age < rhs.age))
    }
}

extension ABIVersion: Equatable {
    public static func ==(lhs: ABIVersion, rhs: ABIVersion) -> Bool {
        return (lhs.current == rhs.current && lhs.revision == rhs.revision && lhs.age == rhs.age)
    }
}
