//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherDataType: CustomDebugStringConvertible {
  var coordinate: CLLocationCoordinate2D { get set }
  var originDate: Date { get set }
  var humidity: Float { get set }
  var pressure: Float { get set }
  var temperature: Float { get set }
  var apparentTemperature: Float { get }
  var sunrise: Date { get set }
  var sunset: Date { get set }
  var weatherTextDescription: [String] { get set }
  var wind: WindInfoType? { get set }
  var icon: URL? { get }

}

extension WeatherDataType {

  public var debugDescription: String {
    let theResult = """
        Coordinate: \(coordinate)
        Origin date: \(originDate)
        Humidity: \(humidity)
        Pressure: \(pressure)
        Temperature: \(temperature)
        Sunrise: \(sunrise)
        Sunset: \(sunset)
        Weather description: \(weatherTextDescription)
        Wind: \(wind == nil ? "unknown" : wind!.debugDescription)
        Icon: \(icon == nil ? "unknown" : icon!.absoluteString)
        """
    return theResult
  }

}
