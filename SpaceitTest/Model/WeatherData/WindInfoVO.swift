//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

struct WindInfoVO: WindInfoType, Decodable {

  var speed: Float = 0
  var direction: Int?

  init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: WindInfoKeys.self)
    speed = try theContainer.decode(Float.self, forKey: .speed)
    direction = try theContainer.decodeIfPresent(Int.self, forKey: .direction)
  }

  enum WindInfoKeys: String, CodingKey {
    case speed
    case direction = "deg"
  }

}
