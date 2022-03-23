//
//  VIPapplicationTests.swift
//  VIPapplicationTests
//
//  Created by Braeden Meikle on 2/13/22.
//

import XCTest
@testable import VIPapplication

class VIPapplicationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    /* test that tries to sign up with a bad email address */
    func testSignUpBadEmail() throws {
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "failure@domain.c"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "whoops@@doubleatsign.edu"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "s(oory)@gmail.com"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "another_failure..twoconsecutivedots@testing.org"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "missing@end"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "alsobad@z.z"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "nice try@gatech.edu"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "withoutthe.@gatechedu"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "notokay#brae@yahoo.mail"))
        XCTAssertTrue(SignUpView.isValidEmailAddress(email: "withouttheatgatech.edu"))
    }
    
    /* tests successfully signing up with a good email address */
    func testSignUpGoodEmail() throws {
        XCTAssertFalse(SignUpView.isValidEmailAddress(email: "validemail1234567890@valid.com"))
        XCTAssertFalse(SignUpView.isValidEmailAddress(email: "this.email.address.also.works@does-not.matter.com"))
        XCTAssertFalse(SignUpView.isValidEmailAddress(email: "another-fine-address@alittlebitlongbutitisfine.uk"))
        XCTAssertFalse(SignUpView.isValidEmailAddress(email: "123.fine.123.123@abc.com"))
        XCTAssertFalse(SignUpView.isValidEmailAddress(email: "upperCASEworksTOO@ABCDHSS.ABDBSSS.com"))
        XCTAssertFalse(SignUpView.isValidEmailAddress(email: "werexow661@jo6s.com"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
