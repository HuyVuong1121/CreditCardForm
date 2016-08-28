//
//  CreditCardController.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 8/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class CreditCardController {
    
    static let sharedInstance = CreditCardController()
    private init() {}
    
    func creditCardFromString(creditCardNumber: String) -> CreditCardProtocol {
        let creditCard = UnknownCreditCard(cardNumber: "", expirationDate: "", cvv: "")
        var validCard: CreditCardProtocol
        for type in CreditCardType.validValues {
            validCard = creditCard.cardFromType(type, cardNumber: "", expirationDate: "", cvv: "")
            let predicate = NSPredicate(format: "SELF MATCHES %@", validCard.regex)
            let numbersString = creditCardNumber.onlyNumbersFromString()
            if predicate.evaluateWithObject(numbersString) {
                return validCard
            }
        }
        return creditCard
    }
}
