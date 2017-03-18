/*
    ABIVersionTests.swift

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

class ABIVersionTests: XCTestCase {
    func testABIVersion() {
        let version = ABIVersion(current: 1, revision: 2, age: 3)

        XCTAssertEqual(version.current, 1, "version.current != 1")
        XCTAssertEqual(version.revision, 2, "version.revision != 2")
        XCTAssertEqual(version.age, 3, "version.age != 3")

        if let temp = ABIVersion(rawValue: version.description) {
            XCTAssertEqual(temp.current, 1, "temp.current != 1")
            XCTAssertEqual(temp.revision, 2, "temp.revision != 2")
            XCTAssertEqual(temp.age, 3, "temp.age != 3")
        } else {
            XCTAssert(false, "\(version.description) not converted to a ABIVersion()!")
        }

        let versionString = "1.a.3"

        if let _ = ABIVersion(rawValue: versionString) {
            XCTAssert(false, "\(versionString) converted to a ABIVersion()!")
        }
    }

#if !os(OSX)
    static let allTests = [
        ("testABIVersion", testABIVersion)
    ]
#endif
}
