//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import UIKit

protocol MainScreenViewNotifyType: class {

  func updateMap(weatherData aWeatherData: [WeatherDataType])

  func updateTemperature(value aValue: String?)
  func updateApparentTemperature(value aValue: String?)
  func updateWeatherInfoIcon(icon anIcon: UIImage?)
  func updateWeatherInfoDescription(value aValue: String?)
  func updateLocationName(value aValue: String?)
  func updatePressureInfo(value aValue: String?)
  func updateHumidityInfo(value aValue: String?)
  func updateWindDirectionInfo(value aValue: String?)
  func updateWindSpeedInfo(value aValue: String?)

  func showDetail()
  func hideDetail()

}
