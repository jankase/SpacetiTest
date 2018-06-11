//
//  AppDelegate.swift
//  SpaceitTest
//
//  Created by Jan Kase on 29/05/2018.
//  Copyright © 2018 Jan Kaše. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ anApplication: UIApplication,
                   didFinishLaunchingWithOptions aLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = MainScreenRouter.mainScreen()
    window?.makeKeyAndVisible()

    return false

  }

}
