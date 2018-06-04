//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

extension MainScreenPresenter: MainScreenPresenterNotifyType {

  func handle(error anError: Error) {
  }

  func newWeatherDataAvailable(weatherData aWeatherData: WeatherDataType) {
    debugPrint(aWeatherData)
  }

}
