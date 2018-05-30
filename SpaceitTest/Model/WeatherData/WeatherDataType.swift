//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherDataType {
  var coordinate: CLLocationCoordinate2D { get set }
  var originDate: Date { get set }
  var humidity: Float { get set }
  var pressure: Float { get set }
  var temperature: Float { get set }
  var sunrise: Date { get set }
  var sunset: Date { get set }
  var weatherTextDescription: [String] { get set }
  var wind: WindInfoType? { get set }

}
