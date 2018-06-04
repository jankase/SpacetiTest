//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocation: NSObject, CurrentLocationType {

  var minimalDistanceDifference: CLLocationDistance = 10_000
  var shouldUpdateLocation: Bool = false
  var lastLocation: CLLocation?

  weak var interactor: MainScreenInteractorNotifyType!

  lazy var manager: CLLocationManager = {
    let theResult = CLLocationManager()
    theResult.delegate = self
    return theResult
  }()

  var currentLocation: CLLocation? {
    return self.manager.location
  }

  lazy var currentAuthorizationState: CLAuthorizationStatus = CLLocationManager.authorizationStatus()

  func activateLocationServices() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      _requestLocationServicesPermissions()
    case .restricted, .denied:
      interactor.locationServicesNotAvailable(error: LocationServiceError.denied)
    case .authorizedWhenInUse, .authorizedAlways:
      interactor.locationServicesAreAvailable()
    }
  }

  func startUpdatingLocation() {
    shouldUpdateLocation = true
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse, .authorizedAlways:
      manager.startUpdatingLocation()
    case .notDetermined:
      activateLocationServices()
    case .restricted, .denied:
      interactor.locationServicesNotAvailable(error: LocationServiceError.denied)
    }
  }

  func stopUpdatingLocation() {
    shouldUpdateLocation = false
    manager.stopUpdatingLocation()
  }

  private func _requestLocationServicesPermissions() {
    manager.requestWhenInUseAuthorization()
  }

}
