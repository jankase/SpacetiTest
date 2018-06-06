//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Nimble
import Quick
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
      it("has been parsed") {
        expect(theWeatherData).notTo(beNil())
      }
      guard theWeatherData != nil else {
        return
      }
      it("has correct name") {
        expect(theWeatherData.name) == "Belgrade"
      }
      it("has correct id") {
        expect(theWeatherData.id) == 792_680
      }
      it("has correct weather description") {
        expect(theWeatherData.weatherTextDescription.count).to(equal(1), description: "number of description elements")
        expect(theWeatherData.weatherTextDescription.first).to(equal("jasno"), description: "first element description")
      }
      it("has correct temperature") {
        expect(theWeatherData.temperature).to(beCloseTo(24))
      }
      it("has correct pressure") {
        expect(theWeatherData.pressure).to(beCloseTo(1013))
      }
      it("has correct humidity") {
        expect(theWeatherData.humidity).to(beCloseTo(60))
      }
      it("has correct wind info") {
        expect(theWeatherData.windSpeed).to(beCloseTo(2.6), description: "speed")
        expect(theWeatherData.windDirection).to(equal(250), description: "direction")
      }
      it("has correct origin date") {
        var theDateComponents = self._defaultDateComponents
        theDateComponents.hour = 10
        theDateComponents.minute = 4
        theDateComponents.second = 52
        expect(theWeatherData.originDate) == theDateComponents.date!
      }
    }
  }

  private var _defaultDateComponents: DateComponents {
    var theResult = DateComponents()
    theResult.calendar = _defaultCalendar
    theResult.timeZone = _defaultTimeZone
    theResult.year = 2018
    theResult.month = 6
    theResult.day = 6
    return theResult
  }

  private var _defaultCalendar: Calendar = Calendar(identifier: .gregorian)
  private var _defaultTimeZone: TimeZone = TimeZone(abbreviation: "CEST")!

  private var _json = """
  {
    \"id\": 792680,
    \"dt\": 1528272292,
    \"name\": \"Belgrade\",
    \"coord\": {
      \"Lat\": 44.80401,
      \"Lon\": 20.46513
    },
    \"main\": {
      \"temp\": 24,
      \"temp_min\": 24,
      \"temp_max\": 24,
      \"pressure\": 1013,
      \"humidity\": 60
    },
    \"wind\": {
      \"speed\": 2.6,
      \"deg\": 250
    },
    \"rain\": null,
    \"snow\": null,
    \"clouds\": {
      \"today\": 0
    },
    \"weather\": [
      {
        \"id\": 800,
        \"main\": \"Clear\",
        \"description\": \"jasno\",
        \"icon\": \"01d\"
      }
    ]
  }
  """.data(using: .utf8)!
}
