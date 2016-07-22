//
//  CreditCardEvaluator.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/21/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

protocol CreditCardEvaluator: CreditCardValidator {
    
    
}

extension CreditCardEvaluator {
    
    func evaluateCardNumber(cardNumber: String, creditCard: CreditCard, cardImageView: UIImageView, cardNumberCheckMark: UIImageView, cardNumberCheckMarkView:  UIView, expirationDateTextField: UITextField, cvvTextField: UITextField ) -> CreditCard {
        var creditCard = creditCard
        creditCard.type = creditCardTypeFromString(cardNumber)
        cardImageView.image = UIImage(named: creditCard.type.logo)
        creditCard.cardNumber = cardNumber
        let cardNumberIsValid = creditCard.type != .Unknown && creditCardNumberLengthIsCorrect(cardNumber, creditCardType: creditCard.type) && passesLuhnAlgorithm(cardNumber)
        if cardNumberIsValid {
            cardNumberCheckMark.hidden = false
            cardNumberCheckMarkView.hidden = true
        } else {
            cardNumberCheckMark.hidden = true
            cardNumberCheckMarkView.hidden = false
        }
        return creditCard
    }
    
    func evaluateExpiredDate(date: String, creditCard:CreditCard, expirationDateTextField: UITextField, expirationDateCheckMark: UIImageView, expirationDateCheckMarkView:  UIView ) -> CreditCard {
        var creditCard = creditCard
        if date.characters.count <= 2 {
            expirationDateTextField.text = padExpirationDateMonth(date)
        }
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
    
    func evaluateCVV(cvv: String, creditCard:CreditCard, cvvTextField: UITextField, cvvCheckMark: UIImageView, cvvCheckMarkView:  UIView ) -> CreditCard {
        var creditCard = creditCard
        creditCard.cvv = cvv
        if cvv.characters.count == creditCard.type.cvvLength {
            cvvCheckMark.hidden = false
            cvvCheckMarkView.hidden = true
        } else {
            cvvCheckMark.hidden = true
            cvvCheckMarkView.hidden = false
        }
        if creditCard.type.cvvLength == 3 {
            cvvTextField.placeholder = "123"
        } else {
            cvvTextField.placeholder = "1234"
        }
        return creditCard
    }
    
}
