//
//  CreditCardEvaluator.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/21/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

extension String {

    func evaluateCardNumber(creditCard: CreditCardProtocol, cardImageView: UIImageView, cardNumberCheckMark: UIImageView, cardNumberCheckMarkView: UIView) -> CreditCardProtocol {
        var creditCard = self.creditCardFromString()
        cardImageView.image = UIImage(named: creditCard.logo)
        let cardNumberIsValid = creditCard.type != .Unknown && self.creditCardNumberLengthIsCorrect(creditCard.cardNumberLength) && self.passesLuhnAlgorithm()
        if cardNumberIsValid {
            creditCard.cardNumber = self
            cardNumberCheckMark.hidden = false
            cardNumberCheckMarkView.hidden = true
        } else {
            creditCard.cardNumber = ""
            cardNumberCheckMark.hidden = true
            cardNumberCheckMarkView.hidden = false
        }
        return creditCard
    }

    func evaluateExpiredDate(creditCard: CreditCardProtocol, expirationDateTextField: UITextField, expirationDateCheckMark: UIImageView, expirationDateCheckMarkView: UIView ) -> CreditCardProtocol {
        var date = self
        var creditCard = creditCard
        if date.characters.count <= 2 {
            date = date.padExpirationDateMonth()
        }
        expirationDateTextField.text = date
        creditCard.expirationDate = date
        if date.expirationDateIsValid() {
            expirationDateCheckMark.hidden = false
            expirationDateCheckMarkView.hidden = true
        } else {
            expirationDateCheckMark.hidden = true
            expirationDateCheckMarkView.hidden = false
        }
        return creditCard
    }

    func evaluateCVV(creditCard: CreditCardProtocol, cvvTextField: UITextField, cvvCheckMark: UIImageView, cvvCheckMarkView: UIView ) -> CreditCardProtocol {
        var creditCard = creditCard
        if self.characters.count == creditCard.cvvLength {
            creditCard.cvv = self
            cvvCheckMark.hidden = false
            cvvCheckMarkView.hidden = true
        } else {
            creditCard.cvv = ""
            cvvCheckMark.hidden = true
            cvvCheckMarkView.hidden = false
        }
        if creditCard.cvvLength == 3 {
            cvvTextField.placeholder = "123"
        } else {
            cvvTextField.placeholder = "1234"
        }
        return creditCard
    }

}
