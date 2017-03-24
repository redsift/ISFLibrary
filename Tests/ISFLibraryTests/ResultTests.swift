/*
    ResultTests.swift

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

@testable import ISFLibrary

class ResultTests: XCTestCase {
    enum TestError: Error {
        case zeroValue
        case oneValue
        case twoValue
    }

    func testInitWithClosure() {
        do {
            let result = Result<Int> {
                return 3
            }

            XCTAssert(result.value != nil)
            XCTAssert(result.error == nil)
            XCTAssert(result.value! == 3)
        }

        do {
            let result = Result<Int> {
                throw TestError.oneValue
            }

            XCTAssert(result.value == nil)
            XCTAssert(result.error != nil)
        }
    }

    func testInitWithValue() {
        do {
            let result = Result<Int>.Success(3)

            XCTAssert(result.value != nil)
            XCTAssert(result.error == nil)
            XCTAssert(result.value! == 3)
        }

        do {
            let result = Result<Int>.Success(5)

            XCTAssert(result.value != nil)
            XCTAssert(result.error == nil)
            XCTAssert(result.value! == 5)
        }
    }

    func testInitWithError() {
        do {
            let error = TestError.oneValue
            let result = Result<Int>.Failure(TestError.oneValue)

            XCTAssert(result.value == nil)
            XCTAssert(result.error != nil)
            XCTAssert(result.error.map { $0 as! TestError } == error)
        }

        do {
            let error = TestError.twoValue
            let result = Result<Int>.Failure(error)

            XCTAssert(result.value == nil)
            XCTAssert(result.error.map { $0 as! TestError } == error)
        }
    }

    func testFlatMap() {
        do {
            var x = false
            let a = Result<Int>.Success(3)
            let c = a.flatMap { (i: Int) -> Result<Int> in
                XCTAssert(i == 3)

                x = true

                return Result<Int>.Success(5)
            }
            let v = c.value

            XCTAssert(v != nil && v! == 5)
            XCTAssert(x == true)
        }

        do {
            var y = false
            let b = Result<Int>.Failure(TestError.twoValue)
            let d = b.flatMap { (i: Int) -> Result<Int> in
                y = true

                return Result<Int>.Success(5)
            }
            let w = d.value

            XCTAssert(w == nil)
            XCTAssert(y == false)
        }

        do {
            let s = Result<Int>.Success(3)
            let r = s.map { (i: Int) throws -> Bool in
                throw TestError.oneValue
            }

            XCTAssert(r.error != nil)
        }
    }

    func testMap() {
        do {
            var x = false
            let a = Result<Int>.Success(3)
            let c = a.map { (i: Int) -> Int in
                XCTAssert(i == 3)

                x = true

                return 5
            }
            let v = c.value

            XCTAssert(v != nil && v! == 5)
            XCTAssert(x == true)
        }

        do {
            var y = false
            let b = Result<Int>.Failure(NSError(domain: "a", code: 5, userInfo: nil))
            let d = b.map { (i: Int) -> Int in
                y = true

                return 5
            }
            let w = d.value

            XCTAssert(w == nil)
            XCTAssert(y == false)
        }
    }

    func testUnwrap() {
        do {
            var i: Int?
            var e: Error?

            do {
                i = try Result<Int>.Success(3).unwrap()
            } catch {
                e = error
            }

            XCTAssert(i != nil)
            XCTAssert(e == nil)
        }

        do {
            var j: Int?
            var f: Error?

            do {
                j = try Result<Int>.Failure(TestError.oneValue).unwrap()
            } catch {
                f = error
            }

            XCTAssert(j == nil)
            XCTAssert(f != nil)
        }
    }

#if !os(OSX)
    static let allTests = [
        ("testInitWithClosure", testInitWithClosure),
        ("testInitWithValue", testInitWithValue),
        ("testInitWithError", testInitWithError),
        ("testFlatMap", testFlatMap),
        ("testMap", testMap),
        ("testUnwrap", testUnwrap)
    ]
#endif
}
