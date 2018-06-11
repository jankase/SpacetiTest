//
// Created by Jan Kase on 11/06/2018.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar

struct SnackbarHelper {

  static func showError(message aMessage: String) {
    let theMessage = MDCSnackbarMessage()
    theMessage.text = aMessage
    MDCSnackbarManager.show(theMessage)
  }

}
