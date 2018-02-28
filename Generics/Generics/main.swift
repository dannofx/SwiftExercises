//
//  main.swift
//  Generics
//
//  Created by Danno on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation

// MARK: - Generic stack type

struct Stack<Element> where Element: Equatable {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        self.items.append(item)
    }
    
    mutating func pop() -> Element? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
}

extension Stack {
    func topItem() -> Element? {
        return self.items.isEmpty ? nil : self.items[self.items.count - 1]
    }
}


// MARK: - Protocol to be adopted by a type

protocol Container {
    associatedtype Item: Equatable
    
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    mutating func append(_ item: Item)
}

// MARK: - Stack of int types that adopts Container protocol

struct IntStack: Container {
    typealias Item = Int
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        self.items.append(item)
    }
    
    mutating func pop() -> Int? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
    
    // Protocol methods
    
    var count: Int {
        return self.items.count
    }
    
    subscript(i: Int) -> Int {
        return self.items[i]
    }
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
}

// MARK: - Generic stac with protocol adoption

struct ConstainerStack<Element: Equatable>: Container, Sequence {
    typealias Item = Element
    
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        self.items.append(item)
    }
    
    mutating func pop() -> Element? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
    
    // Container protocol methods
    
    var count: Int {
        return self.items.count
    }
    
    subscript(i: Int) -> Element {
        return self.items[i]
    }
    
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    // Sequence iterator
    func makeIterator() -> ContainerStackIterator<Element> {
        return ContainerStackIterator<Element>(self)
    }
    
}

// MARK: - Iterator to use by ContainerStack

struct ContainerStackIterator<Element: Equatable>: IteratorProtocol {
    var containerStack: ConstainerStack<Element>
    var index: Int
    
    init(_ containerStack: ConstainerStack<Element>) {
        self.containerStack = containerStack
        index = 0
    }
    
    mutating func next() -> Element? {
        if self.index < self.containerStack.count {
            let item = self.containerStack[self.index]
            self.index += 1
            return item
        } else {
            return nil
        }
    }
}

// MARK: - Generic type constrained by 'where'

struct EquatableStack<Element> where Element: Equatable {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        self.items.append(item)
    }
    
    mutating func pop() -> Element? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
    
    func isTop(_ element: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == element
    }
}

extension EquatableStack where Element == Double {
    func average() -> Double {
        var sum = 0.0
        
        if items.count == 0 {
            return sum
        }
        
        for index in 0..<items.count {
            sum += self.items[index]
        }
        return sum / Double(items.count)
    }
}

// MARK: - Container with iterator

protocol IterableContainer: Container {
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

// MARK: - Access a range of elements

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
    where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}


// MARK: - Generic function

extension GenericsExample {
    
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temp = a
        a = b
        b = temp
    }
}

// MARK: - Generic function with constraints

extension GenericsExample {
    
    func findIndex<T: Equatable>(of value: T, in items: [T]) -> Int? {
        for (index, item) in items.enumerated() {
            if item == value {
                return index
            }
        }
        return nil
    }
}

// MARK: - Generic function with 'where' constraints

extension GenericsExample {
    
    func allItemsMatch<A: Container, B: Container>(_ container1: A, _ container2: B) -> Bool
        where A.Item == B.Item {
            
            if container1.count != container2.count {
                return false
            }
            
            for i in 0..<container1.count {
                if container1[i] != container2[i] {
                    return false
                }
            }
            
            return true
            
    }
}

class GenericsExample {
    
    func performExamples() {
        // Generic function usage example
        var aStr = "a"
        var bStr = "b"
        self.swapTwoValues(&aStr, &bStr)
        print("a: \(aStr) b: \(bStr)")
        var aInt = 1
        var bInt = 2
        self.swapTwoValues(&aInt, &bInt)
        print("a: \(aInt) b: \(bInt)")
        
        // Generic type (stack) usage example
        var stackStr = Stack<String>()
        stackStr.push("a")
        print("Items \(stackStr.items)")
        stackStr.push("b")
        print("Items \(stackStr.items)")
        _ = stackStr.pop()
        print("Items \(stackStr.items)")
        stackStr.push("c")
        print("Items \(stackStr.items)")
        _ = stackStr.pop()
        print("Items \(stackStr.items)")
        stackStr.push("d")
        print("Items \(stackStr.items)")
        _ = stackStr.pop()
        print("Items \(stackStr.items)")
        _ = stackStr.pop()
        print("Items \(stackStr.items)")
        _ = stackStr.pop()
        print("Items \(stackStr.items)")
        stackStr.push("e")
        print("Items \(stackStr.items)")
        stackStr.push("f")
        print("Items \(stackStr.items)")
        stackStr.push("g")
        print("Items \(stackStr.items)")
        
        // Stack extension
        let top = stackStr.topItem()
        print("Top item: \(top ?? "")")
        
        
        // Generic function with constraints
        let found = self.findIndex(of: "g", in: stackStr.items)
        print("Found element: \(found ?? -1)")
        
        // Use of a generic type conforming a protocol
        var containerStack = ConstainerStack<String>()
        containerStack.push("first")
        containerStack.push("second")
        containerStack.append("third")
        print("Number of ContainerStack elements: \(containerStack.count)")
        print("Accessing first element ContainerStack: \(containerStack[0])")
        print("Iterating ContainerStack")
        for str in containerStack {
            print("\(str)")
        }
        
        // Access a range of elements
        let subElements = containerStack[0...2]
        print("First 2 elements")
        print(subElements)
        
        // Use a function with 'where' generic constraints
        var containerIntStack = ConstainerStack<Int>()
        containerIntStack.append(1)
        containerIntStack.append(2)
        containerIntStack.append(3)
        
        var intStack = IntStack()
        intStack.append(1)
        intStack.append(2)
        intStack.append(3)
        
        let allSame = self.allItemsMatch(containerIntStack, intStack)
        print("Containers items match: \(allSame)")
        
        // Example of EquatableStack
        // (Is constrained by 'where' in the type declaration)
        var equatableStack = EquatableStack<Double>()
        equatableStack.push(3.0)
        equatableStack.push(6.0)
        equatableStack.push(3.0)
        print("Average equatableStack: \(equatableStack.average())")
    }
}

// MARK: - Test

let example = GenericsExample()
example.performExamples()

