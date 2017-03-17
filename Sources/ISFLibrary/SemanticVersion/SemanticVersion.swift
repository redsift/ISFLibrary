/*
    SemanticVersion.swift

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

public struct SemanticVersion {
    public var major: UInt
    public var minor: UInt
    public var patch: UInt

    public init(major: UInt, minor: UInt, patch: UInt) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

extension SemanticVersion: RawRepresentable {
    public init?(rawValue: String) {
        let version = rawValue.components(separatedBy: CharacterSet(charactersIn: "."))

        guard (version.count == 3 && version[0].isNumber && version[1].isNumber && version[2].isNumber) else {
            return nil
        }

        self.major = UInt(version[0])!
        self.minor = UInt(version[1])!
        self.patch = UInt(version[2])!
    }

    public var rawValue: String {
        return "\(major).\(minor).\(patch)"
    }
}

extension SemanticVersion: Equatable {
    public static func ==(lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        return (lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch == rhs.patch)
    }
}

extension SemanticVersion: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}
