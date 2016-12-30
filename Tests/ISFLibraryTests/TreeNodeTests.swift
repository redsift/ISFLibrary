import XCTest
import Foundation

@testable import ISFLibrary

class TreeNodeTests: XCTestCase {
    func testTreeNodeTests() {
        let tree = TreeNode<String>(value: "beverages")

        let hot = TreeNode<String>(value: "hot")
        let cold = TreeNode<String>(value: "cold")

        let tea = TreeNode<String>(value: "tea")
        let coffee = TreeNode<String>(value: "coffee")
        let chocolate = TreeNode<String>(value: "cocoa")

        let blackTea = TreeNode<String>(value: "black")
        let greenTea = TreeNode<String>(value: "green")
        let chaiTea = TreeNode<String>(value: "chai")

        let soda = TreeNode<String>(value: "soda")
        let milk = TreeNode<String>(value: "milk")

        let gingerAle = TreeNode<String>(value: "ginger ale")
        let bitterLemon = TreeNode<String>(value: "bitter lemon")

        tree.addChild(node: hot)
        tree.addChild(node: cold)

        hot.addChild(node: tea)
        hot.addChild(node: coffee)
        hot.addChild(node: chocolate)

        cold.addChild(node: soda)
        cold.addChild(node: milk)

        tea.addChild(node: blackTea)
        tea.addChild(node: greenTea)
        tea.addChild(node: chaiTea)

        soda.addChild(node: gingerAle)
        soda.addChild(node: bitterLemon)

        print(tree)
    }

#if !os(OSX)
    static let allTests = [
        ("testTreeNodeTests", testTreeNodeTests)
    ]
#endif
}
