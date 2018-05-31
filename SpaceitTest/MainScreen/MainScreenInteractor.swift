//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class MainScreenInteractor: MainScreenInteractorType {

  var networkProcessingQueue: DispatchQueue = DispatchQueue(label: "NetworkProcessingQueue")
  var apiKey: String = "4828509bfa2e5f57c2ee890035842666"
  var apiUnits: String = "metric"
  var apiLanguage: String = "cz"
  var apiRoot: URLConvertible = "https://api.openweathermap.org/data/2.5/weather"
  weak var presenter: MainScreenPresenterNotifyType!

  func updateWeatherData(location aLocation: CLLocationCoordinate2D) {
    var theParams = _toParams(location: aLocation)
    theParams["appid"] = apiKey
    theParams["units"] = apiUnits
    theParams["lang"] = apiLanguage
    let theRequest = Alamofire.request(apiRoot, parameters: theParams)
    debugPrint(theRequest)
    theRequest
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .response(queue: networkProcessingQueue) { [weak self] aResponse in
          debugPrint(aResponse)
          guard let theSelf = self else {
            return
          }
          guard let theData = aResponse.data else {
            theSelf.presenter.failedLoadingWeatherData(error: NetworkError.failedToReceiveWeatherData)
            return
          }
          do {
            let theWeatherData = try JSONDecoder().decode(WeatherDataVO.self, from: theData)
            theSelf.presenter.newWeatherDataAvailable(weatherData: theWeatherData)
          } catch {
            theSelf.presenter.failedLoadingWeatherData(error: NetworkError.failedToParseJsonWeatherData)
          }
        }
  }

  private func _toParams(location aLocation: CLLocationCoordinate2D) -> Parameters {
    return ["lat": aLocation.latitude, "lon": aLocation.longitude]
  }

}
