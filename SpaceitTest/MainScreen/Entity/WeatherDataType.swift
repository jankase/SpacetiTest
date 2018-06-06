//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import UIKit

protocol WeatherDataType: CustomDebugStringConvertible {

  var name: String { get set }
  var id: Int { get set }
  var coordinate: CLLocationCoordinate2D { get set }
  var originDate: Date { get set }
  var humidity: Float { get set }
  var pressure: Float { get set }
  var temperature: Float { get set }
  var apparentTemperature: Float { get }
  var weatherTextDescription: [String] { get set }
  var windSpeed: Float? { get set }
  var windDirection: Float? { get set }
  var icon: URL? { get }
  var iconCode: String { get set }

}

internal extension WeatherDataType {

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

  mutating func update(with anAnotherWeatherData: WeatherDataType) {
    name = anAnotherWeatherData.name
    id = anAnotherWeatherData.id
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
