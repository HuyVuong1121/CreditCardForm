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
    
    var name: String {
        switch self {
        case .Amex:
            return "American Express"
        case .DinersClub:
            return "Diners Club"
        case .Discover:
            return "Discover"
        case .JCB:
            return "JCB"
        case .MasterCard:
            return "MasterCard"
        case .Visa:
            return "Visa"
        case .Unknown:
            return "Unknown"
        }
    }
    
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
            return "Cards_GenericCard.png"
        }
    }
    
    var regex: String {
        switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .DinersClub:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .MasterCard:
            return "^5[1-5][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}$"
        case .Unknown:
            return "^$"
        }
    }
    
    var numberLength: Int {
        switch self {
        case .Amex: return 15
        case .DinersClub, .Discover, .JCB, .MasterCard, .Visa, .Unknown: return 16
        }
    }
    
    var cvvLength: Int {
        switch self {
        case .Amex: return 4
        case .DinersClub, .Discover, .JCB, .MasterCard, .Visa, .Unknown: return 3
        }
    }
    
    static let allValues = [Amex, DinersClub, Discover, JCB, MasterCard, Visa]
}

protocol CreditCardProtocol {
    var type: CreditCardType { get }
    var cardNumber: String { get set }
    var expirationDate: String { get set }
    var cvv: String  { get set }
    
    func cardTypeFromCardNumber() -> CreditCardType
    func numberIsValid(number: String) -> Bool
    func expirationDateIsValid(expirationDate: String) -> Bool
}

struct CreditCard: CreditCardProtocol {
    var cardNumber: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType {
        get {
            return cardTypeFromCardNumber()
        }
    }
    
    func cardTypeFromCardNumber() -> CreditCardType {
        if let cardType = typeFromString(cardNumber) {
            return cardType
        }
        return .Unknown
    }
    
    func numberIsValid(number: String) -> Bool {
    
        return true
    }
    
    func expirationDateIsValid(expirationDate: String) -> Bool {
        
        return true
    }
}

