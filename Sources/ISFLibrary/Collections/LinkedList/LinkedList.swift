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
            if (end == nil) {
                end = start
            }
        }
    }

    fileprivate var end: NodeType? {
        didSet {
            // special case for a 1 element list
            if (start == nil) {
                start = end
            }
        }
    }

    /// the number of elements in the list at any given time
    public fileprivate(set) var count: Int = 0

    /// create a new LinkedList
    public init() { }

    /// create a new LinkedList with a sequence
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        for element in elements {
            append(value: element)
        }
    }
}

extension LinkedList {
    /// wether or not the list is empty
    public var isEmpty: Bool {
        return (count == 0)
    }
}

extension LinkedList {
    public func append(value: T) {
        let previousEnd = end

        end = NodeType(value: value)

        end?.previous = previousEnd
        previousEnd?.next = end

        count += 1
    }
}

extension LinkedList {
    fileprivate func iterate(_ closure: (NodeType, Int) throws -> NodeType?) rethrows -> NodeType? {
        var node = start
        var index = 0

        while (node != nil) {
            let result = try closure(node!, index)

            if (result != nil) {
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
        precondition(index >= 0 && index < count, "Index \(index) out of bounds")

        let result = iterate {
            if ($1 == index) {
                return $0
            }

            return nil
        }

        return result!
    }

    public func valueAt(index: Int) -> T {
        return nodeAt(index: index).value
    }
}

extension LinkedList {
    public func remove(node: NodeType) {
        let nextNode = node.next
        let previousNode = node.previous

        if (node === start && node === end) {
            start = nil
            end = nil
        } else if (node === start) {
            start = node.next
        } else if (node === end) {
            end = node.previous
        } else {
            previousNode?.next = nextNode
            nextNode?.previous = previousNode
        }

        count -= 1

        assert((end != nil && start != nil && count > 1) || (end == nil && start == nil && count == 0), "Internal invariant not upheld at the end of remove")
    }

    public func remove(atIndex index: Int) {
        precondition(index >= 0 && index < count, "Index \(index) out of bounds")

        let result = iterate {
            if ($1 == index) {
                return $0
            }

            return nil
        }

        remove(node: result!)
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
