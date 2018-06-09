//
// Created by Jan Kase on 04/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Mapbox

class MainScreenMapDelegate: NSObject, MGLMapViewDelegate {

  var presenter: MainScreenPresenterType!

  func mapView(_ aMapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
    guard aMapView.zoomLevel >= 3 else { // too big map
      return
    }
    presenter.updateWeatherData(region: aMapView.visibleCoordinateBounds, zoom: aMapView.zoomLevel + 1)
  }

  func mapView(_ aMapView: MGLMapView, didUpdate anUserLocation: MGLUserLocation?) {
    guard let theUserLocation = anUserLocation else {
      return
    }
    aMapView.setCenter(theUserLocation.coordinate, zoomLevel: 4, animated: true)
  }

  func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
    guard let theWeatherAnnotation = annotation as? WeatherAnnotation else {
      return
    }
    presenter.showWeatherDetail(for: theWeatherAnnotation.locationId)
  }
}
