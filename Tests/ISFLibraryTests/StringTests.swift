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

@testable import ISFLibrary

class StringTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIsInteger() {
        let integers = [
            "0",
            "1",
            "12",
            "123",
            "+0",
            "+1",
            "+12",
            "+123",
            "-0",
            "-1",
            "-12",
            "-123",
            "00",
            "+00",
            "-00",
            "00123",
            "+00123",
            "-00123"
        ]

        for string in integers {
            XCTAssertEqual(string.isInteger, true, "'\(string)' is an integer!")
        }
    }

    func testIsNotInteger() {
        let integers = [
            "",
            " ",
            "one",
            ".1",
            "0.1",
            "+0.1",
            "-0.1",
            "~0.1"
        ]

        for string in integers {
            XCTAssertEqual(string.isInteger, false, "'\(string)' is not an integer!")
        }
    }

    func testIsPositiveInteger() {
        let integers = [
            "0",
            "1",
            "12",
            "123",
            "+0",
            "+1",
            "+12",
            "+123",
            "00",
            "+00",
            "00123",
            "+00123"
        ]

        for string in integers {
            XCTAssertEqual(string.isPositiveInteger, true, "'\(string)' is a positive integer!")
        }
    }

    func testIsNotPositiveInteger() {
        let integers = [
            "",
            " ",
            "+one",
            "-one",
            ".1",
            "0.1",
            "+0.1",
            "-0.1",
            "-0",
            "-1",
            "-01",
            "~1"
        ]

        for string in integers {
            XCTAssertEqual(string.isPositiveInteger, false, "'\(string)' is not a positive integer!")
        }
    }

    func testIsNegativeInteger() {
        let integers = [
            "-0",
            "-1",
            "-12",
            "-123",
            "-00",
            "-00123"
        ]

        for string in integers {
            XCTAssertEqual(string.isNegativeInteger, true, "'\(string)' is a negative integer!")
        }
    }

    func testIsNotNegativeInteger() {
        let integers = [
            "",
            " ",
            "+one",
            "-one",
            ".1",
            "0.1",
            "+0.1",
            "-0.1",
            "+0",
            "+1",
            "+01",
            "~1"
        ]

        for string in integers {
            XCTAssertEqual(string.isNegativeInteger, false, "'\(string)' is not a negative integer!")
        }
    }

    func testIsDecimal() {
        let decimals = [
            "0",
            "1",
            "12",
            "123",
            "+0",
            "+1",
            "+12",
            "+123",
            "0.123",
            "1.123",
            "12.12",
            "123.1",
            "+0.123",
            "+1.123",
            "+12.12",
            "+123.1",
            "-0",
            "-1",
            "-12",
            "-123",
            "00",
            "+00",
            "-00",
            "00123",
            "+00123",
            "-00123",
            "-0.123",
            "-1.123",
            "-12.12",
            "-123.1",
            "00.0",
            "+00.0",
            "-00.0",
            "00.123",
            "+00.123",
            "-00.123",
            "00123.0",
            "+00123.0",
            "-00123.0",
            "00123.123",
            "+00123.123",
            "-00123.123"
        ]

        for string in decimals {
            XCTAssertEqual(string.isDecimal, true, "'\(string)' is a decimal!")
        }
    }

    func testIsNotDecimal() {
        let decimals = [
            "..",
            "",
            " ",
            ".",
            "0.1a",
            "a",
            "one",
            "one.one",
            "~123.123"
        ]

        for string in decimals {
            XCTAssertEqual(string.isDecimal, false, "'\(string)' is not a decimal!")
        }
    }

    func testIsPositiveDecimal() {
        let decimals = [
            "0",
            "1",
            "12",
            "123",
            "+0",
            "+1",
            "+12",
            "+123",
            "0.123",
            "1.123",
            "12.12",
            "123.1",
            "+0.123",
            "+1.123",
            "+12.12",
            "+123.1",
            "00",
            "+00",
            "00123",
            "+00123",
            "00.0",
            "+00.0",
            "00.123",
            "+00.123",
            "00123.0",
            "+00123.0",
            "00123.123",
            "+00123.123"
        ]

        for string in decimals {
            XCTAssertEqual(string.isPositiveDecimal, true, "'\(string)' is a positive decimal!")
        }
    }

    func testIsNotPositiveDecimal() {
        let decimals = [
            "-1",
            "-12",
            "-123",
            "-0.123",
            "-1.123",
            "-12.12",
            "-123.1",
            "-00123",
            "-00.123",
            "-00123.0",
            "-00123.123",
            "one",
            "+one",
            "-one",
            "~0",
            "~123.123"
        ]

        for string in decimals {
            XCTAssertEqual(string.isPositiveDecimal, false, "'\(string)' is not a positive decimal!")
        }
    }

    func testIsNegativeDecimal() {
        let decimals = [
            "-0",
            "-1",
            "-12",
            "-123",
            "-0.123",
            "-1.123",
            "-12.12",
            "-123.1",
            "-00",
            "-00123",
            "-00.0",
            "-00.123",
            "-00123.0",
            "-00123.123"
        ]

        for string in decimals {
            XCTAssertEqual(string.isNegativeDecimal, true, "'\(string)' is a negative decimal!")
        }
    }

    func testIsNotNegativeDecimal() {
        let decimals = [
            "0",
            "1",
            "12",
            "123",
            "+0",
            "+1",
            "+12",
            "+123",
            "0.123",
            "1.123",
            "12.12",
            "123.1",
            "+0.123",
            "+1.123",
            "+12.12",
            "+123.1",
            "00",
            "+00",
            "00123",
            "+00123",
            "00.0",
            "+00.0",
            "00.123",
            "+00.123",
            "00123.0",
            "+00123.0",
            "00123.123",
            "+00123.123"
        ]

        for string in decimals {
            XCTAssertEqual(string.isNegativeDecimal, false, "'\(string)' is not a negative decimal!")
        }
    }

    func testIsFloatingPoint() {
        let floatingPoints = [
            "123",
            "+123",
            "-123",
            "123.",
            "+123.",
            "-123.",
            "123.123",
            "+123.123",
            "-123.123",
            "0.123",
            "+0.123",
            "-0.123",
            ".0",
            "01.123",
            "+01.123",
            "-01.123",
            "0.123123123123e-123",
            "+0.123123123123e-123",
            "-0.123123123123e-123"
        ]

        for string in floatingPoints {
            XCTAssertEqual(string.isFloatingPoint, true, "'\(string)' is a floating point!")
        }
    }

    func testIsNotFloatingPoint() {
        let floatingPoints = [
            "-.123",
            "  ",
            "",
            ".",
            "foo"
        ]

        for string in floatingPoints {
            XCTAssertEqual(string.isFloatingPoint, false, "'\(string)' is not a floating point!")
        }
    }

    func testIsPositiveFloatingPoint() {
        let floatingPoints = [
            "0",
            "123",
            "+123",
            "123.",
            "+123.",
            "123.123",
            "+123.123",
            "0.123",
            "+0.123",
            ".0",
            "01.123",
            "+01.123",
            "0.123123123123e-123",
            "+0.123123123123e-123"
        ]

        for string in floatingPoints {
            XCTAssertEqual(string.isPositiveFloatingPoint, true, "'\(string)' is a positive floating point!")
        }
    }

    func testIsNotPositiveFloatingPoint() {
        let floatingPoints = [
            "-123",
            "-123.",
            "-123.123",
            "-0.123",
            "-01.123",
            "-0.123123123123e-123"
        ]

        for string in floatingPoints {
            XCTAssertEqual(string.isPositiveFloatingPoint, false, "'\(string)' is not a positive floating point!")
        }
    }

    func testIsNegativeFloatingPoint() {
        let floatingPoints = [
            "-0",
            "-123",
            "-123.",
            "-123.123",
            "-0.123",
            "-01.123",
            "-0.123123123123e-123"
        ]

        for string in floatingPoints {
            XCTAssertEqual(string.isNegativeFloatingPoint, true, "'\(string)' is a negative floating point!")
        }
    }

    func testIsNotNegativeFloatingPoint() {
        let floatingPoints = [
            "0",
            "+123",
            "+123.",
            "+123.123",
            "+0.123",
            "+01.123",
            "+0.123123123123e-123"
        ]

        for string in floatingPoints {
            XCTAssertEqual(string.isNegativeFloatingPoint, false, "'\(string)' is not a negative floating point!")
        }
    }

