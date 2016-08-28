//
//  String+CreditCardValidator.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 8/12/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

extension String {

    func onlyNumbersFromString() -> String {
        let set = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        let numbers = self.componentsSeparatedByCharactersInSet(set)
        return numbers.joinWithSeparator("")
    }

    func padExpirationDateMonth() -> String {
        if self.characters.count == 1 {
            if let number = Int(self) {
                if number > 1 {
                    return "0" + self
                } else {
                    return self
                }
            }
        }
        if self == "1/" {
            return "01/"
        }
        return self
    }

    func passesLuhnAlgorithm() -> Bool {
        let formattedCardNumber = self.onlyNumbersFromString()
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

    func expirationDateFormatIsValid() -> Bool {
        if self == "0" {
            return true
        }
        let dateFormatter = NSDateFormatter()
        switch self.characters.count {
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
        if dateFormatter.dateFromString(self) != nil {
            return true
        }
        return false
    }

    func expirationDateIsValid() -> Bool {
        // this is assuming the expiration date is the first day of the month after the month listed on the credit card.
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        if let expirationDate = dateFormatter.dateFromString(self) {
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

    func nextCreditCardDigitIsValid(creditCardType: CreditCardType, cardNumberLength: Int, characterCount: Int) -> Bool {
        if characterCount > 6 && creditCardType == CreditCardType.Unknown {
            return false
        }
        if characterCount <= cardNumberLength &&  (self == "" || Double(self) != nil) {
            return true
        }
        return false
    }

    func nextExpirationDateDigitIsValid(text: String, characterCount: Int) -> Bool {
        if self == "" {
            return true
        }
        if 1...5 ~= characterCount {
            let combinedText = text + self
            return combinedText.expirationDateFormatIsValid()
        }
        return false
    }

    func nextCVVDigitIsValid(creditCardCVVLength: Int, characterCount: Int) -> Bool {
        if characterCount <= creditCardCVVLength &&  (self == "" || Int(self) != nil) {
            return true
        }
        return false
    }

    func creditCardNumberLengthIsCorrect(cardNumberLength: Int) -> Bool {
        return self.characters.count == cardNumberLength
    }

    func cvvLengthIsCorrect(creditCardCVVLength: Int) -> Bool {
        return self.characters.count == creditCardCVVLength
    }
}
