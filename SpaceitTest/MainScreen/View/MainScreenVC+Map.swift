//
// Created by Jan Kase on 04/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit
import SnapKit
import Mapbox

extension MainScreenVC {

  func loadMap() {
    map?.removeFromSuperview()
    let theNewMap = MGLMapView(frame: .zero)
    view.addSubview(theNewMap)
    theNewMap.snp.makeConstraints {
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.height.equalToSuperview().dividedBy(2)
      if #available(iOS 11, *) {
        $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      } else {
        $0.top.equalToSuperview()
      }
    }
    theNewMap.styleURL = MGLStyle.lightStyleURL
    theNewMap.showsUserLocation = true
    theNewMap.showsScale = true
    theNewMap.isZoomEnabled = true
    theNewMap.isScrollEnabled = true
    theNewMap.delegate = mapDelegate
    map = theNewMap
  }

}
