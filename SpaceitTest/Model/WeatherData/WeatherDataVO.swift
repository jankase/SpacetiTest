//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherDataVO: WeatherDataType, Decodable {

  var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  var originDate: Date = Date()
  var humidity: Float = 0
  var pressure: Float = 0
  var temperature: Float = 0
  var sunrise: Date = .distantPast
  var sunset: Date = .distantFuture
  var weatherTextDescription: [String] = []
  var wind: WindInfoType?

  enum WeatherDataKeys: String, CodingKey {
    case coordinate = "coord"
    case originDate = "dt"
    case main
    case sys
    case weather
    case wind
  }

  enum WeatherDataMainKeys: String, CodingKey {
    case humidity
    case pressure
    case temp
  }

  enum WeatherDataSysKeys: String, CodingKey {
    case sunrise
    case sunset
  }

  enum WeatherInfoKeys: String, CodingKey {
    case description
  }

  init() {}

  init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: WeatherDataKeys.self)
    coordinate = try theContainer.decode(CLLocationCoordinate2D.self, forKey: .coordinate)
    originDate = Date(timeIntervalSince1970: try theContainer.decode(TimeInterval.self, forKey: .originDate))
    let theMainContainer = try theContainer.nestedContainer(keyedBy: WeatherDataMainKeys.self, forKey: .main)
    humidity = try theMainContainer.decode(Float.self, forKey: .humidity)
    pressure = try theMainContainer.decode(Float.self, forKey: .pressure)
    temperature = try theMainContainer.decode(Float.self, forKey: .temp)
    let theSysContainer = try theContainer.nestedContainer(keyedBy: WeatherDataSysKeys.self, forKey: .sys)
    sunrise = Date(timeIntervalSince1970: try theSysContainer.decode(TimeInterval.self, forKey: .sunrise))
    sunset = Date(timeIntervalSince1970: try theSysContainer.decode(TimeInterval.self, forKey: .sunset))
    var theWeatherInfo = try theContainer.nestedUnkeyedContainer(forKey: .weather)
    var theStringWeatherInfo: [String] = []
    while !theWeatherInfo.isAtEnd {
      let theWeatherInfoDetail = try theWeatherInfo.nestedContainer(keyedBy: WeatherInfoKeys.self)
      theStringWeatherInfo.append(try theWeatherInfoDetail.decode(String.self, forKey: .description))
    }
    weatherTextDescription = theStringWeatherInfo
    wind = try theContainer.decode(WindInfoVO.self, forKey: .wind)
  }

}
