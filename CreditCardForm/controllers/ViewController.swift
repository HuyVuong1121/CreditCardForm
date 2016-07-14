//
//  ViewController.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.sharedInstance.darkThemeColor()
        titleLabel.textColor = Theme.sharedInstance.contrastThemeColor()
    }

}

