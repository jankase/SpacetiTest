//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

protocol MainScreenPresenterType {

  var view: MainScreenViewNotifyType! { get set }

  func startUpdatingWeatherData()

  func stopUpdatingWeatherData()

}
