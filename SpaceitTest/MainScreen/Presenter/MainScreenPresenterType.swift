//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Mapbox

protocol MainScreenPresenterType {

  var view: MainScreenViewNotifyType! { get set }

  func updateWeatherData(region aRegion: MGLCoordinateBounds, zoom aZoom: Double)

}
