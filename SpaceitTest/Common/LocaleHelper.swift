//
// Created by Jan Kase on 04/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

// future support for different locale then system
struct LocaleHelper {

  static var locale: Locale = .autoupdatingCurrent

  static var language: String {
    return locale.languageCode ?? "en"
  }

  static var apiLanguage: String {
    // only Czech and English supported
    // OpenWeatherApi uses wrong language code
    return language == "cs" ? "cz" : "en"
  }

  static var usesMetric: Bool {
    return locale.usesMetricSystem
  }

  static var temperatureUnitsSymbol: String {
    return usesMetric ? "\u{2103}" : "\u{2109}"
  }

  static var speedUnits: String {
    return usesMetric ? "km/h" : "mph"
  }

}
