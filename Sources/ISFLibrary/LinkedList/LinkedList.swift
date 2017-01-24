/*
    LinkedList.swift

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

public final class LinkedList<T: Equatable> {
    public typealias NodeType = Node<T>

    fileprivate var start: NodeType? {
        didSet {
            // special case for a 1 element list
            if (self.end == nil) {
                self.end = self.start
            }
        }
    }

    fileprivate var end: NodeType? {
        didSet {
            // special case for a 1 element list
            if (self.start == nil) {
                self.start = self.end
            }
        }
    }

    /// the number of elements in the list at any given time
    public fileprivate(set) var count: Int = 0

    /// wether or not the list is empty
    public var isEmpty: Bool {
        return (self.count == 0)
    }

    /// create a new LinkedList
    public init() { }

    /// create a new LinkedList with a sequence
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        for element in elements {
            self.append(value: element)
        }
    }
}

extension LinkedList {
    public func append(value: T) {
        let previousEnd = self.end
        self.end = NodeType(value: value)

        self.end?.previous = previousEnd
        previousEnd?.next = self.end

        self.count += 1
    }
}

extension LinkedList {
    fileprivate func iterate(block: (NodeType, Int) throws -> NodeType?) rethrows -> NodeType? {
        var node = self.start
        var index = 0

        while (node != nil) {
            let result = try block(node!, index)
            if result != nil {
                return result
            }
            index += 1
            node = node?.next
        }

        return nil
    }
}

extension LinkedList {
    public func nodeAt(index: Int) -> NodeType {
        precondition(index >= 0 && index < self.count, "Index \(index) out of bounds")

        let result = self.iterate {
            if ($1 == index) {
                return $0
            }

            return nil
        }

        return result!
    }

    public func valueAt(index: Int) -> T {
        let node = self.nodeAt(index: index)

        return node.value
    }
}

extension LinkedList {
    public func remove(node: NodeType) {
        let nextNode = node.next
        let previousNode = node.previous

        if (node === self.start && node === self.end) {
            self.start = nil
            self.end = nil
        } else if (node === self.start) {
            self.start = node.next
        } else if (node === self.end) {
            self.end = node.previous
        } else {
            previousNode?.next = nextNode
            nextNode?.previous = previousNode
        }

        self.count -= 1

        assert((self.end != nil && self.start != nil && self.count > 1) ||
               (self.end == nil && self.start == nil && self.count == 0), "Internal invariant not upheld at the end of remove")
    }

    public func remove(atIndex index: Int) {
        precondition(index >= 0 && index < self.count, "Index \(index) out of bounds")

        let result = self.iterate {
            if ($1 == index) {
                return $0
            }

            return nil
        }

        self.remove(node: result!)
    }
}

extension LinkedList: Sequence {
    public typealias Iterator = LinkedListIterator<T>

    public func makeIterator() -> LinkedList.Iterator {
        return LinkedListIterator(startNode: self.start)
    }
}

extension LinkedList {
    func copy() -> LinkedList<T> {
        let newLinkedList = LinkedList<T>()

        for element in self {
            newLinkedList.append(value: element.value)
        }

        return newLinkedList
    }
}
