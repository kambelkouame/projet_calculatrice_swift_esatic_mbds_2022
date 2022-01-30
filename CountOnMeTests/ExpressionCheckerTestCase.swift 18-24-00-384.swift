//
//  ExpressionCheckerTestCase.swift
//  CountOnMeTest
//
//  Created by Adam Mokhtar on 03/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

//class ExpressionCheckerTestCase: XCTestCase {
//
//  //----------------------------------------------------------------------------
//  // MARK: - Properties
//  //----------------------------------------------------------------------------
//
//  var signs = ["+","-"]
//
//  let elements = ["+", "1"]
//
//  let threeElements = ["","",""]
//
//  //----------------------------------------------------------------------------
//  // MARK: - Test
//  //----------------------------------------------------------------------------
//
  func testGivenSigns_WhenTheLastElementsIsSigns_ThenTestReturnFalse() {

    XCTAssert(ExpressionChecker.expressionIsCorrect(elements: signs)
      == false)
  }

  func testGivenElements_WhenTheLastElementsIsnotSigns_ThenTestReturnTrue() {

    XCTAssert(ExpressionChecker.expressionIsCorrect(elements: elements)
      == true)
  }

  func testGivenElements_WhenTwoElements_ThenTestReturnFalse() {

    XCTAssert(ExpressionChecker.expressionHaveEnoughElement(elements: elements)
        == false)
  }

  func testGivenElements_WhenThreeElements_ThenTestReturnTrue() {

    XCTAssert(ExpressionChecker.expressionHaveEnoughElement(elements: threeElements) == true)
  }

  func testGivenString_WhenContainsEqual_ThenTestReturnTrue() {

    XCTAssert(ExpressionChecker.expressionHaveResult(textView: "1 + 1 = 2"))
  }

  func testGivenString_WhenContainsEqual_ThenTestReturnFalse() {

    XCTAssert(ExpressionChecker.expressionHaveResult(textView: "1 + 1 ")
      == false)
  }

  func testGivenElement_WhenNil_ThenReturnTrue() {

    XCTAssert(ExpressionChecker.dontAddSign(textView: "") == true)

  }
//  
//  
//
//}
