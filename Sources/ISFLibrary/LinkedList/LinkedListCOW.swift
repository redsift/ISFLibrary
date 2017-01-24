/*
    LinkedListCOW.swift

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

public struct LinkedListCOW<T: Equatable> {
    public typealias NodeType = Node<T>

    fileprivate var storage: LinkedList<T>
    private var mutableStorage: LinkedList<T> {
        mutating get {
            if !isKnownUniquelyReferenced(&storage) {
                self.storage = self.storage.copy()
            }

            return self.storage
        }
    }

    public init() {
        self.storage = LinkedList()
    }

    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        self.storage = LinkedList(elements)
    }

    public var count: Int {
        return self.storage.count
    }

    public var isEmpty: Bool {
        return self.storage.isEmpty
    }

    public mutating func append(value: T) {
        self.mutableStorage.append(value: value)
    }

    public func nodeAt(index: Int) -> NodeType {
        return self.storage.nodeAt(index: index)
    }

    public func valueAt(index: Int) -> T {
        let node = nodeAt(index: index)

        return node.value
    }

    public mutating func remove(node: NodeType) {
        self.mutableStorage.remove(node: node)
    }

    public mutating func remove(atIndex index: Int) {
        self.mutableStorage.remove(atIndex: index)
    }
}

extension LinkedListCOW: CustomStringConvertible {
    public var description: String {
        return "LinkedListCOW(storage: \(self.storage))"
    }
}
