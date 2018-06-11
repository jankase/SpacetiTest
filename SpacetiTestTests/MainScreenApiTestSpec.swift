//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Alamofire
import CoreLocation
import Foundation
import Nimble
import Quick
@testable import SpacetiTest

class MainScreenApiTestSpec: QuickSpec {

  override func spec() {
    describe("an API test") {
      it("success call") {
        var thePresenter: MainScreenPresenterNotifyType!
        let theInteractor = MainScreenInteractor()
        waitUntil(timeout: 5) { aDone in

          class Test: MainScreenPresenterNotifyType {
            var finishHandler: (() -> Void)?

            func handle(error anError: SpaceitError) {
              fail("Error appeared: \(anError)")
              finishHandler?()
            }

            func newWeatherDataAvailable(weatherData aWeatherData: [WeatherDataType]) {
              expect(true).to(beTrue())
              finishHandler?()
            }

            func newDetailWeatherDataAvailable(weatherData aWeatherData: WeatherDataType) {}

          }

          thePresenter = Test()
          (thePresenter as? Test)?.finishHandler = aDone
          theInteractor.presenter = thePresenter
          theInteractor.updateWeatherData(location: CLLocationCoordinate2D(latitude: 50.098_935_3,
                                                                           longitude: 14.434_146_7))
        }
      }
      it("unsecured HTTP call") {
        var thePresenter: MainScreenPresenterNotifyType!
        let theInteractor = MainScreenInteractor()
        theInteractor.apiRoot = "http://api.openweathermap.org/data/2.5/weather"
        waitUntil(timeout: 5) { aDone in

          class Test: MainScreenPresenterNotifyType {
            var finishHandler: (() -> Void)?

            func handle(error anError: SpaceitError) {
              expect(true).to(beTrue())
              finishHandler?()
            }

            func newWeatherDataAvailable(weatherData aWeatherData: [WeatherDataType]) {
              fail("Should fail")
              finishHandler?()
            }

            func newDetailWeatherDataAvailable(weatherData aWeatherData: WeatherDataType) {}
          }

          thePresenter = Test()
          (thePresenter as? Test)?.finishHandler = aDone
          theInteractor.presenter = thePresenter
          theInteractor.updateWeatherData(location: CLLocationCoordinate2D(latitude: 50.098_935_3,
                                                                           longitude: 14.434_146_7))
        }
      }
    }
  }

}
