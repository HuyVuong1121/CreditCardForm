//
//  CreditCardControllerTests.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 8/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import CreditCardForm

class CreditCardControllerTests: XCTestCase {

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

    func testcreditCardFromStringEmptyNumber() {
        let card = CreditCardController.sharedInstance.creditCardFromString(emptyNumber)
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringShortNumber() {
        let card = CreditCardController.sharedInstance.creditCardFromString(shortNumber)
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringRandomNumber() {
        let card = CreditCardController.sharedInstance.creditCardFromString(randomNumber)
        XCTAssertEqual(card.type, CreditCardType.Unknown)
    }

    func testcreditCardFromStringAmex1() {
        let card = CreditCardController.sharedInstance.creditCardFromString(amex1Number)
        XCTAssertEqual(card.type, CreditCardType.Amex)
    }

    func testcreditCardFromStringAmex2() {
        let card = CreditCardController.sharedInstance.creditCardFromString(amex2Number)
        XCTAssertEqual(card.type, CreditCardType.Amex)
    }

    func testcreditCardFromStringDiners1() {
        let card = CreditCardController.sharedInstance.creditCardFromString(diners1Number)
        XCTAssertEqual(card.type, CreditCardType.DinersClub)
    }

    func testcreditCardFromStringDiners2() {
        let card = CreditCardController.sharedInstance.creditCardFromString(diners2Number)
        XCTAssertEqual(card.type, CreditCardType.DinersClub)
    }

    func testcreditCardFromStringDiscover1() {
        let card = CreditCardController.sharedInstance.creditCardFromString(discover1Number)
        XCTAssertEqual(card.type, CreditCardType.Discover)
    }

    func testcreditCardFromStringDiscover2() {
        let card = CreditCardController.sharedInstance.creditCardFromString(discover2Number)
        XCTAssertEqual(card.type, CreditCardType.Discover)
    }

    func testcreditCardFromStringJCB1() {
        let card = CreditCardController.sharedInstance.creditCardFromString(jcb1Number)
        XCTAssertEqual(card.type, CreditCardType.JCB)
    }

    func testcreditCardFromStringJCB2() {
        let card = CreditCardController.sharedInstance.creditCardFromString(jcb2Number)
        XCTAssertEqual(card.type, CreditCardType.JCB)
    }

    func testcreditCardFromStringMasterCard1() {
        let card = CreditCardController.sharedInstance.creditCardFromString(mastercard1Number)
        XCTAssertEqual(card.type, CreditCardType.MasterCard)
    }

    func testcreditCardFromStringMasterCard2() {
        let card = CreditCardController.sharedInstance.creditCardFromString(masterCard2Number)
        XCTAssertEqual(card.type, CreditCardType.MasterCard)
    }

    func testcreditCardFromStringVisa1() {
        let card = CreditCardController.sharedInstance.creditCardFromString(visa1Number)
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testcreditCardFromStringVisa2() {
        let card = CreditCardController.sharedInstance.creditCardFromString(visa2Number)
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

    func testcreditCardFromStringVisa3() {
        let card = CreditCardController.sharedInstance.creditCardFromString(visa3Number)
        XCTAssertEqual(card.type, CreditCardType.Visa)
    }

}
