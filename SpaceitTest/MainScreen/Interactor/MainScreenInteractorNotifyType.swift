//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation

protocol MainScreenInteractorNotifyType: class {

  func locationServicesAreAvailable()

  func locationServicesNotAvailable(error anError: Error)

  func updateCurrentLocation(_ aLocation: CLLocationCoordinate2D?)

}
