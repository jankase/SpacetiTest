//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class MainScreenInteractor: MainScreenInteractorType {

  var networkProcessingQueue: DispatchQueue = DispatchQueue(label: "NetworkProcessingQueue")
  var storeQueue: DispatchQueue = DispatchQueue(label: "StoreQueue", qos: .background)
  var apiKey: String = "4828509bfa2e5f57c2ee890035842666"
  var apiUnits: String = "metric"
  var apiLanguage: String = "cz"
  var apiRoot: URLConvertible = "https://api.openweathermap.org/data/2.5/weather"
  var fileManager: FileManager = FileManager.default
  var storeFileName: String = "weatherData.json"
  weak var presenter: MainScreenPresenterNotifyType!

  lazy var currentLocationHelper: CurrentLocationType = {
    let theResult = CurrentLocation()
    theResult.interactor = self
    return theResult
  }()

  func startUpdatingWeatherData() {
    currentLocationHelper.activateLocationServices()
  }

  func stopUpdatingWeatherData() {
    currentLocationHelper.stopUpdatingLocation()
  }

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
        .responseJSON { debugPrint($0) }
        .response(queue: networkProcessingQueue) { [weak self] aResponse in
          guard let theSelf = self else {
            return
          }
          guard let theData = aResponse.data else {
            theSelf.presenter.handle(error: NetworkError.failedToReceiveWeatherData)
            return
          }
          do {
            let theWeatherData = try JSONDecoder().decode(WeatherDataVO.self, from: theData)
            theSelf.storeQueue.async {
              theSelf._store(weatherData: theWeatherData)
            }
            theSelf.presenter.newWeatherDataAvailable(weatherData: theWeatherData)
          } catch {
            theSelf.presenter.handle(error: NetworkError.failedToParseJsonWeatherData)
          }
        }
  }

  private lazy var _storeUrl: URL = {
    guard let theDocumentDirUrl = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      fatalError()
    }
    return theDocumentDirUrl.appendingPathComponent(self.storeFileName)
  }()

  private func _toParams(location aLocation: CLLocationCoordinate2D) -> Parameters {
    return ["lat": aLocation.latitude, "lon": aLocation.longitude]
  }

  private func _store(weatherData aWeatherData: WeatherDataVO) {
    do {
      let theJsonData = try JSONEncoder().encode(aWeatherData)
      try theJsonData.write(to: _storeUrl, options: .atomic)
    } catch let theError {
      presenter.handle(error: theError)
    }
  }

}
