//
// Created by Jan Kase on 07/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Mapbox

extension WeatherDataType {

  var mapAnnotation: MGLAnnotation {
    let theResult = MGLPointAnnotation()
    theResult.title = name
    theResult.coordinate = coordinate
    theResult.subtitle = "\(Int(temperature)) \(LocaleHelper.temperatureUnitsSymbol)"
    return theResult
  }

}
