//
//  CreditCardValidationTests.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import CreditCardForm

class CreditCardValidationTests: XCTestCase, CreditCardValidator {

    let emptyNumber = ""
    let shortNumber = "3782"
    let randomNumber = "asoidfwneroqj"
    let amex1Number = "378282246310005"
    let amex1BadLuhnNumber = "378282246310004"
    let amex2Number = "371449635398431"
    let diners1Number = "30569309025904"
    let diners2Number = "38520000023237"
    let discover1Number = "6011111111111117"
    let discover2Number = "6011000990139424"
    let jcb1Number = "3530111333300000"
    let jcb2Number = "3566002020360505"
    let mastercard1Number = "5555555555554444"
    let masterCard2Number = "5105105105105100"
    let visa1Number = "4111111111111111"
    let visa2Number = "4012888888881881"
    let visa3Number = "4222222222222"
    let visa3BadNumber = "4222222222223"
    let visa3BadLuhnNumber = "4222222222225"

    let amexCVVNumber = "1234"

    let unknownCreditCard: CreditCardProtocol = UnknownCreditCard(cardNumber: "", expirationDate: "", cvv: "")
    let amexCreditCard: CreditCardProtocol = AmexCreditCard(cardNumber: "378282246310005", expirationDate: "", cvv: "")
    let visaCreditCard: CreditCardProtocol = VisaCreditCard(cardNumber: "4111111111111111", expirationDate: "", cvv: "")

    let dateFormatter = NSDateFormatter()

