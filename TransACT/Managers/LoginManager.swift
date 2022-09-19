//
//  LoginManager.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 3/26/22.
//

import Foundation


/* This class contains any static methods that are used across views for logging in
 and other utilities -> the main purpose is the localize all those classes in one class
 here */
class LoginManager {
    
    static func isValidEmailAddress(email: String) -> Bool {
        // used this for the code -> https://regexr.com/
        
        /* prefix:
         technically any special character is allowed but we will restrict only to _ . - and / for brevity
         special character must be followed by a number/digit
         max 64 characters
         upper and lowercase are both fine
         "([a-zA-Z0-9]|([\_\.\-\/][a-zA-Z0-9])*){1,64}"
         
         the _ . - / symbols must be followed by at least one number or letter
         
         the @ symbol
         
         domain:
         max 253 characters
         A-Za-z0-9 or - or . -> only allowing 0, 1 - or . for brevity
         "([A-Za-z0-9]|([\-\.][a-zA-Z0-9])?){2,253}\.[a-z]{2,5}"
         
         .com ; .org ; .edu ; .mil ; .int ; .gov ; .uk ; should be nothing longer than 5 or shorter than 2
         
         */
        let emailRegex: String = #"([a-zA-Z0-9]|([\_\.\-\/][a-zA-Z0-9])*){1,64}@([A-Za-z0-9]|([\-\.][a-zA-Z0-9])?){2,253}\.[a-z]{2,5}"#
        // the #...# are needed in Swift to avoid double escape (\\) and keep the \
        return NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    /* function for if the password is strong enough
     
    requirements for a sufficiently strong password:
     - >=8 characters long
     - >=1 upper case character
     - >=1 lower case character
     - >=1 number
     - >=1 special character
     
     strongPassword returns a tuple:
     0 -> boolean whether the password was sufficiently strong
     1 -> personalized message of how to fix the password if it is not, "" if it is proper
     */
    static func isStrongPassword(password: String) -> (Bool, String) {
        /* see NSRegularExpression and NSPredicate packages
         helpful links:
         https://stackoverflow.com/questions/35957696/nspredicate-for-regex-pattern-matching-crashes
         https://stackoverflow.com/questions/29535792/check-if-a-string-contains-at-least-a-uppercase-letter-a-digit-or-a-special-ch
         https://code.tutsplus.com/tutorials/swift-and-regular-expressions-syntax--cms-26387
         https://regexr.com/
         
         * = 0 or more
         + = at least 1
         ? = 0 or 1
         [] signifies a set
         () are used for grouping
         - indicates a range
         | indicates or
         . matches any character except line breaks
         {} is a length quantifier {1,3} = 1,2,3 {3,} = 3,4,... {3} = 3
         \ means literal
        */
        
        /* all requirements in 1 line:
         let requirement: String = ".*[a-z]+[A-Z]+[0-9]+[!@#$%^&*]+.*{8,}"
         let result: Bool = NSPredicate(format:"SELF MATCHES %@", requirement).evaluate(with: password)
         return result && password.count >= 8
         */
        
        let upCaseMissing = "1 uppercase letter" // missing uppercase
        let lowCaseMissing = "1 lowercase letter" // missing lowercase
        let numMissing = "1 number" // missing number
        let specialCharMissing = "1 special character" // missing special character
        let lengthMissing = "at least 8 characters" // too short
        
        // updated: split up the requirements so the bad password message can be more helpful:
        let upCaseReq: String = ".*[A-Z]+.*"
        let lowCaseReq: String = ".*[a-z]+.*"
        let numReq: String = ".*[0-9]+.*"              // or "\d" -> any digit
        let specialCharReq: String = ".*[!@#$%^&*]+.*"
        let lengthReq: Bool = password.count >= 8
        
        // the String array is for the bad password message, initialize an empty String array
        var errors: [String] = [String]()
        
        let hasUpCase: Bool = NSPredicate(format:"SELF MATCHES %@", upCaseReq).evaluate(with: password)
        if !hasUpCase {
            errors.append(upCaseMissing)
        }
        
        let hasLowCase: Bool = NSPredicate(format:"SELF MATCHES %@", lowCaseReq).evaluate(with: password)
        if !hasLowCase {
            errors.append(lowCaseMissing)
        }
        
        let hasNum: Bool = NSPredicate(format:"SELF MATCHES %@", numReq).evaluate(with: password)
        if !hasNum {
            errors.append(numMissing)
        }
        
        let hasSpecialChar: Bool = NSPredicate(format:"SELF MATCHES %@", specialCharReq).evaluate(with: password)
        if !hasSpecialChar {
            errors.append(specialCharMissing)
        }
        
        let longEnough: Bool = lengthReq
        if !longEnough {
            errors.append(lengthMissing)
        }
        
        return (hasUpCase && hasLowCase && hasNum && hasSpecialChar && longEnough, badPasswordMessage(errors: errors))
    }
    
    private static func badPasswordMessage(errors: [String]) -> String {
        /* default message no matter what
         guaranteed >= 1 */
        var message: String = "Password must contain "
        
        // keep track of the number of errors so the message can be displayed with proper grammar
        let numErrors: Int = errors.count;
        
        // more readable
        let comma = ", "
        let and = " and "
        
        /*
         1 error: Password must contain ...
         2 errors: Password must contain ... and ...
         3+ errors: Password must contain ..., ..., and ...
         */
        switch numErrors {
        case 0:
            message += "no error"
        case 1:
            message += errors[0]
        case 2:
            message += errors[0] + and + errors[1]
        default:
            for i in 0...errors.count - 1 {
                if i == errors.count - 1 {
                    message += errors[i] + "!"
                } else if i == errors.count - 2 {
                    message += errors[i] + "," + and
                } else {
                    message += errors[i] + comma
                }
            }
        }
        
        return message
    }
}
