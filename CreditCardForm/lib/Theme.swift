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
        return UIColor.init(red: 49.0/255.0, green: 127.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    }
    
    func lightThemeColor() -> UIColor {
        return UIColor.init(red: 226.0/255.0, green: 230.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    }
    
    func textThemeColor() -> UIColor {
        return UIColor.init(red: 84.0/255.0, green: 95.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    func contrastThemeColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    func setNavigationBarAppearance(navigationController: UINavigationController?) {
        if let controller = navigationController {
            controller.navigationBar.barTintColor = darkThemeColor()
            controller.navigationBar.tintColor = UIColor.whiteColor()
        }
    }
}

