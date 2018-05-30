//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Decodable {

  public init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: CLLocationCoordinate2DKeys.self)
    let theLatitude = try theContainer.decode(CLLocationDegrees.self, forKey: .latitude)
    let theLongitude = try theContainer.decode(CLLocationDegrees.self, forKey: .longitude)
    self.init(latitude: theLatitude, longitude: theLongitude)
  }

  enum CLLocationCoordinate2DKeys: String, CodingKey {
    case latitude = "lat"
    case longitude = "lon"
  }

}
