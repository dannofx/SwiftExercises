//
//  ViewController.swift
//  GrandCentralDispatch
//
//  Created by Danno on 7/21/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import UIKit

// This property will be used in the example "Dispatch example"
var firstAccessMessage: String = { _ in
    print("This code will be executed just once.")
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-MM-dd H:m:ss.SSSS"
    let stringDate = dateFormatter.string(from: date)
    let message = "The firt and las calculation of this was on \(stringDate)"
    return message
    }()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For clarity in the logs, is recommended just perform one example per run.
        // The examples are ordered by difficulty level.
        
        // Custom queue example
        self.performCustomQueueTask()
        
        // Global queue example
        //self.performGlobalQueueTask()
        
        // Main queue example
        //self.performMainQueueTask()
        
        // Sync perform example
        //self.performSyncTask()
        
        // Async perform example
        //self.performAsyncTask()
        
        // Concurrent queue example
        //self.performConcurrentTasks()
        
        // Serial queue example
        //self.performSerialTasks()
        
        // Dispatch once example
        //self.performDispatchOnceExample()
        
        // Initially inactive queue example
        //self.useOfInactiveQueue()
        
        // Delayed task example
        //self.performDelayedTaks()
        
        // Dispatch barrier example
        //self.performTaskWithBarrierOption()
        
        // Cancellable task example
        //self.performCancellableTask()
        
        // Dispatch group example
        //self.performGroupOfTasks()
        
        // Concurrent perform example
        //self.performConcurrentDownloads()
        
        // Semaphone example to wait for a task or launch timeout
        //self.performReconcileSemaphoreExample()
        
        // Semaphore example that manages multiple resources
        //self.performLimitedResourcesSemaphoreExample()
        
        // Setting signal handler example
        //_ = setUpSignalHandler(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Custom queue example
    // 
    // A download will be performed in a queue that you will create, you can be sure that 
    // this queue won't be shared with any other task you are not aware of
    
    func performCustomQueueTask() {
        let customQueue = DispatchQueue(label: "org.mystercyb.custom")// A label is necessary, try to use a reverted domain
        customQueue.async {
            print("The download begins")
            self.downloadData()
            print("The download finishes")
        }
    }
    // Global queue
    //
    // A download will be performed in a queue managed by iOS
    // it may be executed along with other tasks you are not aware of,
    // but is the most common way to perform tasks outside the main queue.
    // You can specify the kind of queue you want to retrieve specifying
    // the `qos` parameter.
    
    func performGlobalQueueTask() {
        // `qos` determine the kind of queue that will be retrieved.
        let globalQueue = DispatchQueue.global(qos: .background)
        globalQueue.async {
            print("The download begins")
            self.downloadData()
            print("The download finishes")
        }
    }
    
    // Main queue update
    //
    // This example downloads and image in background, once it is 
    // finished, it informs to the main thread that the action was
    // completed, you regularly do this so you can perform weightful
    // tasks in background and notify the UI when it finishes without
    // causing a freeze on the screen.
    
    func performMainQueueTask() {
        // `qos` determine the kind of queue that will be retrieved.
        let backgroundQueue = DispatchQueue.global(qos: .background)
        backgroundQueue.async {
            print("The download begins")
            self.downloadData()
            print("The download finishes")
            DispatchQueue.main.async {
                print("The main queue is notified that the download finishes")
                print("You can perform a UI update here without risk of freeze.")
            }
        }
    }
    
    // Synchronous task performed
    //
    // The download will be performed in another queue
    // but the method will wait to continue with the execution
    func performSyncTask() {
        print("The download is about to begin")
        let queue = DispatchQueue(label: "org.mistercyb.syncqueue")
        queue.sync {
            print("The download begins")
            self.downloadData()
            print("The download finishes")
        }
        print("Leaving the method")
    }
    
    // Asynchronous task performed
    //
    // The download will be performed in another queue
    // and the method won't have to wait to the download
    // finishes
    func performAsyncTask() {
        print("The download is about to begin")
        let queue = DispatchQueue(label: "org.mistercyb.asyncqueue")
        queue.async {
            print("The download begins")
            self.downloadData()
            print("The download finishes")
        }
        print("Leaving the method")
    }
    
    // Concurrent queue example
    //
    // 5 tasks will be performed concurrently
    func performConcurrentTasks() {
        let serialQueue = DispatchQueue(label: "org.mistercyb.concurrent", attributes: .concurrent)
        for i in 0..<5 {
            serialQueue.async {
                print("Download \(i) begins...")
                self.downloadData()
                print("Download \(i) finished.")
            }
        }
        print("Download invokations finished")
    }
    
    // Serial queue example
    //
    // 5 tasks will be performed one after another. The method will return
    // before the downloads finish.
    func performSerialTasks() {
        let serialQueue = DispatchQueue(label: "org.mistercyb.serial")
        for i in 0..<5 {
            serialQueue.async {
                print("Download \(i) begins...")
                self.downloadData()
                print("Download \(i) finished.")
            }
        }
        print("Download invokations finished")
    }
    
    // Dispatch once example
    //
    // There is no longer `dispatch_once` method to
    // perform a code one and just one time. Instead the use
    // of lazy initialization of global variables is encouraged
    // since Swift ensures that the initialization will
    // be thread safe. Static properties have the same behavior.
    //
    // The example shows a variable which calculation to generate
    // its value will be performed just once. This variable is at
    // the beginning of the file, outside of the class.
    
    func performDispatchOnceExample() {
        for i in 0..<100 {
            DispatchQueue.global(qos: .userInitiated).async {
                let message = firstAccessMessage
                print("Access number \(i) of message\"\(message)\"")
            }
        }
    }

    
    // Delayed execution example
    //
    // Task that is executed after a delay of 2 seconds
    
    func performDelayedTaks() {
        let time = DispatchTime.now() + 2.0
        print("The download will begin in 2 seconds (now: \(Date()))")
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: time) {
            print("The download has begun... (now: \(Date()))")
            self.downloadData()
            print("Download finished")
        }
    }
    
    // Initially inactive queue example
    //
    // Some tasks will be added to a queue, but these will not be performed
    // until the queue is explicitly activated.
    
    func useOfInactiveQueue() {
        // `.initiallyInactive` is the important option here
        let queueToActivate = DispatchQueue(label: "org.mistercyb.inactive",
                                            qos: .userInitiated,
                                            attributes: [.initiallyInactive, .concurrent])
        for i in 0..<5 {
            queueToActivate.async {
                print("Download \(i) begins...")
                self.downloadData()
                print("Download \(i) finished.")
            }
        }
        print("The downloads won't start even we wait 2 seconds.")
        Thread.sleep(forTimeInterval: 2.0)
        print("Two seconds passed.")
        print("The downloads will begin now")
        queueToActivate.activate()
    }
    
    // Dispatch barrier example
    //
    // A barrier is a way to be sure thet a determined task will be the only
    // one executing at a time in a concurrent queue, is important to do 
    // things like mutate a collection, execute code that doesn't support
    // concurrenc, etc.
    
    func performTaskWithBarrierOption() {
        // A custom queue is necessary
        let concurrentQueue = DispatchQueue(label: "org.mistercyb.dispatchqueues",
                                            attributes: .concurrent)
        // First batch of downloads.
        for i in 0..<5 {
            concurrentQueue.async{
                print("Download \(i) from first batch BEGINS")
                self.downloadData()
                print("Download \(i) from first batch FINISHES")
            }
        }
        
        // Special download that needs to be made alone
        concurrentQueue.async(flags: .barrier) {
            print("SPECIAL DOWNLOAD BEGINS")
            self.downloadData()
            print("SPECIAL DOWNLOAD FINISHES")
        }
        
        //Second batch of downloads (will be performed after the special download)
        for i in 0..<5 {
            concurrentQueue.async{
                print("Download \(i) from second batch BEGINS")
                self.downloadData()
                print("Download \(i) from second batch FINISHES")
            }
        }
    }
    
    // Dispatch work item example
    //
    // The following example allows you to cancel a task, it is
    // possible maintaining a reference to the block (DispatchWorkItem)
    // and cancelling before it finishes.
    func performCancellableTask() {
        let block = DispatchWorkItem(flags: .inheritQoS) {
            print("A download has begun ...")
            Thread.sleep(forTimeInterval: 1)// This time is just to be sure that the download won't finish too fast
            self.downloadData()
            print("Download finished")
        }
        // Perform task
        DispatchQueue.global(qos: .userInitiated).async(execute: block)
        // Give some time before cancel
        Thread.sleep(forTimeInterval: 1)
        // Cancel task
        block.cancel()
        print("Task cancelled, the download won't finish.")
        
    }
    
    // DispatchGroup example
    //
    // Some downloads will begin asynchronously, a closure will be invoked
    // when all the downloads finishes
    
    func performGroupOfTasks() {
        let downloadGroup = DispatchGroup()
        for i in 0..<5 {
            DispatchQueue.global(qos: .userInitiated).async{
                downloadGroup.enter()
                print("Download \(i) begins...")
                self.downloadData()
                print("Download \(i) finished.")
                downloadGroup.leave()
            }
        }
        
        downloadGroup.notify(queue: DispatchQueue.main) {
            print("All the downloads have finished!!")
        }
        
        // If you prefer the method finishes until everything is done
        // you can use the following line of code instead `notify`,
        // but that, obviously, will block the main thread.
        //downloadGroup.wait()
    }
    
    // Concurrent downloads example
    //
    // The following code perform determined number of
    // downloads concurrently, without even having to iterate
    // over a for loop, it's recommended to avoid to iterate
    // over very large collections or sets.
    //
    // Note: I don't really like this, you can't know which
    // queue will be used.
    
    func performConcurrentDownloads() {
        DispatchQueue.concurrentPerform(iterations: 5) { i in
            print("Download \(i) begins...")
            self.downloadData()
            print("Download \(i) finished.")
        }
    }
    
    
    // Semaphore example that waits for a task to finish the method call
    //
    // In this example the main thread waits meanwhile an
    // async task is finished, the execution of the method
    // will end, whether the task is finished or the
    // timeout is reached. In this case `value` is 0
    // because we are not indicating available resources,
    // we are waiting an increment to finish the method execution,
    // no to begin a new task.
    
    func performReconcileSemaphoreExample() {
        let timeoutSeconds = 10
        let value = 0
        let semaphore = DispatchSemaphore(value: value)
        print("The method call will finish when the download is completed or if there is a timeout")
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.downloadData()
            semaphore.signal()
        }
        
        let timeout = DispatchTime.now() + .seconds(timeoutSeconds)
        let result = semaphore.wait(timeout: timeout)
        switch result {
        case .success:
            print("Wallpaper downloaded on time :)")
        case .timedOut:
            print("Timeout downloading wallpaper :(")
        }
    }
    
    // Semaphore example that executes 5 tasks, using just 2 threads at a time
    //
    // In this example only 2 downloads can be performed at the same time,
    // some downloads have to wait to others to finish.
    
    func performLimitedResourcesSemaphoreExample() {
        let value = 2
        let semaphore = DispatchSemaphore(value: value)
        print("Just 2 downloads at the same time are allowed.")
        for i in 0..<5 {
            print("\(i): Waiting for resource ...")
            semaphore.wait()
            print("\(i): Resource granted! Downloading")
            DispatchQueue.global(qos: .userInitiated).async {
                self.downloadData()
                print("\(i): Download finished, freeing a resource.")
                semaphore.signal()
            }
        }
        print("Download invokations finished.")
        
    }
    
    // Function to download a wallpaper (no GDC used inside)
    
    func downloadData() {

        let urlString = "https://static.pexels.com/photos/17679/pexels-photo.jpg"
        let url = URL(string: urlString)!
        let data = try? Data.init(contentsOf: url)
        if data == nil {
            print("Error downloading wallpaper")
        }
        
        // The download can be replaced by the next code line
        // if there is a problem, I just used a real download
        // because the time changes in every task.
        //Thread.sleep(forTimeInterval: 3.0)
        
    }

}

// Signal handler example.

// This method doesn't belong to any class, struct nor enum, so
// it can be called from any part of the code.

func setUpSignalHandler(_ object: AnyObject) -> DispatchSourceSignal{
    let queue = DispatchQueue.main
    //SIGSTOP is a unix signal launched when a process is paused
    // (we will use it to know when the programmer stopped the process
    // using the debugger).
    let signal = DispatchSource.makeSignalSource(signal: Int32(SIGSTOP), queue: queue)
    signal.setEventHandler {
        // If the process is paused this code will be executed.
        // We can access to a determined object in that certain moment.
        print("This is being called with: \(object.description!)")
    }
    signal.resume()
    return signal
}

