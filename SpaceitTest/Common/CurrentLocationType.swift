//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation

protocol CurrentLocationType {

  var minimalDistanceDifference: CLLocationDistance { get set }

  func activateLocationServices()

  func startUpdatingLocation()

  func stopUpdatingLocation()

}
