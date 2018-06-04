//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

protocol MainScreenPresenterNotifyType: class {

  func handle(error anError: Error)

  func newWeatherDataAvailable(weatherData aWeatherData: WeatherDataType)

}
