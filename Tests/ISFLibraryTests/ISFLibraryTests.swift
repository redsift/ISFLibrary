import XCTest
@testable import ISFLibrary

class ISFLibraryTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ISFLibrary().text, "Hello, World!")
    }


    static var allTests : [(String, (ISFLibraryTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
