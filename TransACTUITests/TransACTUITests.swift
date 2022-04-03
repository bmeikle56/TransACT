//
//  VIPapplicationUITests.swift
//  VIPapplicationUITests
//
//  Created by Braeden Meikle on 2/13/22.
//

import XCTest

class VIPapplicationUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
                
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testResetPassword() throws {
        let formatInvalidEmail1 = "abc123"
        let notExistEmail1 = "abc123@act.com"
        let formatInvalidEmail2 = "foo"
        let notExistEmail2 = "foo@act.com"
        let validAndExistEmail = "actdrivingsim@gmail.com"
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Email"].tap()
        let loginButtons = app.buttons
        XCTAssertTrue(loginButtons["Forgot password?"].waitForExistence(timeout: 2))
        sleep(1)
        loginButtons["Forgot password?"].doubleTap()
        
        // type first format invalid email
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText(formatInvalidEmail1)
        let getResetEmailButton = app.buttons["GET RESET EMAIL"]
        getResetEmailButton.tap()
        let pleaseEnterAValidEmailAddressStaticText = app.staticTexts["Please enter a valid email address!"]
        XCTAssertTrue(pleaseEnterAValidEmailAddressStaticText.exists)
        
        // type first notExist email
        emailTextField.tap()
        emailTextField.doubleTap()
        emailTextField.typeText(notExistEmail1)
        getResetEmailButton.tap()
        let noUserWithThisEmailAddressHasBeenFoundStaticText = app.staticTexts["No user with this email address has been found"]
        XCTAssertTrue(noUserWithThisEmailAddressHasBeenFoundStaticText.waitForExistence(timeout: 2))
        XCTAssertTrue(noUserWithThisEmailAddressHasBeenFoundStaticText.exists)
        XCTAssertFalse(pleaseEnterAValidEmailAddressStaticText.exists)
        
        // type second format invalid email
        emailTextField.tap()
        emailTextField.doubleTap()
        emailTextField.typeText(formatInvalidEmail2)
        getResetEmailButton.tap()
        sleep(1)
        XCTAssertTrue(pleaseEnterAValidEmailAddressStaticText.exists)
        XCTAssertFalse(noUserWithThisEmailAddressHasBeenFoundStaticText.exists)
        
        // type second notExist email
        emailTextField.tap()
        emailTextField.doubleTap()
        emailTextField.typeText(notExistEmail2)
        getResetEmailButton.tap()
        sleep(1)
        XCTAssertTrue(noUserWithThisEmailAddressHasBeenFoundStaticText.exists)
        XCTAssertFalse(pleaseEnterAValidEmailAddressStaticText.exists)
        
        // type valid and exist email
        emailTextField.tap()
        emailTextField.doubleTap()
        emailTextField.typeText(validAndExistEmail)
        getResetEmailButton.tap()
        let successAlert = app.alerts["Email was sent!"]
        XCTAssertTrue(successAlert.waitForExistence(timeout: 2))
        XCTAssertFalse(noUserWithThisEmailAddressHasBeenFoundStaticText.exists)
        XCTAssertFalse(pleaseEnterAValidEmailAddressStaticText.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
