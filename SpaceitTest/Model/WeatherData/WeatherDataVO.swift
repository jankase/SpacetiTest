//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherDataVO: WeatherDataType, Codable {

  var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  var originDate: Date = Date()
  var humidity: Float = 0
  var pressure: Float = 0
  var temperature: Float = 0
  var sunrise: Date = .distantPast
  var sunset: Date = .distantFuture
  var weatherTextDescription: [String] = []
  var wind: WindInfoType?
  var apparentTemperature: Float {
    // source https://hvezdarnaub.cz/meteostanice/co-je-pocitova-teplota/
    let theDoubleTemp = Double(temperature)
    let theHpa = Double(humidity) / 100.0 * 6.105 * exp(17.27 * theDoubleTemp / (237.7 + theDoubleTemp))
    let theApparentTemp = theDoubleTemp + 0.33 * theHpa - 0.7 * Double(wind?.speed ?? 0) - 4
    let theResult = Float(theApparentTemp)
    return theResult
  }

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

  init() {
  }

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

  func encode(to anEncoder: Encoder) throws {
    var theContainer = anEncoder.container(keyedBy: WeatherDataKeys.self)
    try theContainer.encode(coordinate, forKey: .coordinate)
    try theContainer.encode(Int(originDate.timeIntervalSince1970), forKey: .originDate)
    var theMainContainer = theContainer.nestedContainer(keyedBy: WeatherDataMainKeys.self, forKey: .main)
    try theMainContainer.encode(humidity, forKey: .humidity)
    try theMainContainer.encode(pressure, forKey: .pressure)
    try theMainContainer.encode(temperature, forKey: .temp)
    var theSysContainer = theContainer.nestedContainer(keyedBy: WeatherDataSysKeys.self, forKey: .sys)
    try theSysContainer.encode(sunrise.timeIntervalSince1970, forKey: .sunrise)
    try theSysContainer.encode(sunset.timeIntervalSince1970, forKey: .sunset)
    var theWeatherInfo = theContainer.nestedUnkeyedContainer(forKey: .weather)
    for theWeatherDescription in weatherTextDescription {
      var theWeatherInfoContainer = theWeatherInfo.nestedContainer(keyedBy: WeatherInfoKeys.self)
      try theWeatherInfoContainer.encode(theWeatherDescription, forKey: .description)
    }
    if let theWind = wind as? WindInfoVO {
      try theContainer.encode(theWind, forKey: .wind)
    }
  }

}
