//
//  ViewController.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

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
    @IBOutlet weak var cardNumberCheckMark: UIImageView!
    @IBOutlet weak var expirationDateCheckMark: UIImageView!
    @IBOutlet weak var cvvCheckMark: UIImageView!
    
    let titleLabelDefault: CGFloat = 59.0
    var creditCard: CreditCard = CreditCard.init(cardNumber: "", expirationDate: "", cvv: "", type: .Unknown)
    
    enum TextFieldType: Int {
        case NumberTextField = 0, ExpirationDateTextField, CVVTextField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.sharedInstance.setNavigationBarAppearance(navigationController)
        self.view.backgroundColor = Theme.sharedInstance.lightThemeColor()
        let image = UIImage(named: "Venmo_Logo.png")
        self.navigationItem.titleView = UIImageView(image: image)
        setupDelegates()
        setupControls()
        setupControlLayers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.textDidChange(_:)),    name: UITextFieldTextDidChangeNotification, object: nil)
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
        titleLabel.textColor = Theme.sharedInstance.textThemeColor()
        cardNumberLabel.textColor = Theme.sharedInstance.textThemeColor()
        expirationDateLabel.textColor = Theme.sharedInstance.textThemeColor()
        cvvLabel.textColor = Theme.sharedInstance.textThemeColor()
        submitButton.backgroundColor = Theme.sharedInstance.darkThemeColor()
        submitButton.setTitleColor(Theme.sharedInstance.contrastThemeColor(), forState: UIControlState.Normal)
        cardNumberCheckMark.hidden = true
        expirationDateCheckMark.hidden = true
        cvvCheckMark.hidden = true
        cvvTextField.enabled = false
    }
    
    func setupControlLayers() {
        submitButton.layer.cornerRadius = 4.0
        containerView.layer.cornerRadius = 4.0
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = Theme.sharedInstance.darkThemeColor().CGColor
        cardNumberTextField.layer.cornerRadius = 4.0
        cardNumberTextField.layer.borderWidth = 1.0
        cardNumberTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        expirationDateTextField.layer.cornerRadius = 4.0
        expirationDateTextField.layer.borderWidth = 1.0
        cvvTextField.layer.cornerRadius = 4.0
        cvvTextField.layer.borderWidth = 1.0
        cvvTextField.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if titleLabelTopConstraint.constant == 0 {
            resignFirstResponders()
        }
    }
    
    func resetFormPosition() {
        resignFirstResponders()
        titleLabelTopConstraint.constant = titleLabelDefault
    }
    
    func resignFirstResponders() {
        cardNumberTextField.resignFirstResponder()
        expirationDateTextField.resignFirstResponder()
        cvvTextField.resignFirstResponder()
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
    
    func textDidChange(notification: NSNotification) {
        let textField = notification.object as! UITextField
        if let text = textField.text {
            switch(textField.tag) {
            case 0:
                evaluateCardNumber(text)
            case 1:
                evaluateExpiredDate(text)
            case 2:
                evaluateCVV(text)
            default:
                break
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let characterCount = text.characters.count + string.characters.count
            switch(textField.tag) {
            case 0:
                if characterCount <= creditCard.type.cardNumberLength {
                    return true
                }
                return false
            case 1:
                if characterCount < 6 {
                    return true
                }
                return false
            case 2:
                if characterCount <= creditCard.type.cvvLength {
                    return true
                }
                return false
            default:
                return true
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.layoutIfNeeded()
    }
    
    func evaluateCardNumber(cardNumber: String) {
        creditCard.type = creditCardTypeFromString(cardNumber)
        cardImageView.image = UIImage(named: creditCard.type.logo)
        if creditCard.type != .Unknown && isCorrectCreditCardNumberLength(cardNumber, creditCardType: creditCard.type) && passesLuhnAlgorithm(cardNumber) {
            cardNumberCheckMark.hidden = false
            creditCard.cardNumber = cardNumber
            expirationDateTextField.enabled = true
            cvvTextField.enabled = true
            cvvTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        } else {
            cardNumberCheckMark.hidden = true
            creditCard.cardNumber = ""
            cvvTextField.text = ""
            creditCard.cvv = ""
        }
        evaluateCVV(creditCard.cvv)
    }
    
    func evaluateExpiredDate(date: String) {
        if date.characters.count <= 2 {
            expirationDateTextField.text = padExpirationDateMonth(date)
        }
        if isValidExpirationDate(date) {
            expirationDateCheckMark.hidden = false
            creditCard.expirationDate = date
        } else {
            expirationDateCheckMark.hidden = true
            creditCard.expirationDate = ""
        }
    }
    
    func evaluateCVV(cvv: String) {
        cvvImageView.image = UIImage(named: "Cards_CVV.png")
        if cvv.characters.count == creditCard.type.cvvLength {
            cvvCheckMark.hidden = false
            creditCard.cvv = cvv
        } else {
            cvvCheckMark.hidden = true
            creditCard.cvv = ""
        }
    }

    @IBAction func submitButtonPressed(sender: AnyObject) {
        
    }
}

