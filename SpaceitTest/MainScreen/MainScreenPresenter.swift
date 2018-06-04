//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

class MainScreenPresenter: MainScreenPresenterType {

  weak var view: MainScreenViewNotifyType!
  lazy var interactor: MainScreenInteractorType = {
    let theResult = MainScreenInteractor()
    theResult.presenter = self
    return theResult
  }()

  func startUpdatingWeatherData() {
    interactor.startUpdatingWeatherData()
  }

  func stopUpdatingWeatherData() {
    interactor.stopUpdatingWeatherData()
  }
}
