import Foundation
import XCTest
@testable import ISFLibrary

class QueueTests: XCTestCase {
    func testEmpty() {
        var queue = Queue<Int>()

        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.peek(), nil)
        XCTAssertNil(queue.pop())
    }

    func testOneElement() {
        var queue = Queue<Int>()

        queue.push(123)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.peek(), 123)

        let result = queue.pop()

        XCTAssertEqual(result, 123)
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.peek(), nil)
    }

    func testTwoElements() {
        var queue = Queue<Int>()

        queue.push(123)
        queue.push(456)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 2)
        XCTAssertEqual(queue.peek(), 123)

        let result1 = queue.pop()

        XCTAssertEqual(result1, 123)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.peek(), 456)

        let result2 = queue.pop()

        XCTAssertEqual(result2, 456)
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.peek(), nil)
    }

    func testMakeEmpty() {
        var queue = Queue<Int>()

        queue.push(123)
        queue.push(456)
        XCTAssertNotNil(queue.pop())
        XCTAssertNotNil(queue.pop())
        XCTAssertNil(queue.pop())

        queue.push(789)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.peek(), 789)

        let result = queue.pop()

        XCTAssertEqual(result, 789)
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.peek(), nil)
    }

#if !os(OSX)
    static let allTests = [
        ("testEmpty", testEmpty),
        ("testOneElement", testOneElement),
        ("testTwoElements", testTwoElements),
        ("testMakeEmpty", testMakeEmpty)
    ]
#endif
}
