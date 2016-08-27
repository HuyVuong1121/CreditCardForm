//
//  AlertController.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 8/27/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

final class AlertController {

    let viewController: ViewController

    init(viewController: ViewController) {
        self.viewController = viewController
    }

    func alertMessageForCreditCard(creditCard: CreditCardProtocol) -> String {
        var message = "Your credit card is valid!"
        let cardTypeIsValid = creditCard.type != .Unknown
        let cardNumberIsValid = creditCard.creditCardNumberIsValid()
        let cardExpirationIsValid = creditCard.expirationDate.expirationDateIsValid()
        let cardCVVIsValid = creditCard.cvv.cvvLengthIsCorrect(creditCard.cvvLength)

        if creditCard.creditCardIsValid() {
            self.viewController.resignFirstResponders()
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
        self.viewController.presentViewController(alertController, animated: true) {}
    }
}
