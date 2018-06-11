//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import UIKit

protocol WeatherDataType: CustomDebugStringConvertible {

  var iconUrlMaker: (String) -> URL? { get set }

  init()

  var name: String { get set }
  var id: Int { get set }
  var coordinate: CLLocationCoordinate2D { get set }
  var originDate: Date { get set }
  var humidity: Float { get set }
  var pressure: Float { get set }
  var temperature: Float { get set }
  var weatherTextDescription: [String] { get set }
  var windSpeed: Float? { get set }
  var windDirection: Float? { get set }
  var iconCode: String { get set }

}

internal extension WeatherDataType {

  var apparentTemperature: Float {
    // source https://hvezdarnaub.cz/meteostanice/co-je-pocitova-teplota/
    let theDoubleTemp = LocaleHelper.usesMetric ? Double(temperature) : Double(_fahrenheitToCelsius(temperature))
    let theWindSpeed = LocaleHelper.usesMetric ? Double(windSpeed ?? 0) : Double(_mphToKmh(windSpeed))
    let theHpa = Double(humidity) / 100.0 * 6.105 * exp(17.27 * theDoubleTemp / (237.7 + theDoubleTemp))
    let theApparentTemp = theDoubleTemp + 0.33 * theHpa - 0.7 * theWindSpeed - 4
    let theResult = Float(theApparentTemp)
    return LocaleHelper.usesMetric ? theResult : _celsiusToFahrenheit(theResult)
  }

  private func _fahrenheitToCelsius(_ aValue: Float) -> Float {
    return (aValue - 32) / 1.8
  }

  private func _celsiusToFahrenheit(_ aValue: Float) -> Float {
    return (aValue * 1.8) + 32
  }

  private func _mphToKmh(_ aValue: Float?) -> Float {
    guard let theValue = aValue else {
      return 0
    }
    return theValue * 1.609_344
  }

  var debugDescription: String {
    let theResult = """
        Name: \(name)
        ID: \(id)
        Coordinate: \(coordinate)
        Origin date: \(originDate)
        Humidity: \(humidity)
        Pressure: \(pressure)
        Temperature: \(temperature)
        Weather description: \(weatherTextDescription)
        Wind direction: \(windDirection == nil ? "unknown" : "\(windDirection!)")
        Wind speed: \(windSpeed == nil ? "unknown" : "\(windSpeed!)")
        Icon: \(icon == nil ? "unknown" : icon!.absoluteString)
        """
    return theResult
  }

  var icon: URL? {
    guard !iconCode.isEmpty else {
      return nil
    }
    return iconUrlMaker(iconCode)
  }

  init(weatherData aWeatherData: WeatherDataType) {
    self.init()
    update(with: aWeatherData)
  }

  mutating func update(with anAnotherWeatherData: WeatherDataType, shouldUpdateId aShouldUpdateId: Bool = true) {
    if aShouldUpdateId {
      id = anAnotherWeatherData.id
    }
    name = anAnotherWeatherData.name
    coordinate = anAnotherWeatherData.coordinate
    originDate = anAnotherWeatherData.originDate
    humidity = anAnotherWeatherData.humidity
    pressure = anAnotherWeatherData.pressure
    temperature = anAnotherWeatherData.temperature
    weatherTextDescription = anAnotherWeatherData.weatherTextDescription
    windSpeed = anAnotherWeatherData.windSpeed
    windDirection = anAnotherWeatherData.windDirection
    iconCode = anAnotherWeatherData.iconCode
  }

}

func DefaultIconURLMaker(iconCode anIconCode: String) -> URL? {
  return URL(string: "https://openweathermap.org/img/w/\(anIconCode).png")
}
