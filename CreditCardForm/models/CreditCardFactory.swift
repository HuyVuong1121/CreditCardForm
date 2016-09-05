//
//  CreditCardFactory.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 9/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol CreditCardFactoryProtocol {
    func create(creditCardNumber: String) -> CreditCardProtocol
}

final class CreditCardFactory: CreditCardFactoryProtocol {

    static let sharedInstance = CreditCardFactory()
    private init() {}

    func create(creditCardNumber: String) -> CreditCardProtocol {
        let creditCard = UnknownCreditCard(cardNumber: "", expirationDate: "", cvv: "")
        var validCard: CreditCardProtocol
        for type in CreditCardType.validValues {
            validCard = cardFromType(type, cardNumber: "", expirationDate: "", cvv: "")
            let predicate = NSPredicate(format: "SELF MATCHES %@", validCard.regex)
            let numbersString = creditCardNumber.onlyNumbersFromString()
            if predicate.evaluateWithObject(numbersString) {
                return validCard
            }
        }
        return creditCard
    }

    private func cardFromType(type: CreditCardType, cardNumber: String, expirationDate: String, cvv: String) -> CreditCardProtocol {
        switch type {
        case .Amex:
            return AmexCreditCard(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
        case .DinersClub:
            return DinersClubCreditCard(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
        case .Discover:
            return DiscoverCreditCard(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
        case .JCB:
            return JCBCreditCard(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
        case .MasterCard:
            return MasterCardCreditCard(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
        case .Visa:
            return VisaCreditCard(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
        case .Unknown:
            return UnknownCreditCard(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
        }
    }

}
