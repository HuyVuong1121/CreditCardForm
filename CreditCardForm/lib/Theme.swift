//
//  Theme.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

enum Theme {
    case Dark, Light, Text, Contrast
}

extension Theme {
    var color: UIColor {
        switch self {
        case .Dark:
            return UIColor.init(red: 49.0/255.0, green: 127.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor.init(red: 226.0/255.0, green: 230.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        case .Text:
            return UIColor.init(red: 84.0/255.0, green: 95.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        case .Contrast:
            return UIColor.whiteColor()
        }
    }
}

struct ThemeAppearance {
    func setNavigationBarAppearance(navigationController: UINavigationController?) {
        let navigationController = navigationController!
        navigationController.navigationBar.barTintColor = Theme.Dark.color
        navigationController.navigationBar.tintColor = Theme.Contrast.color
    }
}