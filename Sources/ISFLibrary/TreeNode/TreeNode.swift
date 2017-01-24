/*
    TreeNode.swift

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

public class TreeNode<T> {
    public var value: T

    public weak var parent: TreeNode?
    public var children = [TreeNode<T>]()

    public var isRoot: Bool {
        return (self.parent == nil) ? true : false
    }

    public var isLeaf: Bool {
        return (self.children.isEmpty)
    }

    public var isNode: Bool {
        return (!self.isRoot && !self.isLeaf)
    }

    public init(value: T) {
        self.value = value
    }

    public func addChild(node: TreeNode<T>) {
        self.children.append(node)
        node.parent = self
    }
}

extension TreeNode where T: Equatable {
    public func search(for value: T) -> TreeNode? {
        if (self.value == value) {
            return self
        }

        for child in self.children {
            if let found = child.search(for: value) {
                return found
            }
        }

        return nil
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var description = "\(self.value)"

        if (!self.isLeaf) {
            description += ": (" + self.children.map { $0.description }.joined(separator: ", ") + ")"
        }

        return description
    }
}
