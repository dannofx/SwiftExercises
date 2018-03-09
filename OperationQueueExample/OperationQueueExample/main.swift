//
//  main.swift
//  OperationQueueExample
//
//  Created by Danno on 3/8/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation


// MARK: - Operation definition
class WorkItem: Operation {
    init(name: String, priority: QueuePriority = .normal) {
        super.init()
        self.name = name
        self.queuePriority = priority
    }
    
    override func main() {
        print("Working on: \(self.name ?? "(no name)")")
        Thread.sleep(forTimeInterval: 0.5)
        print("Finished on: \(self.name ?? "(no name)")")
    }
}

// Operation queue declaration
let queue = OperationQueue()
queue.maxConcurrentOperationCount = 2
queue.name = "Test queue"

// Test data
// Regular items
for i in 0..<10 {
    let workItem = WorkItem(name: "Item \(i)")
    queue.addOperation(workItem)
}
// High priority item
let highPriorItem = WorkItem(name: "HIGH PRIORITY", priority: .veryHigh)
queue.addOperation(highPriorItem)
// Wait for the operations to finish
while queue.operations.count != 0 {}
