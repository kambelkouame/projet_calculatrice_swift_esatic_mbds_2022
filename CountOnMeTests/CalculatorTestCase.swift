//
//  CalculatorTestCase.swift
//  CountOnMeTest
//
//  Created by user213395 on 1/24/22.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

//==============================================================================
// MARK: - Mock
//==============================================================================

class CalculatorTestMockedDelegate: CalculatorDelegate {
  
  var didComputeResult: String?
  var didFailResult = false
  var didExpressionErrorDisplayResult = false
  var didEqualErrorDisplayResult = false
  
  func didEqualErrorDisplay() {
    didEqualErrorDisplayResult = true
  }
  
  func didExpressionErrorDisplay() {
    didExpressionErrorDisplayResult = true
  }
  
  func didAddOperatorFail() {
    didFailResult = true
  }
  
  func didCompute(textModel: String) {
    didComputeResult = textModel
  }
  
}

//==============================================================================
// MARK: - Tests
//==============================================================================

class CalculatorTestCase: XCTestCase {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var calculator = Calculator()
  
  var signs = ["+","-"]
  
  let additionTest = ["1"]
  
  let threeElements = ["","",""]
  
  //----------------------------------------------------------------------------
  // MARK: - Set up
  //----------------------------------------------------------------------------
  
  override func setUp() {
    calculator = Calculator()
  }
  
