//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

protocol WindInfoType: CustomDebugStringConvertible {

  var speed: Float { get set }
  var direction: Float? { get set }

}

extension WindInfoType {

  public var debugDescription: String {
    return """
    \n\tSpeed: \(speed)
    \tDirection \(direction == nil ? "unknown" : String(direction!))
    """
  }

}
