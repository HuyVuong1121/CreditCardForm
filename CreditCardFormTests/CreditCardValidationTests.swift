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
    
    let dateFormatter = NSDateFormatter()

    func testCreditCardTypeFromStringEmptyNumber() {
        let cardType = creditCardTypeFromString(emptyNumber)
        XCTAssertEqual(cardType, CreditCardType.Unknown)
    }
    
    func testCreditCardTypeFromStringShortNumber() {
        let cardType = creditCardTypeFromString(shortNumber)
        XCTAssertEqual(cardType, CreditCardType.Unknown)
    }
    
    func testCreditCardTypeFromStringRandomNumber() {
        let cardType = creditCardTypeFromString(randomNumber)
        XCTAssertEqual(cardType, CreditCardType.Unknown)
    }
    
    func testCreditCardTypeFromStringAmex1() {
        let cardType = creditCardTypeFromString(amex1Number)
        XCTAssertEqual(cardType, CreditCardType.Amex)
    }
    
    func testCreditCardTypeFromStringAmex2() {
        let cardType = creditCardTypeFromString(amex2Number)
        XCTAssertEqual(cardType, CreditCardType.Amex)
    }
    
    func testCreditCardTypeFromStringDiners1() {
        let cardType = creditCardTypeFromString(diners1Number)
        XCTAssertEqual(cardType, CreditCardType.DinersClub)
    }
    
    func testCreditCardTypeFromStringDiners2() {
        let cardType = creditCardTypeFromString(diners2Number)
        XCTAssertEqual(cardType, CreditCardType.DinersClub)
    }
    
    func testCreditCardTypeFromStringDiscover1() {
        let cardType = creditCardTypeFromString(discover1Number)
        XCTAssertEqual(cardType, CreditCardType.Discover)
    }
    
    func testCreditCardTypeFromStringDiscover2() {
        let cardType = creditCardTypeFromString(discover2Number)
        XCTAssertEqual(cardType, CreditCardType.Discover)
    }
    
    func testCreditCardTypeFromStringJCB1() {
        let cardType = creditCardTypeFromString(jcb1Number)
        XCTAssertEqual(cardType, CreditCardType.JCB)
    }
    
    func testCreditCardTypeFromStringJCB2() {
        let cardType = creditCardTypeFromString(jcb2Number)
        XCTAssertEqual(cardType, CreditCardType.JCB)
    }
    
    func testCreditCardTypeFromStringMasterCard1() {
        let cardType = creditCardTypeFromString(mastercard1Number)
        XCTAssertEqual(cardType, CreditCardType.MasterCard)
    }
    
    func testCreditCardTypeFromStringMasterCard2() {
        let cardType = creditCardTypeFromString(masterCard2Number)
        XCTAssertEqual(cardType, CreditCardType.MasterCard)
    }
    
    func testCreditCardTypeFromStringVisa1() {
        let cardType = creditCardTypeFromString(visa1Number)
        XCTAssertEqual(cardType, CreditCardType.Visa)
    }
    
    func testCreditCardTypeFromStringVisa2() {
        let cardType = creditCardTypeFromString(visa2Number)
        XCTAssertEqual(cardType, CreditCardType.Visa)
    }
    
    func testCreditCardTypeFromStringVisa3() {
        let cardType = creditCardTypeFromString(visa3Number)
        XCTAssertEqual(cardType, CreditCardType.Visa)
    }
    
    func testIsValidateExpirationDateBadDate() {
        let isValidDate = isValidExpirationDate("aa/bb")
        XCTAssertFalse(isValidDate)
    }
    
    func testIsValidExpirationDateCurrentMonth() {
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(NSDate())
        let isValidDate = isValidExpirationDate(expirationDateString)
        XCTAssertTrue(isValidDate)
    }
    
    func testIsValidExpirationDatePreviousMonth() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: -1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let isValidDate = isValidExpirationDate(expirationDateString)
        XCTAssertFalse(isValidDate)
    }
    
    func testIsCorrectCreditCardNumberLengthBadNumber() {
        let isCorrectLength = isCorrectCreditCardNumberLength(amex1Number, creditCardType: .Discover)
        XCTAssertFalse(isCorrectLength)
    }
    
    func testIsCorrectCreditCardNumberLength() {
        let isCorrectLength = isCorrectCreditCardNumberLength(amex1Number, creditCardType: .Amex)
        XCTAssertTrue(isCorrectLength)
    }
    
    func testIsCorrectCVVLengthBadCVV() {
        let isCorrectLength = isCorrectCVVLength(amexCVVNumber, creditCardType: .Discover)
        XCTAssertFalse(isCorrectLength)
    }
    
    func testPassesLuhnAlgorithm() {
        let passesLuhn = passesLuhnAlgorithm(visa3Number)
        XCTAssertTrue(passesLuhn)
    }
    
    func testPassesLuhnAlgorithmBadDigit() {
        let passesLuhn = passesLuhnAlgorithm(visa3BadLuhnNumber)
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
}
