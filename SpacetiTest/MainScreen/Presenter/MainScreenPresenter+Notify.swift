//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

extension MainScreenPresenter: MainScreenPresenterNotifyType {

  func handle(error anError: SpaceitError) {
    switch anError {
    case let theNetworkError as NetworkError:
      _handleNetworkError(theNetworkError)
    case let theStoreError as StoreError:
      _handleStoreError(theStoreError)
    default:
      debugPrint("Unexpected error appear: \(anError)")
    }
  }

  func newWeatherDataAvailable(weatherData aWeatherData: [WeatherDataType]) {
    view.updateMap(weatherData: aWeatherData)
  }

  func newDetailWeatherDataAvailable(weatherData aWeatherData: WeatherDataType) {
    view.updateTemperature(value: _temperatureString(aWeatherData.temperature))
    view.updateApparentTemperature(value: _apparentTemperatureString(aWeatherData.apparentTemperature))
    view.updateWeatherInfoIcon(icon: _icon(aWeatherData.icon))
    view.updateWeatherInfoDescription(value: _weatherDescriptionString(aWeatherData.weatherTextDescription))
    view.updateLocationName(value: aWeatherData.name)
    view.updatePressureInfo(value: _pressureString(aWeatherData.pressure))
    view.updateHumidityInfo(value: _humidityString(aWeatherData.humidity))
    view.updateWindSpeedInfo(value: _windSpeedString(aWeatherData.windSpeed))
    view.updateWindDirectionInfo(value: _windDirectionString(aWeatherData.windDirection))
    view.showDetail()
  }

  private func _handleNetworkError(_ aNetworkError: NetworkError) {
    switch aNetworkError {
    case .failedToParseJsonWeatherData:
      SnackbarHelper.showError(message: NSLocalizedString("Error.JSONParse", comment: ""))
    case .failedToReceiveWeatherData:
      SnackbarHelper.showError(message: NSLocalizedString("Error.DownloadData", comment: ""))
    }

  }

  private func _handleStoreError(_ aStoreError: StoreError) {
    switch aStoreError {
    case .failedToStoreData:
      SnackbarHelper.showError(message: NSLocalizedString("Error.Store", comment: ""))
    }
  }

  private func _temperatureString(_ aTemperature: Float) -> String? {
    return "\(Int(aTemperature)) \(LocaleHelper.temperatureUnitsSymbol)"
  }

  private func _apparentTemperatureString(_ anApparentTemperature: Float) -> String? {
    return String(format: NSLocalizedString("MainScreen.ApparentTemperature", comment: ""),
                  Int(anApparentTemperature),
                  LocaleHelper.temperatureUnitsSymbol)
  }

  private func _icon(_ anIconUrl: URL?) -> UIImage? {
    if let theIconUrl = anIconUrl,
       let theImageData = try? Data(contentsOf: theIconUrl),
       let theIcon = UIImage(data: theImageData, scale: 1) {
      return theIcon
    } else {
      return nil
    }
  }

  private func _weatherDescriptionString(_ aSource: [String]) -> String? {
    guard !aSource.isEmpty else {
      return nil
    }
    return aSource.joined(separator: ", ")
  }

  private func _pressureString(_ aPressure: Float) -> String? {
    return "\(Int(aPressure)) hPa"
  }

  private func _humidityString(_ aHumidity: Float) -> String? {
    return "\(Int(aHumidity))%"
  }

  private func _windSpeedString(_ aSpeed: Float?) -> String? {
    guard let theSpeed = aSpeed else {
      return NSLocalizedString("UnknownValue", comment: "")
    }
    return "\(Int(theSpeed)) \(LocaleHelper.speedUnits)"
  }

  private func _windDirectionString(_ aDirection: Float?) -> String? {
    guard let theDirection = aDirection else {
      return NSLocalizedString("UnknownValue", comment: "")
    }
    let theIntValue = Int(theDirection)
    let theLocalizationIndex = (((theIntValue * 100) + 1125 ) % 36_000) / 2250
    return NSLocalizedString("WindDirection.\(theLocalizationIndex)", comment: "")
  }

}
