//
//  Constants.swift
//  InternalConstantsNamespace
//
//  Created by Danno on 3/7/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation

/// Alternative to store different constant values that are related.
/// An enum without cases is used in order to make impossible to create
/// an instance of API. An advantage of this is that, since the values are
/// properties of the enum, the enum API works as an namespace at the level
/// of the module.
enum API {
    static let baseURL = "https://somesite.com/api"
    static let token = "An4cc3s5t0k3N"
}

/// This extension is used to keep together the keys that will be used
/// with UserDefaults. The approach is basically the same that the previous enum
/// just that the enum Keys is declared within the UserDefaults extension, so
/// the keys can be accessed as UserDefaults.Keys.YOURKEY
extension UserDefaults {
    enum Keys {
        static let currentUser = "currentUser"
        static let accessTime = "accessTime"
    }
}
