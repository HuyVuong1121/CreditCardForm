//
//  CreditCardEvaluator.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/21/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

protocol CreditCardEvaluator: CreditCardValidator {}

extension CreditCardEvaluator {

    func evaluateCardNumber(cardNumber: String, creditCard: CreditCardProtocol, cardImageView: UIImageView, cardNumberCheckMark: UIImageView, cardNumberCheckMarkView: UIView) -> CreditCardProtocol {
        var creditCard = creditCardFromString(cardNumber)
        cardImageView.image = UIImage(named: creditCard.logo)
        let cardNumberIsValid = creditCard.type != .Unknown && creditCardNumberLengthIsCorrect(cardNumber, creditCard: creditCard) && passesLuhnAlgorithm(cardNumber)
        if cardNumberIsValid {
            creditCard.cardNumber = cardNumber
            cardNumberCheckMark.hidden = false
            cardNumberCheckMarkView.hidden = true
        } else {
            creditCard.cardNumber = ""
            cardNumberCheckMark.hidden = true
            cardNumberCheckMarkView.hidden = false
        }
        return creditCard
    }

    func evaluateExpiredDate(date: String, creditCard: CreditCardProtocol, expirationDateTextField: UITextField, expirationDateCheckMark: UIImageView, expirationDateCheckMarkView: UIView ) -> CreditCardProtocol {
        var date = date
        var creditCard = creditCard
        if date.characters.count <= 2 {
            date = padExpirationDateMonth(date)
        }
        expirationDateTextField.text = date
        creditCard.expirationDate = date
        if expirationDateIsValid(date) {
            expirationDateCheckMark.hidden = false
            expirationDateCheckMarkView.hidden = true
        } else {
            expirationDateCheckMark.hidden = true
            expirationDateCheckMarkView.hidden = false
        }
        return creditCard
    }

    func evaluateCVV(cvv: String, creditCard: CreditCardProtocol, cvvTextField: UITextField, cvvCheckMark: UIImageView, cvvCheckMarkView: UIView ) -> CreditCardProtocol {
        var creditCard = creditCard
        if cvv.characters.count == creditCard.cvvLength {
            creditCard.cvv = cvv
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
