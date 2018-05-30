//
// Created by Jan Kase on 30/05/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CoreLocation
import Alamofire
@testable import SpaceitTest

class MainScreenApiTestSpec: QuickSpec {

  override func spec() {
    describe("an API test") {
      self._testDefaultUrl()
      self._testNotSecureProtocol()
    }
  }

  private func _testDefaultUrl() {
    it("success call") {
      var thePresenter: MainScreenPresenterNotifyType!
      let theInteractor = MainScreenInteractor()
      waitUntil(timeout: 5) { aDone in

        class Test: MainScreenPresenterNotifyType {
          var finishHandler: (() -> Void)?

          func failedLoadingWeatherData(error anError: Error) {
            fail("Error appeared: \(anError)")
            finishHandler?()
          }

          func newWeatherDataAvailable() {
            expect(true).to(beTrue())
            finishHandler?()
          }
        }

        thePresenter = Test()
        (thePresenter as? Test)?.finishHandler = aDone
        theInteractor.presenter = thePresenter
        theInteractor.updateWeatherData(location: CLLocationCoordinate2D(latitude: 50.0989353, longitude: 14.4341467))
      }
    }
  }

  private func _testNotSecureProtocol() {
    it("unsecure HTTP call") {
      var thePresenter: MainScreenPresenterNotifyType!
      let theInteractor = MainScreenInteractor()
      theInteractor.apiRoot = "http://api.openweathermap.org/data/2.5/weather"
      waitUntil(timeout: 5) { aDone in

        class Test: MainScreenPresenterNotifyType {
          var finishHandler: (() -> Void)?

          func failedLoadingWeatherData(error anError: Error) {
            expect(true).to(beTrue())
            finishHandler?()
          }

          func newWeatherDataAvailable() {
            fail("Should fail")
            finishHandler?()
          }
        }

        thePresenter = Test()
        (thePresenter as? Test)?.finishHandler = aDone
        theInteractor.presenter = thePresenter
        theInteractor.updateWeatherData(location: CLLocationCoordinate2D(latitude: 50.0989353, longitude: 14.4341467))
      }
    }
  }

}
