//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation

extension MainScreenInteractor: MainScreenInteractorNotifyType {

  func locationServicesAreAvailable() {
    currentLocationHelper.startUpdatingLocation()
  }

  func locationServicesNotAvailable(error anError: Error) {
    presenter.handle(error: anError)
  }

  func updateCurrentLocation(_ aLocation: CLLocationCoordinate2D?) {
    guard let theLocation = aLocation else {
      presenter.handle(error: LocationServiceError.invalidLocation)
      return
    }
    //TODO update in some interval the weather data
    updateWeatherData(location: theLocation)
  }

}
