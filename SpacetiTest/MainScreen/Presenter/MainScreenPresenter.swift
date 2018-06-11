//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Mapbox

class MainScreenPresenter: MainScreenPresenterType {

  weak var view: MainScreenViewNotifyType!

  lazy var interactor: MainScreenInteractorType = {
    let theResult = MainScreenInteractor()
    theResult.presenter = self
    return theResult
  }()

  func updateWeatherData(region aRegion: MGLCoordinateBounds, zoom aZoom: Double) {
    interactor.updateWeatherData(region: aRegion, zoom: aZoom)
  }

  func showWeatherDetail(for aLocationId: Int) {
    interactor.retrieveWeatherDetail(for: aLocationId)
  }
}
