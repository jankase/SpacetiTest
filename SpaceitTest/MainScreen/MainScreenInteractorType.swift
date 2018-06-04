//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainScreenInteractorType: class {

  func startUpdatingWeatherData()

  func stopUpdatingWeatherData()

  func updateWeatherData(location aLocation: CLLocationCoordinate2D)

}
