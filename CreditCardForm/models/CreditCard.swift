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
    case Amex, DinersClub, Discover, JCB, MasterCard, Visa
    
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
        }
    }
    
    var numberLength: Int {
        switch self {
        case .Amex: return 15
        case .DinersClub, .Discover, .JCB, .MasterCard, .Visa: return 16
        }
    }
    
    var cvvLength: Int {
        switch self {
        case .Amex: return 4
        case .DinersClub, .Discover, .JCB, .MasterCard, .Visa: return 3
        }
    }
}

protocol CreditCardProtocol {
    var type: CreditCardType { get }
    var number: String { get set }
    var expirationDate: String { get set }
    var cvv: String  { get set }
    
    func cardTypeFromNumber(number: String) -> CreditCardType
    func numberIsValid(number: String) -> Bool
    func expirationDateIsValid(expirationDate: String) -> Bool
}

struct CreditCard: CreditCardProtocol {
    var number: String
    var expirationDate: String
    var cvv: String
    var type: CreditCardType {
        get {
            return cardTypeFromNumber(number)
        }
    }
    
    func cardTypeFromNumber(number: String) -> CreditCardType {
        
        return .Amex
    }
    
    func numberIsValid(number: String) -> Bool {
    
        return true
    }
    
    func expirationDateIsValid(expirationDate: String) -> Bool {
        
        return true
    }
}