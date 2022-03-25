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
    
    func test() throws {
        let formatInvalidEmail1 = "abc123"
        
        
        let app = XCUIApplication()
        app.launch()
//        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["Email"].tap()
        app.buttons["Forgot password?"].tap()
        let getResetEmailButton = app.buttons["GET RESET EMAIL"]
        getResetEmailButton.tap()
        
        // type first format invalid email
//        let emailTextField = app.textFields["Email"]
//        emailTextField.tap()
//        emailTextField.typeText(formatInvalidEmail1)
//
//        let getResetEmailButton = app.buttons["GET RESET EMAIL"]
//        getResetEmailButton.tap()
//
//        let pleaseEnterAValidEmailAddressStaticText = app.staticTexts["Please enter a valid email address!"]
//        pleaseEnterAValidEmailAddressStaticText.tap()
//        pleaseEnterAValidEmailAddressStaticText.swipeLeft()
//        pleaseEnterAValidEmailAddressStaticText.tap()
//        emailTextField.tap()
//        getResetEmailButton.tap()
//        app.staticTexts["No user with this email address has been found"].tap()
//        emailTextField.tap()
//        emailTextField.tap()
//        getResetEmailButton.tap()
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
//        getResetEmailButton.tap()
//        app.alerts["Email was sent!"].scrollViews.otherElements.buttons["Return to login"].tap()
                
    }

    func testResetPassword() throws {
        let formatInvalidEmail1 = "abc123"
//        let formatInvalidEmail2 = "foo"
//        let notExistEmail1 = "abc123@act.com"
//        let notExistEmail2 = "foo@act.com"
//        let validAndExistEmail = "actdrivingsim@gmail.com"
        
        let app = XCUIApplication()
        app.buttons["Forgot password?"].tap()
        let emailTextField = app.textFields["Email"]
        //XCTAssert(emailTextField.exists)
        emailTextField.tap()
        // type a format invalid email address
        emailTextField.typeText(formatInvalidEmail1)
        app.buttons["GET RESET EMAIL"].tap()
        
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
