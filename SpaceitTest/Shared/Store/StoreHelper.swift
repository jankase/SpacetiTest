//
// Created by Jan Kase on 06/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import RealmSwift

struct StoreHelper {

  static var dbConfiguration: Realm.Configuration = {
    var theResult = Realm.Configuration(schemaVersion: 1, migrationBlock: { _, _ in })
    let theFileManager = FileManager.default
    guard let theStoreUrl = theFileManager.urls(for: .documentDirectory, in: .userDomainMask).first?
        .appendingPathComponent("spaceit_weather.realm") else {
      fatalError("Failed to find document directory")
    }
    theResult.fileURL = theStoreUrl
    Realm.Configuration.defaultConfiguration = theResult
    return theResult
  }()

  static func createNewRealm() throws -> Realm {
    _creationSemaphore.wait()
    defer { _creationSemaphore.signal() }
    let theResult = try Realm(configuration: dbConfiguration)
    guard var theStoreUrl = theResult.configuration.fileURL,
          FileManager.default.fileExists(atPath: theStoreUrl.path) else {
      return theResult
    }
    var theResourceValues = URLResourceValues()
    theResourceValues.isExcludedFromBackup = true
    try? theStoreUrl.setResourceValues(theResourceValues)
    return theResult
  }

  private static var _creationSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)

}
