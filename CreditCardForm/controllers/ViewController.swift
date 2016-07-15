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
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.sharedInstance.setNavigationBarAppearance(navigationController)
        self.view.backgroundColor = Theme.sharedInstance.lightThemeColor()
        let image = UIImage(named: "Venmo_Logo.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        setupControls()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        resetFormPosition()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resetFormPosition()
    }
    
    func resetFormPosition() {
        cardNumberTextField.resignFirstResponder()
        expirationDateTextField.resignFirstResponder()
        cvvTextField.resignFirstResponder()
        titleLabelTopConstraint.constant = 59.0
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                let keyBoardFrame = CGRect(origin: CGPoint(x: keyboardSize.origin.x,y: (keyboardSize.origin.y -  keyboardSize.size.height)), size: keyboardSize.size)
                let containerViewFrame = containerView.frame
                if keyBoardFrame.intersects(containerViewFrame) {
                    titleLabelTopConstraint.constant = 0
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        titleLabelTopConstraint.constant = 59.0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func submitButtonPressed(sender: AnyObject) {
        
    }
}

