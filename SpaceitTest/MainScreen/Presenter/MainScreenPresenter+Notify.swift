//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

extension MainScreenPresenter: MainScreenPresenterNotifyType {

  func handle(error anError: Error) {
  }

  func newWeatherDataAvailable(weatherData aWeatherData: WeatherDataType) {
    debugPrint(aWeatherData)
    view.updateTemperature(value: aWeatherData.temperature)
    view.updateLocation(coordinates: aWeatherData.coordinate)
    view.updateApparentTemperature(value: aWeatherData.apparentTemperature)
    if let theIconUrl = aWeatherData.icon,
       let theImageData = try? Data(contentsOf: theIconUrl),
       let theIcon = UIImage(data: theImageData, scale: 1) {
      view.updateWeatherInfoIcon(icon: theIcon)
    } else {
      view.updateWeatherInfoIcon(icon: nil)
    }
    let theWeatherDescription = aWeatherData.weatherTextDescription.joined(separator: ", ")
    view.updateWeatherInfoDescription(value: theWeatherDescription)
  }

}