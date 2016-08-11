//
//  CreditCardValidator.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol CreditCardValidator {}

extension CreditCardValidator {

    func creditCardFromString(string: String) -> CreditCardProtocol {
        let creditCard = UnknownCreditCard(cardNumber: "", expirationDate: "", cvv: "")
        var validCard: CreditCardProtocol
        for type in CreditCardType.validValues {
            validCard = creditCard.cardFromType(type, cardNumber: "", expirationDate: "", cvv: "")
            let predicate = NSPredicate(format: "SELF MATCHES %@", validCard.regex)
            let numbersString = onlyNumbersFromString(string)
            if predicate.evaluateWithObject(numbersString) {
                return validCard
            }
        }
        return creditCard
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
        let dateFormatter = NSDateFormatter()
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

    func nextCreditCardDigitIsValid(creditCard: CreditCardProtocol, characterCount: Int, string: String) -> Bool {
        if characterCount > 6 && creditCard.type == CreditCardType.Unknown {
            return false
        }
        if characterCount <= creditCard.cardNumberLength &&  (string == "" || Double(string) != nil) {
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

    func nextCVVDigitIsValid(creditCard: CreditCardProtocol, characterCount: Int, string: String) -> Bool {
        if characterCount <= creditCard.cvvLength &&  (string == "" || Int(string) != nil) {
            return true
        }
        return false
    }

    func creditCardNumberLengthIsCorrect(cardNumber: String, creditCard: CreditCardProtocol) -> Bool {
        return cardNumber.characters.count == creditCard.cardNumberLength
    }

    func cvvLengthIsCorrect(cvv: String, creditCard: CreditCardProtocol) -> Bool {
        return cvv.characters.count == creditCard.cvvLength
    }

    func creditCardIsValid(creditCard: CreditCardProtocol) -> Bool {
        return creditCard.type != .Unknown && creditCardNumberIsValid(creditCard) && creditCardExpirationDateIsValid(creditCard) && creditCardCVVNumberLengthIsValid(creditCard)
    }

    func creditCardNumberIsValid(creditCard: CreditCardProtocol) -> Bool {
        return creditCardNumberLengthIsValid(creditCard) && creditCardLastDigitIsValid(creditCard)
    }

    func creditCardNumberLengthIsValid(creditCard: CreditCardProtocol) -> Bool {
        return creditCardNumberLengthIsCorrect(creditCard.cardNumber, creditCard: creditCard)
    }

    func creditCardLastDigitIsValid(creditCard: CreditCardProtocol) -> Bool {
        return passesLuhnAlgorithm(creditCard.cardNumber)
    }

    func creditCardExpirationDateIsValid(creditCard: CreditCardProtocol) -> Bool {
        return expirationDateIsValid(creditCard.expirationDate)
    }

    func creditCardCVVNumberLengthIsValid(creditCard: CreditCardProtocol) -> Bool {
        return cvvLengthIsCorrect(creditCard.cvv, creditCard: creditCard)
    }

}
