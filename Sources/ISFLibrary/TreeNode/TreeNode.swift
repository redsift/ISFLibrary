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
