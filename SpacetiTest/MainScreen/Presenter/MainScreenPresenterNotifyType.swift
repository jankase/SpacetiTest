//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

protocol MainScreenPresenterNotifyType: class {

  func handle(error anError: SpaceitError)

  func newWeatherDataAvailable(weatherData aWeatherData: [WeatherDataType])

  func newDetailWeatherDataAvailable(weatherData aWeatherData: WeatherDataType)

}
