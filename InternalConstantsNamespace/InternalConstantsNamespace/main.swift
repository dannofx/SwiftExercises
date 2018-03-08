//
//  main.swift
//  InternalConstantsNamespace
//
//  Created by Danno on 3/7/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation

// Example of the access to global constant values
// under a "internal workspace"
print("URL: \(API.baseURL)")
print("Access token: \(API.token)")

// Example of keys used to access/set UserDefaults values
// that are embed in a UserDefaults extension.
let userDefaults = UserDefaults.standard
userDefaults.setValue("dannofx", forKey: UserDefaults.Keys.currentUser)
userDefaults.setValue(Date(), forKey: UserDefaults.Keys.accessTime)
guard let currentUser = userDefaults.value(forKey: UserDefaults.Keys.currentUser) else {
    print("The value for the current user was not found")
    exit(1)
}
guard let accessTime = userDefaults.value(forKey: UserDefaults.Keys.accessTime) else {
    print("The value for the access time was not found")
    exit(1)
}
print("Saved current user: \(currentUser)")
print("Saved access time: \(accessTime)")
