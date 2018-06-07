//
// Created by Jan Kase on 04/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Mapbox
import SnapKit
import UIKit

extension MainScreenVC {

  func loadMap() {
    map?.removeFromSuperview()
    let theNewMap = MGLMapView(frame: .zero)
    view.addSubview(theNewMap)
    theNewMap.snp.makeConstraints {
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      if #available(iOS 11, *) {
        $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      } else {
        $0.top.equalToSuperview()
        $0.bottom.equalToSuperview()
      }
    }
    theNewMap.styleURL = MGLStyle.lightStyleURL
    theNewMap.showsUserLocation = true
    theNewMap.showsScale = true
    theNewMap.isZoomEnabled = true
    theNewMap.isScrollEnabled = true
    theNewMap.delegate = mapDelegate
    theNewMap.isPitchEnabled = true
    map = theNewMap
  }

}
