//
//  Theme.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    static let sharedInstance = Theme()
    
    func darkThemeColor() -> UIColor {
        return UIColor.init(red: 0.06, green: 0.29, blue: 0.46, alpha: 1.0)
    }
    
    func lightThemeColor() -> UIColor {
        return UIColor.init(red: 0.09, green: 0.45, blue: 0.71, alpha: 1.0)
    }
    
    func contrastThemeColor() -> UIColor {
        return UIColor.whiteColor()
    }
}

