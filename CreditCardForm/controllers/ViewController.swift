//
//  ViewController.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, CreditCardValidator, CreditCardEvaluator {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardNumberCheckMark: UIImageView!
    @IBOutlet weak var expirationDateCheckMark: UIImageView!
    @IBOutlet weak var cvvCheckMark: UIImageView!
    @IBOutlet weak var cardNumberCheckMarkView: UIView!
    @IBOutlet weak var expirationDateCheckMarkView: UIView!
    @IBOutlet weak var cvvCheckMarkView: UIView!

    let titleLabelDefault: CGFloat = 59.0
    let cornerRadius: CGFloat = 4.0
    let borderWidth: CGFloat = 1.0
    var creditCard: CreditCardProtocol = UnknownCreditCard(cardNumber: "", expirationDate: "", cvv: "")
    var keyBoardIsOpen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeAppearance().setNavigationBarAppearance(navigationController)
        self.view.backgroundColor = Theme.Light.color
        setupDelegates()
        setupControls()
        setupControlLayers()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.textDidChange(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
        resetFormPosition()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func setupDelegates() {
        cardNumberTextField.delegate = self
        expirationDateTextField.delegate = self
        cvvTextField.delegate = self
    }

    func setupControls() {
        titleLabel.textColor = Theme.Text.color
        cardNumberLabel.textColor = Theme.Text.color
        expirationDateLabel.textColor = Theme.Text.color
        cvvLabel.textColor = Theme.Text.color
        submitButton.backgroundColor = Theme.Dark.color
        submitButton.setTitleColor(Theme.Contrast.color, forState: UIControlState.Normal)
        cardNumberCheckMark.hidden = true
        expirationDateCheckMark.hidden = true
        cvvCheckMark.hidden = true
    }

    func setupControlLayers() {
        submitButton.layer.cornerRadius = cornerRadius
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.borderWidth = borderWidth
        containerView.layer.borderColor = Theme.Dark.color.CGColor
        cardNumberTextField.layer.cornerRadius = cornerRadius
        cardNumberTextField.layer.borderWidth = borderWidth
        cardNumberTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        expirationDateTextField.layer.cornerRadius = cornerRadius
        expirationDateTextField.layer.borderWidth = borderWidth
        cvvTextField.layer.cornerRadius = cornerRadius
        cvvTextField.layer.borderWidth = borderWidth
        cvvTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        cardNumberCheckMarkView.layer.cornerRadius = cardNumberCheckMarkView.frame.width/2.0
        cardNumberCheckMarkView.layer.borderWidth = borderWidth
        cardNumberCheckMarkView.layer.borderColor = Theme.Dark.color.CGColor
        expirationDateCheckMarkView.layer.cornerRadius = expirationDateCheckMarkView.frame.width/2.0
        expirationDateCheckMarkView.layer.borderWidth = borderWidth
        expirationDateCheckMarkView.layer.borderColor = Theme.Dark.color.CGColor
        cvvCheckMarkView.layer.cornerRadius = cvvCheckMarkView.frame.width/2.0
        cvvCheckMarkView.layer.borderWidth = borderWidth
        cvvCheckMarkView.layer.borderColor = Theme.Dark.color.CGColor
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resignFirstResponders()
    }

    func resetFormPosition() {
        resignFirstResponders()
        titleLabelTopConstraint.constant = titleLabelDefault
    }

    func resignFirstResponders() {
        if cardNumberTextField.isFirstResponder() {
            cardNumberTextField.resignFirstResponder()
        }
        if expirationDateTextField.isFirstResponder() {
            expirationDateTextField.resignFirstResponder()
        }
        if cvvTextField.isFirstResponder() {
            cvvTextField.resignFirstResponder()
        }
    }

    func keyboardWillShow(notification: NSNotification) {
        if keyBoardIsOpen {
            return
        }
        keyBoardIsOpen = true
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                let keyBoardFrame = CGRect(origin: CGPoint(x: keyboardSize.origin.x, y: (keyboardSize.origin.y -  keyboardSize.size.height)), size: keyboardSize.size)
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
        keyBoardIsOpen = false
        titleLabelTopConstraint.constant = titleLabelDefault
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let characterCount = text.characters.count + string.characters.count
            switch(textField.tag) {
            case 0:
                return nextCreditCardDigitIsValid(creditCard, characterCount: characterCount, string: string)
            case 1:
                if text.characters.count <= 2 {
                    expirationDateTextField.text = padExpirationDateMonth(text)
                }
                return nextExpirationDateDigitIsValid(text, characterCount: characterCount, string: string)
            case 2:
                return nextCVVDigitIsValid(creditCard, characterCount: characterCount, string: string)
            default:
                return true
            }
        }
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 2 {
            cardImageView.image = UIImage(named: "Cards_CVV.png")
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 2 {
            cardImageView.image = UIImage(named: creditCard.logo)
        }
        textField.layoutIfNeeded()
    }

    func textDidChange(notification: NSNotification) {
        let textField = notification.object as! UITextField
        if let text = textField.text {
            switch(textField.tag) {
            case 0:
                creditCard = evaluateCardNumber(text, creditCard: creditCard, cardImageView: cardImageView, cardNumberCheckMark: cardNumberCheckMark, cardNumberCheckMarkView: cardNumberCheckMarkView)
                creditCard = evaluateCVV(creditCard.cvv, creditCard: creditCard, cvvTextField: cvvTextField, cvvCheckMark: cvvCheckMark, cvvCheckMarkView: cvvCheckMarkView)
            case 1:
                creditCard = evaluateExpiredDate(text, creditCard: creditCard, expirationDateTextField: expirationDateTextField, expirationDateCheckMark: expirationDateCheckMark, expirationDateCheckMarkView: expirationDateCheckMarkView)
            case 2:
                creditCard = evaluateCVV(text, creditCard: creditCard, cvvTextField: cvvTextField, cvvCheckMark: cvvCheckMark, cvvCheckMarkView: cvvCheckMarkView)
            default:
                break
            }
        }
    }

    @IBAction func submitButtonPressed(sender: AnyObject) {
        let title = "New Credit Card"
        let message = alertMessageForCreditCard(creditCard)
        showAlertWithMessage(title, message: message)
    }

    func alertMessageForCreditCard(creditCard: CreditCardProtocol) -> String {
        var message = "Your credit card is valid!"
        let cardTypeIsValid = creditCard.type != .Unknown
        let cardNumberIsValid = creditCardNumberIsValid(creditCard)
        let cardExpirationIsValid = creditCardExpirationDateIsValid(creditCard)
        let cardCVVIsValid = creditCardCVVNumberLengthIsValid(creditCard)

        if creditCardIsValid(creditCard) {
            resignFirstResponders()
        } else {
            if creditCard.cardNumber.isEmpty {
                message = "Please enter a card number"
            } else if !cardTypeIsValid || !cardNumberIsValid {
                message = "Please correct the card number"
            } else if creditCard.expirationDate.isEmpty {
                message = "Please enter an expiration date"
            } else if !cardExpirationIsValid {
                message = "Please correct the expiration date"
            } else if creditCard.cvv.isEmpty {
                message = "Please enter a CVV code"
            } else if !cardCVVIsValid {
                message = "Please correct the CVV number"
            }
        }
        return message
    }

    func showAlertWithMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in}
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true) {}
    }
}
