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
    theNewDetailView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideDetailAction)))
    let theSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideDetailAction))
    theSwipeGesture.direction = .down
    theNewDetailView.addGestureRecognizer(theSwipeGesture)
    detailView = theNewDetailView
    loadLocationInfoView()
    loadTemperatureView()
    loadWeatherInfo()
    loadPressureInfoContainer()
    loadHumidityInfoContainer()
    loadWindSpeedInfoContainer()
    loadWindDirectionInfoContainer()
  }

  func loadLocationInfoView() {
    locationInfoContainer?.removeFromSuperview()
    let theNewLocationInfoContainer = UIView(frame: .zero)
    detailView.addSubview(theNewLocationInfoContainer)
    theNewLocationInfoContainer.snp.makeConstraints {
      $0.leading.equalTo(detailView.snp.leadingMargin)
      $0.trailing.equalTo(detailView.snp.trailingMargin)
      $0.top.equalToSuperview()
    }
    locationInfoContainer = theNewLocationInfoContainer
    let theNewLocationLabel = UILabel()
    theNewLocationLabel.numberOfLines = 0
    theNewLocationLabel.lineBreakMode = .byWordWrapping
    theNewLocationLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    theNewLocationLabel.textAlignment = .center
    theNewLocationInfoContainer.addSubview(theNewLocationLabel)
    theNewLocationLabel.snp.makeConstraints {
      $0.left.equalToSuperview().inset(15)
      $0.top.equalToSuperview().inset(15)
      $0.bottom.equalToSuperview()
      $0.right.equalToSuperview().inset(15)
    }
    locationInfoLabel = theNewLocationLabel
  }

  func loadTemperatureView() {
    temperatureContainerView?.removeFromSuperview()
    let theNewTemperatureView = UIView(frame: .zero)
    detailView.addSubview(theNewTemperatureView)
    theNewTemperatureView.snp.makeConstraints {
      $0.top.equalTo(locationInfoContainer.snp.bottom)
      $0.left.equalToSuperview()
      $0.width.equalToSuperview().dividedBy(2)
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
    temperatureContainerView = theNewTemperatureView
  }

  func loadWeatherInfo() {
    weatherInfoContainerView?.removeFromSuperview()
    let theNewWeatherInfoView = UIView(frame: .zero)
    detailView.addSubview(theNewWeatherInfoView)
    theNewWeatherInfoView.snp.makeConstraints {
      $0.left.equalTo(temperatureContainerView.snp.right)
      $0.top.equalTo(temperatureContainerView.snp.top)
      $0.bottom.equalTo(temperatureContainerView.snp.bottom)
      $0.right.equalToSuperview()
    }
    weatherInfoContainerView = theNewWeatherInfoView
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

  func loadPressureInfoContainer() {
    _loadDetailInfo(container: &pressureInfoContainer,
                    topAnchor: temperatureContainerView.snp.bottom,
                    description: NSLocalizedString("MainScreen.Pressure", comment: ""),
                    valueLabel: &pressureValueLabel)
  }

  func loadHumidityInfoContainer() {
    _loadDetailInfo(container: &humidityInfoContainer,
                    topAnchor: pressureInfoContainer.snp.bottom,
                    description: NSLocalizedString("MainScreen.Humidity", comment: ""),
                    valueLabel: &humidityValueLabel)
  }

  func loadWindSpeedInfoContainer() {
    _loadDetailInfo(container: &windSpeedContainer,
                    topAnchor: humidityInfoContainer.snp.bottom,
                    description: NSLocalizedString("MainScreen.WindSpeed", comment: ""),
                    valueLabel: &windSpeedLabel)
  }

  func loadWindDirectionInfoContainer() {
    _loadDetailInfo(container: &windDirectionContainer,
                    topAnchor: windSpeedContainer.snp.bottom,
                    description: NSLocalizedString("MainScreen.WindDirection", comment: ""),
                    valueLabel: &windDirectionLabel,
                    isLast: true)
  }

  private func _loadDetailInfo(container aContainer: inout UIView!,
                               topAnchor aTopAnchor: ConstraintRelatableTarget,
                               description aDescription: String,
                               valueLabel aValueLabel: inout UILabel!,
                               isLast aShouldAnchorToBottom: Bool = false) {
    aContainer?.removeFromSuperview()
    let theNewPressureInfoContainer = UIView(frame: .zero)
    detailView.addSubview(theNewPressureInfoContainer)
    theNewPressureInfoContainer.snp.makeConstraints {
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.top.equalTo(aTopAnchor)
      if aShouldAnchorToBottom {
        $0.bottom.equalToSuperview()
      }
    }
    aContainer = theNewPressureInfoContainer
    let theNewDescriptionLabel = UILabel()
    theNewDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    theNewDescriptionLabel.text = aDescription
    theNewDescriptionLabel.numberOfLines = 0
    theNewDescriptionLabel.lineBreakMode = .byWordWrapping
    theNewPressureInfoContainer.addSubview(theNewDescriptionLabel)
    theNewDescriptionLabel.snp.makeConstraints {
      $0.left.equalToSuperview().inset(15)
    }
    let theNewValueLabel = UILabel()
    theNewPressureInfoContainer.addSubview(theNewValueLabel)
    theNewValueLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    theNewValueLabel.textAlignment = .right
    theNewValueLabel.snp.makeConstraints {
      $0.right.equalToSuperview().inset(15)
      $0.firstBaseline.equalTo(theNewDescriptionLabel.snp.firstBaseline)
      $0.left.greaterThanOrEqualTo(theNewDescriptionLabel.snp.right)
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview().inset(5)
    }
    theNewValueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    aValueLabel = theNewValueLabel
  }

  @objc
  func hideDetailAction() {
    hideDetail()
  }

}
