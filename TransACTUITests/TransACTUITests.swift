//
//  VIPapplicationUITests.swift
//  VIPapplicationUITests
//
//  Created by Braeden Meikle on 2/13/22.
//

import XCTest

class TransACTUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // automatically launch the app every time
        XCUIApplication().launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testResetPassword() throws {
        let app = XCUIApplication()
        
        // valid email to test the reset
        let email = "actdrivingsim@gmail.com"
        
        // click email and then forgot password to navigate to that screen
        app.buttons["Email"].tap()
        app.buttons["Forgot password?"].tap()
        
        // type the valid email above and click to get the email
        app.textFields["Email"].typeText(email)
        app.buttons["GET RESET EMAIL"].tap()
    }
    
    func testErrorsOnScreen() throws {
        let app = XCUIApplication()
        
        // various emails to test the errors on the screen with
        let formatInvalidEmail1 = "abc123"
        let notExistEmail1 = "abc123@act.com"
        let formatInvalidEmail2 = "foo"
        let notExistEmail2 = "foo@act.com"
        let validAndExistEmail = "actdrivingsim@gmail.com"
        
        // navigate to forgot password screen
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
        let noUserWithThisEmailAddressHasBeenFoundStaticText = app.staticTexts["No user with this email address has been found!"]
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
    
    /* test changing the views in MainTabView, verifying the buttons work as expected */
    func testMainTabView() throws {
        // launch app
        let app = XCUIApplication()
        
        // first screen click email
        app.buttons["Email"].tap()
        
        // type valid email and password, login
        app.textFields["email"].typeText("chengkaiyao825@gmail.com")
        app.textFields["password"].typeText("12a34b56c7")
        app.buttons["LOG IN"].tap()
        
        // click get started
        app.buttons["GET STARTED"].tap()
        
        // MainTabView, tap profile icon -> ProfileView
        app.images["Profile icon"].tap()
        
        // verify that ProfileView pops up when we click profile icon
        XCTAssert(app.otherElements["ProfileView"].exists)
        
        // tap location icon -> MapBoxMapView
        app.images["Location icon"].tap()
        
        // verify that MapBoxMapView pops up when we click location icon
        XCTAssert(app.otherElements["MapBoxMapView"].exists)
        
        // tap survey icon -> SurveyListView
        app.images["Survey icon"].tap()
        
        // verify that SurveyListView pops up when we click survey icon
        XCTAssert(app.otherElements["SurveyListView"].exists)
    }
    
    /* navigate through the UI, enter a proper login, and verify that we get to the home page properly */
    func testFirebaseProperLoginUI() throws {
        let app = XCUIApplication()
        
        // valid email to test the Firebase login
        let email = "chengkaiyao825@gmail.com"
        let password = "12a34b56c7"
        
        // click email
        app.buttons["Email"].tap()
        
        // enter the email and password and login, no errors should appear
        app.textFields["email"].typeText(email)
        app.textFields["password"].typeText(password)
        app.buttons["LOG IN"].tap()
        XCTAssertFalse(app.staticTexts["Incorrect email or password!"].exists)
        XCTAssertFalse(app.staticTexts["Please enter a valid email address!"].exists)
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
