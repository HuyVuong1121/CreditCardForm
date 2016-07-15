//
//  CreditCardValidation.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

func creditCardTypeFromString(string: String) -> CreditCardType {
    if string.characters.count < 6 {
        return CreditCardType.Unknown
    }
    for type in CreditCardType.validValues {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type.regex)
        let numbersString = onlyNumbersFromString(string)
        if predicate.evaluateWithObject(numbersString) {
            return type
        }
    }
    return CreditCardType.Unknown
}

func onlyNumbersFromString(string: String) -> String {
    let set = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    let numbers = string.componentsSeparatedByCharactersInSet(set)
    return numbers.joinWithSeparator("")
}

func isValidExpirationDate(expirationDateString: String) -> Bool {
    // this is assuming the expiration date is the first day of the month after the month listed on the credit card.
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/yy"
    if let expirationDate = dateFormatter.dateFromString(expirationDateString) {
        let now = NSDate()
        let calendar = NSCalendar.currentCalendar()
        var expirationAdjustedDate = calendar.dateByAddingUnit(NSCalendarUnit.Month, value: 1, toDate: expirationDate, options: [])
        let expirationComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: expirationAdjustedDate!)
        expirationComponents.day = 0
        expirationAdjustedDate = calendar.dateFromComponents(expirationComponents)
        if now.compare(expirationAdjustedDate!) == NSComparisonResult.OrderedAscending {
            return true
        }
        return false
    }
    return false
}

func isCorrectCreditCardNumberLength(cardNumber: String, creditCardType: CreditCardType) -> Bool {
    return cardNumber.characters.count == creditCardType.cardNumberLength
}

func isCorrectCVVLength(cvv: String, creditCardType: CreditCardType) -> Bool {
    return cvv.characters.count == creditCardType.cvvLength
}


