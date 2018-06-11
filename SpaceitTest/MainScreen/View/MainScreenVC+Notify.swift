//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Mapbox
import MaterialComponents
import SnapKit
import UIKit

extension MainScreenVC: MainScreenViewNotifyType {

  func updateMap(weatherData aWeatherData: [WeatherDataType]) {
    DispatchQueue.main.async {
      var theRemoveCandidates: [WeatherAnnotation] = self.map.annotations?.compactMap { $0 as? WeatherAnnotation } ?? []
      let theNewAnnotations = aWeatherData.compactMap { $0.mapAnnotation as? WeatherAnnotation }
      var theAnnotationsToAdd = [WeatherAnnotation]()
      for theNewAnnotation in theNewAnnotations {
        if let theIndexToRemove = theRemoveCandidates.index(where: { $0 == theNewAnnotation }) {
          theRemoveCandidates.remove(at: theIndexToRemove)
        } else {
          theAnnotationsToAdd.append(theNewAnnotation)
        }
      }
      if !theRemoveCandidates.isEmpty {
        self.map.removeAnnotations(theRemoveCandidates)
      }
      if !theAnnotationsToAdd.isEmpty {
        self.map.addAnnotations(theAnnotationsToAdd)
      }
    }
  }

  func updateTemperature(value aValue: String?) {
    DispatchQueue.main.async { [weak self] in
      self?.temperatureLabel.text = aValue
    }
  }

  func updateApparentTemperature(value aValue: String?) {
    DispatchQueue.main.async { [weak self] in
      self?.apparentTemperatureLabel?.text = aValue
    }
  }

  func updateWeatherInfoIcon(icon anIcon: UIImage?) {
    DispatchQueue.main.async { [weak self] in
      self?.weatherIcon?.image = anIcon
    }
  }

  func updateWeatherInfoDescription(value aValue: String?) {
    DispatchQueue.main.async { [weak self] in
      self?.weatherDescription?.text = aValue
    }
  }

  func updateLocationName(value aValue: String?) {
    locationInfoLabel?.text = aValue
  }

  func updatePressureInfo(value aValue: String?) {
    pressureValueLabel?.text = aValue
  }

  func updateHumidityInfo(value aValue: String?) {
    humidityValueLabel?.text = aValue
  }

  func updateWindDirectionInfo(value aValue: String?) {
    windDirectionLabel?.text = aValue
  }

  func updateWindSpeedInfo(value aValue: String?) {
    windSpeedLabel?.text = aValue
  }

  func showDetail() {
    DispatchQueue.main.async { [weak self] in
      guard let theSelf = self else {
        return
      }
      theSelf.detailView.layoutIfNeeded()
      UIView.animate(withDuration: 0.5) {
        let theCurve = MDCAnimationTimingFunction.easeOut
        let theAnimationFunction = CAMediaTimingFunction.mdc_function(withType: theCurve)
        CATransaction.setAnimationTimingFunction(theAnimationFunction)
        var theOffsetHeight = -theSelf.detailView.bounds.height
        if #available(iOS 11, *) {
          let theOffset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
          theOffsetHeight -= theOffset
        }
        theSelf.detailViewTopConstraint?.constant = theOffsetHeight
        theSelf.view.layoutIfNeeded()
      }
    }
  }

  func hideDetail() {
    DispatchQueue.main.async { [weak self] in
      guard let theSelf = self else {
        return
      }

      theSelf.detailView.layoutIfNeeded()
      UIView.animate(withDuration: 0.5) {
        let theCurve = MDCAnimationTimingFunction.easeOut
        let theAnimationFunction = CAMediaTimingFunction.mdc_function(withType: theCurve)
        CATransaction.setAnimationTimingFunction(theAnimationFunction)
        theSelf.detailViewTopConstraint?.constant = 0
        theSelf.view.layoutIfNeeded()
      }
    }
  }

}
