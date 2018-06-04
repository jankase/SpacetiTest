//
// Created by Jan Kase on 05/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

class WeatherDataBundleVO: Decodable {

  var weatherData: [WeatherDataVO]

  enum WeatherDataBundleKeys: String, CodingKey {
    case list
  }

  required init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: WeatherDataBundleKeys.self)
    weatherData = try theContainer.decode([WeatherDataVO].self, forKey: .list)
  }

}
