//
//  CreditCardProtocol.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 8/12/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

protocol CreditCardProtocol {
    var cardNumber: String { get set }
    var expirationDate: String { get set }
    var cvv: String { get set }
    var type: CreditCardType { get }
    var logo: String { get }
    var regex: String { get }
    var cardNumberLength: Int { get }
    var cvvLength: Int { get }
}

extension CreditCardProtocol {

    func cardFromType(type: CreditCardType, cardNumber: String, expirationDate: String, cvv: String) -> CreditCardProtocol {
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

    func creditCardIsValid() -> Bool {
        return self.type != .Unknown && self.creditCardNumberIsValid() && self.expirationDate.expirationDateIsValid() && self.cvv.cvvLengthIsCorrect(self.cvvLength)
    }

    func creditCardNumberIsValid() -> Bool {
        return self.cardNumber.creditCardNumberLengthIsCorrect(self.cardNumberLength) && self.cardNumber.passesLuhnAlgorithm()
    }

}
