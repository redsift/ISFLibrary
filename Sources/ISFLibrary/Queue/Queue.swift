/*
    First-in first-out queue (FIFO)

    New elements are added to the end of the queue. Poping pulls elements from
    the front of the queue.

    pushing and poping are O(1) operations.
*/
public struct Queue<T> {
    private var elements = [T?]()
    private var head = 0

    public var isEmpty: Bool {
        return (self.count == 0)
    }

    public var count: Int {
        return self.elements.count - self.head
    }

    public mutating func push(_ element: T) {
        self.elements.append(element)
    }

    public mutating func pop() -> T? {
        guard self.head < self.elements.count, let element = self.elements[self.head] else {
            return nil
        }

        self.elements[self.head] = nil
        self.head += 1

        let percentage = Double(self.head) / Double(self.elements.count)

        if (self.elements.count > 50 && percentage > 0.25) {
            self.elements.removeFirst(self.head)
            self.head = 0
        }

        return element
    }

    public func peek() -> T? {
        return (self.isEmpty) ? nil : self.elements[self.head]
    }
}
