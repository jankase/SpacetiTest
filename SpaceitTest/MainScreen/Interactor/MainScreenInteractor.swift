//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Alamofire
import CoreLocation
import Foundation
import Mapbox

class MainScreenInteractor: MainScreenInteractorType {

  var networkProcessingQueue: DispatchQueue = DispatchQueue(label: "NetworkProcessingQueue")
  var storeQueue: DispatchQueue = DispatchQueue(label: "StoreQueue", qos: .background)
  var apiKey: String = "4828509bfa2e5f57c2ee890035842666"
  var apiUnits: String = LocaleHelper.usesMetric ? "metric" : "imperial"
  var apiLanguage: String = LocaleHelper.apiLanguage
  var apiRoot: URLConvertible = "https://api.openweathermap.org/data/2.5/"

  var fileManager: FileManager = FileManager.default
  var storeFileName: String = "weatherData.json"
  weak var presenter: MainScreenPresenterNotifyType!

  lazy var currentLocationHelper: CurrentLocationType = {
    let theResult = CurrentLocation()
    theResult.interactor = self
    return theResult
  }()
  lazy var locationApi: String = {
    return "\(self.apiRoot)weather"
  }()
  lazy var regionApi: String = {
    return "\(self.apiRoot)box/city"
  }()

  func updateWeatherData(region aRegion: MGLCoordinateBounds, zoom aZoom: Double) {
    var theParams = _toParams(region: aRegion, zoom: aZoom)
    theParams["appid"] = apiKey
    theParams["units"] = apiUnits
    theParams["lang"] = apiLanguage
    let theRequest = Alamofire.request(regionApi, parameters: theParams)
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
            let theWeatherData = try JSONDecoder().decode(WeatherDataBundleVO.self, from: theData)
            theSelf.storeQueue.async {
              do {
                try theWeatherData.weatherData.store()
              } catch let theError {
                debugPrint("Failed to store weather data: \(theError)")
              }
            }
            for theWeatherDataItem in theWeatherData.weatherData {
              theSelf.presenter.newWeatherDataAvailable(weatherData: theWeatherDataItem)
            }
          } catch let theError {
            debugPrint(theError)
            theSelf.presenter.handle(error: NetworkError.failedToParseJsonWeatherData)
          }
        }
  }

  func updateWeatherData(location aLocation: CLLocationCoordinate2D) {
    var theParams = _toParams(location: aLocation)
    theParams["appid"] = apiKey
    theParams["units"] = apiUnits
    theParams["lang"] = apiLanguage
    let theRequest = Alamofire.request(locationApi, parameters: theParams)
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
              do {
                try theWeatherData.store()
              } catch let theError {
                debugPrint("Failed to store weather data: \(theError)")
              }
            }
            theSelf.presenter.newWeatherDataAvailable(weatherData: theWeatherData)
          } catch {
            theSelf.presenter.handle(error: NetworkError.failedToParseJsonWeatherData)
          }
        }
  }

  private lazy var _storeUrl: URL = {
    guard let theDocumentDirUrl = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      fatalError("Unable to find documents directory")
    }
    return theDocumentDirUrl.appendingPathComponent(self.storeFileName)
  }()

  private func _toParams(location aLocation: CLLocationCoordinate2D) -> Parameters {
    return ["lat": aLocation.latitude, "lon": aLocation.longitude]
  }

  private func _toParams(region aRegion: MGLCoordinateBounds, zoom aZoom: Double) -> Parameters {
    return ["bbox":
    "\(aRegion.sw.longitude),\(aRegion.sw.latitude),\(aRegion.ne.longitude),\(aRegion.ne.latitude),\(Int(aZoom))"]
  }

}
