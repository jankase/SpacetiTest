//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SpaceitTest

class WeatherDataTestSpec: QuickSpec {

  override func spec() {
    describe("a standard JSON parsing") {
      var theWeatherData: WeatherDataVO!
      do {
        theWeatherData = try JSONDecoder().decode(WeatherDataVO.self, from: self._json)
        expect(true).to(beTrue(), description: "Passed")
      } catch let theError {
        fail("Parsing failed: \(theError)")
      }
      _testHasBeenParsed(data: theWeatherData)
      guard theWeatherData != nil else {
        return
      }
      _testCoordinates(data: theWeatherData)
      _testWeatherDescription(data: theWeatherData)
      _testTemperature(data: theWeatherData)
      _testPresure(data: theWeatherData)
      _testHumidity(data: theWeatherData)
      _testWindInfo(data: theWeatherData)
      _testOriginDate(data: theWeatherData)
      _testSunrise(data: theWeatherData)
      _testSunset(data: theWeatherData)
    }
  }

  private func _testSunset(data aWeatherData: WeatherDataVO!) {
    it("has correct sunset time") {
      var theDateComponents = self._defaultDateComponents
      theDateComponents.hour = 21
      theDateComponents.minute = 1
      theDateComponents.second = 40
      expect(aWeatherData.sunset).to(equal(theDateComponents.date!))
    }
  }

  private func _testSunrise(data aWeatherData: WeatherDataVO!) {
    it("has correct sunrise time") {
      var theDateComponents = self._defaultDateComponents
      theDateComponents.hour = 4
      theDateComponents.minute = 58
      theDateComponents.second = 48
      expect(aWeatherData.sunrise).to(equal(theDateComponents.date!))
    }
  }

  private func _testOriginDate(data aWeatherData: WeatherDataVO!) {
    it("has correct origin date") {
      var theDateComponents = self._defaultDateComponents
      theDateComponents.hour = 19
      expect(aWeatherData.originDate).to(equal(theDateComponents.date!))
    }
  }

  private func _testWindInfo(data aWeatherData: WeatherDataVO!) {
    it("has correct wind info") {
      expect(aWeatherData.wind).notTo(beNil(), description: "wind info available")
      guard aWeatherData.wind != nil else {
        return
      }
      expect(aWeatherData.wind!.speed).to(beCloseTo(4.6), description: "speed")
      expect(aWeatherData.wind!.direction).to(equal(130), description: "direction")
    }
  }

  private func _testHumidity(data aWeatherData: WeatherDataVO!) {
    it("has correct humidity") {
      expect(aWeatherData.humidity).to(beCloseTo(77))
    }
  }

  private func _testPresure(data aWeatherData: WeatherDataVO!) {
    it("has correct pressure") {
      expect(aWeatherData.pressure).to(beCloseTo(1015))
    }
  }

  private func _testTemperature(data aWeatherData: WeatherDataVO!) {
    it("has correct temperature") {
      expect(aWeatherData.temperature).to(beCloseTo(21.5))
    }
  }

  private func _testWeatherDescription(data aWeatherData: WeatherDataVO!) {
    it("has correct weather description") {
      expect(aWeatherData.weatherTextDescription.count).to(equal(1), description: "number of description elements")
      expect(aWeatherData.weatherTextDescription.first).to(equal("slabý déšť"),
                                                           description: "first element description")
    }
  }

  private func _testCoordinates(data aWeatherData: WeatherDataVO!) {
    it("has correct coordinate") {
      expect(aWeatherData.coordinate.latitude).to(beCloseTo(50.1), description: "latitude")
      expect(aWeatherData.coordinate.longitude).to(beCloseTo(14.43), description: "longitude")
    }
  }

  private func _testHasBeenParsed(data aWeatherData: WeatherDataVO!) {
    it("has been parsed") {
      expect(aWeatherData).notTo(beNil())
    }
  }

  private var _defaultDateComponents: DateComponents {
    var theResult = DateComponents()
    theResult.calendar = _defaultCalendar
    theResult.timeZone = _defaultTimeZone
    theResult.year = 2018
    theResult.month = 5
    theResult.day = 30
    return theResult
  }

  private var _defaultCalendar: Calendar = Calendar(identifier: .gregorian)
  private var _defaultTimeZone: TimeZone = TimeZone(abbreviation: "CEST")!

  private var _json = """
  {\"coord\":{
      \"lon\":14.43,
      \"lat\":50.1},
    \"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"slabý déšť", \"icon\":\"10d\"}],
    \"base\":\"stations\",
    \"main\":{
      \"temp\":21.5,
      \"pressure\":1015,
      \"humidity\":77,
      \"temp_min\":21,
      \"temp_max\":22},
    \"visibility\":10000,
    \"wind\":{
      \"speed\":4.6,
      \"deg\":130},
    \"clouds\":{\"all\":75},
    \"dt\":1527699600,
    \"sys\":{
      \"type\":1,
      \"id\":5889,
      \"message\":0.1854,
      \"country\":\"CZ\",
      \"sunrise\":1527649128,
      \"sunset\":1527706900},
    \"id\":3073838,
    \"name\":\"Karlin\",
    \"cod\":200}
  """.data(using: .utf8)!
}
