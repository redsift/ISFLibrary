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
            if (!isKnownUniquelyReferenced(&storage)) {
                storage = storage.copy()
            }

            return storage
        }
    }

    public init() {
        storage = LinkedList()
    }

    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        storage = LinkedList(elements)
    }

    public var count: Int {
        return storage.count
    }

    public var isEmpty: Bool {
        return storage.isEmpty
    }

    public mutating func append(value: T) {
        mutableStorage.append(value: value)
    }

    public func nodeAt(index: Int) -> NodeType {
        return storage.nodeAt(index: index)
    }

    public func valueAt(index: Int) -> T {
        return nodeAt(index: index).value
    }

    public mutating func remove(node: NodeType) {
        mutableStorage.remove(node: node)
    }

    public mutating func remove(atIndex index: Int) {
        mutableStorage.remove(atIndex: index)
    }
}

extension LinkedListCOW: CustomStringConvertible {
    public var description: String {
        return "LinkedListCOW(storage: \(storage))"
    }
}
