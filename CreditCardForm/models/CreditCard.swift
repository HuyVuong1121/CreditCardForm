//
//  CreditCard.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

enum CreditCardType {
    case Amex, DinersClub, Discover, JCB, MasterCard, Visa, Unknown
    static let validValues = [Amex, DinersClub, Discover, JCB, MasterCard, Visa]
}

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
}

struct AmexCreditCard: CreditCardProtocol, CreditCardValidator {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Amex }
    var logo: String { return "Cards_Amex.png" }
    var regex: String { return "^3[47][0-9]{4,}$" }
    var cardNumberLength: Int { return 15 }
    var cvvLength: Int { return 4 }
}

struct DinersClubCreditCard: CreditCardProtocol, CreditCardValidator {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .DinersClub }
    var logo: String { return "Cards_Dinerclub.png" }
    var regex: String { return "^3(?:0[0-5]|[68][0-9])[0-9]{3,}$" }
    var cardNumberLength: Int { return 14 }
    var cvvLength: Int { return 3 }
}

struct DiscoverCreditCard: CreditCardProtocol, CreditCardValidator {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Discover }
    var logo: String { return "Cards_Discover.png" }
    var regex: String { return "^6(?:011|5[0-9]{2})[0-9]{2,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct JCBCreditCard: CreditCardProtocol, CreditCardValidator {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .JCB }
    var logo: String { return "Cards_JCB.png" }
    var regex: String { return "^(?:2131|1800|35[0-9]{3})[0-9]{1,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct MasterCardCreditCard: CreditCardProtocol, CreditCardValidator {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .MasterCard }
    var logo: String { return "Cards_Mastercard.png" }
    var regex: String { return "^5[1-5][0-9]{4,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct VisaCreditCard: CreditCardProtocol, CreditCardValidator {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Visa }
    var logo: String { return "Cards_Visa.png" }
    var regex: String { return "^4[0-9]{5,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct UnknownCreditCard: CreditCardProtocol, CreditCardValidator {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Unknown }
    var logo: String { return "Cards_GenericCard.png" }
    var regex: String { return "^$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}
