/*
    StringTests.swift

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
import Foundation

import ISFLibrary

class DataTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBytes() {
        var data = Data()

        data.bytes = Array(arrayLiteral: 1, 2, 3)

        XCTAssertEqual(data.bytes, [1, 2, 3], "\(data.bytes) != [1, 2, 3]")
    }

    func testIsLessThan() {
        var data1 = Data()
        var data2 = Data()

        data1.bytes = Array(arrayLiteral: 1, 2, 3)
        data2.bytes = Array(arrayLiteral: 1, 3, 2)

        XCTAssertLessThan(data1, data2, "\(data1) is not less than \(data2)!!!")
    }

#if !os(OSX)
    static let allTests = [
        ("testBytes", testBytes),
        ("testIsLessThan", testIsLessThan)
    ]
#endif
}
