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
    
    var logo: String {
        switch self {
            case .Amex:
                return "Cards_Amex.png"
            case .DinersClub:
                return "Cards_Dinerclub.png"
            case .Discover:
                return "Cards_Discover.png"
            case .JCB:
                return "Cards_JCB.png"
            case .MasterCard:
                return "Cards_Mastercard.png"
            case .Visa:
                return "Cards_Visa.png"
            case .Unknown:
                return "Cards_Blank.png"
        }
    }
    
    var regex: String {
        switch self {
            case .Amex:
                return "^3[47][0-9]{4,}$"
            case .DinersClub:
                return "^3(?:0[0-5]|[68][0-9])[0-9]{3,}$"
            case .Discover:
                return "^6(?:011|5[0-9]{2})[0-9]{2,}$"
            case .JCB:
                return "^(?:2131|1800|35[0-9]{3})[0-9]{1,}$"
            case .MasterCard:
                return "^5[1-5][0-9]{4,}$"
            case .Visa:
                return "^4[0-9]{5,}$"
            case .Unknown:
                return "^$"
        }
    }
    
    var cardNumberLength: Int {
        switch self {
            case .DinersClub: return 14
            case .Amex: return 15
            case .Discover, .JCB, .MasterCard, .Visa, .Unknown: return 16
        }
    }
    
    var cvvLength: Int {
        switch self {
            case .Amex: return 4
            case .DinersClub, .Discover, .JCB, .MasterCard, .Visa, .Unknown: return 3
        }
    }
    
    static let validValues = [Amex, DinersClub, Discover, JCB, MasterCard, Visa]
}

protocol CreditCardProtocol {
    var cardNumber: String { get set }
    var type: CreditCardType { get set }
    var expirationDate: String { get set }
    var cvv: String  { get set }
    
    func creditCardIsValid() -> Bool
    func creditCardNumberIsValid() -> Bool
    func creditCardNumberLengthIsValid() -> Bool
    func creditCardLastDigitIsValid() -> Bool
    func creditCardExpirationDateIsValid() -> Bool
    func creditCardCVVNumberLengthIsValid() -> Bool
}

struct CreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType
    
    func creditCardIsValid() -> Bool {
        return creditCardNumberIsValid() && creditCardExpirationDateIsValid() && creditCardCVVNumberLengthIsValid()
    }
    
    func creditCardNumberIsValid() -> Bool {
        return creditCardNumberLengthIsValid() && creditCardLastDigitIsValid()
    }
    
    func creditCardNumberLengthIsValid() -> Bool {
        return creditCardNumberLengthIsCorrect(cardNumber, creditCardType: type)
    }
    
    func creditCardLastDigitIsValid() -> Bool {
        return passesLuhnAlgorithm(cardNumber)
    }
    
    func creditCardExpirationDateIsValid() -> Bool {
        return expirationDateIsValid(expirationDate)
    }
    
    func creditCardCVVNumberLengthIsValid() -> Bool {
        return cvvLengthIsCorrect(cvv, creditCardType: type)
    }
}

