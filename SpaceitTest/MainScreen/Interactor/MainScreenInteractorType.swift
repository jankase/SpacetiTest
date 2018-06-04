//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation
import Mapbox

protocol MainScreenInteractorType: class {

  func updateWeatherData(location aLocation: CLLocationCoordinate2D)

  func updateWeatherData(region aRegion: MGLCoordinateBounds, zoom aZoom: Double)

}
