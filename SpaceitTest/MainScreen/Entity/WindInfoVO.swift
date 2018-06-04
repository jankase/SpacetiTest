//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

struct WindInfoVO: WindInfoType, Codable {

  var speed: Float = 0
  var direction: Float?

  init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: WindInfoKeys.self)
    speed = try theContainer.decode(Float.self, forKey: .speed)
    direction = try theContainer.decodeIfPresent(Float.self, forKey: .direction)
  }

  func encode(to anEncoder: Encoder) throws {
    var theContainer = anEncoder.container(keyedBy: WindInfoKeys.self)
    try theContainer.encode(speed, forKey: .speed)
    if let theDirection = direction {
      try theContainer.encode(theDirection, forKey: .direction)
    }
  }

  enum WindInfoKeys: String, CodingKey {
    case speed
    case direction = "deg"
  }

}
