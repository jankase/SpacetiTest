//
// Created by Jan Kase on 31/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

enum NetworkError: SpaceitError {
  case failedToReceiveWeatherData
  case failedToParseJsonWeatherData
}
