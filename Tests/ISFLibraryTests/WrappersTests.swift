/*
    WrappersTests.swift

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

class WrappersTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBox() {
        let test = "forty-two"

        let box = Box(test)

        XCTAssert(box.value == test)
    }

    func testMutableBox() {
        let box = MutableBox(42)

        XCTAssert(box.value == 42)

        box.value = 24

        XCTAssert(box.value == 24)
    }

    func testUnowned() {
        var uow: Unowned<NSObject>? = nil

        let w = { () -> Weak<NSObject> in
            let o = NSObject()
            let innerW = Weak(o)
            uow = Unowned(o)

            XCTAssert(innerW.value != nil)
            XCTAssert(uow != nil)
            XCTAssert(uow!.value == o)

            return innerW
        }()

        XCTAssert(w.value == nil)
        XCTAssert(uow != nil)
    }

    func testWeak() {
        let q = NSObject()

        let w = { () -> Weak<NSObject> in
            let o = NSObject()
            let p = NSObject()
            let innerW = Weak(o)

            XCTAssert(innerW.value != nil)
            XCTAssert(innerW.contains(o))
            XCTAssert(!innerW.contains(p))

            return innerW
        }()

        XCTAssert(w.value == nil)
        XCTAssert(!w.contains(q))
    }

    func testPossiblyWeak() {
        let q = NSObject()

        let w = { () -> PossiblyWeak<NSObject> in
            let o = NSObject()
            let p = NSObject()
            let innerW = PossiblyWeak.StrongType(o)

            XCTAssert(innerW.value != nil)
            XCTAssert(innerW.contains(o))
            XCTAssert(!innerW.contains(p))

            return innerW
        }()

        XCTAssert(w.value != nil)
        XCTAssert(!w.contains(q))

        let x = { () -> PossiblyWeak<NSObject> in
            let o = NSObject()
            let p = NSObject()
            let innerW = PossiblyWeak.WeakType(Weak(o))

            XCTAssert(innerW.value != nil)
            XCTAssert(innerW.contains(o))
            XCTAssert(!innerW.contains(p))

            return innerW
        }()

        XCTAssert(x.value == nil)
        XCTAssert(!x.contains(q))
    }

#if !os(OSX)
    static let allTests = [
        ("testBox", testBox),
        ("testMutableBox", testMutableBox),
        ("testUnowned", testUnowned),
        ("testWeak", testWeak),
        ("testPossiblyWeak", testPossiblyWeak)
    ]
#endif
}
