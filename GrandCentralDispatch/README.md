# Grand Central Dispatch

The project contains several examples of the uses of GCD, it covers from simple features like `sync` and `async` and serial queues execution to more complex ones like `DispatchGroup`, `DispatchSemaphore`, `DispatchWorkItem`, etc.  

The code is within an iOS project with an empty `UIViewController` (`ViewController.swift`), this is intentional because the examples are thought to be the smallest possible, and since an iOS app keeps the main thread running, the different examples don't have to add any code to prevent the app to finish before their execution of the examples is done.
