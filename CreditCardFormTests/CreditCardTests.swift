//
//  CreditCardTests.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import CreditCardForm

class CreditCardTests: XCTestCase {

    let amexNumber = "378282246310005"
    let amexBadLuhnNumber = "378282246310004"
    let dinersNumber = "30569309025904"
    let visaBadNumber = "4222222222223"

    let dateFormatter = NSDateFormatter()

    func testAmexCard() {
        let card = AmexCreditCard.init(cardNumber:amexNumber, expirationDate: "", cvv: "1234")
        XCTAssertEqual(card.logo, "Cards_Amex.png")
        XCTAssertEqual(card.regex, "^3[47][0-9]{4,}$")
        XCTAssertEqual(card.cardNumberLength, 15)
        XCTAssertEqual(card.cvvLength, 4)
        XCTAssertTrue(card.cardNumber.creditCardNumberLengthIsCorrect(card.cardNumberLength))
        XCTAssertTrue(card.cvv.cvvLengthIsCorrect(card.cvvLength))
    }

    func testAmexCardBadNumbers() {
        let card = AmexCreditCard.init(cardNumber:dinersNumber, expirationDate: "", cvv: "123")
        XCTAssertFalse(card.cardNumber.creditCardNumberLengthIsCorrect(card.cardNumberLength))
        XCTAssertFalse(card.cvv.cvvLengthIsCorrect(card.cvvLength))
    }

    func testDinersCard() {
        let card = DinersClubCreditCard.init(cardNumber: "", expirationDate: "", cvv: "")
        XCTAssertEqual(card.logo, "Cards_Dinerclub.png")
        XCTAssertEqual(card.regex, "^3(?:0[0-5]|[68][0-9])[0-9]{3,}$")
        XCTAssertEqual(card.cardNumberLength, 14)
        XCTAssertEqual(card.cvvLength, 3)
    }

    func testDiscoverCard() {
        let card = DiscoverCreditCard.init(cardNumber: "", expirationDate: "", cvv: "")
        XCTAssertEqual(card.logo, "Cards_Discover.png")
        XCTAssertEqual(card.regex, "^6(?:011|5[0-9]{2})[0-9]{2,}$")
        XCTAssertEqual(card.cardNumberLength, 16)
        XCTAssertEqual(card.cvvLength, 3)
    }

    func testJCBCard() {
        let card = JCBCreditCard.init(cardNumber: "", expirationDate: "", cvv: "")
        XCTAssertEqual(card.logo, "Cards_JCB.png")
        XCTAssertEqual(card.regex, "^(?:2131|1800|35[0-9]{3})[0-9]{1,}$")
        XCTAssertEqual(card.cardNumberLength, 16)
        XCTAssertEqual(card.cvvLength, 3)
    }

    func testMasterCard() {
        let card = MasterCardCreditCard.init(cardNumber: "", expirationDate: "", cvv: "")
        XCTAssertEqual(card.logo, "Cards_Mastercard.png")
        XCTAssertEqual(card.regex, "^5[1-5][0-9]{4,}$")
        XCTAssertEqual(card.cardNumberLength, 16)
        XCTAssertEqual(card.cvvLength, 3)
    }

    func testVisaCard() {
        let card = VisaCreditCard.init(cardNumber: "", expirationDate: "", cvv: "")
        XCTAssertEqual(card.logo, "Cards_Visa.png")
        XCTAssertEqual(card.regex, "^4[0-9]{5,}$")
        XCTAssertEqual(card.cardNumberLength, 16)
        XCTAssertEqual(card.cvvLength, 3)
    }

    func testUnknownCard() {
        let card = UnknownCreditCard.init(cardNumber: "", expirationDate: "", cvv: "")
        XCTAssertEqual(card.logo, "Cards_GenericCard.png")
        XCTAssertEqual(card.regex, "^$")
        XCTAssertEqual(card.cardNumberLength, 16)
        XCTAssertEqual(card.cvvLength, 3)
    }

    func testCardExpirationDate() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = AmexCreditCard.init(cardNumber: "", expirationDate: expirationDateString, cvv: "")
        XCTAssertTrue(card.expirationDate.expirationDateIsValid())
    }

    func testCardExpirationDateBadDate() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: -1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = AmexCreditCard.init(cardNumber: "", expirationDate: expirationDateString, cvv: "")
        XCTAssertFalse(card.expirationDate.expirationDateIsValid())
    }

    func testCardNumberLength() {
        let card = AmexCreditCard.init(cardNumber: amexNumber, expirationDate: "01/19", cvv: "")
        XCTAssertTrue(card.cardNumber.creditCardNumberLengthIsCorrect(card.cardNumberLength))
    }

    func testCardNumberLengthBadNumber() {
        let card = AmexCreditCard.init(cardNumber: "37828224631000", expirationDate: "01/19", cvv: "")
        XCTAssertFalse(card.cardNumber.creditCardNumberLengthIsCorrect(card.cardNumberLength))
    }

    func testCardLastDigit() {
        let card = AmexCreditCard.init(cardNumber: amexNumber, expirationDate: "01/19", cvv: "")
        XCTAssertTrue(card.cardNumber.passesLuhnAlgorithm())
    }

    func testCardLastDigitBadDigit() {
        let card = AmexCreditCard.init(cardNumber: amexBadLuhnNumber, expirationDate: "01/19", cvv: "")
        XCTAssertFalse(card.cardNumber.passesLuhnAlgorithm())
    }

    func testCreditCardNumberisValid() {
        let card = AmexCreditCard.init(cardNumber: amexNumber, expirationDate: "01/19", cvv: "")
        XCTAssertTrue(card.creditCardNumberIsValid())
    }

    func testCreditCardNumberisValidBadNumber() {
        let card = AmexCreditCard.init(cardNumber: visaBadNumber, expirationDate: "01/19", cvv: "")
        XCTAssertFalse(card.creditCardNumberIsValid())
    }

    func testCreditCardIsValid() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = AmexCreditCard.init(cardNumber: amexNumber, expirationDate: expirationDateString, cvv: "1234")
        XCTAssertTrue(card.creditCardIsValid())
    }

    func testCreditCardIsNotValidBadCVV() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = AmexCreditCard.init(cardNumber: amexNumber, expirationDate: expirationDateString, cvv: "123")
        XCTAssertFalse(card.creditCardIsValid())
    }
}
