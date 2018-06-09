//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import UIKit

protocol MainScreenViewNotifyType: class {

  func updateMap(weatherData aWeatherData: [WeatherDataType])

  func updateTemperature(value aValue: Float)
  func updateApparentTemperature(value aValue: Float)
  func updateWeatherInfoIcon(icon anIcon: UIImage?)
  func updateWeatherInfoDescription(value aValue: String)
  func updateLocationName(value aValue: String)
  func updatePressureInfo(value aValue: Float)
  func updateHumidityInfo(value aValue: Float)
  func updateWindDirectionInfo(value aValue: Float?)
  func updateWindSpeedInfo(value aValue: Float?)

  func showDetail()
  func hideDetail()

}
