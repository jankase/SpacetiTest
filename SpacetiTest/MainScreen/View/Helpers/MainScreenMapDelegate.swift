//
// Created by Jan Kase on 04/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Mapbox

class MainScreenMapDelegate: NSObject, MGLMapViewDelegate {

  var presenter: MainScreenPresenterType!
  var lastPresentedPosition: CLLocation?

  func mapView(_ aMapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
    guard aMapView.zoomLevel >= 3 else { // too big map
      return
    }
    presenter.updateWeatherData(region: aMapView.visibleCoordinateBounds, zoom: aMapView.zoomLevel + 1)
  }

  func mapView(_ aMapView: MGLMapView, didUpdate anUserLocation: MGLUserLocation?) {
    guard let theUserLocation = anUserLocation?.location else {
      return
    }
    guard lastPresentedPosition == nil || lastPresentedPosition!.distance(from: theUserLocation) > 10_000 else {
      return
    }
    aMapView.setCenter(theUserLocation.coordinate, zoomLevel: 4, animated: true)
    lastPresentedPosition = theUserLocation
  }

  func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
    guard let theWeatherAnnotation = annotation as? WeatherAnnotation else {
      return
    }
    mapView.selectedAnnotations = []
    presenter.showWeatherDetail(for: theWeatherAnnotation.locationId)
  }

  func mapView(_ aMapView: MGLMapView, imageFor anAnnotation: MGLAnnotation) -> MGLAnnotationImage? {
    guard let theAnnotation = anAnnotation as? WeatherAnnotation, let theIconId = theAnnotation.iconId else {
      return nil
    }
    var theAnnotationImage = aMapView.dequeueReusableAnnotationImage(withIdentifier: theIconId)
    if theAnnotationImage == nil,
       let theImageUrl = theAnnotation.iconUrl ?? DefaultIconURLMaker(iconCode: theIconId),
       let theImageData = try? Data(contentsOf: theImageUrl),
       var theImage = UIImage(data: theImageData, scale: 1) {
      let theAlignmentInsets = UIEdgeInsets(top: 0, left: 0, bottom: theImage.size.height / 2, right: 0)
      theImage = theImage.withAlignmentRectInsets(theAlignmentInsets)
      theAnnotationImage = MGLAnnotationImage(image: theImage, reuseIdentifier: theIconId)
    }
    return theAnnotationImage
  }

}
