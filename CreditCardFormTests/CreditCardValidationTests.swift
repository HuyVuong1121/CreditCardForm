//
//  CreditCardValidationTests.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import CreditCardForm

class CreditCardValidationTests: XCTestCase {

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
        let card = emptyNumber.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringShortNumber() {
        let card = shortNumber.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringRandomNumber() {
        let card = randomNumber.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringAmex1() {
        let card = amex1Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Amex)
    }

    func testcreditCardFromStringAmex2() {
        let card = amex2Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Amex)
    }

    func testcreditCardFromStringDiners1() {
        let card = diners1Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.DinersClub)
    }

    func testcreditCardFromStringDiners2() {
        let card = diners2Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.DinersClub)
    }

    func testcreditCardFromStringDiscover1() {
        let card = discover1Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Discover)
    }

    func testcreditCardFromStringDiscover2() {
        let card = discover2Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Discover)
    }

    func testcreditCardFromStringJCB1() {
        let card = jcb1Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.JCB)
    }

    func testcreditCardFromStringJCB2() {
        let card = jcb2Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.JCB)
    }

    func testcreditCardFromStringMasterCard1() {
        let card = mastercard1Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.MasterCard)
    }

    func testcreditCardFromStringMasterCard2() {
        let card = masterCard2Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.MasterCard)
    }

    func testcreditCardFromStringVisa1() {
        let card = visa1Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testcreditCardFromStringVisa2() {
        let card = visa2Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testcreditCardFromStringVisa3() {
        let card = visa3Number.creditCardFromString()
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testIsValidateExpirationDateBadDate() {
        let isValidDate = "aa/bb".expirationDateIsValid()
        XCTAssertFalse(isValidDate)
    }

    func testIsValidExpirationDateCurrentMonth() {
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(NSDate())
        let isValidDate = expirationDateString.expirationDateIsValid()
        XCTAssertTrue(isValidDate)
    }

    func testIsValidExpirationDatePreviousMonth() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: -1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let isValidDate = expirationDateString.expirationDateIsValid()
        XCTAssertFalse(isValidDate)
    }

    func testIsCorrectCreditCardNumberLengthBadNumber() {
        let isCorrectLength = amex1Number.creditCardNumberLengthIsCorrect(visaCreditCard.cardNumberLength)
        XCTAssertFalse(isCorrectLength)
    }

    func testIsCorrectCreditCardNumberLength() {
        let isCorrectLength = amex1Number.creditCardNumberLengthIsCorrect(amexCreditCard.cardNumberLength)
        XCTAssertTrue(isCorrectLength)
    }

    func testIsCorrectCVVLengthBadCVV() {
        let isCorrectLength = amexCVVNumber.cvvLengthIsCorrect(visaCreditCard.cvvLength)
        XCTAssertFalse(isCorrectLength)
    }

    func testPassesLuhnAlgorithm() {
        let passesLuhn = amex1Number.passesLuhnAlgorithm()
        XCTAssertTrue(passesLuhn)
    }

    func testPassesLuhnAlgorithmBadDigit() {
        let passesLuhn = amex1BadLuhnNumber.passesLuhnAlgorithm()
        XCTAssertFalse(passesLuhn)
    }

    func testPadExpirationDateMonthWith1Slash() {
        let paddedString = "1/".padExpirationDateMonth()
        XCTAssertEqual(paddedString, "01/")
    }

    func testPadExpirationDateMonthWith3() {
        let paddedString = "3".padExpirationDateMonth()
        XCTAssertEqual(paddedString, "03")
    }

    func testPadExpirationDateMonthWith09() {
        let paddedString = "09".padExpirationDateMonth()
        XCTAssertEqual(paddedString, "09")
    }

    func testPadExpirationDateMonthWithQ() {
        let paddedString = "Q".padExpirationDateMonth()
        XCTAssertEqual(paddedString, "Q")
    }

    func testExpirationDateFormatIsValid1DigitBad() {
        XCTAssertFalse("A".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testExpirationDateFormatIsValid1DigitBad9() {
        XCTAssertTrue("9".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testExpirationDateFormatIsValid1Digit() {
        XCTAssertTrue("1".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testExpirationDateFormatIsValid2Digit() {
        XCTAssertTrue("12".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testExpirationDateFormatIsValid3Digit() {
        XCTAssertTrue("03/".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testExpirationDateFormatIsValid4Digit() {
        XCTAssertTrue("03/1".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testExpirationDateFormatIsValid5Digit() {
        XCTAssertTrue("03/17".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testExpirationDateFormatIsValid1Digit0() {
        XCTAssertTrue("0".padExpirationDateMonth().expirationDateFormatIsValid())
    }

    func testNextCreditCardDigitIsValid() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue("3".nextCreditCardDigitIsValid(card.type, cardNumberLength:card.cardNumberLength, characterCount: 1))
    }

    func testNextCreditCardDigitIsValidEmptyString() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue("".nextCreditCardDigitIsValid(card.type, cardNumberLength:card.cardNumberLength, characterCount: 1))
    }

    func testNextCreditCardDigitIsValidBadDigit() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse("A".nextCreditCardDigitIsValid(card.type, cardNumberLength:card.cardNumberLength, characterCount: 1))
    }

    func testNextCreditCardDigitIsValidTooLong() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse("3".nextCreditCardDigitIsValid(card.type, cardNumberLength:card.cardNumberLength, characterCount: 16))
    }

    func testNextCreditCardDigitIsValidUnKnownType() {
        let card = UnknownCreditCard(cardNumber: "123456", expirationDate: "03/17", cvv: "")
        XCTAssertFalse("3".nextCreditCardDigitIsValid(card.type, cardNumberLength:card.cardNumberLength, characterCount: 7))
    }

    func testNextExpirationDateDigitIsValid() {
        XCTAssertTrue("".nextExpirationDateDigitIsValid("", characterCount: 1))
    }

    func testNextExpirationDateDigitIsValid3Digits() {
        XCTAssertTrue("/".nextExpirationDateDigitIsValid("01", characterCount: 3))
    }

    func testNextExpirationDateDigitIsValidTooManyDigits() {
        XCTAssertFalse("9".nextExpirationDateDigitIsValid("01/18", characterCount: 6))
    }

    func testNextExpirationDateDigitIsValidBadFormat() {
        XCTAssertFalse("?".nextExpirationDateDigitIsValid("01", characterCount: 3))
    }

    func testNextCVVDigitIsValid() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue("3".nextCVVDigitIsValid(card.cvvLength, characterCount: 1))
    }

    func testNextCVVDigitIsValidEmptyString() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertTrue("".nextCVVDigitIsValid(card.cvvLength, characterCount: 1))
    }

    func testNextCVVDigitIsValidBadDigit() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse("A".nextCVVDigitIsValid(card.cvvLength, characterCount: 1))
    }

    func testNextCVVDigitIsValidTooLong() {
        let card = AmexCreditCard(cardNumber: "", expirationDate: "03/17", cvv: "")
        XCTAssertFalse("3".nextCVVDigitIsValid(card.cvvLength, characterCount: 5))
    }
}
