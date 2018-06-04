//
// Created by Jan Kase on 01/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {

  lazy var presenter: MainScreenPresenterType = {
    let theResult = MainScreenPresenter()
    theResult.view = self
    return theResult
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.startUpdatingWeatherData()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    presenter.stopUpdatingWeatherData()
  }

  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
  }

}
