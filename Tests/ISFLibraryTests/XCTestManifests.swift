import Foundation
import XCTest

#if !os(OSX)
public let allTests = [
    testCase(QueueTests.allTests),
    testCase(StackTests.allTests),
    testCase(TreeNodeTests.allTests)
]
#endif
