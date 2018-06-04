//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

protocol MainScreenViewNotifyType: class {

  func updateTemperature(value aValue: Float)
  func updateApparentTemperature(value aValue: Float)
  func updateWeatherInfoIcon(icon anIcon: UIImage?)
  func updateWeatherInfoDescription(value aValue: String)

}
