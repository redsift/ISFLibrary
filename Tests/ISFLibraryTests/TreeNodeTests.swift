/*
    TreeNodeTests.swift

    Copyright (c) 2016, 2017 Stephen Whittle  All rights reserved.

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

        if (tree.description != "beverages: (hot: (tea: (black, green, chai), coffee, cocoa), cold: (soda: (ginger ale, bitter lemon), milk))") {
            XCTAssert(false, "sructure not as expected")
        }

        if let result = tree.search(for: "beverages") {
            XCTAssertEqual(result.isRoot, true, "beverages is a root!")
            XCTAssertEqual(result.isLeaf, false, "beverages is a leaf!")
            XCTAssertEqual(result.isNode, false, "beverages is a not a node!")
        } else {
            XCTAssert(false, "beverages not found!")
        }

        if let result = tree.search(for: "soda") {
            XCTAssertEqual(result.isRoot, false, "soda is a root!")
            XCTAssertEqual(result.isLeaf, false, "soda is a leaf!")
            XCTAssertEqual(result.isNode, true, "soda is a a node!")
        } else {
            XCTAssert(false, "soda not found!")
        }

        if let result = tree.search(for: "green") {
            XCTAssertEqual(result.isRoot, false, "green tea is a root!")
            XCTAssertEqual(result.isLeaf, true, "green tea is a leaf!")
            XCTAssertEqual(result.isNode, false, "green tea is a node!")
        } else {
            XCTAssert(false, "green tea not found!")
        }
    }

#if !os(OSX)
    static let allTests = [
        ("testTreeNodeTests", testTreeNodeTests)
    ]
#endif
}
