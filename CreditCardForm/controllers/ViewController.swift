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
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var cvvImageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.sharedInstance.setNavigationBarAppearance(navigationController)
        self.view.backgroundColor = Theme.sharedInstance.lightThemeColor()
        let image = UIImage(named: "Venmo_Logo.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        setupControls()
    }
    
    func setupControls() {
        titleLabel.textColor = Theme.sharedInstance.textThemeColor()
        cardNumberLabel.textColor = Theme.sharedInstance.textThemeColor()
        expirationDateLabel.textColor = Theme.sharedInstance.textThemeColor()
        cvvLabel.textColor = Theme.sharedInstance.textThemeColor()
        submitButton.layer.cornerRadius = 4.0
        submitButton.backgroundColor = Theme.sharedInstance.darkThemeColor()
        submitButton.setTitleColor(Theme.sharedInstance.contrastThemeColor(), forState: UIControlState.Normal)
        containerView.layer.cornerRadius = 4.0
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = Theme.sharedInstance.darkThemeColor().CGColor
    }

    @IBAction func submitButtonPressed(sender: AnyObject) {
        
    }
}

