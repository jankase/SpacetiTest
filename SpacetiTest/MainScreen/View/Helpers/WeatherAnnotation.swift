//
// Created by Jan Kase on 07/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Mapbox

class WeatherAnnotation: MGLPointAnnotation {

  var locationId: Int = 0
  var iconId: String?
  var iconUrl: URL?

  static func ==(_ aLhs: WeatherAnnotation, _ aRhs: WeatherAnnotation) -> Bool {
    return aLhs.locationId == aRhs.locationId && aLhs.coordinate == aRhs.coordinate
  }

}

extension CLLocationCoordinate2D: Equatable {

  public static func ==(_ aLhs: CLLocationCoordinate2D, _ aRhs: CLLocationCoordinate2D) -> Bool {
    return aLhs.latitude == aRhs.latitude && aLhs.longitude == aRhs.longitude
  }

}
