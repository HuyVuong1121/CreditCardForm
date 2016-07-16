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
        let card = CreditCard.init(cardNumber:amexNumber, expirationDate: "", cvv: "1234", type: .Amex)
        XCTAssertEqual(card.type.logo, "Cards_Amex.png")
        XCTAssertEqual(card.type.regex, "^3[47][0-9]{4,}$")
        XCTAssertEqual(card.type.cardNumberLength, 15)
        XCTAssertEqual(card.type.cvvLength, 4)
        XCTAssertTrue(card.creditCardNumberLengthIsValid())
        XCTAssertTrue(card.cvvNumberLengthIsValid())
    }
    
    func testAmexCardBadNumbers() {
        let card = CreditCard.init(cardNumber:dinersNumber, expirationDate: "", cvv: "123", type: .Amex)
        XCTAssertFalse(card.creditCardNumberLengthIsValid())
        XCTAssertFalse(card.cvvNumberLengthIsValid())
    }
    
    func testDinersCard() {
        let card = CreditCard.init(cardNumber: "", expirationDate: "", cvv: "", type: .DinersClub)
        XCTAssertEqual(card.type.logo, "Cards_Dinerclub.png")
        XCTAssertEqual(card.type.regex, "^3(?:0[0-5]|[68][0-9])[0-9]{3,}$")
        XCTAssertEqual(card.type.cardNumberLength, 14)
        XCTAssertEqual(card.type.cvvLength, 3)
    }
    
    func testDiscoverCard() {
        let card = CreditCard.init(cardNumber: "", expirationDate: "", cvv: "", type: .Discover)
        XCTAssertEqual(card.type.logo, "Cards_Discover.png")
        XCTAssertEqual(card.type.regex, "^6(?:011|5[0-9]{2})[0-9]{2,}$")
        XCTAssertEqual(card.type.cardNumberLength, 16)
        XCTAssertEqual(card.type.cvvLength, 3)
    }
    
    func testJCBCard() {
        let card = CreditCard.init(cardNumber: "", expirationDate: "", cvv: "", type: .JCB)
        XCTAssertEqual(card.type.logo, "Cards_JCB.png")
        XCTAssertEqual(card.type.regex, "^(?:2131|1800|35[0-9]{3})[0-9]{1,}$")
        XCTAssertEqual(card.type.cardNumberLength, 16)
        XCTAssertEqual(card.type.cvvLength, 3)
    }
    
    func testMasterCard() {
        let card = CreditCard.init(cardNumber: "", expirationDate: "", cvv: "", type: .MasterCard)
        XCTAssertEqual(card.type.logo, "Cards_Mastercard.png")
        XCTAssertEqual(card.type.regex, "^5[1-5][0-9]{4,}$")
        XCTAssertEqual(card.type.cardNumberLength, 16)
        XCTAssertEqual(card.type.cvvLength, 3)
    }
    
    func testVisaCard() {
        let card = CreditCard.init(cardNumber: "", expirationDate: "", cvv: "", type: .Visa)
        XCTAssertEqual(card.type.logo, "Cards_Visa.png")
        XCTAssertEqual(card.type.regex, "^4[0-9]{5,}$")
        XCTAssertEqual(card.type.cardNumberLength, 16)
        XCTAssertEqual(card.type.cvvLength, 3)
    }
    
    func testUnknownCard() {
        let card = CreditCard.init(cardNumber: "", expirationDate: "", cvv: "", type: .Unknown)
        XCTAssertEqual(card.type.logo, "Cards_Blank.png")
        XCTAssertEqual(card.type.regex, "^$")
        XCTAssertEqual(card.type.cardNumberLength, 16)
        XCTAssertEqual(card.type.cvvLength, 3)
    }
    
    func testCardExpirationDate() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = CreditCard.init(cardNumber: "", expirationDate: expirationDateString, cvv: "", type: .Amex)
        XCTAssertTrue(card.expirationDateIsValid())
    }
    
    func testCardExpirationDateBadDate() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: -1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = CreditCard.init(cardNumber: "", expirationDate: expirationDateString, cvv: "", type: .Amex)
        XCTAssertFalse(card.expirationDateIsValid())
    }
    
    func testCardNumberLength() {
        let card = CreditCard.init(cardNumber: amexNumber, expirationDate: "01/19", cvv: "", type: .Amex)
        XCTAssertTrue(card.creditCardNumberLengthIsValid())
    }
    
    func testCardNumberLengthBadNumber() {
        let card = CreditCard.init(cardNumber: "37828224631000", expirationDate: "01/19", cvv: "", type: .Amex)
        XCTAssertFalse(card.creditCardNumberLengthIsValid())
    }
    
    func testCardLastDigit() {
        let card = CreditCard.init(cardNumber: amexNumber, expirationDate: "01/19", cvv: "", type: .Amex)
        XCTAssertTrue(card.lastDigitIsValid())
    }
    
    func testCardLastDigitBadDigit() {
        let card = CreditCard.init(cardNumber: amexBadLuhnNumber, expirationDate: "01/19", cvv: "", type: .Amex)
        XCTAssertFalse(card.lastDigitIsValid())
    }
    
    func testCreditCardNumberisValid() {
        let card = CreditCard.init(cardNumber: amexNumber, expirationDate: "01/19", cvv: "", type: .Amex)
        XCTAssertTrue(card.creditCardNumberIsValid())
    }
    
    func testCreditCardNumberisValidBadNumber() {
        let card = CreditCard.init(cardNumber: visaBadNumber, expirationDate: "01/19", cvv: "", type: .Amex)
        XCTAssertFalse(card.creditCardNumberIsValid())
    }
    
    func testCardIsValid() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = CreditCard.init(cardNumber: amexNumber, expirationDate: expirationDateString, cvv: "1234", type: .Amex)
        XCTAssertTrue(card.creditCardIsValid())
    }
    
    func testCardIsNotValidBadCVV() {
        let expirationDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: NSDate(), options:[])
        dateFormatter.dateFormat = "MM/yy"
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        let card = CreditCard.init(cardNumber: amexNumber, expirationDate: expirationDateString, cvv: "123", type: .Amex)
        XCTAssertFalse(card.creditCardIsValid())
    }
}
