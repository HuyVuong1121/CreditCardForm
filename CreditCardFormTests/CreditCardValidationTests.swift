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

    override func setUp() {
        super.setUp()
    }

    func testCreditCardTypeFromStringEmptyNumber() {
        let cardNumber = emptyNumber
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Unknown)
    }
    
    func testCreditCardTypeFromStringRandomNumber() {
        let cardNumber = randomNumber
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Unknown)
    }
    
    func testCreditCardTypeFromStringAmex1() {
        let cardNumber = amex1Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Amex)
    }
    
    func testCreditCardTypeFromStringAmex2() {
        let cardNumber = amex2Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Amex)
    }
    
    func testCreditCardTypeFromStringDiners1() {
        let cardNumber = diners1Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.DinersClub)
    }
    
    func testCreditCardTypeFromStringDiners2() {
        let cardNumber = diners2Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.DinersClub)
    }
    
    func testCreditCardTypeFromStringDiscover1() {
        let cardNumber = discover1Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Discover)
    }
    
    func testCreditCardTypeFromStringDiscover2() {
        let cardNumber = discover2Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Discover)
    }
    
    func testCreditCardTypeFromStringJCB1() {
        let cardNumber = jcb1Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.JCB)
    }
    
    func testCreditCardTypeFromStringJCB2() {
        let cardNumber = jcb2Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.JCB)
    }
    
    func testCreditCardTypeFromStringMasterCard1() {
        let cardNumber = mastercard1Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.MasterCard)
    }
    
    func testCreditCardTypeFromStringMasterCard2() {
        let cardNumber = masterCard2Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.MasterCard)
    }
    
    func testCreditCardTypeFromStringVisa1() {
        let cardNumber = visa1Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Visa)
    }
    
    func testCreditCardTypeFromStringVisa2() {
        let cardNumber = visa2Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Visa)
    }
    
    func testCreditCardTypeFromStringVisa3() {
        let cardNumber = visa3Number
        let cardType = creditCardTypeFromString(cardNumber)
        XCTAssertEqual(cardType, CreditCardType.Visa)
    }

}
