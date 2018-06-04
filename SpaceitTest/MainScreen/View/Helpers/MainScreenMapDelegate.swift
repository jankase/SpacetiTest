//
// Created by Jan Kase on 04/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Mapbox

class MainScreenMapDelegate: NSObject, MGLMapViewDelegate {

  var presenter: MainScreenPresenterType!

  func mapView(_ aMapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
    let theZoom = aMapView.zoomLevel + 1
    presenter.updateWeatherData(region: aMapView.visibleCoordinateBounds, zoom: theZoom)
  }
}
