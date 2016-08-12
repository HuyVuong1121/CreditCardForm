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

struct AmexCreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Amex }
    var logo: String { return "Cards_Amex.png" }
    var regex: String { return "^3[47][0-9]{4,}$" }
    var cardNumberLength: Int { return 15 }
    var cvvLength: Int { return 4 }
}

struct DinersClubCreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .DinersClub }
    var logo: String { return "Cards_Dinerclub.png" }
    var regex: String { return "^3(?:0[0-5]|[68][0-9])[0-9]{3,}$" }
    var cardNumberLength: Int { return 14 }
    var cvvLength: Int { return 3 }
}

struct DiscoverCreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Discover }
    var logo: String { return "Cards_Discover.png" }
    var regex: String { return "^6(?:011|5[0-9]{2})[0-9]{2,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct JCBCreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .JCB }
    var logo: String { return "Cards_JCB.png" }
    var regex: String { return "^(?:2131|1800|35[0-9]{3})[0-9]{1,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct MasterCardCreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .MasterCard }
    var logo: String { return "Cards_Mastercard.png" }
    var regex: String { return "^5[1-5][0-9]{4,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct VisaCreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Visa }
    var logo: String { return "Cards_Visa.png" }
    var regex: String { return "^4[0-9]{5,}$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}

struct UnknownCreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType { return .Unknown }
    var logo: String { return "Cards_GenericCard.png" }
    var regex: String { return "^$" }
    var cardNumberLength: Int { return 16 }
    var cvvLength: Int { return 3 }
}
