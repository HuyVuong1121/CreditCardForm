//
//  ViewController.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TextFieldDelegate {

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

    var alertController: AlertController?
    var textFieldDelegate: ViewControllerTextFieldDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeAppearance().setNavigationBarAppearance(navigationController)
        self.view.backgroundColor = Theme.Light.color
        setupControls()
        setupControlLayers()
        self.alertController = AlertController(viewController: self)
        self.textFieldDelegate = ViewControllerTextFieldDelegate(cardNumberTextField: cardNumberTextField, expirationDateTextField: expirationDateTextField, cvvTextField: cvvTextField, creditCard: creditCard)
        self.textFieldDelegate!.updateWithViews(cardImageView, cardNumberCheckMark: cardNumberCheckMark, cardNumberCheckMarkView: cardNumberCheckMarkView, expirationDateCheckMark: expirationDateCheckMark, expirationDateCheckMarkView: expirationDateCheckMarkView, cvvCheckMark: cvvCheckMark, cvvCheckMarkView: cvvCheckMarkView)
        self.textFieldDelegate?.delegate = self
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
        updateLayer(cardNumberTextField)
        updateLayer(expirationDateTextField)
        updateLayer(cvvTextField)
        updateLayerForCircle(cardNumberCheckMarkView)
        updateLayerForCircle(expirationDateCheckMarkView)
        updateLayerForCircle(cvvCheckMarkView)
    }

    func updateLayer(view: UIView) {
        view.layer.cornerRadius = cornerRadius
        updateLayerCommon(view)
    }

    func updateLayerForCircle(view: UIView) {
        view.layer.cornerRadius = view.frame.width/2.0
        updateLayerCommon(view)
    }

    func updateLayerCommon(view: UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = Theme.Dark.color.CGColor
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resignFirstResponders()
    }

    func resetFormPosition() {
        resignFirstResponders()
        titleLabelTopConstraint.constant = titleLabelDefault
    }

    func resignFirstResponders() {
        resignFirstResponder(cardNumberTextField)
        resignFirstResponder(expirationDateTextField)
        resignFirstResponder(cvvTextField)
    }

    func resignFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }

    func creditCardUpdated(creditCard: CreditCardProtocol) {
        self.creditCard = creditCard
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

    @IBAction func submitButtonPressed(sender: AnyObject) {
        let title = "New Credit Card"
        let message = self.alertController?.alertMessageForCreditCard(creditCard)
        self.alertController?.showAlertWithMessage(title, message: message!)
    }

    deinit {
        self.removeObserver(self, forKeyPath: UIKeyboardWillShowNotification)
        self.removeObserver(self, forKeyPath: UIKeyboardWillHideNotification)
    }
}
