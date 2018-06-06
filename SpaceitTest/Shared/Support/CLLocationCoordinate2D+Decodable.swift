//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Codable {

  public init(from aDecoder: Decoder) throws {
    let theContainer = try aDecoder.container(keyedBy: CLLocationCoordinate2DKeys.self)
    let theLatitude = try theContainer.decode(CLLocationDegrees.self, forKey: .latitude)
    let theLongitude = try theContainer.decode(CLLocationDegrees.self, forKey: .longitude)
    self.init(latitude: theLatitude, longitude: theLongitude)
  }

  public func encode(to anEncoder: Encoder) throws {
    var theContainer = anEncoder.container(keyedBy: CLLocationCoordinate2DKeys.self)
    try theContainer.encode(latitude, forKey: .latitude)
    try theContainer.encode(longitude, forKey: .longitude)
  }

  enum CLLocationCoordinate2DKeys: String, CodingKey {
    case latitude = "Lat"
    case longitude = "Lon"
  }

}
