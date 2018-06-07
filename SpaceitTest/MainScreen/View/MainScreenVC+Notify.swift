//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Mapbox
import UIKit

extension MainScreenVC: MainScreenViewNotifyType {

  func updateMap(weatherData aWeatherData: [WeatherDataType]) {
    if let theCurrentAnnotations = map.annotations {
      map.removeAnnotations(theCurrentAnnotations)
    }
    let theNewAnnotations = aWeatherData.map { return $0.mapAnnotation }
    map.addAnnotations(theNewAnnotations)
  }

  func updateTemperature(value aValue: Float) {
    DispatchQueue.main.async { [weak self] in
      self?.temperatureLabel?.text = "\(Int(aValue)) \(LocaleHelper.temperatureUnitsSymbol)"
    }
  }

  func updateApparentTemperature(value aValue: Float) {
    DispatchQueue.main.async { [weak self] in
      self?.apparentTemperatureLabel?.text = String(format: NSLocalizedString("MainScreen.ApparentTemperature",
                                                                              comment: ""),
                                                    Int(aValue),
                                                    LocaleHelper.temperatureUnitsSymbol)
    }
  }

  func updateWeatherInfoIcon(icon anIcon: UIImage?) {
    DispatchQueue.main.async { [weak self] in
      self?.weatherIcon?.image = anIcon
    }
  }

  func updateWeatherInfoDescription(value aValue: String) {
    DispatchQueue.main.async { [weak self] in
      self?.weatherDescription?.text = aValue
    }
  }

  func updateLocation(coordinates aCoordinates: CLLocationCoordinate2D) {
//    DispatchQueue.main.async { [weak self] in
//      self?.map?.setCenter(aCoordinates, zoomLevel: 10, animated: true)
//    }
  }
}
