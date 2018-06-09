//
// Created by Jan Kase on 04/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import SnapKit
import UIKit

extension MainScreenVC {

  func loadDetailView() {
    detailView?.removeFromSuperview()
    let theNewDetailView = ShadowView(frame: .zero)
    theNewDetailView.setDefaultElevation()
    view.addSubview(theNewDetailView)
    theNewDetailView.snp.makeConstraints {
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      self.detailViewTopConstraint = $0.top.equalTo(view.snp.bottom).constraint.layoutConstraints.first
      $0.top.greaterThanOrEqualTo(map.snp.bottom)
    }
    theNewDetailView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    detailView = theNewDetailView
    loadTemperatureView()
    loadWeatherInfo()
  }

  @objc
  func tap() {
    hideDetail()
  }

  func loadTemperatureView() {
    temperatureView?.removeFromSuperview()
    let theNewTemperatureView = UIView(frame: .zero)
    detailView.addSubview(theNewTemperatureView)
    theNewTemperatureView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.left.equalToSuperview()
      $0.width.equalToSuperview().dividedBy(2)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(theNewTemperatureView.snp.width)
    }
    let theNewTemperatureLabel = UILabel()
    theNewTemperatureView.addSubview(theNewTemperatureLabel)
    theNewTemperatureLabel.snp.makeConstraints {
      $0.width.equalToSuperview().multipliedBy(0.6)
      $0.center.equalToSuperview()
    }
    theNewTemperatureLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    theNewTemperatureLabel.textAlignment = .center
    let theNewApparentTemperatureLabel = UILabel()
    theNewTemperatureView.addSubview(theNewApparentTemperatureLabel)
    theNewApparentTemperatureLabel.snp.makeConstraints {
      $0.top.equalTo(theNewTemperatureLabel.snp.bottom)
      $0.centerX.equalTo(theNewTemperatureLabel.snp.centerX)
    }
    theNewApparentTemperatureLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    theNewTemperatureLabel.textAlignment = .center
    apparentTemperatureLabel = theNewApparentTemperatureLabel
    temperatureLabel = theNewTemperatureLabel
    temperatureView = theNewTemperatureView
  }

  func loadWeatherInfo() {
    weatherInfoView?.removeFromSuperview()
    let theNewWeatherInfoView = UIView(frame: .zero)
    detailView.addSubview(theNewWeatherInfoView)
    theNewWeatherInfoView.snp.makeConstraints {
      $0.left.equalTo(temperatureView.snp.right)
      $0.top.equalTo(temperatureView.snp.top)
      $0.bottom.equalTo(temperatureView.snp.bottom)
      $0.right.equalToSuperview()
    }
    weatherInfoView = theNewWeatherInfoView
    let theNewIconContainer = UIView()
    theNewWeatherInfoView.addSubview(theNewIconContainer)
    theNewIconContainer.snp.makeConstraints {
      $0.width.equalToSuperview()
      $0.top.equalToSuperview()
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.8)
    }
    let theNewWeatherIcon = UIImageView()
    theNewIconContainer.addSubview(theNewWeatherIcon)
    theNewWeatherIcon.snp.makeConstraints {
      $0.width.equalToSuperview().multipliedBy(0.6)
      $0.height.equalTo(theNewWeatherIcon.snp.width)
      $0.center.equalToSuperview()
    }
    weatherIcon = theNewWeatherIcon
    let theNewWeatherDescription = UILabel()
    theNewWeatherInfoView.addSubview(theNewWeatherDescription)
    theNewWeatherDescription.snp.makeConstraints {
      $0.centerX.equalTo(theNewWeatherIcon.snp.centerX)
      $0.top.equalTo(theNewWeatherIcon.snp.bottom)
    }
    theNewWeatherDescription.textAlignment = .center
    theNewWeatherDescription.font = UIFont.preferredFont(forTextStyle: .caption1)
    weatherDescription = theNewWeatherDescription
  }

}
