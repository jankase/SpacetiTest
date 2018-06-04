//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

extension MainScreenVC: MainScreenViewNotifyType {

  func updateTemperature(value aValue: Float) {
    DispatchQueue.main.async { [weak self] in
      self?.temperatureLabel?.text = "\(Int(aValue)) \u{2103}"
    }
  }

  func updateApparentTemperature(value aValue: Float) {
    DispatchQueue.main.async { [weak self] in
      self?.apparentTemperatureLabel?.text = "Pocitová \(Int(aValue)) \u{2103}"
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

}
