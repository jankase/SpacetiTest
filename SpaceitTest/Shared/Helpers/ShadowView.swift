//
// Created by Jan Kase on 09/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import MaterialComponents
import UIKit

class ShadowView: UIView {

  override class var layerClass: AnyClass {
    return MDCShadowLayer.self
  }

  var shadowLayer: MDCShadowLayer {
    return self.layer as! MDCShadowLayer
  }

  func setDefaultElevation() {
    shadowLayer.elevation = .cardResting
  }

}