#if !os(OSX)
    static let allTests = [
        ("testIsInteger", testIsInteger),
        ("testIsNotInteger", testIsNotInteger),
        ("testIsPositiveInteger", testIsPositiveInteger),
        ("testIsNotPositiveInteger", testIsNotPositiveInteger),
        ("testIsNegativeInteger", testIsNegativeInteger),
        ("testIsNotNegativeInteger", testIsNotNegativeInteger),
        ("testIsDecimal", testIsDecimal),
        ("testIsNotDecimal", testIsNotDecimal),
        ("testIsPositiveDecimal", testIsPositiveDecimal),
        ("testIsNotPositiveDecimal", testIsNotPositiveDecimal),
        ("testIsNegativeDecimal", testIsNegativeDecimal),
        ("testIsNotNegativeDecimal", testIsNotNegativeDecimal),
        ("testIsFloatingPoint", testIsFloatingPoint),
        ("testIsNotFloatingPoint", testIsNotFloatingPoint),
        ("testIsPositiveFloatingPoint", testIsPositiveFloatingPoint),
        ("testIsNotPositiveFloatingPoint", testIsNotPositiveFloatingPoint),
        ("testIsNegativeFloatingPoint", testIsNegativeFloatingPoint),
        ("testIsNotNegativeFloatingPoint", testIsNotNegativeFloatingPoint)
    ]
#endif
}