    func testcreditCardFromStringEmptyNumber() {
        let card = creditCardFromString(emptyNumber)
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringShortNumber() {
        let card = creditCardFromString(shortNumber)
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringRandomNumber() {
        let card = creditCardFromString(randomNumber)
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringAmex1() {
        let card = creditCardFromString(amex1Number)
        XCTAssertEqual(card.type, CreditCardType.Amex)
    }

    func testcreditCardFromStringAmex2() {
        let card = creditCardFromString(amex2Number)
        XCTAssertEqual(card.type, CreditCardType.Amex)
    }

    func testcreditCardFromStringDiners1() {
        let card = creditCardFromString(diners1Number)
        XCTAssertEqual(card.type, CreditCardType.DinersClub)
    }

    func testcreditCardFromStringDiners2() {
        let card = creditCardFromString(diners2Number)
        XCTAssertEqual(card.type, CreditCardType.DinersClub)
    }

    func testcreditCardFromStringDiscover1() {
        let card = creditCardFromString(discover1Number)
        XCTAssertEqual(card.type, CreditCardType.Discover)
    }

    func testcreditCardFromStringDiscover2() {
        let card = creditCardFromString(discover2Number)
        XCTAssertEqual(card.type, CreditCardType.Discover)
    }

    func testcreditCardFromStringJCB1() {
        let card = creditCardFromString(jcb1Number)
        XCTAssertEqual(card.type, CreditCardType.JCB)
    }

    func testcreditCardFromStringJCB2() {
        let card = creditCardFromString(jcb2Number)
        XCTAssertEqual(card.type, CreditCardType.JCB)
    }

    func testcreditCardFromStringMasterCard1() {
        let card = creditCardFromString(mastercard1Number)
        XCTAssertEqual(card.type, CreditCardType.MasterCard)
    }

    func testcreditCardFromStringMasterCard2() {
        let card = creditCardFromString(masterCard2Number)
        XCTAssertEqual(card.type, CreditCardType.MasterCard)
    }

    func testcreditCardFromStringVisa1() {
        let card = creditCardFromString(visa1Number)
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testcreditCardFromStringVisa2() {
        let card = creditCardFromString(visa2Number)
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testcreditCardFromStringVisa3() {
        let card = creditCardFromString(visa3Number)
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testIsValidateExpirationDateBadDate() {
        let isValidDate = expirationDateIsValid("aa/bb")
        XCTAssertFalse(isValidDate)
    }

    func testIsValidExpirationDateCurrentMonth() {
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(NSDate())
        let isValidDate = expirationDateIsValid(expirationDateString)
        XCTAssertTrue(isValidDate)
    }

    func testIsValidExpirationDatePreviousMonth() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: -1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let isValidDate = expirationDateIsValid(expirationDateString)
        XCTAssertFalse(isValidDate)
    }

    func testIsCorrectCreditCardNumberLengthBadNumber() {
        let isCorrectLength = creditCardNumberLengthIsCorrect(amex1Number, creditCard: visaCreditCard)
        XCTAssertFalse(isCorrectLength)
    }

    func testIsCorrectCreditCardNumberLength() {
        let isCorrectLength = creditCardNumberLengthIsCorrect(amex1Number, creditCard: amexCreditCard)
        XCTAssertTrue(isCorrectLength)
    }

    func testIsCorrectCVVLengthBadCVV() {
        let isCorrectLength = cvvLengthIsCorrect(amexCVVNumber, creditCard: visaCreditCard)
        XCTAssertFalse(isCorrectLength)
    }

    func testPassesLuhnAlgorithm() {
        let passesLuhn = passesLuhnAlgorithm(amex1Number)
        XCTAssertTrue(passesLuhn)
    }

    func testPassesLuhnAlgorithmBadDigit() {
        let passesLuhn = passesLuhnAlgorithm(amex1BadLuhnNumber)
        XCTAssertFalse(passesLuhn)
    }

    func testPadExpirationDateMonthWith1Slash() {
        let paddedString = padExpirationDateMonth("1/")
        XCTAssertEqual(paddedString, "01/")
    }

    func testPadExpirationDateMonthWith3() {
        let paddedString = padExpirationDateMonth("3")
        XCTAssertEqual(paddedString, "03")
    }

    func testPadExpirationDateMonthWith09() {
        let paddedString = padExpirationDateMonth("09")
        XCTAssertEqual(paddedString, "09")
    }

    func testPadExpirationDateMonthWithQ() {
        let paddedString = padExpirationDateMonth("Q")
        XCTAssertEqual(paddedString, "Q")
    }

    func testExpirationDateFormatIsValid1DigitBad() {
        XCTAssertFalse(expirationDateFormatIsValid(padExpirationDateMonth("A")))
    }

    func testExpirationDateFormatIsValid1DigitBad9() {
        XCTAssertTrue(expirationDateFormatIsValid(padExpirationDateMonth("9")))
    }

    func testExpirationDateFormatIsValid1Digit() {
        XCTAssertTrue(expirationDateFormatIsValid(padExpirationDateMonth("1")))
    }

    func testExpirationDateFormatIsValid2Digit() {
        XCTAssertTrue(expirationDateFormatIsValid(padExpirationDateMonth("12")))
    }

    func testExpirationDateFormatIsValid3Digit() {
        XCTAssertTrue(expirationDateFormatIsValid(padExpirationDateMonth("03/")))
    }

    func testExpirationDateFormatIsValid4Digit() {
        XCTAssertTrue(expirationDateFormatIsValid(padExpirationDateMonth("03/1")))
    }

    func testExpirationDateFormatIsValid5Digit() {
        XCTAssertTrue(expirationDateFormatIsValid(padExpirationDateMonth("03/17")))
    }

    func testExpirationDateFormatIsValid1Digit0() {
        XCTAssertTrue(expirationDateFormatIsValid(padExpirationDateMonth("0")))
    }

    func testNextCreditCardDigitIsValid() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue(nextCreditCardDigitIsValid(card, characterCount: 1, string: "3"))
    }

    func testNextCreditCardDigitIsValidEmptyString() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue(nextCreditCardDigitIsValid(card, characterCount: 1, string: ""))
    }

    func testNextCreditCardDigitIsValidBadDigit() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse(nextCreditCardDigitIsValid(card, characterCount: 1, string: "A"))
    }

    func testNextCreditCardDigitIsValidTooLong() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse(nextCreditCardDigitIsValid(card, characterCount: 16, string: "3"))
    }

    func testNextCreditCardDigitIsValidUnKnownType() {
        let card = UnknownCreditCard(cardNumber: "123456", expirationDate: "03/17", cvv: "")
        XCTAssertFalse(nextCreditCardDigitIsValid(card, characterCount: 7, string: "3"))
    }

    func testNextExpirationDateDigitIsValid() {
        XCTAssertTrue(nextExpirationDateDigitIsValid("", characterCount: 1, string: ""))
    }

    func testNextExpirationDateDigitIsValid3Digits() {
        XCTAssertTrue(nextExpirationDateDigitIsValid("01", characterCount: 3, string: "/"))
    }

    func testNextExpirationDateDigitIsValidTooManyDigits() {
        XCTAssertFalse(nextExpirationDateDigitIsValid("01/18", characterCount: 6, string: "9"))
    }

    func testNextExpirationDateDigitIsValidBadFormat() {
        XCTAssertFalse(nextExpirationDateDigitIsValid("01", characterCount: 3, string: "?"))
    }

    func testNextCVVDigitIsValid() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue(nextCVVDigitIsValid(card, characterCount: 1, string: "3"))
    }

    func testNextCVVDigitIsValidEmptyString() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue(nextCVVDigitIsValid(card, characterCount: 1, string: ""))
    }

    func testNextCVVDigitIsValidBadDigit() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse(nextCVVDigitIsValid(card, characterCount: 1, string: "A"))
    }

    func testNextCVVDigitIsValidTooLong() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse(nextCVVDigitIsValid(card, characterCount: 5, string: "3"))
    }
}
