/*
    Last-in first-out stack (LIFO)

    Push and pop are O(1) operations.
*/

public struct Stack<T> {
    private var elements = [T]()

    public var isEmpty: Bool {
        return self.elements.isEmpty
    }

    public var count: Int {
        return self.elements.count
    }

    public mutating func push(_ element: T) {
        self.elements.append(element)
    }

    public mutating func pop() -> T? {
        return self.elements.popLast()
    }

    public func peek() -> T? {
        return self.elements.last
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var current = self

        return AnyIterator { _ -> T? in
            return current.pop()
        }
    }
}
