//
//  CreditCardValidation.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

let dateFormatter = NSDateFormatter()

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

func padExpirationDateMonth(string: String) -> String {
    if string.characters.count == 1 {
        if let number = Int(string) {
            if number > 1 {
                return "0" + string
            } else {
                return string
            }
        }
    }
    if string == "1/" {
        return "01/"
    }
    return string
}

func passesLuhnAlgorithm(cardNumber: String) -> Bool {
    let formattedCardNumber = onlyNumbersFromString(cardNumber)
    let originalCheckDigit = formattedCardNumber.characters.last!
    let characters = formattedCardNumber.characters.dropLast().reverse()
    
    var digitSum = 0
    for (idx, character) in characters.enumerate() {
        let value = Int(String(character)) ?? 0
        if idx % 2 == 0 {
            var product = value * 2
            if product > 9 {
                product = product - 9
            }
            digitSum = digitSum + product
        } else {
            digitSum = digitSum + value
        }
    }
    
    digitSum = digitSum * 9
    let computedCheckDigit = digitSum % 10
    let originalCheckDigitInt = Int(String(originalCheckDigit))
    
    return originalCheckDigitInt == computedCheckDigit
}

func expirationDateFormatIsValid(expirationDateString: String) -> Bool {
    if expirationDateString == "0" {
        return true
    }
    switch expirationDateString.characters.count {
        case 1:
            dateFormatter.dateFormat = "M"
        case 2:
            dateFormatter.dateFormat = "MM"
        case 3:
            dateFormatter.dateFormat = "MM/"
        case 4:
            dateFormatter.dateFormat = "MM/y"
        default:
            dateFormatter.dateFormat = "MM/yy"
    }
    if dateFormatter.dateFromString(expirationDateString) != nil {
        return true
    }
    return false
}

func expirationDateIsValid(expirationDateString: String) -> Bool {
    // this is assuming the expiration date is the first day of the month after the month listed on the credit card.
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

func nextCreditCardDigitIsValid(creditCard: CreditCard, characterCount: Int, string: String) -> Bool {
    if characterCount > 6 && creditCard.type == CreditCardType.Unknown {
        return false
    }
    if characterCount <= creditCard.type.cardNumberLength &&  (string == "" || Double(string) != nil) {
        return true
    }
    return false
}

func nextExpirationDateDigitIsValid(text: String, characterCount: Int, string: String) -> Bool {
    if string == "" {
        return true
    }
    if 1...5 ~= characterCount {
        return expirationDateFormatIsValid(text + string)
    }
    return false
}

func nextCVVDigitIsValid(creditCard: CreditCard, characterCount: Int, string: String) -> Bool {
    if characterCount <= creditCard.type.cvvLength &&  (string == "" || Int(string) != nil) {
        return true
    }
    return false
}

func creditCardNumberLengthIsCorrect(cardNumber: String, creditCardType: CreditCardType) -> Bool {
    return cardNumber.characters.count == creditCardType.cardNumberLength
}

func cvvLengthIsCorrect(cvv: String, creditCardType: CreditCardType) -> Bool {
    return cvv.characters.count == creditCardType.cvvLength
}


