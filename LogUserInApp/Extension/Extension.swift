//
//  Extension.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//

import UIKit

extension UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    open override var shouldAutorotate: Bool {
        return false
    }
}
