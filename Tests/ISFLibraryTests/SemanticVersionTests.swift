/*
    SemanticVersionTests.swift

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

import XCTest
@testable import ISFLibrary

class SemanticVersionTests: XCTestCase {
    func testSemanticVersion() {
        let version = SemanticVersion(major: 1, minor: 2, patch: 3)

        XCTAssertEqual(version.major, 1, "version.major != 1")
        XCTAssertEqual(version.minor, 2, "version.minor != 2")
        XCTAssertEqual(version.patch, 3, "version.patch != 3")

        if let temp = SemanticVersion(rawValue: version.description) {
            XCTAssertEqual(temp.major, 1, "temp.major != 1")
            XCTAssertEqual(temp.minor, 2, "temp.minor != 2")
            XCTAssertEqual(temp.patch, 3, "temp.patch != 3")
        } else {
            XCTAssert(false, "\(version.description) not converted to a SemanticVersion()!")
        }

        let versionString = "1.a.3"

        if let _ = SemanticVersion(rawValue: versionString) {
            XCTAssert(false, "\(versionString) converted to a SemanticVersion()!")
        }
    }

#if !os(OSX)
    static let allTests = [
        ("testSemanticVersion", testSemanticVersion)
    ]
#endif
}
