//
//  CreditCardEvaluatorTests.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/22/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
import UIKit
@testable import CreditCardForm

class CreditCardEvaluatorTests: XCTestCase, CreditCardEvaluator {
    var vc: ViewController!
    var creditCard: CreditCard!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let nc: UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        vc = nc.topViewController as! ViewController
        creditCard = vc.creditCard
    }
    
    func testEvaluateCardNumberInvalidCard() {
        let _ = vc.view
        creditCard.type = .Unknown
        _ = evaluateCardNumber("", creditCard: vc.creditCard, cardImageView: vc.cardImageView, cardNumberCheckMark: vc.cardNumberCheckMark, cardNumberCheckMarkView: vc.cardNumberCheckMarkView)
        XCTAssertTrue(vc.cardNumberCheckMark.hidden)
        XCTAssertFalse(vc.cardNumberCheckMarkView.hidden)
    }
    
    func testEvaluateCardNumberValidCard() {
        let _ = vc.view
        creditCard.type = .Visa
        _ = evaluateCardNumber("4111111111111111", creditCard: creditCard, cardImageView: vc.cardImageView, cardNumberCheckMark: vc.cardNumberCheckMark, cardNumberCheckMarkView: vc.cardNumberCheckMarkView)
        XCTAssertFalse(vc.cardNumberCheckMark.hidden)
        XCTAssertTrue(vc.cardNumberCheckMarkView.hidden)
    }
    
    func testEvaluateExpiredDatePadDate() {
        let _ = vc.view
        let testCard = evaluateExpiredDate("2", creditCard: creditCard, expirationDateTextField: vc.expirationDateTextField, expirationDateCheckMark: vc.expirationDateCheckMark, expirationDateCheckMarkView: vc.expirationDateCheckMarkView)
        XCTAssertEqual(testCard.expirationDate, "02")
        XCTAssertEqual(vc.expirationDateTextField.text, "02")
        XCTAssertTrue(vc.cardNumberCheckMark.hidden)
        XCTAssertFalse(vc.cardNumberCheckMarkView.hidden)
    }
    
    func testEvaluateExpiredDateInvalidDate() {
        let _ = vc.view
        _ = evaluateExpiredDate("02/", creditCard: creditCard, expirationDateTextField: vc.expirationDateTextField, expirationDateCheckMark: vc.expirationDateCheckMark, expirationDateCheckMarkView: vc.expirationDateCheckMarkView)
        XCTAssertTrue(vc.cardNumberCheckMark.hidden)
        XCTAssertFalse(vc.cardNumberCheckMarkView.hidden)
    }
    
    func testEvaluateExpiredDateValidDate() {
        let _ = vc.view
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        let calendar = NSCalendar.currentCalendar()
        let expirationDate = calendar.dateByAddingUnit(NSCalendarUnit.Year, value: 1, toDate: NSDate(), options: [])
        let expirationDateString = dateFormatter.stringFromDate(expirationDate!)
        _ = evaluateExpiredDate(expirationDateString, creditCard: creditCard, expirationDateTextField: vc.expirationDateTextField, expirationDateCheckMark: vc.expirationDateCheckMark, expirationDateCheckMarkView: vc.expirationDateCheckMarkView)
        XCTAssertTrue(vc.cardNumberCheckMark.hidden)
        XCTAssertFalse(vc.cardNumberCheckMarkView.hidden)
    }
    
    func testEvaluateCVVCheckPlaceholderWithAmex() {
        let _ = vc.view
        creditCard.type = .Amex
        _ = evaluateCVV("123", creditCard: creditCard, cvvTextField: vc.cvvTextField, cvvCheckMark: vc.cvvCheckMark, cvvCheckMarkView: vc.cvvCheckMarkView)
        XCTAssertEqual(vc.cvvTextField.placeholder, "1234")
    }
    
    func testEvaluateCVVCheckPlaceholderWithNonAmex() {
        let _ = vc.view
        creditCard.type = .Visa
        _ = evaluateCVV("123", creditCard: creditCard, cvvTextField: vc.cvvTextField, cvvCheckMark: vc.cvvCheckMark, cvvCheckMarkView: vc.cvvCheckMarkView)
        XCTAssertEqual(vc.cvvTextField.placeholder, "123")
    }
    
    func testEvaluateCVVCheckCVVLengthWithAmexBadLength() {
        let _ = vc.view
        creditCard.type = .Amex
        _ = evaluateCVV("123", creditCard: creditCard, cvvTextField: vc.cvvTextField, cvvCheckMark: vc.cvvCheckMark, cvvCheckMarkView: vc.cvvCheckMarkView)
        XCTAssertTrue(vc.cvvCheckMark.hidden)
        XCTAssertFalse(vc.cvvCheckMarkView.hidden)
    }
    
    func testEvaluateCVVCheckCVVLengthWithAmex() {
        let _ = vc.view
        creditCard.type = .Amex
        _ = evaluateCVV("1234", creditCard: creditCard, cvvTextField: vc.cvvTextField, cvvCheckMark: vc.cvvCheckMark, cvvCheckMarkView: vc.cvvCheckMarkView)
        XCTAssertFalse(vc.cvvCheckMark.hidden)
        XCTAssertTrue(vc.cvvCheckMarkView.hidden)
    }

}