  override func tearDown() {
    calculator = Calculator()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Test Checkers
  //----------------------------------------------------------------------------
  
  /******************* Elements *******************/
  
  func testGivenName_WhenElements_ThenArrayOfTheString() {
    calculator.textModel.append("Salut")
    calculator.textModel.append(" Bonjour")
    XCTAssert(calculator.elements == ["Salut", "Bonjour"])
  }
  
  /******************* Checker Sign *******************/
  
  func testGivenExpression_WhenOtherCheckIsOk_ThenICanAddTheSign() {
    calculator.textModel = "1"
    calculator.checkerSigns(sign: "/")
    XCTAssert(calculator.textModel == "1/")
  }
  
  func testGivenExpression_WhenComputeHasAlreadyBeenDone_ThenTheTextModelIsClear() {
    calculator.textModel = "1+1=0"
    calculator.checkerSigns(sign: "-")
    XCTAssert(calculator.textModel == "-")
  }
  
  func testGivenExpression_WhenTheLastElementIsSign_ThenDisplayError() {
    let calculatorMockedDelegate = CalculatorTestMockedDelegate()
    calculator.delegate = calculatorMockedDelegate
    
    calculator.textModel = "1 "
    calculator.checkerSigns(sign: "+")
    calculator.checkerSigns(sign: "+")
    
    XCTAssertTrue(calculatorMockedDelegate.didFailResult)
    
  }
  
  /******************* Expression Is correct *******************/
  
  func testGivenSigns_WhenTheLastElementsIsSigns_ThenTestReturnFalse() {
    
    XCTAssert(calculator.expressionIsCorrect(elements: signs)
      == false)
  }
  
  func testGivenElements_WhenTheLastElementsIsnotSigns_ThenTestReturnTrue() {
    
    XCTAssert(calculator.expressionIsCorrect(elements: additionTest)
      == true)
  }
  
  /******************* Expression have enough element *******************/
  
  func testGivenElements_WhenTwoElements_ThenTestReturnFalse() {
    
    XCTAssert(calculator.expressionHaveEnoughElement(elements: additionTest)
      == false)
  }
  
  func testGivenElements_WhenThreeElements_ThenTestReturnTrue() {
    
    XCTAssert(calculator.expressionHaveEnoughElement(elements: threeElements) == true)
  }
  
  /******************* Expression have result *******************/
  
  func testGivenString_WhenContainsEqual_ThenTestReturnTrue() {
    
    XCTAssert(calculator.expressionHaveResult(textModel: "1 + 1 = 2"))
  }
  
  func testGivenString_WhenContainsEqual_ThenTestReturnFalse() {
    
    XCTAssert(calculator.expressionHaveResult(textModel: "1 + 1 ")
      == false)
  }
  
  /******************* Don't add sign *******************/
  
  func testGivenElement_WhenNil_ThenReturnTrue() {
    
    XCTAssert(calculator.dontAddSign(textModel: "") == true)
    
  }
  //----------------------------------------------------------------------------
  // MARK: - Test Compute
  //----------------------------------------------------------------------------
  
  /******************* Add Number *******************/
  
  func testGivenExpressionNil_WhenUseFuncAddNumber_ThenNumberIsAdded() {
    calculator.textModel = ""
    calculator.addNumber(number: "1")
    XCTAssert(calculator.textModel == "1")
    
  }
  
  func testGivenExpression_WhenUseFuncAddNumber_ThenExpressionIsClearAndNumberAdded() {
    calculator.textModel = "1+1=2"
    calculator.addNumber(number: "1")
    XCTAssert(calculator.textModel == "1")
  }
  
  /******************** Add comma zero ********************/
  
  func testGivenNumber_WhenUseFuncAddCommaZero_ThenNumberWithZero() {
    
    XCTAssert(calculator.addCommaZero(item: "5") == "5.0")
  }
  
  func testGivenSign_WhenUseFunAddCommaZero_ThenReturnNil() {
    
    XCTAssert(calculator.addCommaZero(item: "/") == "/ ")
  }
  /******************** Compute test ********************/
  
  func testGivenSum_WhenCompute_ThenResultIsTwo() {
    
    let expression = "1 + 1"
    
    XCTAssert(calculator.compute(elements: expression) == "2.0")
  }
  
  func testGivenSubstraction_WhenCompute_ThenResultIsZero() {
    
    let expression = "1 - 1"
    
    XCTAssert(calculator.compute(elements: expression) == "0.0")
  }
  
  func testGivenMultiplication_WhenCompute_ThenResultIsTen() {
    
    let expression = "2 * 2"
    
    XCTAssert(calculator.compute(elements: expression) == "4.0")
  }
  
  func testGivenDivision_WhenCompute_ThenResultIsTen() {
    
    let expression = "5 / 2"
    
    XCTAssert(calculator.compute(elements: expression) == "2.5")
  }
func testGivenDivision1_WhenCompute_ThenResultIsTen() {
  
  let expression = "5 / 0"
  
  XCTAssert(calculator.compute(elements: expression) == "Erreur")
}
  
  func testGivenExpressionNegative_WhenCompute_ThenResultIsMinusTen() {
    
    let expression = "- 5 - 5"
    
    XCTAssert(calculator.compute(elements: expression) == "-10.0")
  }
  
  func testGivenExpression_WhenCompute_ThenResultIsTen() {
    
    let expression = "5 + 5 * 2 - 10 / 2"
    
    XCTAssert(calculator.compute(elements: expression) == "10.0")
  }
  
  /******************* Addition *******************/
  
  func testGivenExpression_WhenUseFuncAdder_ThenAddTheSign() {
    calculator.textModel = "1"
    calculator.adder()
    XCTAssert(calculator.textModel == "1 + ")
  }

  func testGivenExpressionNil_WhenUseAdder_ThenDontAddSign() {
    calculator.textModel = ""
    calculator.adder()
    XCTAssert(calculator.textModel == "")
  }
  
  /******************* Substraction *******************/
  
  func testGivenExpression_WhenUseFuncSubstraction_ThenAddTheSign() {
    calculator.textModel = ""
    calculator.subtract()
    XCTAssert(calculator.textModel == " - ")
  }
  
  /******************* Divide *******************/
  
  func testGivenExpression_WhenUseDivide_ThenAddTheSign() {
    calculator.textModel = "1"
    calculator.divide()
    XCTAssert(calculator.textModel == "1 / ")
  }
  
  func testGivenExpressionNil_WhenUseDivide_ThenDontAddSign() {
    calculator.textModel = ""
    calculator.divide()
    XCTAssert(calculator.textModel == "")
  }
  
  /******************* Multiply *******************/
  
  func testGivenExpression_WhenUseFuncMultiply_ThenAddTheSign() {
    calculator.textModel = "1"
    calculator.multiply()
    XCTAssert(calculator.textModel == "1 * ")
  }
  
  func testGivenExpressionNil_WhenUseMultiply_ThenDontAddSign() {
    calculator.textModel = ""
    calculator.multiply()
    XCTAssert(calculator.textModel == "")
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Clear
  //----------------------------------------------------------------------------
  
  func testGivenExpression_WhenUseClear_ThenResultIsEmpty() {
    let calculatorMockedDelegate = CalculatorTestMockedDelegate()
    calculator.delegate = calculatorMockedDelegate
    
    calculator.addNumber(number: "1")
    
    calculator.clear()
    
    guard let result = calculatorMockedDelegate.didComputeResult else {
      XCTFail("Result should not be nil")
      return
    }
    
    XCTAssert(result.isEmpty, "textmodelDelegate should be empty.")
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Calculate
  //----------------------------------------------------------------------------
  
  func testGivenExpressionFalse_WhenUseCalculate_ThenDisplayError () {
    
    let calculatorMockedDelegate = CalculatorTestMockedDelegate()
    calculator.delegate = calculatorMockedDelegate
    
    calculator.textModel = "1 +"
    calculator.calculate()
    
    XCTAssertTrue(calculatorMockedDelegate.didExpressionErrorDisplayResult)
  }
  
  func testGivenExpression_WhenUseCalculate_ThenCanComputeAndManageError() {
    let calculatorMockedDelegate = CalculatorTestMockedDelegate()
    calculator.delegate = calculatorMockedDelegate
    
    calculator.textModel = "1 + 1"
    calculator.calculate()
    
    guard let result = calculatorMockedDelegate.didComputeResult else {
      XCTFail("Result should not be nil")
      return
    }
    
    XCTAssertEqual(result, "1 + 1 = 2.0 ")
    
    calculator.calculate()
    
    XCTAssertTrue(calculatorMockedDelegate.didEqualErrorDisplayResult)
    
    calculatorMockedDelegate.didComputeResult = nil
    calculatorMockedDelegate.didEqualErrorDisplayResult = false
    calculator.clear()
    calculator.calculate()
    
    XCTAssertTrue(calculatorMockedDelegate.didComputeResult?.isEmpty ?? false)
    XCTAssertTrue(calculatorMockedDelegate.didEqualErrorDisplayResult)
  }
}

