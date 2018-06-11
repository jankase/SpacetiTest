//
// Created by Jan Kase on 06/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation
import RealmSwift

class WeatherDataMO: Object, WeatherDataType {

  var iconUrlMaker: (String) -> URL? = DefaultIconURLMaker

  @objc dynamic var name: String = ""
  @objc dynamic var id: Int = 0
  @objc dynamic var originDate: Date = Date()
  @objc dynamic var humidity: Float = 0
  @objc dynamic var pressure: Float = 0
  @objc dynamic var temperature: Float = 0
  @objc dynamic var iconCode: String = ""

  override class func primaryKey() -> String? {
    return "id"
  }

  fileprivate let internalWindSpeed: RealmOptional<Float> = RealmOptional<Float>()
  fileprivate let internalWindDirection: RealmOptional<Float> = RealmOptional<Float>()
  fileprivate let internalWeatherTextDescription: List<String> = List<String>()

  @objc dynamic fileprivate var internalLatitude: CLLocationDegrees = 0
  @objc dynamic fileprivate var internalLongitude: CLLocationDegrees = 0

}

extension WeatherDataMO {

  var windSpeed: Float? {
    get {
      return internalWindSpeed.value
    }
    set(aNewWindSpeed) {
      internalWindSpeed.value = aNewWindSpeed
    }
  }
  var windDirection: Float? {
    get {
      return internalWindDirection.value
    }
    set(aNewWindDirection) {
      internalWindDirection.value = aNewWindDirection
    }
  }
  var coordinate: CLLocationCoordinate2D {
    get {
      return CLLocationCoordinate2D(latitude: internalLatitude, longitude: internalLongitude)
    }
    set(aNewCoordinate) {
      internalLatitude = aNewCoordinate.latitude
      internalLongitude = aNewCoordinate.longitude
    }
  }
  var weatherTextDescription: [String] {
    get {
      return [String](internalWeatherTextDescription)
    }
    set(aNewWeatherTextDescription) {
      internalWeatherTextDescription.removeAll()
      internalWeatherTextDescription.append(objectsIn: aNewWeatherTextDescription)
    }
  }

}

extension WeatherDataType {

  func store() throws {
    let theRealm = try StoreHelper.createNewRealm()
    try theRealm.write {
      var theWeatherData = theRealm.create(WeatherDataMO.self, value: ["id": id], update: true)
      theWeatherData.update(with: self, shouldUpdateId: false)
    }
  }

}

extension Array where Element: WeatherDataType {

  func store() throws {
    let theRealm = try StoreHelper.createNewRealm()
    try theRealm.write {
      self.forEach {
        var theWeatherRecord = theRealm.create(WeatherDataMO.self, value: ["id": $0.id], update: true)
        theWeatherRecord.update(with: $0, shouldUpdateId: false)
      }
    }
  }

}
