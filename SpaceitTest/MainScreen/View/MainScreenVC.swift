//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Mapbox
import UIKit

class MainScreenVC: UIViewController {

  weak var detailView: UIView!
  weak var temperatureView: UIView!
  weak var temperatureLabel: UILabel!
  weak var apparentTemperatureLabel: UILabel!
  weak var weatherInfoView: UIView!
  weak var weatherIcon: UIImageView!
  weak var weatherDescription: UILabel!
  weak var map: MGLMapView!

  weak var detailViewTopConstraint: NSLayoutConstraint?

  // swiftlint:disable weak_delegate
  lazy var mapDelegate: MainScreenMapDelegate = {
    let theResult = MainScreenMapDelegate()
    theResult.presenter = presenter
    return theResult
  }()
  // swiftlint:enable weak_delegate

  lazy var presenter: MainScreenPresenterType = {
    let theResult = MainScreenPresenter()
    theResult.view = self
    return theResult
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }

  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    loadMap()
    loadDetailView()
  }

}
