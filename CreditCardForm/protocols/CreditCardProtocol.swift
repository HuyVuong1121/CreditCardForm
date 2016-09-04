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
    func creditCardIsValid() -> Bool
    func creditCardNumberIsValid() -> Bool
}

extension CreditCardProtocol {

    func creditCardIsValid() -> Bool {
        return self.type != .Unknown && self.creditCardNumberIsValid() && self.expirationDate.expirationDateIsValid() && self.cvv.cvvLengthIsCorrect(self.cvvLength)
    }

    func creditCardNumberIsValid() -> Bool {
        return self.cardNumber.creditCardNumberLengthIsCorrect(self.cardNumberLength) && self.cardNumber.passesLuhnAlgorithm()
    }

}
