//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation

struct WeatherDataVO: WeatherDataType, Decodable {

  var iconUrlMaker: (String) -> URL? = DefaultIconURLMaker

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
