import UIKit

var array1 = [2,9,0,6,8,10]

public class LinkedListNode<T>  {

    public var prev: LinkedListNode?
    public var data: T
    public var next: LinkedListNode?

    public init(prev: LinkedListNode? = nil, data: T, next: LinkedListNode? = nil) {
        self.prev = prev
        self.data = data
        self.next = next
    }
}

public struct DoubleLinkedList<T>  {

    var headNode: LinkedListNode<T>?
    var tailNode: LinkedListNode<T>?

    public init() {
        self.headNode = nil
        self.tailNode = nil
    }

    // To check linked list is empty or not

    public var isEmpty: Bool {
        headNode == nil
    }
    
    // To count total number of nodes
       
    public var count: Int {
        guard var headNode = self.headNode else {
            return 0
        }
        var count = 1
        var firstIndex = 0
        while (headNode.next != nil) {
            count += 1
            headNode = headNode.next!
            firstIndex += 1
        }
        return count
    }

    /* 1. display: Display the list from head to tail node. */

    public mutating func display() {
        var node = self.headNode
        while(node != nil) {
            print(node?.data as Any, terminator: " ")
            node = node?.next
        }
    }

    /* 2. insert: Insert value in a list */

    public mutating func insert(value: T) {
        if self.headNode == nil {
            self.insertAtFirst(value: value)
        } else {
            self.insertAtLast(value: value)
        }
    }

    /* 3. insertAtFirst: Insert value before first position in a list */

    public mutating func insertAtFirst(value: T) {
        let newNode =  LinkedListNode(prev: nil, data: value, next: nil)
        if self.headNode == nil {
            headNode = newNode
            tailNode = newNode
        } else {
            headNode?.prev = newNode
            newNode.next = headNode
            headNode = newNode
        }
    }
    
    /* 4. insert: Insert value at particular position in a list */

    public mutating func insert(value: T, index: Int) {
        if index == 0 {
            self.insertAtFirst(value: value)
        } else if index == self.count - 1 {
            self.insertAtLast(value: value)
        } else {
            var firstIndex = 0
            var node = self.headNode
            while (firstIndex < index) {
                node = node?.next
                firstIndex += 1
            }
            let newNode = LinkedListNode(prev: nil, data: value, next: nil)
            newNode.next = node?.next
            newNode.prev = node
            if let _ = node?.next {
                node?.next?.prev = newNode
            }
            node?.next = newNode
        }

    }

    /* 5. insertAtLast: Insert value after last position in a list */

    public mutating func insertAtLast(value: T) {
        let newNode =  LinkedListNode(prev: nil, data: value, next: nil)
        self.tailNode?.next = newNode
        newNode.prev = self.tailNode
        self.tailNode = newNode
    }

    /* 6. deleteAtFirst: Delete first value */

    public mutating func deleteAtFirst() {
        guard self.headNode != nil else { return }
        if self.headNode === self.tailNode {
            self.headNode = nil
            self.tailNode = nil
        } else {
            var nodeToBeDeleted = self.headNode
            self.headNode = nodeToBeDeleted?.next
            nodeToBeDeleted = nil
            if let _ = self.headNode {
                self.headNode?.prev = nil
            }
        }
    }

    /* 7. delete: Delete value at particular position in a list */

    public mutating func delete(index: Int) {
        guard self.headNode != nil else { return }
        var firstIndex = 0
        var nodeToBeDeleted = self.headNode
        while (firstIndex < index) {
            nodeToBeDeleted = nodeToBeDeleted?.next
            firstIndex += 1
        }
        nodeToBeDeleted?.prev?.next = nodeToBeDeleted?.next
        if let _ = nodeToBeDeleted?.next {
            nodeToBeDeleted?.next?.prev = nodeToBeDeleted?.prev
        }
        nodeToBeDeleted = nil
    }
    
    /* 8. reverse: Reverse a list */

    public mutating func reverse() {
        guard self.headNode != nil else { return }
        var node = self.headNode
        var backNode: LinkedListNode<T>? = nil
        self.tailNode = self.headNode
        while (node != nil) {
            self.headNode = node
            node = node?.next
            self.headNode?.prev = node
            self.headNode?.next = backNode
            backNode = self.headNode
        }
    }
}

/* Create and fetch linked list */

func createAndFetchLinkedList(array: inout [Int]) -> DoubleLinkedList<Int> {
    var firstIndex = 0
    let lastIndex = array.count
    var list = DoubleLinkedList<Int>()
    while (firstIndex < lastIndex) {
        list.insert(value: array[firstIndex])
        firstIndex += 1
    }
    return list
}

var doublelist1 = createAndFetchLinkedList(array: &array1)
print("Insert at first positon", doublelist1.insertAtFirst(value: 55), doublelist1.display())
print("Insert at positon", doublelist1.insert(value: 35, index: 3), doublelist1.display())
print("Insert at positon", doublelist1.insertAtLast(value: 16), doublelist1.display())
print("Delete at first positon", doublelist1.deleteAtFirst(), doublelist1.display())
print("Delete at positon", doublelist1.delete(index: 2), doublelist1.display())
print("Reverse of list", doublelist1.reverse(), doublelist1.display())
