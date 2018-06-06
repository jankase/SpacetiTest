//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation

struct WeatherDataVO: WeatherDataType, Decodable {

  static var iconUrlMaker: (String) -> URL? = {
    return URL(string: "https://openweathermap.org/img/w/\($0).png")
  }

  var id: Int = 0
  var name: String = ""
  var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  var originDate: Date = Date()
  var humidity: Float = 0
  var pressure: Float = 0
  var temperature: Float = 0
  var weatherTextDescription: [String] = []
  var windDirection: Float?
  var windSpeed: Float?
  var iconCode: String = ""
  var icon: URL? {
    guard !iconCode.isEmpty else {
      return nil
    }
    return WeatherDataVO.iconUrlMaker(iconCode)
  }

  var apparentTemperature: Float {
    // source https://hvezdarnaub.cz/meteostanice/co-je-pocitova-teplota/
    let theDoubleTemp = Double(temperature)
    let theHpa = Double(humidity) / 100.0 * 6.105 * exp(17.27 * theDoubleTemp / (237.7 + theDoubleTemp))
    let theApparentTemp = theDoubleTemp + 0.33 * theHpa - 0.7 * Double(windSpeed ?? 0) - 4
    let theResult = Float(theApparentTemp)
    return theResult
  }

  init() {
  }

  init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: _WeatherDataKeys.self)
    coordinate = try theContainer.decode(CLLocationCoordinate2D.self, forKey: .coordinate)
    id = try theContainer.decode(Int.self, forKey: .id)
    name = try theContainer.decode(String.self, forKey: .name)
    originDate = Date(timeIntervalSince1970: try theContainer.decode(TimeInterval.self, forKey: .originDate))
    let theMainContainer = try theContainer.nestedContainer(keyedBy: _WeatherDataMainKeys.self, forKey: .main)
    humidity = try theMainContainer.decode(Float.self, forKey: .humidity)
    pressure = try theMainContainer.decode(Float.self, forKey: .pressure)
    temperature = try theMainContainer.decode(Float.self, forKey: .temp)
    var theWeatherInfo = try theContainer.nestedUnkeyedContainer(forKey: .weather)
    var theStringWeatherInfo: [String] = []
    while !theWeatherInfo.isAtEnd {
      let theWeatherInfoDetail = try theWeatherInfo.nestedContainer(keyedBy: _WeatherInfoKeys.self)
      theStringWeatherInfo.append(try theWeatherInfoDetail.decode(String.self, forKey: .description))
      if icon == nil, let theIconCode = try theWeatherInfoDetail.decodeIfPresent(String.self, forKey: .icon) {
        iconCode = theIconCode
      }
    }
    weatherTextDescription = theStringWeatherInfo
    do {
      let theWindContainer = try theContainer.nestedContainer(keyedBy: _WindInfoKeys.self, forKey: .wind)
      windSpeed = try theWindContainer.decodeIfPresent(Float.self, forKey: .speed)
      windDirection = try theWindContainer.decodeIfPresent(Float.self, forKey: .direction)
    } catch {}
  }

  private enum _WeatherDataKeys: String, CodingKey {
    case coordinate = "coord"
    case originDate = "dt"
    case name
    case id
    case main
    case weather
    case wind
  }

  private enum _WeatherDataMainKeys: String, CodingKey {
    case humidity
    case pressure
    case temp
  }

  private enum _WeatherDataSysKeys: String, CodingKey {
    case sunrise
    case sunset
  }

  private enum _WeatherInfoKeys: String, CodingKey {
    case description
    case icon
  }

  private enum _WindInfoKeys: String, CodingKey {
    case speed
    case direction = "deg"
  }

}
