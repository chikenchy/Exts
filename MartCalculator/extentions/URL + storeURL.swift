//
//  URL + storeURL.swift
//
//  Created by 신희욱 on 2020/06/03.
//  Copyright © 2020 신희욱. All rights reserved.
//

import Foundation
import CoreData

public extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
