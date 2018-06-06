//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation

extension CurrentLocation: CLLocationManagerDelegate {

  public func locationManager(_ _: CLLocationManager, didUpdateLocations aLocations: [CLLocation]) {
    let theLocations = aLocations.sorted { return $0.timestamp < $1.timestamp }
    guard let theLocation = theLocations.last else {
      interactor.updateCurrentLocation(nil)
      return
    }
    guard lastLocation == nil || theLocation.distance(from: lastLocation!) >= minimalDistanceDifference else {
      return
    }
    lastLocation = theLocation
    interactor.updateCurrentLocation(theLocation.coordinate)
  }

  public func locationManager(_ aManager: CLLocationManager, didChangeAuthorization aStatus: CLAuthorizationStatus) {
    switch aStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      interactor.locationServicesAreAvailable()
      if shouldUpdateLocation {
        aManager.startUpdatingLocation()
      }
    case .denied, .restricted:
      interactor.locationServicesNotAvailable(error: LocationServiceError.denied)
    case .notDetermined:
      aManager.requestWhenInUseAuthorization()
    }
  }

}
